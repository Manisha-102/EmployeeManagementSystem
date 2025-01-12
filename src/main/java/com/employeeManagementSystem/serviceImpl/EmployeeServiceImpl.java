package com.employeeManagementSystem.serviceImpl;




import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.employeeManagementSystem.entity.Employee;
import com.employeeManagementSystem.repository.EmployeeRepository;
import com.employeeManagementSystem.service.EmployeeService;

@Service
public class EmployeeServiceImpl  implements EmployeeService{
	
	@Autowired
	private EmployeeRepository employeeRepository;

	@Override
	public Employee createEmployee(Employee emp) {
		
        
        return  employeeRepository.createEmployee(emp);
				
	}

	@Override
	public Page<Employee> geetAllEmployee(Pageable page) {
		return employeeRepository.geetAllEmployee(page);
	}

	@Override
	public Employee getEmployeeById(Long id) {
		return employeeRepository.getEmployeeById(id);
	}

	@Override
	public Employee updateEmployee(Long id, Employee emp) {
		return employeeRepository.updateEmployee(id,emp);
	}

	@Override
	public boolean deleteEmployeeById(Long id) {
		return employeeRepository.deleteEmployeeById(id);
	}
	
	

}

