<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deleting Employee...</title>
    <!-- Bootstrap CSS for styling -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 100px;
        }
        .message {
            font-size: 1.5rem;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 id="statusMessage">Deleting employee, please wait...</h2>
        <p class="message" id="responseMessage"></p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Extract employee ID from the URL query parameters
            const urlParams = new URLSearchParams(window.location.search);
            const employeeId = urlParams.get('id');

            const statusMessage = document.getElementById('statusMessage');
            const responseMessage = document.getElementById('responseMessage');
  
            if (employeeId) {
                // Send DELETE request to the server
                 if (confirm("Are you sure you want to delete this employee?")) {
                fetch(`/employee/delete/`+employeeId+``, {
                    method: 'DELETE'
                })
                .then(response => response.text())
                .then(result => {
                    statusMessage.textContent = 'Employee Deleted';
                    responseMessage.textContent = result;

                    // Redirect to employee list after 3 seconds
                    setTimeout(() => {
                        window.location.href = '/';
                    }, 3000);
                })
                .catch(error => {
                    statusMessage.textContent = 'Error!';
                    responseMessage.textContent = 'Failed to delete the employee.';
                    console.error('Error:', error);

                    // Redirect back after 3 seconds
                    setTimeout(() => {
                        window.location.href = '/';
                    }, 3000);
                });
                 }
            } else {
                statusMessage.textContent = 'Invalid Request!';
                responseMessage.textContent = 'No employee ID provided. Redirecting...';

                // Redirect back after 3 seconds
                setTimeout(() => {
                    window.location.href = '/';
                }, 3000);
            }
        });
    </script>
</body>
</html>
