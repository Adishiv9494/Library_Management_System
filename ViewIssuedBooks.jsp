<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>View Issued Books with Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --danger-color: #e74a3b;
            --warning-color: #f6c23e;
            --card-bg-light: #ffffff;
            --card-bg-dark: #16213e;
            --text-light: #212529;
            --text-dark: #f8f9fa;
            --body-bg-light: #f8f9fa;
            --body-bg-dark: #1a1a2e;
            --table-bg-light: #ffffff;
            --table-bg-dark: #16213e;
            --table-border-light: #dee2e6;
            --table-border-dark: #495057;
        }

        [data-bs-theme="dark"] {
            --primary-color: #4e73df;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --info-color: #36b9cc;
            --body-bg: #1a1a2e;
            --card-bg: #16213e;
            --text-color: #f8f9fa;
            --border-color: #2c3e50;
        }

        [data-bs-theme="light"] {
            --bs-body-bg: var(--body-bg-light);
            --bs-body-color: var(--text-light);
            --card-bg: var(--card-bg-light);
            --border-color: #dee2e6;
            --table-bg: var(--table-bg-light);
            --table-border: var(--table-border-light);
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
            margin-bottom: 1rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .theme-toggle-btn {
            transition: transform 0.3s;
        }
        .theme-toggle-btn:hover {
            transform: rotate(15deg);
        }

        .table-container {
            border-radius: 0.75rem;
            overflow: hidden;
            margin-top: 1rem;
        }

        .dataTables_wrapper .dataTables_filter input {
            background-color: var(--card-bg);
            color: var(--bs-body-color);
            border: 1px solid var(--border-color);
            margin-left: 0.5rem;
        }

        .dataTables_wrapper .dataTables_length select {
            background-color: var(--card-bg);
            color: var(--bs-body-color);
            border: 1px solid var(--border-color);
        }

        table.dataTable {
            background-color: var(--table-bg);
            border-color: var(--table-border) !important;
            width: 100% !important;
            margin: 0 !important;
        }

        table.dataTable thead th {
            border-bottom-color: var(--table-border) !important;
            white-space: nowrap;
            padding: 12px 15px;
            background-color: rgba(var(--primary-color), 0.1);
        }

        table.dataTable tbody td {
            border-top-color: var(--table-border) !important;
            padding: 10px 15px;
            vertical-align: middle;
        }

        .status-badge {
            padding: 0.5em 0.75em;
            font-size: 0.8em;
            font-weight: 700;
            border-radius: 0.375rem;
            white-space: nowrap;
            display: inline-block;
            text-align: center;
            min-width: 80px;
        }

        .status-pending {
            background-color: rgba(78, 115, 223, 0.2);
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }

        .status-overdue {
            background-color: rgba(246, 194, 62, 0.2);
            color: var(--warning-color);
            border: 1px solid var(--warning-color);
        }

        .status-defaulter {
            background-color: rgba(231, 74, 59, 0.2);
            color: var(--danger-color);
            border: 1px solid var(--danger-color);
        }

        /* Print styles */
        @media print {
            body * {
                visibility: hidden;
            }
            .print-area, .print-area * {
                visibility: visible;
            }
            .print-area {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }
            .no-print {
                display: none !important;
            }
            .print-header {
                display: block !important;
            }
            .dataTables_info, .dataTables_length, .dataTables_filter {
                display: none !important;
            }
            table {
                width: 100% !important;
            }
        }

        /* Print header styles */
        .print-header {
            display: none;
            text-align: center;
            margin-bottom: 20px;
        }

        .print-header img {
            height: 80px;
            margin-bottom: 10px;
        }

        .print-header h2 {
            margin: 0;
            font-size: 22px;
        }

        .print-header p {
            margin: 5px 0;
            font-size: 14px;
        }

        /* Date filter styles */
        .date-filter-container {
            display: none;
            background: var(--card-bg);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid var(--border-color);
        }

        .date-filter-container.active {
            display: block;
        }

        .quick-date-btn {
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .date-input-group {
            margin-top: 10px;
        }

        /* Responsive adjustments */
        .container-fluid {
            padding: 0 15px;
        }

        /* Make table header sticky */
        .dataTables_scrollHead {
            position: sticky;
            top: 0;
            z-index: 10;
        }

        /* Adjust column widths */
        #bookIssuesTable th:nth-child(1), #bookIssuesTable td:nth-child(1) { width: 80px; } /* Issue ID */
        #bookIssuesTable th:nth-child(2), #bookIssuesTable td:nth-child(2) { width: 100px; } /* CRN */
        #bookIssuesTable th:nth-child(3), #bookIssuesTable td:nth-child(3) { min-width: 180px; } /* Student Name */
        #bookIssuesTable th:nth-child(4), #bookIssuesTable td:nth-child(4) { width: 120px; } /* Contact */
        #bookIssuesTable th:nth-child(5), #bookIssuesTable td:nth-child(5) { width: 120px; } /* Course */
        #bookIssuesTable th:nth-child(6), #bookIssuesTable td:nth-child(6) { width: 120px; } /* Accession No */
        #bookIssuesTable th:nth-child(7), #bookIssuesTable td:nth-child(7) { min-width: 200px; } /* Book Title */
        #bookIssuesTable th:nth-child(8), #bookIssuesTable td:nth-child(8) { min-width: 150px; } /* Author */
        #bookIssuesTable th:nth-child(9), #bookIssuesTable td:nth-child(9) { width: 80px; } /* Edition */
        #bookIssuesTable th:nth-child(10), #bookIssuesTable td:nth-child(10) { width: 110px; } /* Issue Date */
        #bookIssuesTable th:nth-child(11), #bookIssuesTable td:nth-child(11) { width: 110px; } /* Due Date */
        #bookIssuesTable th:nth-child(12), #bookIssuesTable td:nth-child(12) { width: 120px; } /* Status */
        #bookIssuesTable th:nth-child(13), #bookIssuesTable td:nth-child(13) { width: 100px; } /* Fine */

        /* Responsive adjustments for smaller screens */
        @media (max-width: 768px) {
            .card-body {
                padding: 1rem;
            }
            
            .container-fluid {
                padding: 0 10px;
            }
            
            #bookIssuesTable th, #bookIssuesTable td {
                padding: 8px 10px;
                font-size: 0.9em;
            }
            
            .status-badge {
                padding: 0.4em 0.6em;
                font-size: 0.75em;
                min-width: 70px;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid py-3">
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <button class="btn btn-outline-primary" onclick="window.history.back()">
                                <i class="fas fa-arrow-left me-2"></i>Back
                            </button>
                            <h2 class="text-center mb-0 fw-bold" style="color: var(--primary-color);">
                                <i class="fas fa-book-open me-2"></i>Book Issuance Records
                            </h2>
                            <button id="themeToggle" class="btn btn-outline-secondary theme-toggle-btn">
                                <i class="fas fa-moon"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm print-area">
                    <div class="card-body">
                        <!-- Print header (hidden by default) -->
                        <div class="print-header">
                            <img src="logo2.jpg" alt="Library Logo">
                            <h2>Library Issued Books Report</h2>
                            <p id="printDateRange">All Issued Books</p>
                            <p>Generated on: <span id="printCurrentDate"></span></p>
                        </div>

                        <div class="print-actions no-print mb-3">
                            <button class="btn btn-success" id="printBtn">
                                <i class="fas fa-print mr-2"></i>Print Report
                            </button>
                            <button class="btn btn-info" id="filterBtn">
                                <i class="fas fa-filter mr-2"></i>Filter by Date
                            </button>
                            <button class="btn btn-primary float-right" id="refreshBtn">
                                <i class="fas fa-sync-alt mr-2"></i>Refresh
                            </button>
                        </div>
                        
                        <div class="date-filter-container no-print" id="dateFilterContainer">
                            <h5><i class="fas fa-calendar-alt mr-2"></i>Filter by Date Range</h5>
                            <div class="quick-date-buttons mb-3">
                                <button class="btn btn-sm btn-outline-secondary quick-date-btn" data-days="30">Last 30 Days</button>
                                <button class="btn btn-sm btn-outline-secondary quick-date-btn" data-days="60">Last 60 Days</button>
                                <button class="btn btn-sm btn-outline-secondary quick-date-btn" data-days="90">Last 90 Days</button>
                                <button class="btn btn-sm btn-outline-secondary quick-date-btn" data-days="0">All Time</button>
                            </div>
                            <div class="date-input-group">
                                <div class="form-row">
                                    <div class="col-md-5">
                                        <label for="fromDate">From Date</label>
                                        <input type="date" class="form-control" id="fromDate">
                                    </div>
                                    <div class="col-md-5">
                                        <label for="toDate">To Date</label>
                                        <input type="date" class="form-control" id="toDate">
                                    </div>
                                    <div class="col-md-2 d-flex align-items-end">
                                        <button class="btn btn-primary btn-block" id="applyFilter">Apply</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="table-responsive table-container">
                            <table id="bookIssuesTable" class="table table-hover w-100">
                                <thead>
                                    <tr>
                                        <th>Issue ID</th>
                                        <th>CRN</th>
                                        <th>Student Name</th>
                                        <th>Contact</th>
                                        <th>Course</th>
                                        <th>Accession No</th>
                                        <th>Book Title</th>
                                        <th>Author</th>
                                        <th>Edition</th>
                                        <th>Issue Date</th>
                                        <th>Due Date</th>
                                        <th>Status</th>
                                        <th>Fine (₹)</th>
                                    </tr>
                                </thead>
                                <tbody>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

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
            
            bookIssuesTable.ajax.reload(null, false);
        });

        initTheme();

        // Initialize DataTable
        const bookIssuesTable = $('#bookIssuesTable').DataTable({
            ajax: {
                url: 'ViewIssuedBooks',
                type: 'POST',
                data: function(d) {
                    // Add date filter parameters if they exist
                    const fromDate = $('#fromDate').val();
                    const toDate = $('#toDate').val();
                    if (fromDate && toDate) {
                        d.fromDate = fromDate;
                        d.toDate = toDate;
                    }
                },
                dataSrc: function(json) {
                    console.log("Data received:", json);
                    if (json.success) {
                        return json.data;
                    } else {
                        console.error("Error:", json.message);
                        return [];
                    }
                },
                error: function(xhr, error, thrown) {
                    console.error("AJAX Error:", xhr.responseText);
                }
            },
            columns: [
                { data: 'issueId' },
                { data: 'crn' },
                { data: 'studentName' },
                { data: 'contact' },
                { data: 'course' },
                { data: 'accessionNumber' },
                { data: 'bookTitle' },
                { data: 'author' },
                { data: 'edition' },
                { 
                    data: 'issueDate',
                    render: function(data) {
                        return data ? new Date(data).toLocaleDateString('en-IN') : 'N/A';
                    }
                },
                { 
                    data: 'dueDate',
                    render: function(data) {
                        return data ? new Date(data).toLocaleDateString('en-IN') : 'N/A';
                    }
                },
                { 
                    data: 'status',
                    render: function(data) {
                        let badgeClass = '';
                        switch(data.toUpperCase()) {
                            case 'PENDING': badgeClass = 'status-pending'; break;
                            case 'OVERDUE': badgeClass = 'status-overdue'; break;
                            case 'DEFAULTER': badgeClass = 'status-defaulter'; break;
                            default: badgeClass = 'status-pending';
                        }
                        return `<span class="status-badge ${badgeClass}">${data}</span>`;
                    }
                },
                { 
                    data: null,
                    render: function(data, type, row) {
                        // Calculate fine if book is overdue
                        if (row.status === 'OVERDUE' && row.dueDate) {
                            const dueDate = new Date(row.dueDate);
                            const today = new Date();
                            const diffTime = today - dueDate;
                            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                            const fineWeeks = Math.ceil(diffDays / 7);
                            return fineWeeks * 50; // ₹50 per week
                        }
                        return '0';
                    }
                }
            ],
            responsive: true,
            scrollX: true,
            scrollCollapse: true,
            scrollY: '60vh',
            language: {
                emptyTable: "No book issue records found",
                zeroRecords: "No matching records found",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "Showing 0 to 0 of 0 entries",
                infoFiltered: "(filtered from _MAX_ total entries)",
                search: "_INPUT_",
                searchPlaceholder: "Search...",
                lengthMenu: "Show _MENU_ entries",
                paginate: {
                    first: "First",
                    last: "Last",
                    next: "Next",
                    previous: "Previous"
                }
            },
            dom: '<"top"<"d-flex justify-content-between align-items-center"lf>>rt<"bottom"<"d-flex justify-content-between align-items-center"ip>>',
            initComplete: function() {
                $('.dataTables_filter input').attr('placeholder', 'Search...');
            }
        });

        // Toggle date filter container
        $('#filterBtn').click(function() {
            $('#dateFilterContainer').toggleClass('active');
        });

        // Quick date buttons
        $('.quick-date-btn').click(function() {
            const days = $(this).data('days');
            if (days > 0) {
                const fromDate = new Date();
                fromDate.setDate(fromDate.getDate() - days);
                
                const toDate = new Date();
                
                $('#fromDate').val(formatDate(fromDate));
                $('#toDate').val(formatDate(toDate));
                
                // Apply filter
                bookIssuesTable.ajax.reload();
                updatePrintDateRange(formatDisplayDate(fromDate) + ' to ' + formatDisplayDate(toDate));
            } else {
                // Clear date filters
                $('#fromDate').val('');
                $('#toDate').val('');
                bookIssuesTable.ajax.reload();
                updatePrintDateRange("All Time");
            }
        });

        // Apply date filter
        $('#applyFilter').click(function() {
            const fromDate = $('#fromDate').val();
            const toDate = $('#toDate').val();
            
            if (fromDate && toDate) {
                if (new Date(fromDate) > new Date(toDate)) {
                    alert('From Date cannot be after To Date');
                    return;
                }
                
                bookIssuesTable.ajax.reload();
                updatePrintDateRange(formatDisplayDate(fromDate) + ' to ' + formatDisplayDate(toDate));
            } else {
                alert('Please select both From and To dates');
            }
        });

        // Refresh button
        $('#refreshBtn').click(function() {
            bookIssuesTable.ajax.reload();
        });

        // Print button
        $('#printBtn').click(function() {
            // Update print header with current date range
            const fromDate = $('#fromDate').val();
            const toDate = $('#toDate').val();
            
            if (fromDate && toDate) {
                $('#printDateRange').text('Date Range: ' + formatDisplayDate(fromDate) + ' to ' + formatDisplayDate(toDate));
            } else {
                $('#printDateRange').text('All Issued Books');
            }
            
            // Update current date
            const today = new Date();
            $('#printCurrentDate').text(today.toLocaleDateString());
            
            // Trigger print
            window.print();
        });

        // Helper function to format date as YYYY-MM-DD
        function formatDate(date) {
            const d = new Date(date);
            let month = '' + (d.getMonth() + 1);
            let day = '' + d.getDate();
            const year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        }

        // Helper function to format date for display (e.g., May 15, 2023)
        function formatDisplayDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
        }

        // Update the print date range text
        function updatePrintDateRange(rangeText) {
            $('#printDateRange').text('Date Range: ' + rangeText);
        }

        // Set default dates (last 30 days)
        const defaultFromDate = new Date();
        defaultFromDate.setDate(defaultFromDate.getDate() - 30);
        const defaultToDate = new Date();
        
        $('#fromDate').val(formatDate(defaultFromDate));
        $('#toDate').val(formatDate(defaultToDate));
        
        // Apply default filter
        bookIssuesTable.ajax.reload();
        updatePrintDateRange(formatDisplayDate(defaultFromDate) + ' to ' + formatDisplayDate(defaultToDate));

        // Auto-refresh every 30 seconds
        setInterval(function() {
            bookIssuesTable.ajax.reload(null, false);
        }, 30000);
    });
    </script>
</body>
</html>