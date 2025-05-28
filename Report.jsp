<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Report</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        :root {
            --bg-color: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            --card-bg: #ffffff;
            --text-color: #333333;
            --header-bg: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            --section-title-color: #5a5c69;
            --section-title-border: #4e73df;
            --shadow-color: rgba(0,0,0,0.08);
            --hover-shadow-color: rgba(0,0,0,0.15);
        }

        [data-theme="dark"] {
            --bg-color: linear-gradient(135deg, #2c3e50 0%, #1a1a2e 100%);
            --card-bg: #2d3748;
            --text-color: #f8f9fa;
            --header-bg: linear-gradient(135deg, #1e3a8a 0%, #1e40af 100%);
            --section-title-color: #a0aec0;
            --section-title-border: #4299e1;
            --shadow-color: rgba(0,0,0,0.3);
            --hover-shadow-color: rgba(0,0,0,0.5);
        }

        body {
            background: var(--bg-color);
            min-height: 100vh;
            color: var(--text-color);
            transition: all 0.3s ease;
        }

        .card {
            transition: all 0.3s ease;
            border-radius: 15px;
            box-shadow: 0 6px 10px var(--shadow-color);
            border: none;
            margin-bottom: 25px;
            background-color: var(--card-bg);
            color: var(--text-color);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px var(--hover-shadow-color);
        }

        .card-body {
            text-align: center;
            padding: 1.5rem;
        }

        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .import-card .card-icon {
            color: #4e73df;
        }

        .defaulter-card .card-icon {
            color: #e74a3b;
        }

        .fine-card .card-icon {
            color: #f6c23e;
        }

        .books-card .card-icon {
            color: #1cc88a;
        }

        .issue-card .card-icon {
            color: #36b9cc;
        }

        .btn-import {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-import:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(78, 115, 223, 0.4);
        }

        .btn-import:active {
            transform: translateY(0);
        }

        .btn-import:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background: #6c757d;
        }

        .btn-import::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-import:focus:not(:active)::after {
            animation: ripple 0.6s ease-out;
        }

        .btn-defaulter {
            background: linear-gradient(135deg, #e74a3b 0%, #be2617 100%);
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-defaulter:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 74, 59, 0.4);
        }

        .btn-defaulter:active {
            transform: translateY(0);
        }

        .btn-fine {
            background: linear-gradient(135deg, #f6c23e 0%, #dda20a 100%);
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-fine:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(246, 194, 62, 0.4);
        }

        .btn-fine:active {
            transform: translateY(0);
        }

        .btn-books {
            background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-books:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(28, 200, 138, 0.4);
        }

        .btn-books:active {
            transform: translateY(0);
        }

        .btn-issue {
            background: linear-gradient(135deg, #36b9cc 0%, #258391 100%);
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-issue:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(54, 185, 204, 0.4);
        }

        .btn-issue:active {
            transform: translateY(0);
        }

        .header {
            background: var(--header-bg);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: relative;
        }

        .section-title {
            color: var(--section-title-color);
            margin-bottom: 25px;
            font-weight: 600;
            border-left: 4px solid var(--section-title-border);
            padding-left: 15px;
        }

        .col-custom-4 {
            -ms-flex: 0 0 33.333333%;
            flex: 0 0 33.333333%;
            max-width: 33.333333%;
        }

        @media (max-width: 1200px) {
            .col-custom-4 {
                -ms-flex: 0 0 33.333333%;
                flex: 0 0 33.333333%;
                max-width: 33.333333%;
            }
        }

        @media (max-width: 768px) {
            .col-custom-4 {
                -ms-flex: 0 0 50%;
                flex: 0 0 50%;
                max-width: 50%;
            }
        }

        @media (max-width: 576px) {
            .col-custom-4 {
                -ms-flex: 0 0 100%;
                flex: 0 0 100%;
                max-width: 100%;
            }
        }

        .back-button {
            position: absolute;
            left: 20px;
            top: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            color: white;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateX(-3px);
        }

        .theme-toggle {
            position: absolute;
            right: 20px;
            top: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            color: white;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .theme-toggle:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(30deg);
        }

        .file-input-container {
            margin-bottom: 15px;
        }

        .file-input-label {
            display: block;
            padding: 8px 15px;
            background: rgba(78, 115, 223, 0.1);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            border: 1px dashed rgba(78, 115, 223, 0.5);
            margin-bottom: 5px;
        }

        .file-input-label:hover {
            background: rgba(78, 115, 223, 0.2);
        }

        .file-input {
            display: none;
        }

        .file-name {
            font-size: 0.8rem;
            color: var(--section-title-color);
            word-break: break-all;
            margin-top: 5px;
        }

        .file-error {
            color: #e74a3b !important;
        }

        .spinner-border {
            vertical-align: middle;
            margin-right: 5px;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 1;
            }
            20% {
                transform: scale(25, 25);
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: scale(40, 40);
            }
        }
    </style>
</head>
<body class="container py-5">
    <div class="header text-center">
        <button class="back-button" onclick="window.history.back()">
            <i class="fas fa-arrow-left"></i>
        </button>
        <button class="theme-toggle" id="themeToggle">
            <i class="fas fa-moon"></i>
        </button>
        <h1><i class="fas fa-user-graduate mr-2"></i> Student Data Management</h1>
        <p class="mb-0 mt-2">Manage all student records, defaulters and pending fines</p>
    </div>
    
    <h4 class="section-title">Data Import</h4>
    <div class="row">
        <!-- BCA Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="bcaForm" action="BCAImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="BCA">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-laptop-code"></i>
                        </div>
                        <h5 class="card-title">BCA Students</h5>
                        <p class="card-text">Import Bachelor of Computer Applications records</p>
                        
                        <div class="file-input-container">
                            <label for="bcaFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="bcaFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="bcaFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="bcaImportBtn" onclick="confirmImport('bcaForm', 'BCA')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- BBA Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="bbaForm" action="BBAImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="BBA">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <h5 class="card-title">BBA Students</h5>
                        <p class="card-text">Import Bachelor of Business Administration records</p>
                        
                        <div class="file-input-container">
                            <label for="bbaFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="bbaFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="bbaFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="bbaImportBtn" onclick="confirmImport('bbaForm', 'BBA')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- B.Tech Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="btechForm" action="BTechImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="BTECH">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-microchip"></i>
                        </div>
                        <h5 class="card-title">B.Tech Students</h5>
                        <p class="card-text">Import Bachelor of Technology student records</p>
                        
                        <div class="file-input-container">
                            <label for="btechFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="btechFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="btechFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="btechImportBtn" onclick="confirmImport('btechForm', 'B.Tech')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- MCA Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="mcaForm" action="MCAImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="MCA">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h5 class="card-title">MCA Students</h5>
                        <p class="card-text">Import Master of Computer Applications records</p>
                        
                        <div class="file-input-container">
                            <label for="mcaFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="mcaFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="mcaFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="mcaImportBtn" onclick="confirmImport('mcaForm', 'MCA')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- MBA Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="mbaForm" action="MBAImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="MBA">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h5 class="card-title">MBA Students</h5>
                        <p class="card-text">Import Master of Business Administration records</p>
                        
                        <div class="file-input-container">
                            <label for="mbaFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="mbaFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="mbaFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="mbaImportBtn" onclick="confirmImport('mbaForm', 'MBA')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Polytechnic Card -->
        <div class="col-custom-4 col-md-6 mb-4">
            <form id="polyForm" action="PTechImportData" method="post" enctype="multipart/form-data">
                <input type="hidden" name="department" value="POLY">
                <div class="card h-100 import-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <h5 class="card-title">Polytechnic</h5>
                        <p class="card-text">Import Polytechnic/Diploma student records</p>
                        
                        <div class="file-input-container">
                            <label for="polyFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="polyFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="polyFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="polyImportBtn" onclick="confirmImport('polyForm', 'Polytechnic')" class="btn btn-import text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <h4 class="section-title mt-5">Student Management</h4>
    <div class="row">
        <!-- Defaulter Students Card -->
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card h-100 defaulter-card">
                <div class="card-body">
                    <div class="card-icon">
                        <i class="fas fa-user-clock"></i>
                    </div>
                    <h5 class="card-title">Defaulters</h5>
                    <p class="card-text">View late book submissions</p>
                    <a href="Defaulter.jsp" class="btn btn-defaulter text-white">
                        <i class="fas fa-list mr-2"></i> View
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Pending Fine Students Card -->
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card h-100 fine-card">
                <div class="card-body">
                    <div class="card-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <h5 class="card-title">Pending Fines</h5>
                    <p class="card-text">Students with unpaid fines</p>
                    <a href="PendingFine.jsp" class="btn btn-fine text-white">
                        <i class="fas fa-eye mr-2"></i> View
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Books Import Card -->
        <div class="col-lg-3 col-md-6 mb-4">
            <form id="booksForm" action="BooksImportData" method="post" enctype="multipart/form-data">
                <div class="card h-100 books-card">
                    <div class="card-body">
                        <div class="card-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <h5 class="card-title">Import Books</h5>
                        <p class="card-text">Import book records to the library</p>
                        
                        <div class="file-input-container">
                            <label for="booksFile" class="file-input-label">
                                <i class="fas fa-file-excel mr-2"></i>Choose Excel File
                            </label>
                            <input type="file" id="booksFile" name="file" class="file-input" accept=".xlsx,.xls" required>
                            <div id="booksFileName" class="file-name">No file chosen</div>
                        </div>
                        
                        <button type="button" id="booksImportBtn" onclick="confirmBookImport()" class="btn btn-books text-white" disabled>
                            <i class="fas fa-upload mr-2"></i> Import
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Issue Records Card -->
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card h-100 issue-card">
                <div class="card-body">
                    <div class="card-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h5 class="card-title">Issue Records</h5>
                    <p class="card-text">View all book issue records</p>
                    <a href="ShowAllIssueData.jsp" class="btn btn-issue text-white">
                        <i class="fas fa-list mr-2"></i> View
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        // Theme toggle functionality
        const themeToggle = document.getElementById('themeToggle');
        const icon = themeToggle.querySelector('i');
        
        // Check for saved theme preference or use preferred color scheme
        const currentTheme = localStorage.getItem('theme') || 
                            (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
        
        // Apply the current theme
        if (currentTheme === 'dark') {
            document.body.setAttribute('data-theme', 'dark');
            icon.classList.remove('fa-moon');
            icon.classList.add('fa-sun');
        }
        
        // Theme toggle click handler
        themeToggle.addEventListener('click', () => {
            const currentTheme = document.body.getAttribute('data-theme');
            
            if (currentTheme === 'dark') {
                document.body.removeAttribute('data-theme');
                localStorage.setItem('theme', 'light');
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
            } else {
                document.body.setAttribute('data-theme', 'dark');
                localStorage.setItem('theme', 'dark');
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            }
        });
        
        // File input change handlers with validation
        document.querySelectorAll('.file-input').forEach(input => {
            input.addEventListener('change', function() {
                const fileNameDiv = document.getElementById(this.id + 'Name');
                const importBtn = document.getElementById(this.id.replace('File', 'ImportBtn'));
                
                if (this.files.length > 0) {
                    const file = this.files[0];
                    fileNameDiv.textContent = file.name;
                    
                    // Check file extension
                    const validExtensions = ['.xlsx', '.xls'];
                    const fileExt = file.name.substring(file.name.lastIndexOf('.')).toLowerCase();
                    
                    if (validExtensions.includes(fileExt)) {
                        importBtn.disabled = false;
                        fileNameDiv.classList.remove('file-error');
                        fileNameDiv.textContent = file.name;
                    } else {
                        importBtn.disabled = true;
                        fileNameDiv.classList.add('file-error');
                        fileNameDiv.textContent = file.name + ' (Invalid file type)';
                        Swal.fire({
                            icon: 'error',
                            title: 'Invalid File',
                            text: 'Please select an Excel file (.xlsx, .xls)'
                        });
                    }
                } else {
                    fileNameDiv.textContent = 'No file chosen';
                    fileNameDiv.classList.remove('file-error');
                    importBtn.disabled = true;
                }
            });
        });
        
        // Confirm import function for student data with progress tracking
        function confirmImport(formId, department) {
            const form = document.getElementById(formId);
            const fileInput = form.querySelector('input[type="file"]');
            const importBtn = document.getElementById(formId.replace('Form', 'ImportBtn'));
            
            if (!fileInput.files.length) {
                Swal.fire({
                    icon: 'error',
                    title: 'No File Selected',
                    text: 'Please select a file to import.'
                });
                return;
            }
            
            // Disable button during import
            importBtn.disabled = true;
            importBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Importing...';
            
            const formData = new FormData(form);
            
            Swal.fire({
                title: `Import ${department} Students?`,
                text: `This will import student records from the selected file. Continue?`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#4e73df',
                cancelButtonColor: '#e74a3b',
                confirmButtonText: 'Yes, import!',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                preConfirm: () => {
                    return fetch(form.action, {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(response.statusText);
                        }
                        return response.json();
                    })
                    .catch(error => {
                        Swal.showValidationMessage(
                            `Import failed: ${error}`
                        );
                    });
                },
                allowOutsideClick: () => !Swal.isLoading()
            }).then((result) => {
                // Re-enable button
                importBtn.disabled = false;
                importBtn.innerHTML = '<i class="fas fa-upload mr-2"></i> Import';
                
                if (result.isConfirmed) {
                    const data = result.value;
                    if (data.error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Import Failed',
                            text: data.error
                        });
                    } else {
                        Swal.fire({
                            title: 'Import Successful!',
                            html: `<div class="text-left">
                                  <p><b>Total Records Processed:</b> ${data.totalRecords}</p>
                                  <p><b>New Records Added:</b> ${data.insertedCount}</p>
                                  <p><b>Existing Records Updated:</b> ${data.updatedCount}</p>
                                  <p><b>Failed Records:</b> ${data.failedCount}</p>
                                  </div>`,
                            icon: 'success',
                            confirmButtonText: 'OK',
                            confirmButtonColor: '#1cc88a',
                            width: '500px'
                        }).then(() => {
                            // Reset file input
                            fileInput.value = '';
                            document.getElementById(fileInput.id + 'Name').textContent = 'No file chosen';
                        });
                    }
                }
            });
        }
        
        // Confirm import function for books
        function confirmBookImport() {
            const form = document.getElementById('booksForm');
            const fileInput = form.querySelector('input[type="file"]');
            const importBtn = document.getElementById('booksImportBtn');
            
            if (!fileInput.files.length) {
                Swal.fire({
                    icon: 'error',
                    title: 'No File Selected',
                    text: 'Please select a file to import.'
                });
                return;
            }
            
            // Disable button during import
            importBtn.disabled = true;
            importBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Importing...';
            
            const formData = new FormData(form);
            
            Swal.fire({
                title: 'Import Books?',
                text: 'This will import book records from the selected file. Continue?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#1cc88a',
                cancelButtonColor: '#e74a3b',
                confirmButtonText: 'Yes, import!',
                cancelButtonText: 'Cancel',
                showLoaderOnConfirm: true,
                preConfirm: () => {
                    return fetch(form.action, {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(response.statusText);
                        }
                        return response.json();
                    })
                    .catch(error => {
                        Swal.showValidationMessage(
                            `Import failed: ${error}`
                        );
                    });
                },
                allowOutsideClick: () => !Swal.isLoading()
            }).then((result) => {
                // Re-enable button
                importBtn.disabled = false;
                importBtn.innerHTML = '<i class="fas fa-upload mr-2"></i> Import';
                
                if (result.isConfirmed) {
                    const data = result.value;
                    if (data.error) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Import Failed',
                            text: data.error
                        });
                    } else {
                        Swal.fire({
                            title: 'Import Successful!',
                            html: `<div class="text-left">
                                  <p><b>Total Records Processed:</b> ${data.totalRecords}</p>
                                  <p><b>New Records Added:</b> ${data.insertedCount}</p>
                                  <p><b>Existing Records Updated:</b> ${data.updatedCount}</p>
                                  <p><b>Failed Records:</b> ${data.failedCount}</p>
                                  </div>`,
                            icon: 'success',
                            confirmButtonText: 'OK',
                            confirmButtonColor: '#1cc88a',
                            width: '500px'
                        }).then(() => {
                            // Reset file input
                            fileInput.value = '';
                            document.getElementById(fileInput.id + 'Name').textContent = 'No file chosen';
                        });
                    }
                }
            });
        }
        
        // Add ripple effect to buttons
        document.querySelectorAll('.btn-import, .btn-defaulter, .btn-fine, .btn-books, .btn-issue').forEach(button => {
            button.addEventListener('click', function(e) {
                const rect = this.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                const ripple = document.createElement('span');
                ripple.classList.add('ripple-effect');
                ripple.style.left = `${x}px`;
                ripple.style.top = `${y}px`;
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
    </script>
</body>
</html>