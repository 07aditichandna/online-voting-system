package com.voting.online_voting_system.controller;

import com.voting.online_voting_system.dto.AdminUserResponse;
import com.voting.online_voting_system.entity.User;
import com.voting.online_voting_system.enums.AssignmentStatus;
import com.voting.online_voting_system.repository.ElectionOfficerAssignmentRepository;
import com.voting.online_voting_system.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/users")
public class AdminUserController {

    private final UserRepository userRepository;
    private final ElectionOfficerAssignmentRepository assignmentRepository;

    public AdminUserController(
            UserRepository userRepository,
            ElectionOfficerAssignmentRepository assignmentRepository
    ) {
        this.userRepository = userRepository;
        this.assignmentRepository = assignmentRepository;
    }

    // ---------------------------------------------------------
    // ADMIN VIEWS ALL USERS
    // ---------------------------------------------------------

    @GetMapping
    public ResponseEntity<?> getAllUsers(
            Authentication authentication
    ) {

        try {

            List<User> users = userRepository.findAll();

            List<AdminUserResponse> response = users.stream()
                    .map(user -> {

                        boolean activeEO =
                                assignmentRepository
                                        .findByUserIdAndStatus(
                                                user.getId(),
                                                AssignmentStatus.ACTIVE
                                        )
                                        .isPresent();

                        String eoStatus =
                                activeEO ? "ACTIVE" : "NOT_ASSIGNED";

                        return new AdminUserResponse(
                                user.getId(),
                                user.getStudentId(),
                                user.getFirstName(),
                                user.getLastName(),
                                user.getEmail(),
                                user.getDepartment(),
                                user.getCourse(),
                                user.getYear(),
                                user.getRole(),
                                eoStatus
                        );
                    })
                    .toList();

            return ResponseEntity.ok(response);

        } catch (RuntimeException e) {

            return ResponseEntity
                    .badRequest()
                    .body(e.getMessage());
        }
    }
}