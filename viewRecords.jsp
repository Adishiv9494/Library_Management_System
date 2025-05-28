<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>View Records</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Embedded CSS */
        body {
            padding: 20px;
            background: linear-gradient(115deg, #f5f5f5, #e0e0e0);
            color: #333;
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
            transition: background 0.3s ease, color 0.3s ease;
        }

        body.dark-mode {
            background: linear-gradient(115deg, #121212, #333333);
            color: white;
        }

        .container {
            max-width: 1500px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5rem;
            color: #333;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        body.dark-mode h1 {
            color: white;
        }

         .back-button {
            position: fixed;
            top: 20px;
            left: 20px;
            background-color: #2189f0;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .back-button:hover {
            background-color: #1a6bbf;
            transform: scale(1.05);
        }

        .back-button i {
            margin-right: 5px;
        }


        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-bar input {
            padding: 10px;
            width: 300px;
            border: 1px solid #2189f0;
            border-radius: 5px 0 0 5px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .search-bar input:focus {
            border-color: #1a6bbf;
            box-shadow: 0 0 8px rgba(33, 137, 240, 0.6);
        }

        .search-bar button {
            padding: 10px 20px;
            background: #2189f0;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .search-bar button:hover {
            background-color: #1a6bbf;
            transform: scale(1.05);
        }

        .table-container {
            display: flex;
            gap: 20px;
        }

        /* Adjust table widths */
        .table-section.student-table {
            width: 50%; /* Increased width for Student Records */
        }

        .table-section.book-table {
            width: 50%; /* Increased width for Book Records */
        }

        .table-section {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .table-section table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .table-section th,
        .table-section td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table-section th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }

        .table-section tr {
            background-color: rgba(255, 255, 255, 0.9);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .table-section tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .show-more {
            text-align: center;
            margin-top: 20px;
        }

        .show-more select {
            padding: 5px 10px;
            border: 1px solid #2189f0;
            border-radius: 5px;
            cursor: pointer;
        }

        .show-more select:focus {
            outline: none;
            border-color: #1a6bbf;
        }

        /* Dark Mode Styles */
        body.dark-mode .table-section {
            background-color: rgba(0, 0, 0, 0.8);
            color: white;
        }

        body.dark-mode .table-section th {
            background-color: #333;
        }

        body.dark-mode .table-section tr {
            background-color: rgba(255, 255, 255, 0.1);
        }

        body.dark-mode .table-section tr:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        body.dark-mode .search-bar input {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-color: #555;
        }

        body.dark-mode .search-bar input:focus {
            background-color: rgba(255, 255, 255, 0.2);
            border-color: #2189f0;
            box-shadow: 0 0 8px rgba(33, 137, 240, 0.6);
        }

        body.dark-mode .search-bar button {
            background-color: #555;
        }

        body.dark-mode .search-bar button:hover {
            background-color: #666;
        }

        /* Dark/Light Mode Toggle Button */
        #mode-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(115deg, #0a0a0a, #4e54c8);
            border: 2px solid rgba(255, 165, 0, 0.6);
            color: #ff6600;
            padding: 10px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0px 5px 15px rgba(255, 165, 0, 0.5);
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
        }

        #mode-toggle:hover {
            background: rgba(255, 102, 0, 0.2);
            transform: scale(1.1);
        }

        body.dark-mode #mode-toggle {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-color: white;
        }
    </style>
</head>
<body>
    <!-- Back Button -->
    <button class="back-button" onclick="goBack()">
        <i class="fas fa-arrow-left"></i> Back
    </button>

    <!-- Dark/Light Mode Toggle Button -->
    <button id="mode-toggle" onclick="toggleDarkMode()">
        <i class="fas fa-moon"></i>
    </button>

    <div class="container">
        <h1>View Records</h1>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search by Student ID or Book ID" class="form-control">
            <button onclick="searchRecords()" class="btn-custom">Search</button>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <!-- Student Records Table -->
            <div class="table-section student-table">
                <h2>Student Records</h2>
                <table id="studentTable" class="table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Contact Number</th>
                            <th>Course</th>
                        </tr>
                    </thead>
                    <tbody id="studentBody">
                        <!-- Student records will be populated here -->
                    </tbody>
                </table>
                <!-- Show More Options -->
                <div class="show-more">
                    <select onchange="updateLimit(this.value)">
                        <option value="10">Show 10 Records</option>
                        <option value="20">Show 20 Records</option>
                        <option value="50">Show 50 Records</option>
                        <option value="all">Show All Records</option>
                    </select>
                </div>
            </div>

            <!-- Book Records Table -->
            <div class="table-section book-table">
                <h2>Book Records</h2>
                <table id="bookTable" class="table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Book ID</th>
                            <th>Book Name</th>
                            <th>Author Name</th>
                            <th>Book Description</th>
                        </tr>
                    </thead>
                    <tbody id="bookBody">
                        <!-- Book records will be populated here -->
                    </tbody>
                </table>
                <!-- Show More Options -->
                <div class="show-more">
                    <select onchange="updateLimit(this.value)">
                        <option value="10">Show 10 Records</option>
                        <option value="20">Show 20 Records</option>
                        <option value="50">Show 50 Records</option>
                        <option value="all">Show All Records</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <script>
 // Function for the back button
    function goBack() {
            window.history.back();
        }
        

        // Function to populate the student table
        function populateStudentTable() {
            const studentBody = document.getElementById("studentBody");
            studentBody.innerHTML = ""; // Clear existing rows
            students.forEach(student => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${student.id}</td>
                    <td>${student.name}</td>
                    <td>${student.contact}</td>
                    <td>${student.course}</td>
                `;
                studentBody.appendChild(row);
            });
        }

        // Function to populate the book table
        function populateBookTable() {
            const bookBody = document.getElementById("bookBody");
            bookBody.innerHTML = ""; // Clear existing rows
            books.forEach(book => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${book.id}</td>
                    <td>${book.name}</td>
                    <td>${book.author}</td>
                    <td>${book.description}</td>
                `;
                bookBody.appendChild(row);
            });
        }

        // Function to search records
        function searchRecords() {
            const searchValue = document.getElementById("searchInput").value.toLowerCase();
            const filteredStudents = students.filter(student =>
                student.id.toLowerCase().includes(searchValue) ||
                student.name.toLowerCase().includes(searchValue)
            );
            const filteredBooks = books.filter(book =>
                book.id.toLowerCase().includes(searchValue) ||
                book.name.toLowerCase().includes(searchValue)
            );

            // Update tables with filtered data
            updateTable(filteredStudents, "studentBody");
            updateTable(filteredBooks, "bookBody");
        }

        // Function to update a table with data
        function updateTable(data, tableBodyId) {
            const tableBody = document.getElementById(tableBodyId);
            tableBody.innerHTML = ""; // Clear existing rows
            data.forEach(item => {
                const row = document.createElement("tr");
                row.innerHTML = Object.values(item).map(value => `<td>${value}</td>`).join("");
                tableBody.appendChild(row);
            });
        }

        // Function to update the record limit
        function updateLimit(limit) {
            const studentData = limit === "all" ? students : students.slice(0, limit);
            const bookData = limit === "all" ? books : books.slice(0, limit);
            updateTable(studentData, "studentBody");
            updateTable(bookData, "bookBody");
        }

        // Function to toggle dark mode
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
            const icon = document.querySelector("#mode-toggle i");
            if (document.body.classList.contains("dark-mode")) {
                icon.classList.remove("fa-moon");
                icon.classList.add("fa-sun");
            } else {
                icon.classList.remove("fa-sun");
                icon.classList.add("fa-moon");
            }
        }

        

        // Initialize tables on page load
        document.addEventListener("DOMContentLoaded", () => {
            populateStudentTable();
            populateBookTable();
        });
    </script>
</body>
</html>