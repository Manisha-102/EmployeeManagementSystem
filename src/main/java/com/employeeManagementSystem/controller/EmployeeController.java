package com.employeeManagementSystem.controller;



import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.employeeManagementSystem.entity.Employee;
import com.employeeManagementSystem.service.EmployeeService;


@Controller("")
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	
	@GetMapping("/")
	public String home() {
		return "index.jsp";
	}
	
	@GetMapping("/register")
	public String register() {
		return "register.jsp";
	}
	
	@ResponseBody
	@GetMapping("/update/{id}")
	public String update(@PathVariable Long id) {
		return "update.jsp";
	}
	
	@ResponseBody()
	@PostMapping("/employee/create")
	public String createEmployee(@ModelAttribute Employee emp) {
		System.out.println("sal....."+emp.getSalary());
		long salary = Long.parseLong(emp.getSalary());
		System.out.println("in sal......."+salary);
		if (!StringUtils.hasText(emp.getName())) {
            return "Name cannot be empty!";
        }
        if (!StringUtils.hasText(emp.getEmail())) {
            return "Email cannot be empty!";
        }
        if (!isValidEmail(emp.getEmail())) {
            return "Invalid email format!";
        }
        if (!StringUtils.hasText(emp.getDepartment())) {
            return "Department cannot be empty!";
        }
        if (!StringUtils.hasText(emp.getDesignation())) {
            return "Designation cannot be empty!";
        }
        if (emp.getSalary() == null || salary <= 0) {
            return "Salary must be a positive number!";
        }

        if (emp.getJoiningDate() == null) {
            return "Joining Date cannot be empty!";
        }
		
		employeeService.createEmployee(emp);
		System.out.println("created/................");
		return "/";
	}
	
	
	@ResponseBody
	@GetMapping("/employee/getAll")
	public Page<Employee> geetAllEmployee(Pageable page){
		System.out.println("insert.................");
		return employeeService.geetAllEmployee(page);
		
	}
	
	@ResponseBody
	@GetMapping("/employee/getById/{id}")
	public Employee getEmployeeById(@PathVariable Long id) {
		Employee emp=employeeService.getEmployeeById(id);
	    return emp;
	}
 
	@ResponseBody
	@PutMapping("/employee/update/{id}")
	public String updateEmployee(@PathVariable Long id, @RequestBody Employee emp) {
	    Employee updatedEmployee = employeeService.updateEmployee(id, emp);
	    return "Employee with ID " + id + " updated successfully!";
	}
	
	@DeleteMapping("/employee/delete/{id}")
	public String deleteEmployee(@PathVariable Long id) {
	    boolean isDeleted = employeeService.deleteEmployeeById(id);
	    if (isDeleted) {
	        return "Employee with ID " + id + " deleted successfully!";
	    } else {
	        return "Employee with ID " + id + " not found!";
	    }
	}
	
	
	private boolean isValidEmail(String email) {
	    String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
	    Pattern pattern = Pattern.compile(emailRegex);
	    Matcher matcher = pattern.matcher(email);
	    return matcher.matches();
	}

	

}

