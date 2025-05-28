<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/c1df782baf.js"></script>
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.1.0/uicons-thin-rounded/css/uicons-thin-rounded.css'>
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.1.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        /* General Styles */
       body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            color: var(--text-color);
            transition: background-color 0.5s, color 0.5s;
            padding-top: 70px;
            min-height: 100vh;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        :root {
            --text-color: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.15);
            --card-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            --primary-color: #4e54c8;
            --hover-color: #8f94fb;
            --footer-bg: rgba(0, 0, 0, 0.3);
            --glass-border: 1px solid rgba(255, 255, 255, 0.18);
        }

        [data-theme="dark"] {
            --text-color: #f9f9f9;
            --card-bg: rgba(15, 23, 42, 0.7);
            --card-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            --primary-color: #7e3af2;
            --hover-color: #a85ff1;
            --footer-bg: rgba(15, 23, 42, 0.8);
        }

        [data-theme="dark"] {
            --bg-color: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            --text-color: #f9f9f9;
            --card-bg: #34495e;
            --card-shadow: 0 5px 15px rgba(255, 255, 255, 0.1);
            --primary-color: #ff5733;
            --hover-color: #ff8c66;
            --footer-bg: #2c3e50; /* Dark mode footer background color */
        }

        /* Navbar */
        .navbar {
            background-color: rgba(0, 0, 0, 0.5);
            box-shadow: var(--card-shadow);
            position: fixed; /* Fix the navbar at the top */
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000; /* Ensure navbar stays on top of other content */
        }

        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: var(--text-color);
        }

        .navbar-brand i {
            animation: rotateLogo 5s linear infinite; /* Rotate the symbol */
        }

        .navbar-nav .nav-link {
            color: var(--text-color);
            font-weight: 500;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-color);
            transform: translateY(-5px);
        }

        /* Hero Section */
        .hero {
            background: url('hero-bg.jpg') no-repeat center center/cover;
            height: 30vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .hero .btn {
            background-color: var(--primary-color);
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .hero .btn:hover {
            background-color: var(--hover-color);
            transform: translateY(-5px);
        }

        /* Management Systems Section */
        .management-section {
            padding: 80px 0;
            text-align: center;
            background: var(--bg-color);
        }

        .management-section h2 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .management-section p {
            font-size: 16px;
            color: var(--text-color);
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .management-box {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }

        .management-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .management-box img {
       
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 20px;
            animation: rotateLogo 5s linear infinite;
        }

        .management-box h3 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .management-box ul {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
        }

        .management-box ul li {
            font-size: 16px;
            margin: 10px 0;
            display: flex;
            align-items: center;
        }

        .management-box ul li i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .management-box .btn {
            background-color: var(--primary-color);
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .management-box .btn:hover {
            background-color: var(--hover-color);
            transform: translateY(-5px);
        }

        /* Animations */
        @keyframes rotateLogo {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Footer */
        .footer {
            background-color: var(--footer-bg); /* Dynamic footer background color */
            color: var(--text-color);
            padding: 40px 0 20px;
            font-family: 'Arial', sans-serif;
        }

        .footer-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            max-width: 1200px;
            margin: 0 auto;
            gap: 20px;
        }

        .footer-section {
            flex: 1;
            min-width: 200px;
            margin-bottom: 20px;
        }

        .footer-section h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--primary-color); /* Use primary color for headings */
        }

        /* Social Icons */
        .social-icons {
            display: flex;
            gap: 15px;
        }

        .social-icon {
            color: var(--text-color);
            font-size: 24px;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .social-icon:hover {
            color: var(--primary-color);
            transform: scale(1.2);
        }

        /* Quick Links */
        .quick-links ul {
            list-style: none;
            padding: 0;
        }

        .quick-links ul li {
            margin-bottom: 10px;
        }

        .quick-links ul li a {
            color: var(--text-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .quick-links ul li a:hover {
            color: var(--primary-color);
        }

        /* Contact Info */
        .contact-info ul {
            list-style: none;
            padding: 0;
        }

        .contact-info ul li {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .contact-info ul li i {
            margin-right: 10px;
            color: var(--primary-color);
        }

        .contact-info ul li a {
            color: var(--text-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .contact-info ul li a:hover {
            color: var(--primary-color);
        }

        /* Newsletter Form */
        .newsletter-form {
            display: flex;
            gap: 10px;
        }

        .newsletter-form input {
            padding: 10px;
            border: none;
            border-radius: 5px;
            flex: 1;
            background-color: var(--card-bg);
            color: var(--text-color);
        }

        .newsletter-form button {
            padding: 10px 20px;
            background-color: var(--primary-color);
            border: none;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .newsletter-form button:hover {
            background-color: var(--hover-color);
        }

        /* Footer Bottom (Copyright) */
        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 20px;
        }

        .footer-bottom p {
            margin: 0;
            font-size: 14px;
        }

        .footer-bottom a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-bottom a:hover {
            color: var(--hover-color);
        }

        /* Dark Mode Toggle */
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: var(--primary-color);
            color: #fff;
            padding: 10px 15px;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
            z-index: 1001; /* Ensure it stays above the navbar */
        }

        .theme-toggle:hover {
            transform: translateY(-5px);
        }
        /* Back to Top Button */
#back-to-top {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: var(--primary-color);
    color: #fff;
    border: none;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    font-size: 20px;
    cursor: pointer;
    display: none; /* Hidden by default */
    transition: background-color 0.3s ease;
    z-index: 1000; /* Ensure it stays above other elements */
}

#back-to-top:hover {
    background-color: var(--hover-color);
}


    </style>
    
    
    
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-cogs"></i> All Management System
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav" style = "margin-left : 20px;">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Dark Mode Toggle -->
    <div class="theme-toggle" onclick="toggleTheme()">
        <i class="fas fa-moon"></i>
    </div>

    <!-- Hero Section -->
    
    
    
 <section id="home" class="hero" style="
    position: relative;
    overflow: hidden;
    height: 50vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #6e8efb 0%, #a777e3 100%);
    color: white;
    text-align: center;
">
    <!-- Animated background elements -->
    <div style="
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    ">
        <div style="
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: pulse 8s infinite alternate;
        "></div>
        <div style="
            position: absolute;
            bottom: 10%;
            right: 10%;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            animation: float 6s ease-in-out infinite;
        "></div>
        <div style="
            position: absolute;
            top: 20%;
            left: 15%;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            animation: float 5s ease-in-out infinite 1s;
        "></div>
    </div>

    <div class="container" style="
        position: relative;
        z-index: 1;
        max-width: 800px;
        padding: 0 20px;
    ">
        <h1 style="
            font-size: 2.5rem;
            margin-bottom: 1rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease-out 0.3s forwards;
        ">
            Welcome to <br>
            <span style="
                display: inline-block;
                font-size: 3.5rem;
                font-weight: 800;
                background: linear-gradient(90deg, #ffffff, #f0f0f0, #ffffff);
                background-size: 200% auto;
                color: transparent;
                -webkit-background-clip: text;
                background-clip: text;
                animation: shine 3s linear infinite;
                text-shadow: 0 4px 12px rgba(0,0,0,0.3);
                padding: 0 10px;
                margin: 10px 0;
                position: relative;
            ">
                <span style="
                    position: absolute;
                    bottom: -5px;
                    left: 0;
                    width: 100%;
                    height: 3px;
                    background: white;
                    transform: scaleX(0);
                    transform-origin: left;
                    animation: underline 2s ease-in-out infinite 1s;
                "></span>
                One For All Management System
            </span>
        </h1>
        
        <p style="
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 1s ease-out 0.6s forwards;
            text-shadow: 0 1px 5px rgba(0,0,0,0.2);
        ">Streamline your operations with our comprehensive management solutions.</p>
    </div>

    <style>
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0% {
                transform: scale(0.8);
                opacity: 0.8;
            }
            100% {
                transform: scale(1.2);
                opacity: 0.4;
            }
        }
        
        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
            100% {
                transform: translateY(0) rotate(0deg);
            }
        }
        
        @keyframes shine {
            to {
                background-position: 200% center;
            }
        }
        
        @keyframes underline {
            0% {
                transform: scaleX(0);
            }
            50% {
                transform: scaleX(1);
            }
            100% {
                transform: scaleX(0);
                transform-origin: right;
            }
        }
    </style>
</section>
    
    
    
    

    <!-- Management Systems Section -->
    <section id="about" class="management-section">
        <div class="container">
        
           <div style="text-align: center; margin: 40px 0;">
<h2 style="
      font-size: 2.8rem;
      font-weight: 700;
      margin: 0 auto 15px;
      color: #2c3e50;
      font-family: 'Segoe UI', system-ui, sans-serif;
      opacity: 0;
      transform-style: preserve-3d;
      animation: 
        fadeIn 0.8s ease-out forwards,
        subtleGlow 3s ease-in-out infinite alternate,
        subtle3dTilt 6s ease-in-out infinite;
      animation-delay: 0.3s;
  ">
    Our Management Systems
</h2>

<style>
  @keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
  }
  
  @keyframes subtleGlow {
    from { text-shadow: 0 0 5px rgba(44, 62, 80, 0.3); }
    to { text-shadow: 0 0 15px rgba(44, 62, 80, 0.5); }
  }
  
  @keyframes subtle3dTilt {
    0%, 100% {
      transform: rotateX(0deg) rotateY(0deg) rotateZ(0deg);
    }
    25% {
      transform: rotateX(2deg) rotateY(1deg) rotateZ(-0.5deg);
    }
    50% {
      transform: rotateX(-1deg) rotateY(2deg) rotateZ(0.5deg);
    }
    75% {
      transform: rotateX(1deg) rotateY(-1deg) rotateZ(-0.3deg);
    }
  }
</style>

  <p style="
      font-size: 1.25rem;
      color: #5d6d7e;
      max-width: 700px;
      margin: 0 auto 40px;
      line-height: 1.6;
      opacity: 0;
      transform: translateY(15px);
      animation: fadeSlideUp 0.8s ease-out forwards;
      animation-delay: 0.6s;
  ">
    Explore our specialized management systems designed to meet your needs.
  </p>
</div>

<style>
  @keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
  }
  
  @keyframes fadeSlideUp {
    from { 
      opacity: 0;
      transform: translateY(15px);
    }
    to { 
      opacity: 1;
      transform: translateY(0);
    }
  }
  
  @keyframes subtleGlow {
    0%, 100% {
      text-shadow: 0 0 0 rgba(110, 142, 251, 0);
    }
    50% {
      text-shadow: 0 0 12px rgba(110, 142, 251, 0.3);
    }
  }
</style>
            
            
            <div class="row">
                <!-- Banking Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/Banking2.jpg" alt="Banking Management System">
                        <h3>Banking Management System</h3>
                        <p>A digital platform designed to streamline and automate banking operations.</p>
                        <ul>
                            <li><i class="fas fa-user"></i> Account Management</li>
                            <li><i class="fas fa-exchange-alt"></i> Transaction Tracking</li>
                            <li><i class="fas fa-hand-holding-usd"></i> Loan Processing</li>
                            <li><i class="fas fa-shield-alt"></i> Fraud Detection</li>
                            <li><i class="fas fa-headset"></i> Customer Support</li>
                        </ul>
                        <a href="Banking_Management.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Library Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/Library1.jpg" alt="Library Management System">
                        <h3>Library Management System</h3>
                        <p>A digital solution that helps libraries manage books and member accounts.</p>
                        <ul>
                            <li><i class="fas fa-book"></i> Book Management</li>
                            <li><i class="fas fa-users"></i> Member Management</li>
                            <li><i class="fas fa-exchange-alt"></i> Borrowing & Returning</li>
                            <li><i class="fas fa-archive"></i> Catalog Management</li>
                            <li><i class="fas fa-search"></i> Reservation System</li>
                        </ul>
                        <a href="LIBRARY/welcome.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Hospital Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/Hospital2.jpg" alt="Hospital Management System">
                        <h3>Hospital Management System</h3>
                        <p>A comprehensive software solution designed to manage hospital operations.</p>
                        <ul>
                            <li><i class="fas fa-user-injured"></i> Patient Records</li>
                            <li><i class="fas fa-calendar-check"></i> Appointment Scheduling</li>
                            <li><i class="fas fa-file-invoice-dollar"></i> Billing & Invoicing</li>
                            <li><i class="fas fa-pills"></i> Pharmacy Management</li>
                            <li><i class="fas fa-ambulance"></i> Emergency Services</li>
                        </ul>
                        <a href="HOSPITAL/dashboard.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- School Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/sch1.jpg" alt="School Management System">
                        <h3>School Management System</h3>
                        <p>A digital platform that helps schools manage student records and attendance.</p>
                        <ul>
                            <li><i class="fas fa-user-graduate"></i> Student Records</li>
                            <li><i class="fas fa-calendar-alt"></i> Attendance Tracking</li>
                            <li><i class="fas fa-file-alt"></i> Exam Management</li>
                            <li><i class="fas fa-money-bill-wave"></i> Fee Collection</li>
                            <li><i class="fas fa-users"></i> Parent Portal</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Inventory Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/inv.jpg" alt="Inventory Management System">
                        <h3>Inventory Management System</h3>
                        <p>A software solution that helps businesses track and manage stock levels.</p>
                        <ul>
                            <li><i class="fas fa-boxes"></i> Stock Management</li>
                            <li><i class="fas fa-truck"></i> Order Processing</li>
                            <li><i class="fas fa-warehouse"></i> Warehouse Management</li>
                            <li><i class="fas fa-chart-line"></i> Demand Forecasting</li>
                            <li><i class="fas fa-file-alt"></i> Report Generation</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Hotel Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/hotel.jpg" alt="Hotel Management System">
                        <h3>Hotel Management System</h3>
                        <p>A software platform designed to manage hotel operations.</p>
                        <ul>
                            <li><i class="fas fa-bed"></i> Reservation Management</li>
                            <li><i class="fas fa-concierge-bell"></i> Guest Services</li>
                            <li><i class="fas fa-money-bill-wave"></i> Billing & Invoicing</li>
                            <li><i class="fas fa-broom"></i> Housekeeping</li>
                            <li><i class="fas fa-file-alt"></i> Report Generation</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Restaurant Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/rest.jpg" alt="Restaurant Management System">
                        <h3>Restaurant Management System</h3>
                        <p>A software solution designed to manage restaurant operations efficiently.</p>
                        <ul>
                            <li><i class="fas fa-utensils"></i> Menu Management</li>
                            <li><i class="fas fa-users"></i> Customer Management</li>
                            <li><i class="fas fa-cash-register"></i> Order Processing</li>
                            <li><i class="fas fa-clock"></i> Table Reservation</li>
                            <li><i class="fas fa-file-alt"></i> Report Generation</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- University Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/sch1.jpg" alt="University Management System">
                        <h3>University Management System</h3>
                        <p>A digital platform designed to manage university operations and student data.</p>
                        <ul>
                            <li><i class="fas fa-user-graduate"></i> Student Records</li>
                            <li><i class="fas fa-calendar-alt"></i> Course Scheduling</li>
                            <li><i class="fas fa-file-invoice-dollar"></i> Fee Management</li>
                            <li><i class="fas fa-chalkboard-teacher"></i> Faculty Management</li>
                            <li><i class="fas fa-file-alt"></i> Report Generation</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>

                <!-- Retail Management System -->
                <div class="col-md-4">
                    <div class="management-box">
                        <img src="Logo/ret.jpg" alt="Retail Management System">
                        <h3>Retail Management System</h3>
                        <p>A software solution that helps retailers manage sales and inventory.</p>
                        <ul>
                            <li><i class="fas fa-shopping-cart"></i> Sales Management</li>
                            <li><i class="fas fa-boxes"></i> Inventory Control</li>
                            <li><i class="fas fa-users"></i> Customer Relationship Management</li>
                            <li><i class="fas fa-cash-register"></i> Point of Sale (POS)</li>
                            <li><i class="fas fa-file-alt"></i> Report Generation</li>
                        </ul>
                        <a href="ComingSoon.jsp" class="btn">
                            <i class="fas fa-arrow-right"></i> Learn More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <!-- Follow Us Section -->
        <div class="footer-section follow-us">
            <h3>Follow Us</h3>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                <a href="https://instagram.com" target="_blank" class="social-icon"><i class="fab fa-instagram"></i></a>
                <a href="https://twitter.com" target="_blank" class="social-icon"><i class="fab fa-x-twitter"></i></a>
                <a href="https://google.com" target="_blank" class="social-icon"><i class="fab fa-google"></i></a>
            </div>
        </div>

        <!-- Quick Links Section -->
        <div class="footer-section quick-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="#home"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="#about"><i class="fas fa-info-circle"></i> About</a></li>
                <li><a href="#services"><i class="fas fa-cogs"></i> Services</a></li>
                <li><a href="#gallery"><i class="fas fa-images"></i> Gallery</a></li>
                <li><a href="appointmentForm.jsp"><i class="fas fa-calendar-check"></i> Appointment</a></li>
                <li><a href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
            </ul>
        </div>

        <!-- Contact Us Section -->
        <div class="footer-section contact-info">
            <h3>Contact Us</h3>
            <ul>
                <li><i class="fas fa-phone-alt"></i> <a href="tel:+1234567890">+1 (234) 567-890</a></li>
                <li><i class="fas fa-map-marker-alt"></i> Allenhouse Institute of Technology, Rooma, Kanpur Nagar, UP, India</li>
                <li><i class="fab fa-whatsapp"></i> <a href="https://wa.me/1234567890">Chat on WhatsApp</a></li>
                <li><i class="fas fa-envelope"></i> <a href="mailto:info@example.com">info@example.com</a></li>
            </ul>
        </div>

        <!-- Newsletter Section -->
        <div class="footer-section newsletter">
            <h3>Subscribe to Our Newsletter</h3>
            <form class="newsletter-form">
                <input type="email" placeholder="Enter your email" required>
                <button type="submit">Subscribe</button>
            </form>
        </div>
    </div>

    <!-- Back to Top Button -->
    <button id="back-to-top" title="Go to top"><i class="fas fa-arrow-up"></i></button>

    <!-- Copyright Section -->
    <div class="footer-bottom">
        <p>&copy; 2023 Your Company. All Rights Reserved. | <a href="#">Privacy Policy</a> | <a href="#">Terms & Conditions</a></p>
    </div>
</footer>
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Dark Mode Toggle
        function toggleTheme() {
            const body = document.body;
            body.setAttribute('data-theme', body.getAttribute('data-theme') === 'dark' ? 'light' : 'dark');
        }

        // Back to Top Button
        const backToTopButton = document.getElementById("back-to-top");

        window.onscroll = function() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                backToTopButton.style.display = "block"; // Show the button
            } else {
                backToTopButton.style.display = "none"; // Hide the button
            }
        };

        backToTopButton.addEventListener("click", () => {
            document.body.scrollTop = 0; // For Safari
            document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE, and Opera
        });
    </script>
</body>
</html>