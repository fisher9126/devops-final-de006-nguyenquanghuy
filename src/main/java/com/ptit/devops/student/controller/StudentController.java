package com.ptit.devops.student.controller;

import com.ptit.devops.student.entity.Student;
import com.ptit.devops.student.repository.StudentRepository;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class StudentController {

    private final StudentRepository repository;

    public StudentController(StudentRepository repository) {
        this.repository = repository;
    }

    /** GET /api/students - danh sách sinh viên */
    @GetMapping("/students")
    public List<Student> findAll() {
        return repository.findAll(Sort.by("id"));
    }
}
