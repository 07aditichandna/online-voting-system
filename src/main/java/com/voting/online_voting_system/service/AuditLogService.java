
package com.voting.online_voting_system.service;

import com.voting.online_voting_system.entity.AuditLog;
import com.voting.online_voting_system.entity.User;
import com.voting.online_voting_system.enums.AuditAction;
import com.voting.online_voting_system.repository.AuditLogRepository;
import com.voting.online_voting_system.repository.UserRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AuditLogService {

    private final AuditLogRepository auditLogRepository;
    private final UserRepository userRepository;

    public AuditLogService(
            AuditLogRepository auditLogRepository,
            UserRepository userRepository) {

        this.auditLogRepository = auditLogRepository;
        this.userRepository = userRepository;
    }

    // SAVE NORMAL AUDIT LOG
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void log(
            User user,
            AuditAction action,
            String description
    ) {

        AuditLog auditLog = new AuditLog();

        auditLog.setUser(user);
        auditLog.setAction(action);
        auditLog.setDescription(description);
        auditLog.setTimestamp(LocalDateTime.now());

        auditLogRepository.save(auditLog);
    }

    // SAVE FAILED LOGIN AUDIT LOG
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void logFailedLogin(
            String email,
            int attempts
    ) {

        AuditLog auditLog = new AuditLog();

        // Find registered user using email
        User user = userRepository.findByEmail(email).orElse(null);
        auditLog.setUser(user);

        auditLog.setAction(
                attempts >= 5
                        ? AuditAction.REPEATED_FAILED_LOGIN
                        : AuditAction.FAILED_LOGIN_ATTEMPT
        );

        auditLog.setDescription(
                "Failed login attempt for account identifier: "
                        + email
                        + ". Consecutive attempts: "
                        + attempts
        );

        auditLog.setTimestamp(LocalDateTime.now());

        auditLogRepository.save(auditLog);
    }

    // GET ALL AUDIT LOGS
    @Transactional(readOnly = true)
    public List<AuditLog> getAllLogs() {

        return auditLogRepository.findAll();
    }
}
