
package com.voting.online_voting_system.service;

import com.voting.online_voting_system.entity.ElectionOfficerAssignment;
import com.voting.online_voting_system.entity.Notification;
import com.voting.online_voting_system.entity.User;
import com.voting.online_voting_system.enums.AssignmentStatus;
import com.voting.online_voting_system.enums.AuditAction;
import com.voting.online_voting_system.enums.NotificationType;
import com.voting.online_voting_system.enums.Role;
import com.voting.online_voting_system.repository.ElectionOfficerAssignmentRepository;
import com.voting.online_voting_system.repository.NotificationRepository;
import com.voting.online_voting_system.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ElectionOfficerService {

    private final ElectionOfficerAssignmentRepository assignmentRepository;
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;
    private final AuditLogService auditLogService;

    public ElectionOfficerService(
            ElectionOfficerAssignmentRepository assignmentRepository,
            UserRepository userRepository,
            NotificationRepository notificationRepository,
            AuditLogService auditLogService
    ) {
        this.assignmentRepository = assignmentRepository;
        this.userRepository = userRepository;
        this.notificationRepository = notificationRepository;
        this.auditLogService = auditLogService;
    }

    // ADMIN ASSIGNS A USER AS ELECTION OFFICER
    public ElectionOfficerAssignment assignOfficer(
            Long userId,
            User admin
    ) {

        if (admin.getRole() != Role.ADMIN) {
            auditLogService.log(
                    admin,
                    AuditAction.UNAUTHORIZED_ELECTION_ACTION,
                    "Unauthorized attempt to assign an Election Officer"
            );

            throw new RuntimeException(
                    "Only Admin can assign Election Officers"
            );
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() ->
                        new RuntimeException("User not found"));

        if (user.getRole() == Role.ADMIN) {
            throw new RuntimeException(
                    "Admin cannot be assigned as Election Officer"
            );
        }

        if (assignmentRepository.findByUserIdAndStatus(
                userId,
                AssignmentStatus.ACTIVE
        ).isPresent()) {
            throw new RuntimeException(
                    "User is already an active Election Officer"
            );
        }

        ElectionOfficerAssignment assignment =
                new ElectionOfficerAssignment();

        assignment.setUser(user);
        assignment.setElection(null);
        assignment.setAssignedBy(admin);
        assignment.setAssignedAt(LocalDateTime.now());
        assignment.setStatus(AssignmentStatus.ACTIVE);

        ElectionOfficerAssignment savedAssignment =
                assignmentRepository.save(assignment);

        // AUDIT: ADMIN SUCCESSFULLY ASSIGNED AN EO
        auditLogService.log(
                admin,
                AuditAction.EO_ASSIGNED,
                "Admin assigned user ID " + userId
                        + " as Election Officer. Assignment ID: "
                        + savedAssignment.getId()
        );

        // CREATE EO ASSIGNMENT NOTIFICATION
        Notification notification = new Notification();

        notification.setUser(user);
        notification.setType(NotificationType.EO_ASSIGNED);
        notification.setMessage(
                "You have been assigned as an Election Officer."
        );
        notification.setRead(false);
        notification.setCreatedAt(LocalDateTime.now());

        notificationRepository.save(notification);

        return savedAssignment;
    }

    // ADMIN ENDS AN EO ASSIGNMENT
    public void removeOfficer(
            Long userId,
            User admin
    ) {

        if (admin.getRole() != Role.ADMIN) {
            auditLogService.log(
                    admin,
                    AuditAction.UNAUTHORIZED_ELECTION_ACTION,
                    "Unauthorized attempt to remove an Election Officer"
            );

            throw new RuntimeException(
                    "Only Admin can remove Election Officers"
            );
        }

        ElectionOfficerAssignment assignment =
                assignmentRepository.findByUserIdAndStatus(
                        userId,
                        AssignmentStatus.ACTIVE
                ).orElseThrow(() ->
                        new RuntimeException(
                                "Active Election Officer assignment not found"
                        ));

        assignment.setStatus(AssignmentStatus.ENDED);

        assignmentRepository.save(assignment);

        auditLogService.log(
                admin,
                AuditAction.EO_REMOVED,
                "Election Officer assignment ended for user ID "
                        + userId
        );
    }
}
