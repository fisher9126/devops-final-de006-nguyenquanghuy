package com.ptit.devops.student.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "students")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "student_code")
    private String studentCode;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "class_name")
    private String className;

    @Column(name = "major")
    private String major;

    @Column(name = "gpa")
    private BigDecimal gpa;

    public Long getId() {
        return id;
    }

    public String getStudentCode() {
        return studentCode;
    }

    public String getFullName() {
        return fullName;
    }

    public String getClassName() {
        return className;
    }

    public String getMajor() {
        return major;
    }

    public BigDecimal getGpa() {
        return gpa;
    }
}
