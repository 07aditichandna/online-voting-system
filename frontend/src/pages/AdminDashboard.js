import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { getToken, getUser, logout } from "../services/auth";
import API_BASE_URL from "../services/api";
import "./AdminDashboard.css";

function AdminDashboard() {
    const navigate = useNavigate();

    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);

    // Filters
    const [searchTerm, setSearchTerm] = useState("");
    const [departmentFilter, setDepartmentFilter] = useState("");
    const [courseFilter, setCourseFilter] = useState("");
    const [yearFilter, setYearFilter] = useState("");
    const [eoStatusFilter, setEoStatusFilter] = useState("");

    // Assign EO
    const [assigningUserId, setAssigningUserId] = useState(null);
    const [actionMessage, setActionMessage] = useState("");

    const user = getUser();

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const token = getToken();

            const response = await fetch(
                `${API_BASE_URL}/api/admin/users`,
                {
                    headers: {
                        Authorization: `Bearer ${token}`
                    }
                }
            );

            if (response.status === 401 || response.status === 403) {
                logout();
                navigate("/login");
                return;
            }

            if (!response.ok) {
                throw new Error("Failed to fetch users");
            }

            const data = await response.json();
            setUsers(data);

        } catch (error) {
            console.error("Error fetching users:", error);
        } finally {
            setLoading(false);
        }
    };

    const handleAssignEO = async (userId) => {
        const confirmAssign = window.confirm(
            "Are you sure you want to assign this user as an Election Officer?"
        );

        if (!confirmAssign) {
            return;
        }

        try {
            setAssigningUserId(userId);
            setActionMessage("");

            const token = getToken();

            const response = await fetch(
                `${API_BASE_URL}/api/admin/election-officers/assign/${userId}`,
                {
                    method: "POST",
                    headers: {
                        Authorization: `Bearer ${token}`
                    }
                }
            );

            const data = await response.text();

            if (!response.ok) {
                throw new Error(data || "Failed to assign Election Officer");
            }

            // Update the user immediately in the UI
            setUsers((previousUsers) =>
                previousUsers.map((user) =>
                    user.id === userId
                        ? {
                              ...user,
                              eoStatus: "ACTIVE"
                          }
                        : user
                )
            );

            setActionMessage("Election Officer assigned successfully.");

        } catch (error) {
            console.error("Error assigning EO:", error);
            setActionMessage(error.message || "Failed to assign Election Officer");
        } finally {
            setAssigningUserId(null);
        }
    };

    // Filter options
    const departments = [
        ...new Set(
            users
                .map((user) => user.department)
                .filter(Boolean)
        )
    ].sort();

    const courses = [
        ...new Set(
            users
                .map((user) => user.course)
                .filter(Boolean)
        )
    ].sort();

    const years = [
        ...new Set(
            users
                .map((user) => user.year)
                .filter((year) => year !== null && year !== undefined)
        )
    ].sort((a, b) => a - b);

    // Apply filters
    const filteredUsers = users.filter((user) => {
        const search = searchTerm.toLowerCase();

        const matchesSearch =
            user.studentId?.toLowerCase().includes(search) ||
            user.firstName?.toLowerCase().includes(search) ||
            user.lastName?.toLowerCase().includes(search) ||
            user.email?.toLowerCase().includes(search) ||
            user.department?.toLowerCase().includes(search) ||
            user.course?.toLowerCase().includes(search);

        const matchesDepartment =
            !departmentFilter ||
            user.department === departmentFilter;

        const matchesCourse =
            !courseFilter ||
            user.course === courseFilter;

        const matchesYear =
            !yearFilter ||
            String(user.year) === String(yearFilter);

        const matchesEOStatus =
            !eoStatusFilter ||
            user.eoStatus === eoStatusFilter;

        return (
            matchesSearch &&
            matchesDepartment &&
            matchesCourse &&
            matchesYear &&
            matchesEOStatus
        );
    });

    const clearFilters = () => {
        setSearchTerm("");
        setDepartmentFilter("");
        setCourseFilter("");
        setYearFilter("");
        setEoStatusFilter("");
    };

    const activeEOCount = users.filter(
        (user) => user.eoStatus === "ACTIVE"
    ).length;

    const availableEOCount = users.filter(
        (user) =>
            user.eoStatus !== "ACTIVE" &&
            user.role !== "ADMIN"
    ).length;

    return (
        <div className="admin-dashboard">

            {/* Header */}
            <header className="admin-header">
                <div>
                    <h1>Admin Dashboard</h1>
                    <p>Manage users and Election Officer assignments</p>
                </div>

                <button
                    className="admin-logout-btn"
                    onClick={() => {
                        logout();
                        navigate("/login");
                    }}
                >
                    Logout
                </button>
            </header>

            {/* Welcome */}
            <section className="admin-welcome-card">
                <h2>
                    Welcome, {user?.firstName || "Admin"} 👋
                </h2>

                <p>
                    Use the filters below to quickly find a user
                    and assign them as an Election Officer.
                </p>
            </section>

            {/* Statistics */}
            <section className="admin-stats">

                <div className="admin-stat-card">
                    <span>Total Users</span>
                    <strong>{users.length}</strong>
                </div>

                <div className="admin-stat-card">
                    <span>Active EOs</span>
                    <strong>{activeEOCount}</strong>
                </div>

                <div className="admin-stat-card">
                    <span>Available for EO</span>
                    <strong>{availableEOCount}</strong>
                </div>

            </section>

            {/* Filters */}
            <section className="admin-filters">

                <div className="filter-group search-group">
                    <label>Search</label>

                    <input
                        type="text"
                        placeholder="Student ID, name, email..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>

                <div className="filter-group">
                    <label>Department</label>

                    <select
                        value={departmentFilter}
                        onChange={(e) =>
                            setDepartmentFilter(e.target.value)
                        }
                    >
                        <option value="">All Departments</option>

                        {departments.map((department) => (
                            <option
                                key={department}
                                value={department}
                            >
                                {department}
                            </option>
                        ))}
                    </select>
                </div>

                <div className="filter-group">
                    <label>Course</label>

                    <select
                        value={courseFilter}
                        onChange={(e) =>
                            setCourseFilter(e.target.value)
                        }
                    >
                        <option value="">All Courses</option>

                        {courses.map((course) => (
                            <option
                                key={course}
                                value={course}
                            >
                                {course}
                            </option>
                        ))}
                    </select>
                </div>

                <div className="filter-group">
                    <label>Year</label>

                    <select
                        value={yearFilter}
                        onChange={(e) =>
                            setYearFilter(e.target.value)
                        }
                    >
                        <option value="">All Years</option>

                        {years.map((year) => (
                            <option
                                key={year}
                                value={year}
                            >
                                Year {year}
                            </option>
                        ))}
                    </select>
                </div>

                <div className="filter-group">
                    <label>EO Status</label>

                    <select
                        value={eoStatusFilter}
                        onChange={(e) =>
                            setEoStatusFilter(e.target.value)
                        }
                    >
                        <option value="">All Status</option>
                        <option value="NOT_ASSIGNED">
                            Not Assigned
                        </option>
                        <option value="ACTIVE">
                            Active EO
                        </option>
                    </select>
                </div>

                <button
                    className="clear-filters-btn"
                    onClick={clearFilters}
                >
                    Clear Filters
                </button>

            </section>

            {/* Message */}
            {actionMessage && (
                <div className="admin-action-message">
                    {actionMessage}
                </div>
            )}

            {/* Users */}
            <section className="admin-users-section">

                <div className="admin-users-header">
                    <h2>Registered Users</h2>

                    <span>
                        Showing {filteredUsers.length} of {users.length}
                    </span>
                </div>

                {loading ? (
                    <p className="admin-loading">
                        Loading users...
                    </p>
                ) : filteredUsers.length === 0 ? (
                    <p className="admin-no-users">
                        No users match the selected filters.
                    </p>
                ) : (
                    <div className="admin-table-container">
                        <table className="admin-users-table">

                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Department</th>
                                    <th>Course</th>
                                    <th>Year</th>
                                    <th>EO Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                {filteredUsers.map((user) => (
                                    <tr key={user.id}>

                                        <td>{user.studentId}</td>

                                        <td>
                                            {user.firstName}{" "}
                                            {user.lastName}
                                        </td>

                                        <td>{user.email}</td>

                                        <td>{user.department}</td>

                                        <td>{user.course}</td>

                                        <td>{user.year}</td>

                                        <td>
                                            <span
                                                className={
                                                    user.eoStatus === "ACTIVE"
                                                        ? "eo-status active"
                                                        : "eo-status not-assigned"
                                                }
                                            >
                                                {user.eoStatus === "ACTIVE"
                                                    ? "Active EO"
                                                    : "Not Assigned"}
                                            </span>
                                        </td>

                                        <td>
                                            {user.role === "ADMIN" ? (
                                                <span className="admin-user-label">
                                                    Admin
                                                </span>
                                            ) : user.eoStatus === "ACTIVE" ? (
                                                <button
                                                    className="assigned-btn"
                                                    disabled
                                                >
                                                    Assigned
                                                </button>
                                            ) : (
                                                <button
                                                    className="assign-eo-btn"
                                                    onClick={() =>
                                                        handleAssignEO(user.id)
                                                    }
                                                    disabled={
                                                        assigningUserId ===
                                                        user.id
                                                    }
                                                >
                                                    {assigningUserId === user.id
                                                        ? "Assigning..."
                                                        : "Assign EO"}
                                                </button>
                                            )}
                                        </td>

                                    </tr>
                                ))}
                            </tbody>

                        </table>
                    </div>
                )}

            </section>

        </div>
    );
}

export default AdminDashboard;