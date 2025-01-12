<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Employee</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Custom CSS for Styling -->
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            background-color: #ffffff;
        }

        .container {
            margin-top: 50px;
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-size: 24px;
            text-align: center;
            padding: 15px;
            border-radius: 10px 10px 0 0;
        }

        .btn-primary {
            width: 100%;
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            width: 100%;
        }

        .form-group label {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">Edit Employee</div>
                    <div class="card-body">
                        <form id="editEmployeeForm">
                            <input type="hidden" id="employeeId" name="employeeId">

                            <div class="form-group">
                                <label for="employeeName">Name</label>
                                <input type="text" class="form-control" id="employeeName" name="employeeName" placeholder="Enter employee name" required>
                            </div>

                            <div class="form-group">
                                <label for="employeeEmail">Email</label>
                                <input type="email" class="form-control" id="employeeEmail" name="employeeEmail" placeholder="Enter employee email" required>
                            </div>

                            <div class="form-group">
                                <label for="employeeDepartment">Department</label>
                                <input type="text" class="form-control" id="employeeDepartment" name="employeeDepartment" placeholder="Enter department" required>
                            </div>

                            <div class="form-group">
                                <label for="employeeDesignation">Designation</label>
                                <input type="text" class="form-control" id="employeeDesignation" name="employeeDesignation" placeholder="Enter designation" required>
                            </div>

                            <div class="form-group">
                                <label for="employeeSalary">Salary</label>
                                <input type="number" class="form-control" id="employeeSalary" name="employeeSalary" placeholder="Enter salary" required>
                            </div>

                            <div class="form-group">
                                <label for="employeeJoiningDate">Joining Date</label>
                                <input type="date" class="form-control" id="employeeJoiningDate" name="employeeJoiningDate" required>
                            </div>

                            <button type="submit" class="btn btn-primary mt-3">Save Changes</button>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- Existing Script (Unchanged) -->
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', () => {
            const urlParams = new URLSearchParams(window.location.search);
            const employeeId = urlParams.get('id');


            if (employeeId) {
                fetch(`/employee/getById/`+employeeId+``)
                    .then(response => response.json())
                    .then(employee => {
                        document.getElementById('employeeId').value = employee.id;
                        document.getElementById('employeeName').value = employee.name;
                        document.getElementById('employeeEmail').value = employee.email;
                        document.getElementById('employeeDepartment').value = employee.department;
                        document.getElementById('employeeDesignation').value = employee.designation;
                        document.getElementById('employeeSalary').value = employee.salary;
                        document.getElementById('employeeJoiningDate').value = new Date(employee.joiningDate).toISOString().split('T')[0];
                    })
                    .catch(error => {
                        console.error('Error fetching employee data:', error);
                        alert('Failed to load employee data.');
                    });
            } else {
                alert('No employee ID provided.');
            }
        });

        document.getElementById('editEmployeeForm').addEventListener('submit', function(event) {
            event.preventDefault();

            const employeeId = document.getElementById('employeeId').value;
            const updatedEmployee = {
                id: employeeId,
                name: document.getElementById('employeeName').value,
                email: document.getElementById('employeeEmail').value,
                department: document.getElementById('employeeDepartment').value,
                designation: document.getElementById('employeeDesignation').value,
                salary: document.getElementById('employeeSalary').value,
                joiningDate: document.getElementById('employeeJoiningDate').value
            };

            console.log("employee....."+ JSON.stringify(updatedEmployee));

            fetch(`/employee/update/`+employeeId+``, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(updatedEmployee),
            })
            .then(response => {
                if (response.ok) {
                    alert('Employee updated successfully.');
                    window.location.href = '/index.jsp';
                } else {
                    return response.text().then(text => { throw new Error(text) });
                }
            })
            .catch(error => {
                console.error('Error updating employee:', error);
                alert('Failed to update employee.');
            });
        });
    </script>
</body>
</html>
