<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Defaulter Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --danger-color: #e74a3b;
            --card-bg-light: #ffffff;
            --card-bg-dark: #16213e;
            --text-light: #212529;
            --text-dark: #f8f9fa;
            --body-bg-light: #f8f9fa;
            --body-bg-dark: #1a1a2e;
        }

        [data-bs-theme="dark"] {
            --bs-body-bg: var(--body-bg-dark);
            --bs-body-color: var(--text-dark);
            --card-bg: var(--card-bg-dark);
            --primary-color: #5a67d8;
            --border-color: #495057;
        }

        [data-bs-theme="light"] {
            --bs-body-bg: var(--body-bg-light);
            --bs-body-color: var(--text-light);
            --card-bg: var(--card-bg-light);
            --border-color: #dee2e6;
        }

        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
            transition: all 0.3s ease;
        }

        .card {
            background-color: var(--card-bg);
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
        }

        .theme-toggle-btn {
            transition: transform 0.3s;
        }
        .theme-toggle-btn:hover {
            transform: rotate(15deg);
        }

        .table-responsive {
            overflow-x: auto;
        }

        .table th {
            background-color: var(--danger-color);
            color: white;
        }

        .defaulter-badge {
            background-color: var(--danger-color);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <button class="btn btn-outline-primary" onclick="window.history.back()">
                        <i class="fas fa-arrow-left me-2"></i>Back
                    </button>
                    <h2 class="text-center mb-0 fw-bold" style="color: var(--danger-color);">
                        <i class="fas fa-exclamation-triangle me-2"></i>Defaulter Students
                    </h2>
                    <button id="themeToggle" class="btn btn-outline-secondary theme-toggle-btn">
                        <i class="fas fa-moon"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-12">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>CRN</th>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Contact</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody id="defaultersTable">
                                    <!-- Data will be loaded via AJAX -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    $(document).ready(function() {
        // Theme Toggle Functionality
        function initTheme() {
            const savedTheme = localStorage.getItem('theme') || 'light';
            $('html').attr('data-bs-theme', savedTheme);
            $('#themeToggle i').removeClass('fa-moon fa-sun').addClass(savedTheme === 'dark' ? 'fa-sun' : 'fa-moon');
        }

        $('#themeToggle').click(function() {
            const currentTheme = $('html').attr('data-bs-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            
            $('html').attr('data-bs-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            $('#themeToggle i').removeClass('fa-moon fa-sun').addClass(newTheme === 'dark' ? 'fa-sun' : 'fa-moon');
        });

        initTheme();

        // Load defaulters data on page load
        loadDefaulters();

        // Function to load defaulters data
        function loadDefaulters() {
            $.ajax({
                url: 'DefaulterStudentsServlet',
                type: 'POST',  // Changed to POST to match servlet
                dataType: 'json',
                beforeSend: function() {
                    $('#defaultersTable').html('<tr><td colspan="5" class="text-center"><i class="fas fa-spinner fa-spin me-2"></i>Loading...</td></tr>');
                },
                success: function(response) {
                    if (response.success && response.data.length > 0) {
                        renderDefaultersTable(response.data);
                    } else {
                        $('#defaultersTable').html('<tr><td colspan="5" class="text-center">No defaulter students found</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    $('#defaultersTable').html('<tr><td colspan="5" class="text-center text-danger">Error loading data: ' + error + '</td></tr>');
                }
            });
        }

        // Function to render defaulters table
        function renderDefaultersTable(data) {
            let tableHtml = '';
            
            data.forEach(function(defaulter) {
                tableHtml += `
                    <tr>
                        <td>${defaulter.crn}</td>
                        <td>${defaulter.studentName}</td>
                        <td>${defaulter.course}</td>
                        <td>${defaulter.contact}</td>
                        <td><span class="defaulter-badge">${defaulter.status}</span></td>
                    </tr>
                `;
            });
            
            $('#defaultersTable').html(tableHtml);
        }
    });
    </script>
</body>
</html>