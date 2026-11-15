package com.voting.online_voting_system.dto;

import com.voting.online_voting_system.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AdminUserResponse {
// this contains the info we return to admin when he/she demands
    private Long id;
    private String studentId;
    private String firstName;
    private String lastName;
    private String email;
    private String department;
    private String course;
    private Integer year;
    private Role role;
    private String eoStatus;
}