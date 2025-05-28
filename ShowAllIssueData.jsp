<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Issued Book Records</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
    <!-- Flatpickr for date range -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
    <style>
        :root {
            --bs-body-bg: #f8f9fa;
            --bs-body-color: #212529;
            --card-bg: #ffffff;
            --table-bg: #ffffff;
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --issued-color: #4e73df;
            --returned-color: #1cc88a;
            --overdue-color: #e74a3b;
            --lost-color: #f6c23e;
        }
        
        [data-bs-theme="dark"] {
            --bs-body-bg: #1a1a2e;
            --bs-body-color: #f8f9fa;
            --card-bg: #16213e;
            --table-bg: #16213e;
            --primary-color: #5a67d8;
            --secondary-color: #a0aec0;
            --issued-color: #5a67d8;
            --returned-color: #10b981;
            --overdue-color: #ef4444;
            --lost-color: #f59e0b;
        }
        
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
            transition: all 0.3s ease;
        }
        
        .card {
            background-color: var(--card-bg);
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .table {
            background-color: var(--table-bg);
            color: var(--bs-body-color);
            margin-bottom: 0;
        }
        
        .table th {
            border-bottom-width: 1px;
            border-top: none;
            background-color: rgba(78, 115, 223, 0.1);
            color: var(--primary-color);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
        }
        
        .table td {
            vertical-align: middle;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: #3a56c7;
            border-color: #3a56c7;
        }
        
        .form-control, .form-select {
            background-color: var(--card-bg);
            color: var(--bs-body-color);
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 0.35rem;
        }
        
        .form-control:focus, .form-select:focus {
            background-color: var(--card-bg);
            color: var(--bs-body-color);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        .pagination .page-item .page-link {
            background-color: var(--card-bg);
            border-color: rgba(0, 0, 0, 0.1);
            color: var(--bs-body-color);
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .record-info {
            font-size: 0.875rem;
            color: var(--secondary-color);
        }
        
        .search-card {
            border-left: 0.25rem solid var(--primary-color) !important;
        }
        
        .back-btn {
            transition: all 0.3s;
        }
        
        .back-btn:hover {
            transform: translateX(-3px);
        }
        
        .theme-toggle {
            transition: all 0.3s;
        }
        
        .theme-toggle:hover {
            transform: rotate(15deg);
        }
        
        .spinner-container {
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .empty-table {
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--secondary-color);
        }
        
        .student-name {
            font-weight: 500;
        }
        
        .book-title {
            font-weight: 500;
        }
        
        .author-name {
            font-style: italic;
        }
        
        .status-badge {
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-weight: 600;
            font-size: 0.75em;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .status-issued {
            background-color: rgba(78, 115, 223, 0.1);
            color: var(--issued-color);
        }
        
        .status-returned {
            background-color: rgba(28, 200, 138, 0.1);
            color: var(--returned-color);
        }
        
        .status-overdue {
            background-color: rgba(231, 74, 59, 0.1);
            color: var(--overdue-color);
        }
        
        .status-lost {
            background-color: rgba(246, 194, 62, 0.1);
            color: var(--lost-color);
        }
        
        .serial-number {
            color: var(--secondary-color);
            font-weight: 500;
        }
        
        .fine-amount {
            font-weight: 500;
            color: #e74a3b;
        }
        
        [data-bs-theme="dark"] .fine-amount {
            color: #ef4444;
        }
        
        .due-date {
            font-weight: 500;
        }
        
        .overdue {
            color: #e74a3b;
            font-weight: 600;
        }
        
        [data-bs-theme="dark"] .overdue {
            color: #ef4444;
        }
        
        .date-range-selector {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .date-range-btn {
            white-space: nowrap;
        }
        
        .custom-date-container {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .flatpickr-input {
            background-color: var(--card-bg) !important;
            color: var(--bs-body-color) !important;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <button class="btn btn-outline-primary back-btn" onclick="window.history.back()">
                        <i class="fas fa-arrow-left me-2"></i>Back
                    </button>
                    <h2 class="text-center mb-0 fw-bold" style="color: var(--primary-color);">
                        <i class="fas fa-book-open me-2"></i>Issued Book Records
                    </h2>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-success" id="printPdfBtn">
                            <i class="fas fa-file-pdf me-2"></i>Print
                        </button>
                        <button id="themeToggle" class="btn btn-outline-secondary theme-toggle">
                            <i class="fas fa-moon"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow-sm search-card">
                    <div class="card-body py-3">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-3">
                                <label for="searchInput" class="form-label fw-semibold">Search Records</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search by CRN, student name, book title...">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label for="statusFilter" class="form-label fw-semibold">Status</label>
                                <select class="form-select" id="statusFilter">
                                    <option value="">All Status</option>
                                    <option value="ISSUED">Issued</option>
                                    <option value="RETURNED">Returned</option>
                                    <option value="OVERDUE">Overdue</option>
                                    <option value="LOST">Lost</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Date Range</label>
                                <div class="date-range-selector">
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-outline-secondary date-range-btn" data-days="30">Last 30 Days</button>
                                        <button type="button" class="btn btn-outline-secondary date-range-btn" data-days="60">Last 60 Days</button>
                                        <button type="button" class="btn btn-outline-secondary date-range-btn" data-days="90">Last 90 Days</button>
                                        <button type="button" class="btn btn-outline-secondary date-range-btn" data-days="0">All Time</button>
                                    </div>
                                </div>
                                <div class="custom-date-container mt-2">
                                    <input type="text" class="form-control flatpickr-input" id="dateFrom" placeholder="From Date">
                                    <span class="mx-2">to</span>
                                    <input type="text" class="form-control flatpickr-input" id="dateTo" placeholder="To Date">
                                    <button type="button" class="btn btn-primary ms-2" id="applyCustomDate">Apply</button>
                                </div>
                            </div>
                            <div class="col-md-1 d-flex align-items-end">
                                <button class="btn btn-primary w-100" id="searchBtn">
                                    <i class="fas fa-search me-2"></i>Search
                                </button>
                            </div>
                            <div class="col-md-2">
                                <label for="limitSelect" class="form-label fw-semibold">Records per page</label>
                                <select class="form-select" id="limitSelect">
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover" id="issuesTable">
                                <thead>
                                    <tr>
                                        <th width="5%">S.No.</th>
                                        <th width="10%">CRN</th>
                                        <th width="15%">Student</th>
                                        <th width="10%">Contact</th>
                                        <th width="10%">Accession No.</th>
                                        <th width="15%">Book Title</th>
                                        <th width="10%">Issue Date</th>
                                        <th width="10%">Due Date</th>
                                        <th width="10%">Status</th>
                                        <th width="5%">Fine</th>
                                    </tr>
                                </thead>
                                <tbody id="issuesTableBody">
                                    <!-- Data will be loaded here -->
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center p-3 border-top">
                            <div id="recordInfo" class="record-info"></div>
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0" id="pagination">
                                    <!-- Pagination will be loaded here -->
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- jsPDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

    <!-- Flatpickr for date range -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script>
        $(document).ready(function() {
            let currentPage = 1;
            let currentLimit = 10;
            let currentSearch = '';
            let currentStatus = '';
            let dateRangeDays = 0; // 0 means all time
            let dateFrom = '';
            let dateTo = '';
            let totalRecords = 0;
            
            // Initialize theme
            const themeToggle = document.getElementById('themeToggle');
            const prefersDarkScheme = window.matchMedia('(prefers-color-scheme: dark)');
            
            if (localStorage.getItem('theme') === 'dark' || (!localStorage.getItem('theme') && prefersDarkScheme.matches)) {
                document.documentElement.setAttribute('data-bs-theme', 'dark');
                themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
            } else {
                document.documentElement.setAttribute('data-bs-theme', 'light');
                themeToggle.innerHTML = '<i class="fas fa-moon"></i>';
            }
            
            // Theme toggle
            themeToggle.addEventListener('click', function() {
                if (document.documentElement.getAttribute('data-bs-theme') === 'dark') {
                    document.documentElement.setAttribute('data-bs-theme', 'light');
                    themeToggle.innerHTML = '<i class="fas fa-moon"></i>';
                    localStorage.setItem('theme', 'light');
                } else {
                    document.documentElement.setAttribute('data-bs-theme', 'dark');
                    themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
                    localStorage.setItem('theme', 'dark');
                }
            });
            
            // Initialize date picker
            flatpickr("#dateFrom", {
                dateFormat: "Y-m-d",
                allowInput: true,
                theme: document.documentElement.getAttribute('data-bs-theme') === 'dark' ? 'dark' : 'default'
            });
            
            flatpickr("#dateTo", {
                dateFormat: "Y-m-d",
                allowInput: true,
                theme: document.documentElement.getAttribute('data-bs-theme') === 'dark' ? 'dark' : 'default'
            });
            
            // Date range button click handler
            $('.date-range-btn').click(function() {
                dateRangeDays = parseInt($(this).data('days'));
                dateFrom = '';
                dateTo = '';
                
                // Update active state
                $('.date-range-btn').removeClass('active');
                $(this).addClass('active');
                
                // Clear custom dates
                $('#dateFrom').val('');
                $('#dateTo').val('');
                
                loadIssuedBooksData();
            });
            
            // Apply custom date range
            $('#applyCustomDate').click(function() {
                dateFrom = $('#dateFrom').val();
                dateTo = $('#dateTo').val();
                dateRangeDays = 0; // Reset days filter when using custom dates
                
                // Update active state
                $('.date-range-btn').removeClass('active');
                
                if (dateFrom || dateTo) {
                    loadIssuedBooksData();
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'No Date Selected',
                        text: 'Please select at least one date for the range'
                    });
                }
            });
            
            // Load initial data
            loadIssuedBooksData();
            
            // Search button click event
            $('#searchBtn').click(function() {
                currentPage = 1;
                loadIssuedBooksData();
            });
            
            // Enter key in search input
            $('#searchInput').keypress(function(e) {
                if (e.which === 13) {
                    currentPage = 1;
                    loadIssuedBooksData();
                }
            });
            
            // Status filter change event
            $('#statusFilter').change(function() {
                currentStatus = $(this).val();
                currentPage = 1;
                loadIssuedBooksData();
            });
            
            // Limit select change event
            $('#limitSelect').change(function() {
                currentLimit = parseInt($(this).val());
                currentPage = 1;
                loadIssuedBooksData();
            });
            
            // Function to load issued book data
            function loadIssuedBooksData() {
                currentSearch = $('#searchInput').val().trim();
                
                $.ajax({
                    url: 'ViewAllIssuedBook',
                    type: 'GET',
                    data: {
                        page: currentPage,
                        limit: currentLimit,
                        search: currentSearch,
                        status: currentStatus,
                        days: dateRangeDays,
                        dateFrom: dateFrom,
                        dateTo: dateTo
                    },
                    dataType: 'json',
                    beforeSend: function() {
                        $('#issuesTableBody').html('<tr><td colspan="10" class="text-center"><div class="spinner-container"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div></td></tr>');
                    },
                    success: function(data) {
                        if (data.error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: data.error
                            });
                            return;
                        }
                        
                        totalRecords = data.totalRecords;
                        renderIssuedBooksData(data.data);
                        renderPagination();
                        updateRecordInfo();
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to load issued book data: ' + error
                        });
                    }
                });
            }
            // Function to render issued book data
            function renderIssuedBooksData(issues) {
                const tableBody = $('#issuesTableBody');
                tableBody.empty();
                
                if (issues.length === 0) {
                    tableBody.append('<tr><td colspan="10"><div class="empty-table"><i class="fas fa-info-circle me-2"></i>No records found</div></td></tr>');
                    return;
                }
                
                const startSerial = (currentPage - 1) * currentLimit + 1;
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                
                $.each(issues, function(index, issue) {
                    const row = $('<tr>');
                    
                    // Serial Number
                    row.append($('<td>').addClass('serial-number').text(startSerial + index));
                    
                    // CRN
                    row.append($('<td>').text(issue.crn));
                    
                    // Student Name with icon
                    const studentCell = $('<td>').addClass('student-name');
                    studentCell.append($('<i>').addClass('fas fa-user-graduate me-2'));
                    studentCell.append(document.createTextNode(issue.student_name));
                    row.append(studentCell);
                    
                    // Contact
                    row.append($('<td>').text(issue.contact));
                    
                    // Accession Number
                    row.append($('<td>').text(issue.accession_number));
                    
                    // Book Title with icon
                    const bookCell = $('<td>').addClass('book-title');
                    bookCell.append($('<i>').addClass('fas fa-book me-2'));
                    bookCell.append(document.createTextNode(issue.book_title));
                    row.append(bookCell);
                    
                    // Issue Date
                    const issueDate = new Date(issue.issue_date);
                    row.append($('<td>').text(issueDate.toLocaleDateString()));
                    
                    // Due Date - highlight if overdue
                    const dueDate = new Date(issue.due_date);
                    const dueDateCell = $('<td>').addClass('due-date');
                    if (issue.status === 'ISSUED' && dueDate < today) {
                        dueDateCell.addClass('overdue');
                    }
                    dueDateCell.text(dueDate.toLocaleDateString());
                    row.append(dueDateCell);
                    
                    // Status with badge
                    const statusCell = $('<td>');
                    const statusBadge = $('<span>').addClass('status-badge');
                    
                    switch(issue.status) {
                        case 'ISSUED':
                            statusBadge.addClass('status-issued').text('Issued');
                            break;
                        case 'RETURNED':
                            statusBadge.addClass('status-returned').text('Returned');
                            break;
                        case 'OVERDUE':
                            statusBadge.addClass('status-overdue').text('Overdue');
                            break;
                        case 'LOST':
                            statusBadge.addClass('status-lost').text('Lost');
                            break;
                    }
                    
                    statusCell.append(statusBadge);
                    row.append(statusCell);
                    
                    // Fine Amount
                    const fineCell = $('<td>').addClass('fine-amount');
                    if (issue.fine_amount > 0) {
                        fineCell.append($('<i>').addClass('fas fa-rupee-sign me-1'));
                        fineCell.append(document.createTextNode(issue.fine_amount.toFixed(2)));
                    } else {
                        fineCell.append($('<span>').addClass('text-muted').text('-'));
                    }
                    row.append(fineCell);
                    
                    tableBody.append(row);
                });
            }
            
            // Function to render pagination
            function renderPagination() {
                const totalPages = Math.ceil(totalRecords / currentLimit);
                const pagination = $('#pagination');
                pagination.empty();
                
                if (totalPages <= 1) return;
                
                // Previous button
                const prevLi = $('<li>').addClass('page-item').toggleClass('disabled', currentPage === 1);
                const prevLink = $('<a>').addClass('page-link').attr('href', '#').html('<i class="fas fa-chevron-left"></i>');
                prevLink.click(function(e) {
                    e.preventDefault();
                    if (currentPage > 1) {
                        currentPage--;
                        loadIssuedBooksData();
                    }
                });
                prevLi.append(prevLink);
                pagination.append(prevLi);
                
                // Page numbers
                const maxVisiblePages = 5;
                let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
                let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
                
                if (endPage - startPage + 1 < maxVisiblePages) {
                    startPage = Math.max(1, endPage - maxVisiblePages + 1);
                }
                
                if (startPage > 1) {
                    const firstLi = $('<li>').addClass('page-item');
                    const firstLink = $('<a>').addClass('page-link').attr('href', '#').text(1);
                    firstLink.click(function(e) {
                        e.preventDefault();
                        currentPage = 1;
                        loadIssuedBooksData();
                    });
                    firstLi.append(firstLink);
                    pagination.append(firstLi);
                    
                    if (startPage > 2) {
                        pagination.append($('<li>').addClass('page-item disabled').append($('<a>').addClass('page-link').text('...')));
                    }
                }
                
                for (let i = startPage; i <= endPage; i++) {
                    const pageLi = $('<li>').addClass('page-item').toggleClass('active', i === currentPage);
                    const pageLink = $('<a>').addClass('page-link').attr('href', '#').text(i);
                    pageLink.click(function(e) {
                        e.preventDefault();
                        currentPage = i;
                        loadIssuedBooksData();
                    });
                    pageLi.append(pageLink);
                    pagination.append(pageLi);
                }
                
                if (endPage < totalPages) {
                    if (endPage < totalPages - 1) {
                        pagination.append($('<li>').addClass('page-item disabled').append($('<a>').addClass('page-link').text('...')));
                    }
                    
                    const lastLi = $('<li>').addClass('page-item');
                    const lastLink = $('<a>').addClass('page-link').attr('href', '#').text(totalPages);
                    lastLink.click(function(e) {
                        e.preventDefault();
                        currentPage = totalPages;
                        loadIssuedBooksData();
                    });
                    lastLi.append(lastLink);
                    pagination.append(lastLi);
                }
                
                // Next button
                const nextLi = $('<li>').addClass('page-item').toggleClass('disabled', currentPage === totalPages);
                const nextLink = $('<a>').addClass('page-link').attr('href', '#').html('<i class="fas fa-chevron-right"></i>');
                nextLink.click(function(e) {
                    e.preventDefault();
                    if (currentPage < totalPages) {
                        currentPage++;
                        loadIssuedBooksData();
                    }
                });
                nextLi.append(nextLink);
                pagination.append(nextLi);
            }
            
            // Function to update record info
            function updateRecordInfo() {
                const startRecord = (currentPage - 1) * currentLimit + 1;
                const endRecord = Math.min(currentPage * currentLimit, totalRecords);
                $('#recordInfo').html(`<i class="fas fa-info-circle me-1"></i>Showing ${startRecord} to ${endRecord} of ${totalRecords} records`);
            }
            
            // Print PDF button click handler
            $('#printPdfBtn').on('click', function() {
                generatePDF();
            });
            
            // Function to generate PDF with properly sized logo
            function generatePDF() {
                try {
                    const { jsPDF } = window.jspdf;
                    const doc = new jsPDF('p', 'pt', 'a4');
                    
                    // First load the logo image
                    const logoUrl = 'logo2.png';
                    const img = new Image();
                    img.src = logoUrl;
                    
                    img.onload = function() {
                        // Calculate logo dimensions (max width 100px)
                        const maxWidth = 100;
                        const ratio = maxWidth / img.width;
                        const logoWidth = maxWidth;
                        const logoHeight = img.height * ratio;
                        
                        // Add header with logo and title to each page
                        const addHeader = () => {
                            // Add logo to the PDF (left side)
                            doc.addImage(img, 'PNG', 40, 20, logoWidth, logoHeight);
                            
                            // Add title and date to the right of the logo
                            doc.setFontSize(18);
                            doc.setTextColor(40);
                            doc.setFont("helvetica", "bold");
                            doc.text("Issued Book Records", 40 + logoWidth + 20, 20 + (logoHeight / 2));
                            
                            // Add generation date below the title
                            const now = new Date();
                            doc.setFontSize(10);
                            doc.setFont("helvetica", "normal");
                            doc.text("Generated on: " + now.toLocaleString(), 40 + logoWidth + 20, 20 + (logoHeight / 2) + 20);
                            
                            // Add status filter info if applied
                            if (currentStatus) {
                                doc.text("Status: " + currentStatus, 40 + logoWidth + 20, 20 + (logoHeight / 2) + 40);
                            }
                            
                            // Add a line separator
                            doc.setDrawColor(200, 200, 200);
                            doc.setLineWidth(1);
                            doc.line(40, 20 + logoHeight + 20, doc.internal.pageSize.width - 40, 20 + logoHeight + 20);
                        };
                        
                        // Get all data from the table
                        const headers = [
                            "S.No.", 
                            "CRN", 
                            "Student", 
                            "Contact", 
                            "Accession No.", 
                            "Book Title", 
                            "Issue Date", 
                            "Due Date", 
                            "Status", 
                            "Fine"
                        ];
                        
                        const data = [];
                        $('#issuesTableBody tr').each(function(index) {
                            const rowData = [];
                            $(this).find('td').each(function() {
                                // Remove any icons and get clean text
                                rowData.push($(this).clone().find('i').remove().end().text().trim());
                            });
                            if (rowData.length > 0) {
                                data.push(rowData);
                            }
                        });
                        
                        // Create the table with header callback for each page
                        doc.autoTable({
                            startY: 20 + logoHeight + 40, // Start below the header
                            head: [headers],
                            body: data,
                            styles: {
                                fontSize: 8,
                                cellPadding: 3,
                                overflow: 'linebreak',
                                valign: 'middle'
                            },
                            headStyles: {
                                fillColor: [78, 115, 223],
                                textColor: 255,
                                fontStyle: 'bold',
                                halign: 'center'
                            },
                            columnStyles: {
                                0: { cellWidth: 'auto', halign: 'center' },  // S.No.
                                1: { cellWidth: 'auto', halign: 'center' },  // CRN
                                2: { cellWidth: 'auto' },  // Student
                                3: { cellWidth: 'auto' },  // Contact
                                4: { cellWidth: 'auto', halign: 'center' },  // Accession No.
                                5: { cellWidth: 'auto' },  // Book Title
                                6: { cellWidth: 'auto', halign: 'center' },  // Issue Date
                                7: { cellWidth: 'auto', halign: 'center' },  // Due Date
                                8: { cellWidth: 'auto', halign: 'center' },  // Status
                                9: { cellWidth: 'auto', halign: 'right' }    // Fine
                            },
                            margin: { 
                                top: 20 + logoHeight + 40,
                                left: 40,
                                right: 40
                            },
                            didDrawPage: function(data) {
                                // Add header to each page
                                addHeader();
                                
                                // Add page numbers
                                const pageCount = doc.internal.getNumberOfPages();
                                doc.setFontSize(10);
                                doc.setTextColor(150);
                                doc.text(
                                    'Page ' + data.pageNumber + ' of ' + pageCount,
                                    data.settings.margin.left,
                                    doc.internal.pageSize.height - 20
                                );
                            }
                        });
                        
                        // Save the PDF
                        doc.save("Issued_Book_Records_" + new Date().toISOString().slice(0, 10) + ".pdf");
                        
                        // Show success message
                        Swal.fire({
                            icon: 'success',
                            title: 'PDF Generated',
                            text: 'All issued book records have been exported to PDF',
                            timer: 2000,
                            showConfirmButton: false
                        });
                    };
                    
                    img.onerror = function() {
                        // Fallback if logo fails to load
                        generatePDFWithoutLogo(doc);
                    };
                    
                } catch (error) {
                    console.error('PDF generation error:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'PDF Generation Failed',
                        text: 'An error occurred while generating the PDF: ' + error.message
                    });
                }
            }
            
            // Fallback function if logo fails to load
            function generatePDFWithoutLogo(doc) {
                try {
                    // Set initial y position
                    let yPosition = 40;
                    
                    // Add title
                    doc.setFontSize(18);
                    doc.setTextColor(40);
                    doc.setFont("helvetica", "bold");
                    doc.text("Issued Book Records", 40, yPosition);
                    yPosition += 30;
                    
                    // Add generation date
                    const now = new Date();
                    doc.setFontSize(10);
                    doc.setFont("helvetica", "normal");
                    doc.text("Generated on: " + now.toLocaleString(), 40, yPosition);
                    yPosition += 20;
                    
                    // Add status filter info if applied
                    if (currentStatus) {
                        doc.text("Status: " + currentStatus, 40, yPosition);
                        yPosition += 20;
                    }
                    
                    // Add a line separator
                    doc.setDrawColor(200, 200, 200);
                    doc.setLineWidth(1);
                    doc.line(40, yPosition, doc.internal.pageSize.width - 40, yPosition);
                    yPosition += 20;
                    
                    // Get all data from the table
                    const headers = [
                        "S.No.", 
                        "CRN", 
                        "Student", 
                        "Contact", 
                        "Accession No.", 
                        "Book Title", 
                        "Issue Date", 
                        "Due Date", 
                        "Status", 
                        "Fine"
                    ];
                    
                    const data = [];
                    $('#issuesTableBody tr').each(function(index) {
                        const rowData = [];
                        $(this).find('td').each(function() {
                            // Remove any icons and get clean text
                            rowData.push($(this).clone().find('i').remove().end().text().trim());
                        });
                        if (rowData.length > 0) {
                            data.push(rowData);
                        }
                    });
                    
                    // Create the table
                    doc.autoTable({
                        startY: yPosition,
                        head: [headers],
                        body: data,
                        styles: {
                            fontSize: 8,
                            cellPadding: 3,
                            overflow: 'linebreak',
                            valign: 'middle'
                        },
                        headStyles: {
                            fillColor: [78, 115, 223],
                            textColor: 255,
                            fontStyle: 'bold',
                            halign: 'center'
                        },
                        columnStyles: {
                            0: { cellWidth: 'auto', halign: 'center' },  // S.No.
                            1: { cellWidth: 'auto', halign: 'center' },  // CRN
                            2: { cellWidth: 'auto' },  // Student
                            3: { cellWidth: 'auto' },  // Contact
                            4: { cellWidth: 'auto', halign: 'center' },  // Accession No.
                            5: { cellWidth: 'auto' },  // Book Title
                            6: { cellWidth: 'auto', halign: 'center' },  // Issue Date
                            7: { cellWidth: 'auto', halign: 'center' },  // Due Date
                            8: { cellWidth: 'auto', halign: 'center' },  // Status
                            9: { cellWidth: 'auto', halign: 'right' }    // Fine
                        },
                        margin: { 
                            top: yPosition,
                            left: 40,
                            right: 40
                        },
                        didDrawPage: function(data) {
                            // Add page numbers
                            const pageCount = doc.internal.getNumberOfPages();
                            doc.setFontSize(10);
                            doc.setTextColor(150);
                            doc.text(
                                'Page ' + data.pageNumber + ' of ' + pageCount,
                                data.settings.margin.left,
                                doc.internal.pageSize.height - 20
                            );
                        }
                    });
                    
                    // Save the PDF
                    doc.save("Issued_Book_Records_" + new Date().toISOString().slice(0, 10) + ".pdf");
                    
                    Swal.fire({
                        icon: 'success',
                        title: 'PDF Generated',
                        text: 'PDF created without logo',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } catch (error) {
                    console.error('PDF generation error (without logo):', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'PDF Generation Failed',
                        text: 'Error creating PDF without logo: ' + error.message
                    });
                }
            }
        });
    </script>
</body>
</html>