<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Pending Fine List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --success-color: #1cc88a;
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
            --danger-color: #dc3545;
            --warning-color: #ffc107;
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
            font-weight: 600;
        }

        .pending-badge {
            background-color: var(--warning-color);
            color: var(--text-dark);
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .overdue-badge {
            background-color: var(--danger-color);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .defaulter-badge {
            background-color: #6c757d;
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: bold;
        }

        .fine-amount {
            font-weight: 600;
            font-family: 'Courier New', Courier, monospace;
        }

        .fine-critical {
            color: var(--danger-color);
            font-weight: 700;
        }

        .app-header {
            background: linear-gradient(135deg, var(--danger-color), #c82333);
            color: white;
            padding: 1rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .app-title {
            font-weight: 700;
            letter-spacing: -0.5px;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .app-title i {
            margin-right: 12px;
            font-size: 1.8rem;
        }

        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: var(--danger-color);
            animation: spin 1s ease-in-out infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .search-container {
            position: relative;
            max-width: 400px;
            margin-bottom: 1.5rem;
        }

        .search-container i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
        }

        .search-input {
            padding-left: 40px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.25);
        }

        .no-results {
            text-align: center;
            padding: 2rem;
            color: var(--secondary-color);
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header class="app-header">
        <div class="container">
            <h1 class="app-title">
                <i class="fas fa-exclamation-circle"></i>Pending Fine List
            </h1>
        </div>
    </header>

    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <button class="btn btn-outline-primary" onclick="window.history.back()">
                        <i class="fas fa-arrow-left me-2"></i>Back
                    </button>
                    
                    <div class="search-container">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" class="form-control search-input" 
                               placeholder="Search by CRN, Name or Contact...">
                    </div>
                    
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
                                        <th>Student Name</th>
                                        <th>Contact</th>
                                        <th>Issue Date</th>
                                        <th>Due Date</th>
                                        <th>Total Fine (₹)</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody id="defaultersTable">
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <div class="loading-spinner"></div>
                                            <span>Loading pending fines...</span>
                                        </td>
                                    </tr>
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
                url: 'PendingFineServlet',
                type: 'POST',
                dataType: 'json',
                beforeSend: function() {
                    $('#defaultersTable').html('<tr><td colspan="7" class="text-center py-4"><div class="loading-spinner"></div><span>Loading pending fines...</span></td></tr>');
                },
                success: function(response) {
                    if (response.success && response.data.length > 0) {
                        renderDefaultersTable(response.data);
                    } else {
                        $('#defaultersTable').html('<tr><td colspan="7" class="text-center py-4 text-muted"><i class="fas fa-check-circle me-2"></i>No pending fines found</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    $('#defaultersTable').html('<tr><td colspan="7" class="text-center py-4 text-danger"><i class="fas fa-exclamation-circle me-2"></i>Error loading data: ' + error + '</td></tr>');
                }
            });
        }

        // Function to render defaulters table
        function renderDefaultersTable(data) {
            let tableHtml = '';
            
            data.forEach(function(defaulter) {
                const fineAmount = parseFloat(defaulter.totalFine);
                const isCritical = fineAmount > 500;
                
                let statusClass, statusText;
                if (defaulter.status === 'OVERDUE') {
                    statusClass = 'overdue-badge';
                    statusText = 'OVERDUE';
                } else if (defaulter.status === 'DEFAULTER') {
                    statusClass = 'defaulter-badge';
                    statusText = 'DEFAULTER';
                } else {
                    statusClass = 'pending-badge';
                    statusText = 'PENDING';
                }
                
                // Format dates
                const issueDate = new Date(defaulter.issueDate).toLocaleDateString();
                const dueDate = new Date(defaulter.dueDate).toLocaleDateString();
                
                tableHtml += `
                    <tr>
                        <td>${defaulter.crn}</td>
                        <td>${defaulter.name}</td>
                        <td>${defaulter.contact || 'N/A'}</td>
                        <td>${issueDate}</td>
                        <td>${dueDate}</td>
                        <td class="fine-amount ${isCritical ? 'fine-critical' : ''}">₹${fineAmount.toFixed(2)}</td>
                        <td><span class="${statusClass}">${statusText}</span></td>
                    </tr>
                `;
            });
            
            $('#defaultersTable').html(tableHtml);
        }

        // Search functionality
        $('#searchInput').on('input', function() {
            const searchTerm = $(this).val().toLowerCase();
            const rows = $('#defaultersTable tr');
            let hasMatches = false;
            
            rows.each(function() {
                const row = $(this);
                const text = row.text().toLowerCase();
                const isMatch = text.includes(searchTerm);
                
                if (isMatch) {
                    hasMatches = true;
                    row.show();
                } else {
                    row.hide();
                }
            });
            
            // Show no results message if no matches found
            if (!hasMatches && searchTerm.length > 0) {
                $('#defaultersTable').html('<tr><td colspan="7" class="no-results"><i class="fas fa-search me-2"></i>No matching records found</td></tr>');
            } else if (!hasMatches && searchTerm.length === 0) {
                // If search is cleared but no rows are visible
                loadDefaulters();
            }
        });
    });
    </script>
</body>
</html>