<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Registration</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 30px 40px; /* Reduced padding */
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 380px; /* Reduced width */
        }

        h2 {
            text-align: center;
            margin-bottom: 15px; /* Reduced space below title */
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 8px; /* Reduced input padding */
            margin-bottom: 12px; /* Reduced space between inputs */
            border: 1px solid #ccc;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus {
            border-color: #007BFF;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            outline: none;
        }

        button {
            width: 100%;
            padding: 10px; /* Reduced button padding */
            background-color: #007BFF;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .footer {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        .footer a {
            color: #007BFF;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Employee Registration </h2>

    <form action="${pageContext.request.contextPath}/employee/create" method="post">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" placeholder="Enter employee name" required />

        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter employee email" required />

        <label for="department">Department</label>
        <input type="text" id="department" name="department" placeholder="Enter department" required />

        <label for="designation">Designation</label>
        <input type="text" id="designation" name="designation" placeholder="Enter designation" required />

        <label for="salary">Salary</label>
        <input type="number" id="salary" name="salary" placeholder="Enter salary" required />

        <label for="joiningDate">Joining Date</label>
        <input type="date" id="joiningDate" name="joiningDate" required />

        <button type="submit">Submit</button>
    </form>

  
</div>

</body>
</html>
