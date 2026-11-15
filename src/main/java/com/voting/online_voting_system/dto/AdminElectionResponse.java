package com.voting.online_voting_system.dto;

import com.voting.online_voting_system.enums.ElectionStatus;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class AdminElectionResponse {

    private Long id;
    private String title;
    private ElectionStatus status;

    private String eoName;
    private String eoStudentId;

    private LocalDateTime startDate;
    private LocalDateTime endDate;

    private String department;
}