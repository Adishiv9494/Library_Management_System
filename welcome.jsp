<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Library Management System</title>
    <link rel="icon" type="image/x-icon" href="lib.png">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: white;
            color: black;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Dark Mode Styles */
        body.dark-mode {
            background-color: #121212;
            color: white;
        }

        body.dark-mode .brand-name {
            background: linear-gradient(90deg, #ff7b00, #ffcc00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        body.dark-mode .footer {
            background: linear-gradient(to right, #000000, #333333);
        }

        body.dark-mode a {
            color: #ff6600;
        }

        body.dark-mode h3 {
            color: #ff9900;
        }

        body.dark-mode .cta-button {
            background: #ff6600;
            color: white;
        }

        body.dark-mode .content-section {
            background: rgba(255, 255, 255, 0.1);
        }

        body.dark-mode .text-section h2 {
            color: #ff6600;
        }

        body.dark-mode .text-section ul li {
            color: white;
        }

        body.dark-mode .text-section ul li::before {
            color: #ff6600;
        }

        body.dark-mode .footer-section h3 {
            color: #ff6600;
        }

        body.dark-mode .footer-section ul li a {
            color: white;
        }

        body.dark-mode .footer-section ul li a:hover {
            color: #ff6600;
        }

        /* Navbar Styling */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: left;
            background: rgba(0, 0, 0, 0.8);
            padding: 15px 20px;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.5);
            position: relative;
        }

        .brand-name {
            background: linear-gradient(90deg, #ff7b00, #ffcc00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 2px 2px 12px rgba(255, 140, 0, 0.6);
            letter-spacing: 2.5px;
            position: relative;
            transition: transform 0.5s ease-in-out;
            padding-bottom: 5px;
            margin-left: 17px;
        }

        .brand-name::after {
            content: "";
            position: absolute;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #ff7b00, #ffcc00);
            bottom: -5px;
            left: 0;
            transform: scaleX(0);
            transition: transform 0.3s ease-in-out;
        }

        .brand-name:hover {
            transform: scale(1.1);
        }

        .brand-name:hover::after {
            transform: scaleX(1);
        }

        /* Logo Styling */
        .logo {
            width: 50px;
            height: 50px;
            margin-right: 15px;
            border-radius: 50%;
            box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.3);
            transition: transform 0.3s ease-in-out;
        }

        .logo:hover {
            transform: rotate(360deg) scale(1.7);
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

        /* Hero Section */
        .hero {
            height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            color: black;
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 50px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            animation: fadeIn 1.5s ease-in-out;
            margin: 20px;
        }

        body.dark-mode .hero {
            color: white;
        }
        

   /* Add this to your existing styles */
   .hero h1 {
        display: inline-block;
        font-size: 3.5rem;
        font-weight: 800;
        text-transform: none;
        letter-spacing: 1px;
        line-height: 1.4;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 15px;
    }

    .hero h1 span {
        display: inline-block;
        background: linear-gradient(135deg, #ff6600 0%, #ff3366 50%, #8844ee 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: wordFloat 4s ease-in-out infinite;
    }

    /* Individual word animations with delays */
    .hero h1 span:nth-child(1) { animation-delay: 0s; }
    .hero h1 span:nth-child(2) { animation-delay: 0.2s; }
    .hero h1 span:nth-child(3) { animation-delay: 0.4s; }
    .hero h1 span:nth-child(4) { animation-delay: 0.6s; }
    .hero h1 span:nth-child(5) { animation-delay: 0.8s; }

    /* Updated Underline Animation - Continuous Shrink */
    .hero h1::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, #ff6600, #ff3366, #8844ee);
        border-radius: 2px;
        animation: 
            continuousShrink 2s ease-in-out infinite,
            colorFlow 6s linear infinite;
        transform-origin: center;
        background-size: 200% 100%;
    }

    /* Word Floating Animation (unchanged) */
    @keyframes wordFloat {
        0%, 100% {
            transform: translateY(0) rotate(0deg);
        }
        50% {
            transform: translateY(-8px) rotate(2deg);
        }
    }

    /* New Continuous Shrink Animation */
    @keyframes continuousShrink {
        0%, 100% {
            width: 100%;
        }
        50% {
            width: 30%;
        }
    }

    /* Color Flow Animation (unchanged) */
    @keyframes colorFlow {
        0% {
            background-position: 0% 50%;
        }
        100% {
            background-position: 100% 50%;
        }
    }

    /* For smaller screens (unchanged) */
    @media (max-width: 768px) {
        .hero h1 {
            font-size: 2.5rem;
            padding-bottom: 10px;
        }
        
        .hero h1::after {
            height: 3px;
        }
    }

    @media (max-width: 576px) {
        .hero h1 {
            font-size: 2rem;
            padding-bottom: 8px;
        }
        
        .hero h1::after {
            height: 2px;
        }
        
        @keyframes wordFloat {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-4px) rotate(1deg);
            }
        }
    }
    
    
    
   /* Subtitle Animation - Perfect Match with Title */
    .hero p {
        font-size: 22px;
        margin-top: 15px;
        color: rgba(0, 0, 0, 0.8);
        letter-spacing: 1px;
        max-width: 600px;
        position: relative;
        display: inline-block;
        animation: subtitleFlow 3s ease-in-out infinite;
        background: linear-gradient(135deg, #ff6600 0%, #ff3366 50%, #8844ee 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        padding-bottom: 8px;
    }

    .hero p::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 30%;
        height: 2px;
        background: linear-gradient(90deg, #ff6600, #ff3366, #8844ee);
        border-radius: 2px;
        animation: 
            subtitleLine 2.5s ease-in-out infinite,
            colorFlow 4s linear infinite;
        background-size: 200% 100%;
    }

    body.dark-mode .hero p {
        color: rgba(255, 255, 255, 0.8);
    }

    @keyframes subtitleFlow {
        0%, 100% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-5px);
        }
    }

    @keyframes subtitleLine {
        0%, 100% {
            width: 30%;
        }
        50% {
            width: 70%;
        }
    }

    @keyframes colorFlow {
        0% {
            background-position: 0% 50%;
        }
        100% {
            background-position: 100% 50%;
        }
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .hero p {
            font-size: 18px;
            padding-bottom: 6px;
        }
        .hero p::after {
            height: 1.5px;
        }
    }

    @media (max-width: 576px) {
        .hero p {
            font-size: 16px;
            padding-bottom: 5px;
        }
        .hero p::after {
            height: 1px;
        }
    }

        body.dark-mode .hero p {
            color: rgba(255, 255, 255, 0.8);
        }

        /* CTA Button */
        .cta-button {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px 34px;
            margin-top: 50px;
            font-size: 20px;
            font-weight: bold;
            color: black;
            border: 2px solid rgba(255, 165, 0, 0.6);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.4s ease-in-out;
            box-shadow: 0px 5px 15px rgba(255, 165, 0, 0.5);
            letter-spacing: 2px;
            text-transform: uppercase;
            outline: none;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }

        body.dark-mode .cta-button {
            color: white;
        }

        .cta-button:hover {
            background: linear-gradient(90deg, #ff6600, #ffcc00);
            box-shadow: 0px 8px 20px rgba(255, 165, 0, 0.8);
            transform: scale(1.1);
            border-color: #ffcc00;
        }

        /* Container and Content Sections */
        .container {
            width: 80%;
            margin: 50px auto;
        }

        .content-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 30px;
        }

        .content-section:hover {
            transform: scale(1.02);
        }

        .text-section {
            width: 55%;
            padding-right: 20px;
        }

        .text-section h2 {
            font-size: 30px;
            color: #ff6600;
            text-transform: uppercase;
            margin-bottom: 15px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
            border-left: 5px solid #ff4500;
            padding-left: 15px;
        }

        .text-section p {
            font-size: 15px;
            line-height: 1.6;
        }

        .text-section ul {
            list-style: none;
        }

        .text-section ul li {
            font-size: 15px;
            margin-bottom: 10px;
            color: black;
            padding-left: 30px;
            position: relative;
            line-height: 1.5;
        }

        .text-section ul li::before {
            content: "✔";
            color: #ff6600;
            font-size: 20px;
            position: absolute;
            left: 0;
            top: 2px;
        }

        .image-section {
            width: 40%;
        }

        .image-section img {
            width: 100%;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s ease-in-out;
        }

        .image-section img:hover {
            transform: scale(1.05);
        }

        /* Footer */
     /* Footer Styles */
.footer {
    background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
    color: white;
    position: relative;
    padding-top: 60px;
    margin-top: 80px;
}

.footer-wave {
    position: absolute;
    top: -1px;
    left: 0;
    width: 100%;
    overflow: hidden;
    line-height: 0;
    transform: rotate(180deg);
}

.footer-wave svg {
    position: relative;
    display: block;
    width: calc(100% + 1.3px);
    height: 50px;
}

.footer-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 40px;
}

.footer-section {
    margin-bottom: 30px;
    position: relative;
    z-index: 1;
}

.footer-heading {
    display: flex;
    align-items: center;
    margin-bottom: 25px;
    position: relative;
}

.footer-heading::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 0;
    width: 50px;
    height: 3px;
    background: #ff6600;
    border-radius: 3px;
}

.footer-icon {
    font-size: 24px;
    color: #ff6600;
    margin-right: 15px;
}

.footer-heading h3 {
    font-size: 1.5rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin: 0;
}

.footer-links {
    list-style: none;
    padding: 0;
}

.footer-links li {
    margin-bottom: 12px;
    transition: all 0.3s ease;
}

.footer-links li:hover {
    transform: translateX(5px);
}

.footer-links a {
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    display: flex;
    align-items: center;
    transition: all 0.3s ease;
    font-size: 1rem;
}

.footer-links a:hover {
    color: #ff6600;
}

.footer-links i {
    margin-right: 10px;
    font-size: 12px;
    color: #ff6600;
}

/* Contact Info Styles */
.contact-info {
    list-style: none;
    padding: 0;
}

.contact-item {
    display: flex;
    margin-bottom: 20px;
}

.contact-icon {
    font-size: 20px;
    color: #ff6600;
    margin-right: 15px;
    margin-top: 3px;
}

.contact-text {
    flex: 1;
}

.contact-label {
    display: block;
    font-weight: 600;
    color: #ff6600;
    font-size: 0.9rem;
    margin-bottom: 5px;
}

.contact-value, .contact-link {
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.95rem;
    display: block;
    line-height: 1.5;
    transition: all 0.3s ease;
}

.contact-values {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.contact-link {
    text-decoration: none;
}

.contact-link:hover {
    color: #ff6600;
    text-decoration: underline;
}

/* Newsletter Styles */
.newsletter-text {
    color: rgba(255, 255, 255, 0.8);
    margin-bottom: 20px;
    line-height: 1.6;
    font-size: 0.95rem;
}

.newsletter-form {
    margin-bottom: 30px;
}

.input-group {
    display: flex;
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.form-control {
    flex: 1;
    padding: 12px 20px;
    border: none;
    outline: none;
    font-size: 0.95rem;
    background: rgba(255, 255, 255, 0.9);
}

.subscribe-btn {
    background: #ff6600;
    color: white;
    border: none;
    padding: 0 20px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.subscribe-btn:hover {
    background: #e65c00;
}

/* Social Links Styles */
.social-links {
    margin-top: 30px;
}

.social-title {
    font-size: 1.1rem;
    margin-bottom: 15px;
    color: rgba(255, 255, 255, 0.9);
    position: relative;
    padding-bottom: 10px;
}

.social-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 40px;
    height: 2px;
    background: #ff6600;
}

.social-icons {
    display: flex;
    gap: 15px;
}

.social-icon {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 18px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.social-icon::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.1);
    z-index: -1;
    transition: all 0.3s ease;
}

.social-icon:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.social-icon:hover::before {
    background: rgba(255, 255, 255, 0.2);
}

.facebook { background: #3b5998; }
.twitter { background: #1da1f2; }
.instagram { background: linear-gradient(45deg, #405de6, #5851db, #833ab4, #c13584, #e1306c, #fd1d1d); }
.linkedin { background: #0077b5; }
.youtube { background: #ff0000; }

/* Copyright Styles */
.copyright-section {
    background: rgba(0, 0, 0, 0.2);
    padding: 20px 0;
    margin-top: 50px;
}

.copyright-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.copyright-text {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.9rem;
    margin-bottom: 10px;
}

.footer-legal {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 10px;
}

.legal-link {
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    font-size: 0.85rem;
    transition: all 0.3s ease;
}

.legal-link:hover {
    color: #ff6600;
}

.legal-separator {
    color: rgba(255, 255, 255, 0.3);
    font-size: 0.85rem;
}

/* Back to Top Button */
.back-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: #ff6600;
    color: white;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 999;
}

.back-to-top.active {
    opacity: 1;
    visibility: visible;
}

.back-to-top:hover {
    background: #e65c00;
    transform: translateY(-5px);
}

/* Responsive Styles */
@media (max-width: 992px) {
    .footer-container {
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
    }
}

@media (max-width: 768px) {
    .footer {
        padding-top: 40px;
    }
    
    .footer-section {
        text-align: center;
    }
    
    .footer-heading {
        justify-content: center;
    }
    
    .footer-heading::after {
        left: 50%;
        transform: translateX(-50%);
    }
    
    .footer-links li {
        justify-content: center;
    }
    
    .contact-item {
        flex-direction: column;
        align-items: center;
        text-align: center;
    }
    
    .contact-icon {
        margin-right: 0;
        margin-bottom: 10px;
    }
    
    .social-icons {
        justify-content: center;
    }
    
    .social-title::after {
        left: 50%;
        transform: translateX(-50%);
    }
}

@media (max-width: 576px) {
    .footer-container {
        grid-template-columns: 1fr;
    }
    
    .footer-section {
        margin-bottom: 40px;
    }
    
    .footer-heading h3 {
        font-size: 1.3rem;
    }
    
    .back-to-top {
        width: 40px;
        height: 40px;
        font-size: 16px;
        bottom: 20px;
        right: 20px;
    }
}
    </style>
</head>

<body>

  <div class="navbar">
    <div class="logo-container">
        <img src="library.png" alt="Library Logo" class="logo">
    </div>
    <span class="brand-name">Library Management System</span>
</div>

<!-- Dark/Light Mode Toggle Button -->
<button id="mode-toggle">🌙</button>

<div class="hero">
    <h1>
        <span>Welcome</span>
        <span>to</span>
        <span>the</span>
        <span>Smart</span>
        <span>&</span>
        <span>Secure</span>
        <span>Library</span>
        <span>Management</span>
        <span>System</span>
    </h1>
    <p>Experience hassle-free library management with the best security</p>
   
    
    
    <a href="Login.jsp" target="_blank">
        <button class="cta-button">Get Started</button>
    </a>
</div>

<div class="container">
    <div class="content-section">
        <div class="text-section">
            <h2>What is Library Management System?</h2>
            <p>A Library Management System is a digital solution that helps libraries manage books, member accounts, and borrowing processes efficiently. It automates library operations, making book tracking, issuing, and returning faster, more organized, and convenient for both librarians and users.</p>
        </div>
        <div class="image-section">
            <img src="32880.jpg" alt="Library System" class="img-fluid">
        </div>
    </div>
</div>

<div class="container">
    <div class="content-section">
        <div class="text-section">
            <h2>Function of Management System</h2>
            <ul>
                <li><b>🔹 Book Management:</b> Adds, updates, and organizes books and other library resources efficiently.</li>
                <li><b>🔹 Member Management:</b> Registers, maintains, and manages library member accounts and their details.</li>
                <li><b>🔹 Borrowing & Returning:</b> Tracks book issuing, returning, and overdue fines in real-time.</li>
                <li><b>🔹 Catalog Management:</b> Maintains a searchable catalog of books, journals, and digital resources.</li>
                <li><b>🔹 Reservation System:</b> Allows members to reserve books and notifies them when available.</li>
                <li><b>🔹 Report Generation:</b> Generates reports on book availability, member activity, and overdue items.</li>
            </ul>
        </div>
        <div class="image-section">
            <img src="31703.jpg" alt="Library Functions" class="img-fluid">
        </div>
    </div>
</div>

<div class="container">
    <div class="content-section">
        <div class="text-section">
            <h2>Importance of Library Management System</h2>
            <ul>
                <li><b>🔹 Efficiency & Automation:</b> Reduces manual work and speeds up library operations like book tracking and member management.</li>
                <li><b>🔹 Resource Organization:</b> Ensures books and digital resources are well-organized and easily accessible.</li>
                <li><b>🔹 Member Convenience:</b> Allows 24/7 access to book catalogs, reservations, and borrowing history.</li>
                <li><b>🔹 Borrowing & Returning Management:</b> Simplifies tracking of issued books, returns, and overdue fines.</li>
                <li><b>🔹 Regulatory Compliance:</b> Helps libraries follow institutional or government policies for resource management.</li>
                <li><b>🔹 Real-Time Updates:</b> Provides instant notifications for book availability, due dates, and reservations.</li>
                <li><b>🔹 Cost Reduction:</b> Saves money by reducing paperwork and manual record-keeping.</li>
            </ul>
        </div>
        <div class="image-section">
            <img src="20468.jpg" alt="Library Importance" class="img-fluid">
        </div>
    </div>
</div>

<footer class="footer">
    <div class="footer-wave">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
            <path fill="#ff6600" fill-opacity="1" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,0L1392,0C1344,0,1248,0,1152,0C1056,0,960,0,864,0C768,0,672,0,576,0C480,0,384,0,288,0C192,0,96,0,48,0L0,0Z"></path>
        </svg>
    </div>
    
    <div class="footer-container">
        <!-- Quick Links Section -->
        <div class="footer-section">
            <div class="footer-heading">
                <i class="fas fa-link footer-icon"></i>
                <h3>Quick Links</h3>
            </div>
            <ul class="footer-links">
                <li>
                    <a href="index.jsp" onclick="showNavigationAlert('Home')">
                        <i class="fas fa-chevron-right"></i> Home
                    </a>
                </li>
                <li>
                    <a href="about.jsp" onclick="showNavigationAlert('About Us')">
                        <i class="fas fa-chevron-right"></i> About Us
                    </a>
                </li>
                <li>
                    <a href="services.jsp" onclick="showNavigationAlert('Services')">
                        <i class="fas fa-chevron-right"></i> Services
                    </a>
                </li>
                <li>
                    <a href="catalog.jsp" onclick="showNavigationAlert('Book Catalog')">
                        <i class="fas fa-chevron-right"></i> Book Catalog
                    </a>
                </li>
                <li>
                    <a href="contact.jsp" onclick="showNavigationAlert('Contact')">
                        <i class="fas fa-chevron-right"></i> Contact
                    </a>
                </li>
            </ul>
        </div>

        <!-- Contact Information Section -->
        <div class="footer-section">
            <div class="footer-heading">
                <i class="fas fa-envelope-open-text footer-icon"></i>
                <h3>Contact Info</h3>
            </div>
            <ul class="contact-info">
                <li>
                    <div class="contact-item">
                        <i class="fas fa-map-marker-alt contact-icon"></i>
                        <div class="contact-text">
                            <span class="contact-label">Address:</span>
                            <span class="contact-value">Kanpur, UP, India</span>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="contact-item">
                        <i class="fas fa-phone-alt contact-icon"></i>
                        <div class="contact-text">
                            <span class="contact-label">Phone:</span>
                            <div class="contact-values">
                                <a href="tel:+918957946100" class="contact-link">+91 8957946100</a>
                                <a href="tel:+917318413600" class="contact-link">+91 7318413600</a>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="contact-item">
                        <i class="fas fa-envelope contact-icon"></i>
                        <div class="contact-text">
                            <span class="contact-label">Email:</span>
                            <div class="contact-values">
                                <a href="mailto:sftcoder@gmail.com" class="contact-link">sftcoder@gmail.com</a>
                                <a href="mailto:thecoderabhishek@gmail.com" class="contact-link">thecoderabhishek@gmail.com</a>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="contact-item">
                        <i class="fas fa-clock contact-icon"></i>
                        <div class="contact-text">
                            <span class="contact-label">Opening Hours:</span>
                            <span class="contact-value">Mon-Sat: 9:00 AM - 6:00 PM</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <!-- Newsletter Section -->
        <div class="footer-section">
            <div class="footer-heading">
                <i class="fas fa-paper-plane footer-icon"></i>
                <h3>Newsletter</h3>
            </div>
            <p class="newsletter-text">Subscribe to our newsletter for the latest updates and book releases.</p>
            <form class="newsletter-form" onsubmit="subscribeNewsletter(event)">
                <div class="input-group">
                    <input type="email" class="form-control" placeholder="Your Email Address" required>
                    <button class="subscribe-btn" type="submit">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </form>
            <div class="social-links">
                <h4 class="social-title">Follow Us:</h4>
                <div class="social-icons">
                    <a href="#" class="social-icon facebook" onclick="showSocialAlert('Facebook')">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-icon twitter" onclick="showSocialAlert('Twitter')">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-icon instagram" onclick="showSocialAlert('Instagram')">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="social-icon linkedin" onclick="showSocialAlert('LinkedIn')">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a href="#" class="social-icon youtube" onclick="showSocialAlert('YouTube')">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Copyright Section -->
    <div class="copyright-section">
        <div class="copyright-container">
            <p class="copyright-text">
                &copy; <span id="current-year">2025</span> Library Management System. All Rights Reserved.
            </p>
            <div class="footer-legal">
                <a href="privacy.jsp" class="legal-link">Privacy Policy</a>
                <span class="legal-separator">|</span>
                <a href="terms.jsp" class="legal-link">Terms of Service</a>
                <span class="legal-separator">|</span>
                <a href="sitemap.jsp" class="legal-link">Sitemap</a>
            </div>
            <span class="legal-separator">|
                <a  class="legal-link">Created by: Aditya Singh & Abhishek Kumar</a>
        </div>
        </span>
        
    </div>

    <!-- Back to Top Button -->
    <button class="back-to-top" onclick="scrollToTop()">
        <i class="fas fa-arrow-up"></i>
    </button>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleButton = document.getElementById("mode-toggle");
        const body = document.body;

        // Check local storage for mode
        if (localStorage.getItem("theme") === "dark") {
            body.classList.add("dark-mode");
            toggleButton.innerHTML = '<i class="fas fa-sun"></i>';
        } else {
            body.classList.remove("dark-mode");
            toggleButton.innerHTML = '<i class="fas fa-moon"></i>';
        }

        toggleButton.addEventListener("click", function () {
            body.classList.toggle("dark-mode");

            if (body.classList.contains("dark-mode")) {
                toggleButton.innerHTML = '<i class="fas fa-sun"></i>';
                localStorage.setItem("theme", "dark");
                showAlert("Dark mode enabled", "success");
            } else {
                toggleButton.innerHTML = '<i class="fas fa-moon"></i>';
                localStorage.setItem("theme", "light");
                showAlert("Light mode enabled", "info");
            }
        });
        
        // Show welcome message
        setTimeout(() => {
            showAlert("Welcome to Library Management System", "info");
        }, 1000);
    });
    
    // SweetAlert functions
    function showAlert(message, type) {
        Swal.fire({
            title: message,
            icon: type,
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
            }
        });
    }
    
    function showSocialAlert(platform) {
        Swal.fire({
            title: `Redirect to ${platform}`,
            text: `You'll be redirected to our ${platform} page.`,
            icon: 'info',
            showCancelButton: true,
            confirmButtonColor: '#ff6600',
            cancelButtonColor: '#6c757d',
            confirmButtonText: `Go to ${platform}`,
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                showAlert(`Redirecting to ${platform}...`, 'success');
                // In a real application, you would redirect to the actual social media page
                // window.location.href = `https://${platform}.com/yourpage`;
            }
        });
    }
    
    // Email click handler
    document.querySelectorAll('a[href^="mailto:"]').forEach(emailLink => {
        emailLink.addEventListener('click', function(e) {
            e.preventDefault();
            const email = this.getAttribute('href').replace('mailto:', '');
            Swal.fire({
                title: 'Send Email',
                text: `Do you want to send an email to ${email}?`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#ff6600',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Open Email Client',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = `mailto:${email}`;
                }
            });
        });
    });
    
    // Phone click handler
    document.querySelectorAll('a[href^="tel:"]').forEach(phoneLink => {
        phoneLink.addEventListener('click', function(e) {
            e.preventDefault();
            const phone = this.getAttribute('href').replace('tel:', '');
            Swal.fire({
                title: 'Make a Call',
                text: `Do you want to call ${phone}?`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#ff6600',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Call Now',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = `tel:${phone}`;
                }
            });
        });
    });
</script>

<script>

//Back to Top Button
window.addEventListener('scroll', function() {
    const backToTop = document.querySelector('.back-to-top');
    if (window.pageYOffset > 300) {
        backToTop.classList.add('active');
    } else {
        backToTop.classList.remove('active');
    }
});

function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

// Set current year in copyright
document.getElementById('current-year').textContent = new Date().getFullYear();

// Newsletter Subscription
function subscribeNewsletter(event) {
    event.preventDefault();
    const email = event.target.querySelector('input').value;
    
    Swal.fire({
        title: 'Subscribe to Newsletter',
        html: `You're subscribing with <strong>${email}</strong>`,
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#ff6600',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Subscribe',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            // In a real application, you would send this to your backend
            Swal.fire({
                title: 'Subscribed!',
                text: 'Thank you for subscribing to our newsletter.',
                icon: 'success',
                timer: 3000,
                timerProgressBar: true,
                showConfirmButton: false
            });
            event.target.reset();
        }
    });
}

// Navigation Alert
function showNavigationAlert(page) {
    event.preventDefault();
    Swal.fire({
        title: `Navigate to ${page}`,
        text: `You'll be redirected to the ${page} page.`,
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#ff6600',
        cancelButtonColor: '#6c757d',
        confirmButtonText: `Go to ${page}`,
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            // In a real application, you would redirect to the actual page
            // window.location.href = `${page}.jsp`;
            showAlert(`Redirecting to ${page}...`, 'success');
        }
    });
}

// Social Media Alert
function showSocialAlert(platform) {
    event.preventDefault();
    Swal.fire({
        title: `Visit our ${platform}`,
        text: `You'll be redirected to our ${platform} page.`,
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#ff6600',
        cancelButtonColor: '#6c757d',
        confirmButtonText: `Go to ${platform}`,
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            showAlert(`Redirecting to ${platform}...`, 'success');
            // In a real application, you would redirect to the actual social media page
            // window.location.href = `https://${platform}.com/yourpage`;
        }
    });
}

// Show Toast Alert
function showAlert(message, type) {
    Swal.fire({
        title: message,
        icon: type,
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });
}

</script>

</body>
</html>