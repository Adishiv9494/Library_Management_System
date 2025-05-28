<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Student Records</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    
    <style>
        :root {
            --bs-body-bg: #f8f9fa;
            --bs-body-color: #212529;
            --card-bg: #ffffff;
            --table-bg: #ffffff;
            --primary-color: #4e73df;
            --secondary-color: #858796;
        }
        
        [data-bs-theme="dark"] {
            --bs-body-bg: #1a1a2e;
            --bs-body-color: #f8f9fa;
            --card-bg: #16213e;
            --table-bg: #16213e;
            --primary-color: #5a67d8;
            --secondary-color: #a0aec0;
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
        
        .student-contact {
            font-family: monospace;
        }
        
        .course-badge {
            background-color: var(--primary-color);
            padding: 0.25em 0.95em;
            
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
                        <i class="fas fa-user-graduate me-2"></i>Student Records
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
                            <div class="col-md-4">
                                <label for="searchInput" class="form-label fw-semibold">Search Students</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search by CRN, Name or Course...">
                                </div>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button class="btn btn-primary w-100" id="searchBtn">
                                    <i class="fas fa-filter me-2"></i>Filter
                                </button>
                            </div>
                            <div class="col-md-3">
                                <label for="courseFilter" class="form-label fw-semibold">Filter by Course</label>
                                <select class="form-select" id="courseFilter">
                                    <option value="">All Courses</option>
                                    <option value="BCA">BCA</option>
                                    <option value="BBA">BBA</option>
                                    <option value="BTech">B. Tech</option>
                                    <option value="MCA">MCA</option>
                                    <option value="MBA">MBA</option>
                                    <option value="PTech">PolyTech</option>
                                </select>
                            </div>
                            <div class="col-md-3">
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
                            <table class="table table-hover" id="studentsTable">
                                <thead>
                                    <tr>
                                        <th width="5%">S.No.</th>
                                        <th width="15%">CRN</th>
                                        <th width="40%">Name</th>
                                        <th width="20%">Contact</th>
                                        <th width="20%">Course</th>
                                    </tr>
                                </thead>
                                <tbody id="studentsTableBody">
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
    
    <script>
        $(document).ready(function() {
            let currentPage = 1;
            let currentLimit = 10;
            let currentSearch = '';
            let currentCourse = '';
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
            
            // Load initial data
            loadStudentData();
            
            // Search button click event
            $('#searchBtn').click(function() {
                currentPage = 1;
                loadStudentData();
            });
            
            // Enter key in search input
            $('#searchInput').keypress(function(e) {
                if (e.which === 13) {
                    currentPage = 1;
                    loadStudentData();
                }
            });
            
            // Limit select change event
            $('#limitSelect').change(function() {
                currentLimit = parseInt($(this).val());
                currentPage = 1;
                loadStudentData();
            });
            
            // Course filter change event
            $('#courseFilter').change(function() {
                currentCourse = $(this).val();
                currentPage = 1;
                loadStudentData();
            });
            
            // Function to load student data
            function loadStudentData() {
                currentSearch = $('#searchInput').val().trim();
                currentCourse = $('#courseFilter').val();
                
                $.ajax({
                    url: 'StudentsRecordsData',
                    type: 'GET',
                    data: {
                        page: currentPage,
                        limit: currentLimit,
                        search: currentSearch,
                        course: currentCourse // Send course filter to backend
                    },
                    dataType: 'json',
                    beforeSend: function() {
                        $('#studentsTableBody').html('<tr><td colspan="5" class="text-center"><div class="spinner-container"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div></td></tr>');
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
                        renderStudentData(data.data);
                        renderPagination();
                        updateRecordInfo();
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to load student data: ' + error
                        });
                    }
                });
            }
            // Function to render student data
            function renderStudentData(students) {
                const tableBody = $('#studentsTableBody');
                tableBody.empty();
                
                if (students.length === 0) {
                    tableBody.append('<tr><td colspan="5"><div class="empty-table"><i class="fas fa-info-circle me-2"></i>No records found</div></td></tr>');
                    return;
                }
                
                const startSerial = (currentPage - 1) * currentLimit + 1;
                
                $.each(students, function(index, student) {
                    const row = $('<tr>');
                    row.append($('<td>').text(startSerial + index));
                    row.append($('<td>').text(student.crn));
                    
                    
                    // Name with icon
                    const nameCell = $('<td>').addClass('student-name');
                    nameCell.append($('<i>').addClass('fas fa-user me-2'));
                    nameCell.append(document.createTextNode(student.name));
                    row.append(nameCell);
                    
                    // Contact with icon
                    const contactCell = $('<td>').addClass('student-contact');
                    contactCell.append($('<i>').addClass('fas fa-phone me-2'));
                    contactCell.append(document.createTextNode(student.contact));
                    row.append(contactCell);
                    
                    // Course with badge
                    const courseCell = $('<td>').addClass('student-name');
                    courseCell.append($('<i>').addClass('fas fa-graduation-cap me-2'));
                    courseCell.append(document.createTextNode(student.course || ''));
                    row.append(courseCell);
                    
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
                        loadStudentData();
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
                        loadStudentData();
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
                        loadStudentData();
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
                        loadStudentData();
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
                        loadStudentData();
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
        });
    </script>

</body>
</html>