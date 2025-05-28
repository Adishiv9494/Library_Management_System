<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coming Soon | Awesome Product</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Montserrat:wght@800&display=swap" rel="stylesheet">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    
    <style>
        :root {
            --primary-color: #6c63ff;
            --secondary-color: #4d44db;
            --accent-color: #ff6584;
            --dark-color: #2f2e41;
            --light-color: #f8f9fa;
        }
        
        body {
        	
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7ff;
            color: var(--dark-color);
            overflow-x: hidden;
        }
       
        .hero-section {
            min-height: 100vh;
            background: linear-gradient(100deg, #f5f7ff 2%, #e8ecff 100%);
            position: relative;
            padding-top: 10px;
        }
        
        .brand-logo {
        	 padding:10px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 2rem;
            color: var(--primary-color);
            
        }
        
        .coming-soon-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 3.5rem;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 2rem;
        }
        
        .lead-text {
            font-size: 1.25rem;
            max-width: 600px;
            margin: 0 auto 2rem;
        }
        
        .countdown-container {
            margin: 3rem 0;
        }
        
        .countdown-box {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(108, 99, 255, 0.1);
            padding: 1.5rem;
            margin: 0 0.5rem;
            min-width: 100px;
            text-align: center;
        }
        
        .countdown-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            line-height: 1;
        }
        
        .countdown-label {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6c757d;
            margin-top: 0.5rem;
        }
        
        .btn-cta {
            background: var(--primary-color);
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 600;
            border-radius: 50px;
            color: white;
            box-shadow: 0 4px 15px rgba(108, 99, 255, 1);
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-cta:hover {
            background: var(--secondary-color);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(108, 99, 255, 0.4);
            color: white;
        }
        
        .social-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: white;
            color: var(--primary-color);
            margin: 0 0.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .social-icon:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        
        .hero-graphic {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .hero-image {
    width: 100%;
    height: auto;
    border-radius: 25px;
    box-shadow: 0 25px 50px rgba(108, 115, 255, 2);
}
        
        .floating-element {
            position: absolute;
            opacity: 0.7;
            z-index: 0;
        }
        
        .floating-element-1 {
            top: 10%;
            left: 5%;
            animation: float 6s ease-in-out infinite;
        }
        
        .floating-element-2 {
            bottom: 15%;
            right: 5%;
            animation: float 8s ease-in-out infinite;
        }
        
        .floating-element-3 {
            top: 40%;
            right: 10%;
            animation: float 5s ease-in-out infinite;
        }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }
        
        .notify-form {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .form-control {
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            border: 1px solid #e0e0e0;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(108, 99, 255, 0.25);
        }
        
        footer {
            background: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .coming-soon-title {
                font-size: 2.5rem;
            }
            
            .countdown-box {
                min-width: 80px;
                padding: 1rem;
                margin: 0 0.25rem;
            }
            
            .countdown-value {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="hero-section">
        <!-- Floating decorative elements -->
        <img src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f4a5.svg" class="floating-element floating-element-1" width="60" alt="">
        <img src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f680.svg" class="floating-element floating-element-2" width="60" alt="">
        <img src="https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/1f4a1.svg" class="floating-element floating-element-3" width="60" alt="">
        
        <div class="container">
            <!-- Header -->
            <header class="d-flex justify-content-between align-items-center mb-5">
                <div class="brand-logo">AWE<span style="color: var(--accent-color);">SOME.</span></div>
                <div>
                    <a href="#" class="btn btn-outline-primary btn-sm">Contact Us</a>
                </div>
            </header>
            
            <!-- Main Content -->
            <div class="row align-items-center">
                <div class="col-lg-6 order-lg-1 order-2">
                    <h1 class="coming-soon-title animate__animated animate__fadeInUp">
                        Something Awesome Is Coming Soon
                    </h1>
                    <p class="lead-text animate__animated animate__fadeInUp animate__delay-1s">
                        We're working hard to bring you an amazing new experience. Stay tuned for our launch!
                    </p>
                    
                    <!-- Countdown Timer -->
                    <div class="countdown-container d-flex justify-content-center animate__animated animate__fadeInUp animate__delay-2s">
                        <div class="countdown-box">
                            <div class="countdown-value" id="days">00</div>
                            <div class="countdown-label">Days</div>
                        </div>
                        <div class="countdown-box">
                            <div class="countdown-value" id="hours">00</div>
                            <div class="countdown-label">Hours</div>
                        </div>
                        <div class="countdown-box">
                            <div class="countdown-value" id="minutes">00</div>
                            <div class="countdown-label">Minutes</div>
                        </div>
                        <div class="countdown-box">
                            <div class="countdown-value" id="seconds">00</div>
                            <div class="countdown-label">Seconds</div>
                        </div>
                    </div>
                   
                    <!-- Notify Form -->
                    <div class="notify-form animate__animated animate__fadeInUp animate__delay-3s">
                        <div class="input-group mb-3">
                            <input type="email" class="form-control" placeholder="Enter your email">
                            <button class="btn btn-cta" type="button">Notify Me</button>
                        </div>
                        <p class="text-center small text-muted">We'll notify you when we launch. No spam, promise!</p>
                    </div>
                    
                    <!-- Social Links -->
                    <div class="text-center mt-4 animate__animated animate__fadeInUp animate__delay-4s">
                        <p class="mb-3">Follow us for updates</p>
                        <div>
                            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6 order-lg-2 order-1 mb-5 mb-lg-0 animate__animated animate__fadeIn">
                    <div class="hero-graphic">
                        <img src="Logo/come4.gif" class="hero-image" alt="Coming Soon Illustration">
                    </div>
                </div>
              
            </div>
             
        </div>
    </div>
    
    <footer class="text-center">
        <div class="container">
            <p class="mb-2">&copy; 2023 Awesome Product. All rights reserved.</p>
            <p class="small text-muted">Designed with <i class="fas fa-heart" style="color: var(--accent-color);"></i> by Awesome Team</p>
        </div>
    </footer>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Countdown Timer Script -->
    <script>
        // Set the date we're counting down to (2 months from now)
        const countDownDate = new Date();
        countDownDate.setMonth(countDownDate.getMonth() + 2);
        
        // Update the count down every 1 second
        const x = setInterval(function() {
            // Get today's date and time
            const now = new Date().getTime();
            
            // Find the distance between now and the count down date
            const distance = countDownDate - now;
            
            // Time calculations for days, hours, minutes and seconds
            const days = Math.floor(distance / (1000 * 60 * 60 * 24));
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            // Display the result
            document.getElementById("days").innerHTML = days.toString().padStart(2, '0');
            document.getElementById("hours").innerHTML = hours.toString().padStart(2, '0');
            document.getElementById("minutes").innerHTML = minutes.toString().padStart(2, '0');
            document.getElementById("seconds").innerHTML = seconds.toString().padStart(2, '0');
            
            // If the count down is finished, write some text
            if (distance < 0) {
                clearInterval(x);
                document.getElementById("days").innerHTML = "00";
                document.getElementById("hours").innerHTML = "00";
                document.getElementById("minutes").innerHTML = "00";
                document.getElementById("seconds").innerHTML = "00";
            }
        }, 1000);
    </script>
</body>
</html>