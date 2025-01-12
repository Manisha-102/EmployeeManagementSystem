package com.employeeManagementSystem.repositoryImpl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.employeeManagementSystem.entity.Employee;
import com.employeeManagementSystem.repository.EmployeeRepository;

@Repository
public class EmployeeRepositoryImpl implements EmployeeRepository {
	 private JdbcTemplate jdbcTemplate;
		
		
		public EmployeeRepositoryImpl(JdbcTemplate jdbcTemplate) {
			super();
			this.jdbcTemplate = jdbcTemplate;
		}

		@Override
		public Employee createEmployee(Employee emp) {
			 String sql = "INSERT INTO employee (name, email, department, designation, salary, joining_date) " +
	                 "VALUES (?, ?, ?, ?, ?, ?)";

	         jdbcTemplate.update(sql, emp.getName(), emp.getEmail(), emp.getDepartment(), 
	                        emp.getDesignation(), emp.getSalary(), emp.getJoiningDate());

	         return emp;
		}

		@Override
		public Page<Employee> geetAllEmployee(Pageable pageable) {
		    // Query to fetch paginated employee data
		    String query = "SELECT * FROM employee LIMIT ? OFFSET ?";
		    
		    // Query to count total number of employees
		    String countQuery = "SELECT COUNT(*) FROM employee";

		    // Fetch employee data for the current page
		    List<Employee> employees = jdbcTemplate.query(
		        query,
		        new Object[]{pageable.getPageSize(), pageable.getOffset()},
		        (rs, rowNum) -> new Employee(
		            rs.getLong("id"),
		            rs.getString("name"),
		            rs.getString("email"),
		            rs.getString("department"),
		            rs.getString("designation"),
		            rs.getString("salary"),
		            rs.getDate("joining_date")
		        )
		    );
		    
		    System.out.println("list..........."+employees);

		    // Fetch total employee count
		    Long total = jdbcTemplate.queryForObject(countQuery, Long.class);

		    // Return as Page
		    return new PageImpl<>(employees, pageable, total);
		}


		@Override
		public Employee getEmployeeById(Long id) {
		    String query = "SELECT * FROM employee WHERE id = ?";
		    return jdbcTemplate.queryForObject(
		        query,
		        new Object[]{id},
		        new BeanPropertyRowMapper<>(Employee.class)
		    );
		}


		@Override
		public Employee updateEmployee(Long id, Employee emp) {
			String query = "UPDATE employee SET name = ?, email = ?, department = ?, designation = ?, salary = ?, joining_date = ? WHERE id = ?";
		    
		    jdbcTemplate.update(query, emp.getName(), emp.getEmail(), emp.getDepartment(), emp.getDesignation(),
		            emp.getSalary(), emp.getJoiningDate(), id);
		    
		    emp.setId(id); 
		    return emp;
			
		}

		@Override
		public boolean deleteEmployeeById(Long id) {
			 String query = "DELETE FROM employee WHERE id = ?";
			 int rowsAffected = jdbcTemplate.update(query, id);
			 return rowsAffected > 0;
		}

}
