package com.employeeManagementSystem.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.employeeManagementSystem.entity.Employee;


public interface EmployeeService {
	Employee createEmployee(Employee emp);

	Page<Employee> geetAllEmployee(Pageable page);

	Employee getEmployeeById(Long id);

	Employee updateEmployee(Long id, Employee emp);

	boolean deleteEmployeeById(Long id);

}
