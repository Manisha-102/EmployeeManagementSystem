<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Management System</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f0f2f5;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .btn {
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
            margin: 5px 0;
            transition: all 0.3s ease;
        }

        .btn-add {
            background-color: #28a745;
            color: white;
            margin-bottom: 20px;
        }

        /* Edit Button Styles */
        .btn-edit {
            background-color: #ffc107;
            color: white;
            width: 120px;
            text-align: center;
        }

        .btn-edit:hover {
            background-color: #e0a800;
        }

        /* Delete Button Styles */
        .btn-delete {
            background-color: #dc3545;
            color: white;
            width: 120px;
            text-align: center;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        .actions-cell {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            align-items: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            color: black;
            background-color: white;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .pagination button {
            padding: 8px 16px;
            margin: 5px;
            border-radius: 4px;
            cursor: pointer;
            background-color: #007BFF;
            color: white;
            border: none;
        }

        .pagination button:hover {
            background-color: #0056b3;
        }

        .pagination .active {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Employee Management System</h1>
    <a href="${pageContext.request.contextPath}/register" class="btn btn-add">+ Add Employee</a>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Designation</th>
                <th>Salary</th>
                <th>Joining Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="employeeTable">
            <!-- Employee data will be populated here -->
        </tbody>
    </table>
    
    <!-- Pagination Controls -->
    <div class="pagination" id="paginationControls"></div>
</div>

<!-- Status Messages -->
<div id="statusMessage" style="text-align:center; margin-top:20px; color:green;"></div>
<div id="responseMessage" style="text-align:center; margin-top:5px; color:red;"></div>

<script>
let currentPage = 0;
const pageSize = 5;

// Load employees from backend
function loadEmployees(page) {
    fetch(`/employee/getAll?page=`+page+`&size=`+pageSize+``)
        .then(response => response.json())
        .then(data => {
            const table = document.getElementById("employeeTable");
            table.innerHTML = "";  // Clear the existing table data

            if (data.content && data.content.length > 0) {
                data.content.forEach(emp => {
                    const formattedDate = new Date(emp.joiningDate).toLocaleDateString();
                    const row = table.insertRow();

                    row.insertCell(0).textContent = emp.id;
                    row.insertCell(1).textContent = emp.name;
                    row.insertCell(2).textContent = emp.email;
                    row.insertCell(3).textContent = emp.department;
                    row.insertCell(4).textContent = emp.designation;
                    row.insertCell(5).textContent = emp.salary;
                    row.insertCell(6).textContent = formattedDate;

                    const actionsCell = row.insertCell(7);
                    actionsCell.classList.add("actions-cell");
                    actionsCell.innerHTML = `
                        <a href="/update.jsp?id=`+emp.id+`" class="btn btn-edit">Edit</a>
                        <button onclick="deleteEmployee(${emp.id})" class="btn btn-delete">Delete</button>
                    `;
                });
            }

            // Render pagination
            renderPagination(data.totalPages, page);
        })
        .catch(error => console.error('Error fetching employees:', error));
}

// Render pagination
function renderPagination(totalPages, currentPage) {
    const pagination = document.getElementById("paginationControls");
    pagination.innerHTML = "";  // Clear existing pagination buttons

    // Previous button
    if (currentPage > 0) {
        const prevBtn = document.createElement("button");
        prevBtn.textContent = "Previous";
        prevBtn.onclick = function() {
            loadEmployees(currentPage - 1);  // Load the previous page
        };
        pagination.appendChild(prevBtn);
    }

    // Page buttons
    for (let i = 0; i < totalPages; i++) {
        const btn = document.createElement("button");
        btn.textContent = i + 1;

        if (i === currentPage) {
            btn.classList.add("active");
        }

        btn.onclick = function () {
            loadEmployees(i);  // Load the clicked page
        };

        pagination.appendChild(btn);
    }

    // Next button
    if (currentPage < totalPages - 1) {
        const nextBtn = document.createElement("button");
        nextBtn.textContent = "Next";
        nextBtn.onclick = function() {
            loadEmployees(currentPage + 1);  // Load the next page
        };
        pagination.appendChild(nextBtn);
    }
}

// Load the first page on page load
window.onload = function () {
    loadEmployees(0);  // Load the first page (0-based index)
};

// Delete employee function
function deleteEmployee(id) {
    if (confirm("Are you sure you want to delete this employee?")) {
        fetch(`/employee/delete/`+id+``, {
            method: 'DELETE'
        })
        .then(response => response.text())
        .then(result => {
            document.getElementById('statusMessage').textContent = "Employee Deleted Successfully!";
            loadEmployees(currentPage); // Refresh the table
        })
        .catch(error => {
            document.getElementById('responseMessage').textContent = "Failed to delete the employee.";
            console.error('Error:', error);
        });
    }
}
</script>

</body>
</html>
