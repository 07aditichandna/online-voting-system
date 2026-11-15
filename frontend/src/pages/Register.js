
import { useState } from "react";
import { useNavigate } from "react-router-dom";

import "./Register.css";
import API_BASE_URL from "../services/api";

function Register() {

  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    studentId: "",
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    department: "",
    course: "",
    year: ""
  });

  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleChange = (event) => {
    const { name, value } = event.target;

    setFormData({
      ...formData,
      [name]: value
    });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    setMessage("");
    setError("");

    // Validate MANIT student email format
    const emailPattern = /^[0-9]+@stu\.manit\.ac\.in$/;

    if (!emailPattern.test(formData.email.trim())) {
      setError(
        "Please enter a valid MANIT student email (schlno@stu.manit.ac.in)."
      );
      return;
    }

    try {
      const response = await fetch(
        `${API_BASE_URL}/api/auth/register`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            ...formData,
            email: formData.email.trim(),
            year: Number(formData.year)
          })
        }
      );

      // Read backend response safely
      const responseText = await response.text();

      let data;

      try {
        data = responseText ? JSON.parse(responseText) : null;
      } catch {
        data = responseText;
      }

      if (!response.ok) {
        const errorMessage =
          typeof data === "string"
            ? data
            : data?.message || data?.error || "Registration failed";

        throw new Error(errorMessage);
      }

      setMessage("Account created successfully!");

      setFormData({
        studentId: "",
        firstName: "",
        lastName: "",
        email: "",
        password: "",
        department: "",
        course: "",
        year: ""
      });

      setTimeout(() => {
        navigate("/login");
      }, 1000);

    } catch (error) {
      setError(
        error.message || "Something went wrong. Please try again."
      );
    }
  };

  return (
    <div className="register-page">

      <div className="register-container">

        <h1>Online Voting System</h1>

        <h2>Create Account</h2>

        {message && (
          <p className="success-message">
            {message}
          </p>
        )}

        {error && (
          <p className="error-message">
            {error}
          </p>
        )}

        <form
          className="register-form"
          onSubmit={handleSubmit}
        >

          <div className="form-group">
            <label>Student ID</label>

            <input
              type="text"
              name="studentId"
              value={formData.studentId}
              onChange={handleChange}
              placeholder="Enter your student ID"
              required
            />
          </div>

          <div className="form-group">
            <label>First Name</label>

            <input
              type="text"
              name="firstName"
              value={formData.firstName}
              onChange={handleChange}
              placeholder="Enter your first name"
              required
            />
          </div>

          <div className="form-group">
            <label>Last Name</label>

            <input
              type="text"
              name="lastName"
              value={formData.lastName}
              onChange={handleChange}
              placeholder="Enter your last name"
              required
            />
          </div>

          <div className="form-group">
            <label>Email</label>

            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              placeholder="studentId@stu.manit.ac.in"
              required
            />
          </div>

          <div className="form-group">
            <label>Password</label>

            <input
              type="password"
              name="password"
              value={formData.password}
              onChange={handleChange}
              placeholder="Create a password"
              required
            />
          </div>

          <div className="form-group">
            <label>Department</label>

            <input
              type="text"
              name="department"
              value={formData.department}
              onChange={handleChange}
              placeholder="Enter your department"
              required
            />
          </div>

          <div className="form-group">
            <label>Course</label>

            <input
              type="text"
              name="course"
              value={formData.course}
              onChange={handleChange}
              placeholder="Enter your course"
              required
            />
          </div>

          <div className="form-group">
            <label>Year</label>

            <input
              type="number"
              name="year"
              value={formData.year}
              onChange={handleChange}
              placeholder="Enter your year"
              min="1"
              max="5"
              required
            />
          </div>

          <button
            type="submit"
            className="register-button"
          >
            Create Account
          </button>

        </form>

      </div>

    </div>
  );
}

export default Register;
