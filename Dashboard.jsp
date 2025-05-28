<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.*" %>
<%
// Set cache control headers
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

// Get user details from session
String username = (String) session.getAttribute("username");
String email = (String) session.getAttribute("email");
String firstName = (String) session.getAttribute("first_name");
String lastName = (String) session.getAttribute("last_name");
String contactNumber = (String) session.getAttribute("contact_number");
String profileImage = (String) session.getAttribute("profile_image");
String address = (String) session.getAttribute("address");

// Create fullName by combining firstName and lastName
String fullName = "";
if (firstName != null && lastName != null) {
    fullName = firstName + " " + lastName;
} else if (firstName != null) {
    fullName = firstName;
} else if (lastName != null) {
    fullName = lastName;
} else if (username != null) {
    fullName = username;
}

// Redirect if not logged in
if (email == null) {
    response.sendRedirect("welcome.jsp");
    return;
}

// Get initials for profile icon
String initials = "";
if (firstName != null && !firstName.isEmpty() && lastName != null && !lastName.isEmpty()) {
    initials = firstName.substring(0, 1).toUpperCase() + lastName.substring(0, 1).toUpperCase();
} else if (username != null && !username.isEmpty()) {
    initials = username.substring(0, 1).toUpperCase();
}

// Get additional user details from database if not in session
if (email == null || contactNumber == null || profileImage == null || address == null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "Adishiv@7318");
        
        String query = "SELECT email, first_name, last_name, contact_number, profile_image, address FROM lib_loginsignup WHERE email = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            email = rs.getString("email");
            firstName = rs.getString("first_name");
            lastName = rs.getString("last_name");
            contactNumber = rs.getString("contact_number");
            address = rs.getString("address");
            
            // Get profile image if exists
            byte[] imageBytes = rs.getBytes("profile_image");
            if (imageBytes != null && imageBytes.length > 0) {
                profileImage = Base64.getEncoder().encodeToString(imageBytes);
                session.setAttribute("profile_image", profileImage);
            }
            
            // Store other details in session
            session.setAttribute("email", email);
            session.setAttribute("first_name", firstName);
            session.setAttribute("last_name", lastName);
            session.setAttribute("contact_number", contactNumber);
            session.setAttribute("address", address);
        }
        
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        // Handle error properly
    }
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
   
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Admin Dashboard</title>
    
   <style>
        @import url("https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap");
        
        * {
            font-family: "Ubuntu", sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --blue: #2a2185;
            --white: #fff;
            --gray: #f5f5f5;
            --black1: #222;
            --black2: #999;
        }

        body {
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container {
            position: relative;
            width: 100%;
        }

        .navigation {
            position: fixed;
            width: 300px;
            height: 100%;
            background: var(--blue);
            border-left: 10px solid var(--blue);
            transition: 0.5s;
            overflow: hidden;
        }
        .navigation.active {
            width: 80px;
        }

        .navigation ul {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
        }

        .navigation ul li {
            position: relative;
            width: 100%;
            list-style: none;
            border-top-left-radius: 30px;
            border-bottom-left-radius: 30px;
        }

        .navigation ul li:hover,
        .navigation ul li.hovered {
            background-color: var(--white);
        }

        .navigation ul li:nth-child(1) {
            margin-bottom: 40px;
            pointer-events: none;
        }

        .navigation ul li a {
            position: relative;
            display: block;
            width: 100%;
            display: flex;
            text-decoration: none;
            color: var(--white);
        }
        .navigation ul li:hover a,
        .navigation ul li.hovered a {
            color: var(--blue);
        }

        .navigation ul li a .icon {
            position: relative;
            display: block;
            min-width: 60px;
            height: 60px;
            line-height: 75px;
            text-align: center;
        }
        .navigation ul li a .icon ion-icon {
            font-size: 1.75rem;
        }

        .navigation ul li a .title {
            position: relative;
            display: block;
            padding: 0 10px;
            height: 60px;
            line-height: 60px;
            text-align: start;
            white-space: nowrap;
        }

        .navigation ul li:hover a::before,
        .navigation ul li.hovered a::before {
            content: "";
            position: absolute;
            right: 0;
            top: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px 35px 0 10px var(--white);
            pointer-events: none;
        }
        .navigation ul li:hover a::after,
        .navigation ul li.hovered a::after {
            content: "";
            position: absolute;
            right: 0;
            bottom: -50px;
            width: 50px;
            height: 50px;
            background-color: transparent;
            border-radius: 50%;
            box-shadow: 35px -35px 0 10px var(--white);
            pointer-events: none;
        }

        /* Improved Dropdown styles */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .main {
            position: absolute;
            width: calc(100% - 300px);
            left: 300px;
            min-height: 100vh;
            background: var(--white);
            transition: 0.5s;
        }
        .main.active {
            width: calc(100% - 80px);
            left: 80px;
        }

        .topbar {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
        }

        .toggle {
            position: relative;
            width: 60px;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2.5rem;
            cursor: pointer;
        }

        .search {
            position: relative;
            width: 400px;
            margin: 0 10px;
        }

        .search label {
            position: relative;
            width: 100%;
        }

        .search label input {
            width: 100%;
            height: 40px;
            border-radius: 40px;
            padding: 5px 20px;
            padding-left: 35px;
            font-size: 18px;
            outline: none;
            border: 1px solid var(--black2);
        }

        .search label ion-icon {
            position: absolute;
            top: 0;
            left: 10px;
            font-size: 1.2rem;
        }

        /* User Dropdown Styles */
        .user-dropdown {
            position: relative;
            display: inline-block;
        }

       /* Update user profile styles */
.user {
    position: relative;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    cursor: pointer;
    background-color: #2a2185;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 18px;
}

/* Add this for proper image display in profile icon */
.user img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Update image preview styles */
.image-preview {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-top: 10px;
    overflow: hidden;
    border: 2px solid #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f5f5f5;
}

.image-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

        .dropdown-menu {
            position: absolute;
            top: 50px;
            right: 0;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            width: 200px;
            z-index: 1000;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        .dropdown-menu ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .dropdown-menu li a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }

        .dropdown-menu li a:hover {
            background-color: #f5f5f5;
            color: #2a2185;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            animation: fadeIn 0.3s;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border-radius: 10px;
            width: 50%;
            max-width: 500px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .close-btn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close-btn:hover {
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .form-group input, 
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .save-btn {
            background-color: #2a2185;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .save-btn:hover {
            background-color: #1a1865;
        }

       

        .cardBox {
            position: relative;
            width: 100%;
            padding: 20px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 30px;
        }

        .cardBox .card {
            position: relative;
            background: var(--white);
            padding: 30px;
            border-radius: 20px;
            display: flex;
            justify-content: space-between;
            cursor: pointer;
            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.08);
        }

        .cardBox .card .numbers {
            position: relative;
            font-weight: 500;
            font-size: 2.5rem;
            color: var(--blue);
        }

        .cardBox .card .cardName {
            color: var(--black2);
            font-size: 1.1rem;
            margin-top: 5px;
        }

        .cardBox .card .iconBx {
            font-size: 3.5rem;
            color: var(--black2);
        }

        .cardBox .card:hover {
            background: var(--blue);
        }
        .cardBox .card:hover .numbers,
        .cardBox .card:hover .cardName,
        .cardBox .card:hover .iconBx {
            color: var(--white);
        }

        .details {
            position: relative;
            width: 100%;
            padding: 20px;
            display: grid;
            grid-template-columns: 2fr 1fr;
            grid-gap: 30px;
        }

        .table-container {
            margin-top: 30px;
            background: #007bff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(15, 2, 2, 0.1);
        }

        .table-container h3 {
            margin-bottom: 10px;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        table th {
            background: #ffff;
            color: rgb(63, 3, 3);
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        /* Dark Mode Styles */
        body.dark-mode {
            background: linear-gradient(115deg, #0a0a0a, #4e54c8);
            color: white;
        }

        body.dark-mode .navigation {
            background-color: #1e1e1e;
            color: white;
        }

        body.dark-mode .main {
            background-color: #1e1e1e;
            color: white;
        }

        body.dark-mode .card {
            background-color: #333;
            color: white;
        }

        body.dark-mode .table-container {
            background-color: #333;
            color: white;
        }

        body.dark-mode table {
            color: white;
        }

        body.dark-mode table th,
        body.dark-mode table td {
            border-color: #555;
        }

        body.dark-mode table th {
            background-color: #444;
            color: white;
        }

        body.dark-mode table tr:nth-child(even) {
            background-color: #444;
        }

        /* Dark Mode Dropdown Styles */
        body.dark-mode .dropdown-menu {
            background-color: #333;
            color: white;
        }

        body.dark-mode .dropdown-menu li a {
            color: white;
        }

        body.dark-mode .dropdown-menu li a:hover {
            background-color: #444;
            color: #ddd;
        }

        body.dark-mode .modal-content {
            background-color: #333;
            color: white;
        }

        body.dark-mode .form-group input,
        body.dark-mode .form-group textarea {
            background-color: #444;
            color: white;
            border-color: #555;
        }

        body.dark-mode .close-btn {
            color: #aaa;
        }

        body.dark-mode .close-btn:hover {
            color: #ddd;
        }

        /* Dark/Light Mode Toggle Button */
        #mode-toggle {
            background: linear-gradient(115deg, #0a0a0a, #4e54c8);
            border: 2px solid rgba(255, 165, 0, 0.6);
            color: #ff6600;
            padding: 10px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0px 5px 15px rgba(255, 165, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            margin-right: 20px;
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

        /* Topbar Layout Adjustments */
        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
        }

        .topbar .toggle {
            margin-right: auto;
        }

        .topbar .search {
            margin: 0 20px;
        }

        .topbar .user {
            display: flex;
            align-items: center;
        }

        @media (max-width: 991px) {
            .navigation {
                left: -300px;
            }
            .navigation.active {
                width: 300px;
                left: 0;
            }
            .main {
                width: 100%;
                left: 0;
            }
            .main.active {
                left: 300px;
            }
            .cardBox {
                grid-template-columns: repeat(2, 1fr);
            }
            .modal-content {
                width: 80%;
            }
        }

        @media (max-width: 768px) {
            .details {
                grid-template-columns: 1fr;
            }
            .recentOrders {
                overflow-x: auto;
            }
            .status.inProgress {
                white-space: nowrap;
            }
            .modal-content {
                width: 90%;
                margin: 10% auto;
            }
        }

        @media (max-width: 480px) {
            .cardBox {
                grid-template-columns: repeat(1, 1fr);
            }
            .cardHeader h2 {
                font-size: 20px;
            }
            .user {
                min-width: 40px;
            }
            .navigation {
                width: 100%;
                left: -100%;
                z-index: 1000;
            }
            .navigation.active {
                width: 100%;
                left: 0;
            }
            .toggle {
                z-index: 10001;
            }
            .main.active .toggle {
                color: #fff;
                position: fixed;
                right: 0;
                left: initial;
            }
            .dropdown-menu {
                width: 150px;
            }
            .search {
                width: 200px;
            }
        }
        /* Image Slider Styles */
.slider-container {
    width: 100%;
    margin: 10px 0;
    padding: 20px;
    overflow: hidden;
    position: relative;
}

.slider-title {
    text-align: center;
    margin-bottom: 20px;
    font-size: 1.8rem;
    color: var(--blue);
    position: relative;
}

.slider-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 3px;
    background: var(--blue);
}

.slider-track {
    display: flex;
    transition: transform 0.5s ease;
    width: 100%;
}

.slide {
    min-width: 25%;
    padding: 0 10px;
    box-sizing: border-box;
}

.slide img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}

.slide img:hover {
    transform: scale(1.05);
}

.slider-nav {
    text-align: center;
    margin-top: 20px;
}

.slider-nav button {
    background: var(--blue);
    color: white;
    border: none;
    padding: 8px 15px;
    margin: 0 5px;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s;
}

.slider-nav button:hover {
    background: #1a1865;
}

/* Dark mode adjustments */
body.dark-mode .slider-title {
    color: #fff;
}

body.dark-mode .slider-title::after {
    background: #fff;
}

body.dark-mode .slider-nav button {
    background: #4e54c8;
}

/* Responsive adjustments */
@media (max-width: 991px) {
    .slide {
        min-width: 33.33%;
    }
}

@media (max-width: 768px) {
    .slide {
        min-width: 50%;
    }
}

@media (max-width: 480px) {
    .slide {
        min-width: 100%;
    padding: 0 5px;
    margin-bottom: 10px;
    text-align: center;
    display: flex;
        justify-content: center;
    }
    
    .slide img {
        height: 150px;
        max-width: 300px;
    }
    
    .slider-title {
        font-size: 1.5rem;
    }
}
/* Modern Single Image Slider */
.gallery-container {
    width: 100%;
    max-width: 1000px;
    margin: 30px auto;
    padding: 20px;
    position: relative;
    overflow: hidden;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.gallery-title {
    text-align: center;
    margin-bottom: 20px;
    font-size: 2rem;
    color: var(--blue);
    position: relative;
}

.gallery-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 3px;
    background: var(--blue);
}

.single-slide {
    width: 100%;
    height: 400px;
    position: relative;
    overflow: hidden;
    border-radius: 10px;
}

.single-slide img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    position: absolute;
    top: 0;
    left: 0;
    opacity: 0;
    transition: opacity 1s ease-in-out;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.single-slide img.active {
    opacity: 1;
}

.slider-controls {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 10px;
    z-index: 10;
}

.slider-controls .dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: rgba(255,255,255,0.5);
    cursor: pointer;
    transition: all 0.3s;
}

.slider-controls .dot.active {
    background: var(--white);
    transform: scale(1.2);
}

/* Dark mode adjustments */
body.dark-mode .gallery-title {
    color: #fff;
}

body.dark-mode .gallery-title::after {
    background: #fff;
}

body.dark-mode .slider-controls .dot {
    background: rgba(255,255,255,0.3);
}

body.dark-mode .slider-controls .dot.active {
    background: var(--white);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .single-slide {
        height: 300px;
    }
}

@media (max-width: 480px) {
    .gallery-title {
        font-size: 1.5rem;
    }
    
    .single-slide {
        height: 200px;
    }
    
    .slider-controls .dot {
        width: 10px;
        height: 10px;
    }
}
    </style>
</head>

<body>
    <!-- =============== Navigation ================ -->
    <div class="container">
        <div class="navigation">
            <ul>
            
            
                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="library-outline"></ion-icon>
                        </span>
                        <span class="title">Library Management</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Home</span>
                    </a>
                </li>

                <li>
                    <a href="Addstudent.jsp">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">Manage Students</span>
                    </a>
                </li>

                <li>
                    <a href="Addbooks.jsp">
                        <span class="icon">
                            <ion-icon name="book-outline"></ion-icon>
                        </span>
                        <span class="title">Manage Books</span>
                    </a>
                </li>

                <li>
                    <a href="Issuebooks.jsp">
                        <span class="icon">
                            <ion-icon name="book-outline"></ion-icon>
                        </span>
                        <span class="title">Issue Books</span>
                    </a>
                </li>

                <li>
                    <a href="submittedBooks.jsp">
                        <span class="icon">
                            <ion-icon name="cart-outline"></ion-icon>
                        </span>
                        <span class="title">Return Books</span>
                    </a>
                </li>

                <li>
                    <a href="IssuedBooks.jsp">
                        <span class="icon">
                            <ion-icon name="book-outline"></ion-icon>
                        </span>
                        <span class="title">View issued Books</span>
                    </a>
                </li>

                <li>
                    <a href="studentRecords.jsp">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">View Students</span>
                    </a>
                </li>
                <li>
                    <a href="BooksRecords.jsp">
                        <span class="icon">
                            <ion-icon name="book-outline"></ion-icon>
                        </span>
                        <span class="title">View Books Data</span>
                    </a>
                </li>
                
                <li>
                    <a href="Report.jsp">
                        <span class="icon">
                            <ion-icon name="receipt-outline"></ion-icon>
                        </span>
                        <span class="title">Reports</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- ========================= Main ==================== -->
        <div class="main">
            <div class="topbar">
                <div class="toggle">
                    <ion-icon name="menu-outline"></ion-icon>
                </div>

                <button id="mode-toggle">🌙</button>

                <div class="user-dropdown">
                    <div class="user" id="profile-icon">
                        <% if (profileImage != null && !profileImage.isEmpty()) { %>
                            <img src="data:image/jpeg;base64,<%= profileImage %>" alt="Profile">
                        <% } else { %>
                            <%= initials %>
                        <% } %>
                    </div>
                    <div class="dropdown-menu">
                        <ul>
                            <li><a href="#" id="edit-profile-btn">Edit Profile</a></li>
                            <li><a href="LogoutServlet">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- ======================= Cards ================== -->
            
            
            
            <div class="cardBox">
            
            
 <div class="card">
    <div>
        <div class="numbers" id="studentCount">0</div>
        <div class="cardName">Total Students</div>
    </div>
    <div class="iconBx">
        <ion-icon name="people-outline"></ion-icon>
    </div>
</div>



  <div class="card">
  <div>
    <div class="numbers" id="bookCount">0</div>
    <div class="cardName">Total Books</div>
  </div>
  <div class="iconBx">
    <ion-icon name="book-outline"></ion-icon>
  </div>
</div>


                
                
<div class="card">
  <div>
    <div class="numbers" id="issuedBookCount">0</div>
    <div class="cardName">Issued Books</div>
  </div>
  <div class="iconBx">
    <ion-icon name="book-outline"></ion-icon>
  </div>
</div>
<div class="card">
  <div>
    <div class="numbers" id="pendingCount">0</div>
    <div class="cardName">Available Books</div>
  </div>
  <div class="iconBx">
    <ion-icon name="file-tray-full-outline"></ion-icon>
  </div>
</div>
                

 
            </div>
            

            <!-- =================== Single Image Gallery ================== -->
            <div class="gallery-container">
                <h2 class="gallery-title">Our Library Gallery</h2>
                <div class="single-slide">
                    <img src="library_01.jpg" alt="Library Image 1" class="active">
                    <img src="library_05.jpg" alt="Library Image 5">
                    <img src="library_07.jpg" alt="Library Image 7">
                    <img src="library_02.jpg" alt="Library Image 2">
                    <img src="library_03.jpg" alt="Library Image 3">
                    <img src="library_04.jpg" alt="Library Image 4">
                    <img src="library_09.jpg" alt="Library Image 9">
                    <img src="library_08.jpg" alt="Library Image 8">
                    
                </div>
                <div class="slider-controls" id="slider-controls">
                    <!-- Dots will be added dynamically -->
                </div>
            </div>
            
            <div class="modal" id="profile-modal">
                <div class="modal-content">
                    <span class="close-btn">&times;</span>
                    <h2>Edit Profile</h2>
                    <form id="profile-form" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="profile-name">Full Name</label>
                            <input type="text" id="profile-name" value="<%= fullName %>" required>
                        </div>
                        <div class="form-group">
                            <label for="profile-email">Email</label>
                            <input type="email" id="profile-email" value="<%= email %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="profile-phone">Phone Number</label>
                            <input type="tel" id="profile-phone" value="<%= contactNumber != null ? contactNumber : "" %>">
                        </div>
                        <div class="form-group">
                            <label for="profile-address">Address</label>
                            <textarea id="profile-address" rows="3"><%= address != null ? address : "" %></textarea>
                        </div>
                        <div class="form-group">
                            <label for="profile-photo">Profile Photo</label>
                            <input type="file" id="profile-photo" name="profilePhoto" accept="image/*">
                            <div class="image-preview" id="image-preview">
                                <% if (profileImage != null && !profileImage.isEmpty()) { %>
                                    <img src="data:image/jpeg;base64,<%= profileImage %>" alt="Current Profile">
                                <% } %>
                            </div>
                        </div>
                        <button type="submit" class="save-btn">Save Changes</button>
                    </form>
                </div>
            </div>

            <!-- =========== Scripts =========  -->
            <script>
    // Dark/Light Mode Toggle
    document.addEventListener("DOMContentLoaded", () => {
        const modeToggle = document.getElementById("mode-toggle");
        const body = document.body;

        // Check local storage for mode
        if (localStorage.getItem("theme") === "dark") {
            body.classList.add("dark-mode");
            modeToggle.innerHTML = "☀";
        } else {
            body.classList.remove("dark-mode");
            modeToggle.innerHTML = "🌙";
        }

        modeToggle.addEventListener("click", () => {
            body.classList.toggle("dark-mode");

            if (body.classList.contains("dark-mode")) {
                modeToggle.innerHTML = "☀";
                localStorage.setItem("theme", "dark");
            } else {
                modeToggle.innerHTML = "🌙";
                localStorage.setItem("theme", "light");
            }
        });

        // Menu Toggle
        const toggle = document.querySelector(".toggle");
        const navigation = document.querySelector(".navigation");
        const main = document.querySelector(".main");

        if (toggle && navigation && main) {
            toggle.onclick = function() {
                navigation.classList.toggle("active");
                main.classList.toggle("active");
            };
        }

        // Profile Dropdown Functionality
        const profileIcon = document.getElementById('profile-icon');
        const dropdownMenu = document.querySelector('.dropdown-menu');
        
        if (profileIcon && dropdownMenu) {
            profileIcon.addEventListener('click', function(e) {
                e.stopPropagation();
                dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
            });
            
            // Close dropdown when clicking elsewhere
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.user-dropdown')) {
                    dropdownMenu.style.display = 'none';
                }
            });
        }

        // Edit Profile Modal
        const editProfileBtn = document.getElementById('edit-profile-btn');
        const profileModal = document.getElementById('profile-modal');
        const closeBtn = document.querySelector('.close-btn');
        
        if (editProfileBtn && profileModal && closeBtn) {
            editProfileBtn.addEventListener('click', function(e) {
                e.preventDefault();
                profileModal.style.display = 'block';
            });
            
            closeBtn.addEventListener('click', function() {
                profileModal.style.display = 'none';
            });
            
            window.addEventListener('click', function(e) {
                if (e.target === profileModal) {
                    profileModal.style.display = 'none';
                }
            });
        }
        
        // Image preview functionality
        const fileInput = document.getElementById('profile-photo');
        const imagePreview = document.getElementById('image-preview');
        
        if (fileInput && imagePreview) {
            fileInput.addEventListener('change', function() {
                const file = this.files[0];
                if (file) {
                    // Validate file type
                    const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
                    if (!validTypes.includes(file.type)) {
                        Swal.fire({
                            title: 'Invalid File Type',
                            text: 'Please upload a JPEG, PNG, or GIF image',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                        this.value = '';
                        return;
                    }
                    
                    // Validate file size (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        Swal.fire({
                            title: 'File Too Large',
                            text: 'Please upload an image smaller than 5MB',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                        this.value = '';
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        imagePreview.innerHTML = '<img src="' + e.target.result + '" alt="Preview">';
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
        
        // Form submission with enhanced error handling
        const profileForm = document.getElementById('profile-form');
        if (profileForm) {
            profileForm.addEventListener('submit', async function(e) {
                e.preventDefault();
                
                // Validate form inputs
                const fullName = document.getElementById('profile-name').value.trim();
                const phone = document.getElementById('profile-phone').value.trim();
                
                if (!fullName) {
                    Swal.fire({
                        title: 'Validation Error',
                        text: 'Full name is required',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                
                // Show loading indicator
                const saveBtn = profileForm.querySelector('.save-btn');
                const originalBtnText = saveBtn.innerHTML;
                saveBtn.disabled = true;
                saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';
                
                try {
                    const formData = new FormData();
                    formData.append('fullName', fullName);
                    formData.append('phone', phone);
                    formData.append('address', document.getElementById('profile-address').value.trim());
                    
                    if (fileInput && fileInput.files[0]) {
                        formData.append('profilePhoto', fileInput.files[0]);
                    }
                    
                    // Add CSRF token if using Spring Security
                    const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                    if (csrfToken) {
                        formData.append('_csrf', csrfToken);
                    }
                    
                    // Send data to server with credentials
                    const response = await fetch('ProfileImageServlet', {
                        method: 'POST',
                        body: formData,
                        credentials: 'include' // Include cookies for session
                    });
                    
                    // Check for HTTP errors
                    if (response.status === 401) {
                        // Session expired
                        throw new Error(JSON.stringify({
                            status: 'error',
                            message: 'Session expired. Please login again.',
                            redirect: true
                        }));
                    }
                    
                    if (!response.ok) {
                        const error = await response.text();
                        throw new Error(error || `HTTP error! status: ${response.status}`);
                    }
                    
                    // Parse JSON response
                    const result = await response.json();
                    
                    if (result.status === 'success') {
                        // Update UI based on response
                        if (result.imageUpdated && fileInput && fileInput.files[0]) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                if (profileIcon) {
                                    profileIcon.innerHTML = '<img src="' + e.target.result + '" alt="Profile">';
                                }
                            };
                            reader.readAsDataURL(fileInput.files[0]);
                        }
                        
                        // Show success message
                        await Swal.fire({
                            title: 'Success!',
                            text: result.message || 'Profile updated successfully',
                            icon: 'success',
                            confirmButtonText: 'OK',
                            confirmButtonColor: '#2a2185',
                            background: body.classList.contains('dark-mode') ? '#1e1e1e' : '#fff',
                            color: body.classList.contains('dark-mode') ? '#fff' : '#333',
                            timer: 3000,
                            timerProgressBar: true
                        });
                        
                        // Close modal and reload page
                        if (profileModal) {
                            profileModal.style.display = 'none';
                        }
                        setTimeout(() => location.reload(), 500);
                    } else {
                        throw new Error(JSON.stringify(result));
                    }
                } catch (error) {
                    console.error('Update error:', error);
                    
                    // Parse error message
                    let errorMsg = 'An error occurred while updating profile';
                    let redirect = false;
                    
                    try {
                        const errorObj = JSON.parse(error.message);
                        errorMsg = errorObj.message || errorMsg;
                        redirect = errorObj.redirect || false;
                    } catch (e) {
                        errorMsg = error.message || errorMsg;
                    }
                    
                    if (redirect) {
                        await Swal.fire({
                            title: 'Session Expired',
                            text: errorMsg,
                            icon: 'error',
                            confirmButtonText: 'Login',
                            allowOutsideClick: false
                        }).then(() => {
                            window.location.href = 'Login.jsp'; // Redirect to login page
                        });
                    } else {
                        await Swal.fire({
                            title: 'Error!',
                            text: errorMsg,
                            icon: 'error',
                            confirmButtonText: 'OK',
                            confirmButtonColor: '#d33',
                            background: body.classList.contains('dark-mode') ? '#1e1e1e' : '#fff',
                            color: body.classList.contains('dark-mode') ? '#fff' : '#333'
                        });
                    }
                } finally {
                    // Reset button state
                    saveBtn.disabled = false;
                    saveBtn.innerHTML = originalBtnText;
                }
            });
        }
        
        // Single Image Gallery Functionality
        const galleryContainer = document.querySelector('.single-slide');
        if (galleryContainer) {
            const images = galleryContainer.querySelectorAll('img');
            const sliderControls = document.getElementById('slider-controls');
            let currentIndex = 0;
            let autoSlideInterval;
            
            // Create navigation dots
            if (sliderControls) {
                images.forEach((_, index) => {
                    const dot = document.createElement('div');
                    dot.classList.add('dot');
                    if (index === 0) dot.classList.add('active');
                    dot.addEventListener('click', () => {
                        goToSlide(index);
                    });
                    sliderControls.appendChild(dot);
                });
            }
            
            const dots = sliderControls ? sliderControls.querySelectorAll('.dot') : [];
            
            // Go to specific slide
            function goToSlide(index) {
                images[currentIndex].classList.remove('active');
                if (dots.length > 0) {
                    dots[currentIndex].classList.remove('active');
                }
                
                currentIndex = index;
                
                images[currentIndex].classList.add('active');
                if (dots.length > 0) {
                    dots[currentIndex].classList.add('active');
                }
                
                // Reset auto-slide timer
                resetAutoSlide();
            }
            
            // Next slide
            function nextSlide() {
                const newIndex = (currentIndex + 1) % images.length;
                goToSlide(newIndex);
            }
            
            // Start auto sliding
            function startAutoSlide() {
                autoSlideInterval = setInterval(nextSlide, 3000);
            }
            
            // Reset auto slide timer
            function resetAutoSlide() {
                clearInterval(autoSlideInterval);
                startAutoSlide();
            }
            
            // Initialize the gallery
            function initGallery() {
                // Show first image
                images[0].classList.add('active');
                if (dots.length > 0) {
                    dots[0].classList.add('active');
                }
                
                // Start auto-slide
                startAutoSlide();
                
                // Pause on hover
                galleryContainer.addEventListener('mouseenter', () => {
                    clearInterval(autoSlideInterval);
                });
                
                galleryContainer.addEventListener('mouseleave', startAutoSlide);
            }
            
            // Initialize the gallery
            initGallery();
        }
    });
</script>


            <!-- ====== ionicons ======= -->
            <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
            <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
        </div>
    </div>
    
<!--     <script>
    function fetchTotalStudents() {
        fetch('TotalStudentCount') // servlet URL
            .then(response => response.text())
            .then(data => {
                document.getElementById('studentCount').innerText = data;
            })
            .catch(error => console.error('Error fetching student count:', error));
    }

    // Call on page load
    window.onload = function() {
        fetchTotalStudents();

        // Auto refresh every 10 seconds (optional)
        setInterval(fetchTotalStudents, 10000);
    };
</script>

<script>
  window.onload = function() {
    fetch('BooksCount')
      .then(response => response.text())
      .then(count => {
        document.getElementById("bookCount").innerText = count;
      })
      .catch(error => {
        console.error("Error fetching book count:", error);
      });
  };
</script> -->

<script>
  // Function to fetch and display pending books count
  function fetchPendingBooksCount() {
    fetch('PendingBooksCount')
      .then(response => {
        if (!response.ok) throw new Error('Pending books count fetch failed');
        return response.text();
      })
      .then(count => {
        document.getElementById("pendingCount").innerText = count;
      })
      .catch(error => {
        console.error("Error fetching pending books count:", error);
        document.getElementById("pendingCount").innerText = "0";
      });
  }

  // Function to initialize all counts
  function initializeCounts() {
    // Books Count
    fetch('BooksCount')
      .then(response => {
        if (!response.ok) throw new Error('Book count fetch failed');
        return response.text();
      })
      .then(count => {
        document.getElementById("bookCount").innerText = count;
      })
      .catch(error => {
        console.error("Error fetching book count:", error);
        document.getElementById("bookCount").innerText = "0";
      });

    // Students Count
    fetch('TotalStudentCount')
      .then(response => {
        if (!response.ok) throw new Error('Student count fetch failed');
        return response.text();
      })
      .then(count => {
        document.getElementById("studentCount").innerText = count;
      })
      .catch(error => {
        console.error("Error fetching student count:", error);
        document.getElementById("studentCount").innerText = "0";
      });

    // Issued Books Count
    fetch('IssuesBooksCount')
      .then(response => {
        if (!response.ok) throw new Error('Issued books count fetch failed');
        return response.text();
      })
      .then(count => {
        document.getElementById("issuedBookCount").innerText = count;
      })
      .catch(error => {
        console.error("Error fetching issued books count:", error);
        document.getElementById("issuedBookCount").innerText = "0";
      });

    // Pending Books Count
    fetchPendingBooksCount();
  }

  // Initialize on page load
  document.addEventListener("DOMContentLoaded", function() {
    initializeCounts();
    
    // Auto-refresh every 60 seconds
    setInterval(initializeCounts, 60000);
  });
</script>
</body>
</html>