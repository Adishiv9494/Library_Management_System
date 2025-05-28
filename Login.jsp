<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="lib.png">
    <title>Login and Signup</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', 'sans-serif';
    }

    body {
        background: linear-gradient(135deg, #0a0a0a, #4e54c8);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        transition: all 0.5s ease;
    }

    /* Dark Mode Styles */
    body.dark-mode {
        background: linear-gradient(135deg, #121212, #2c3e50);
        color: #f5f5f5;
    }

    body.dark-mode .container {
        background: #2d3436;
        box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
    }

    body.dark-mode .form-box {
        background: #2d3436;
    }

    body.dark-mode .input-box input {
        background: #3d4548;
        color: #f5f5f5;
    }

    body.dark-mode .input-box input::placeholder {
        color: #bbb;
    }

    body.dark-mode .btn {
        background: #4e54c8;
        color: white;
    }

    body.dark-mode .forget-link a {
        color: #bbb;
    }

    body.dark-mode .social-icons a {
        color: white;
        border-color: white;
    }

    body.dark-mode .toggle-panel {
        color: white;
    }

    body.dark-mode .toggle-panel .btn {
        border-color: white;
        color: white;
    }

    /* Dark/Light Mode Toggle Button */
    #mode-toggle {
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(135deg, #4e54c8, #8f94fb);
        border: none;
        color: white;
        padding: 10px;
        border-radius: 50%;
        font-size: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(78, 84, 200, 0.5);
        z-index: 1000;
        display: flex;
        align-items: right;
        justify-content: center;
        width: 45px;
        height: 45px;
    }

    #mode-toggle:hover {
        transform: scale(1.1) rotate(30deg);
        box-shadow: 0 6px 20px rgba(78, 84, 200, 0.7);
    }

    body.dark-mode #mode-toggle {
        background: linear-gradient(135deg, #2c3e50, #4ca1af);
        box-shadow: 0 4px 15px rgba(44, 62, 80, 0.5);
    }

    .container {
        position: relative;
        width: 1300px;
        height: 730px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        overflow: hidden;
        margin: 2px;
    }

    .form-box {
        position: absolute;
        right: 0;
        width: 50%;
        height: 100%;
        background: #fff;
        display: flex;
        align-items: center;
        color: #333;
        text-align: center;
        padding: 40px;
        z-index: 1;
        transition: .6s ease-in-out 1.2s, visibility 0s 1s;
    }

    .container.active .form-box {
        right: 50%;
    }

    .form-box.register {
        visibility: hidden;
    }

    .container.active .form-box.register {
        visibility: visible;
    }

    form {
        width: 100%;
        height: 100%;
        overflow-y: auto;
        padding-right: 10px;
    }

    form::-webkit-scrollbar {
        width: 6px;
    }

    form::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }

    form::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 10px;
    }

    form::-webkit-scrollbar-thumb:hover {
        background: #555;
    }

    body.dark-mode form::-webkit-scrollbar-track {
        background: #3d4548;
    }

    body.dark-mode form::-webkit-scrollbar-thumb {
        background: #666;
    }

    .container h1 {
        font-size: 36px;
        margin-bottom: 20px;
        background: linear-gradient(to right, #4e54c8, #8f94fb);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
    }

    body.dark-mode .container h1 {
        background: linear-gradient(to right, #8f94fb, #4ca1af);
        -webkit-background-clip: text;
        background-clip: text;
    }

    .input-row {
        display: flex;
        gap: 15px;
        margin-bottom: 15px;
    }

    .input-box {
        position: relative;
        margin-bottom: 15px;
        flex: 1;
    }

    .input-box input {
        width: 100%;
        padding: 15px 50px 15px 20px;
        background: #f5f5f5;
        border-radius: 10px;
        border: 2px solid transparent;
        outline: none;
        font-size: 16px;
        color: #333;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .input-box input:focus {
        border-color: #4e54c8;
        box-shadow: 0 0 10px rgba(78, 84, 200, 0.3);
        background: white;
    }

    body.dark-mode .input-box input:focus {
        background: #3d4548;
    }

    .input-box input::placeholder {
        color: #888;
        font-weight: 400;
    }

    .input-box i {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        color: #888;
        cursor: pointer;
    }

    .forget-link {
        margin: -10px 0 20px;
        text-align: right;
    }

    .forget-link a {
        font-size: 14px;
        color: #666;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .forget-link a:hover {
        color: #4e54c8;
        text-decoration: underline;
    }

    body.dark-mode .forget-link a:hover {
        color: #8f94fb;
    }

    .btn {
        width: 75%;
        height: 50px;
        background: linear-gradient(to right, #4e54c8, #8f94fb);
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(78, 84, 200, 0.3);
        cursor: pointer;
        font-size: 18px;
        color: white;
        font-weight: 600;
        border: none;
        transition: all 0.3s ease;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(78, 84, 200, 0.4);
    }

    .container p {
        font-size: 14px;
        margin: 20px 0;
        color: #666;
    }

    body.dark-mode .container p {
        color: #bbb;
    }

    .social-icons {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin: 20px 0;
    }

    .social-icons a {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        border-radius: 50%;
        font-size: 20px;
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .social-icons a:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
    }

    .social-icons a:nth-child(1) {
        background: linear-gradient(to right, #4285F4, #34A853);
    }

    .social-icons a:nth-child(2) {
        background: linear-gradient(to right, #3b5998, #4267B2);
    }

    .social-icons a:nth-child(3) {
        background: linear-gradient(to right, #1DA1F2, #1DA1F2);
    }

    .social-icons a:nth-child(4) {
        background: linear-gradient(to right, #E4405F, #FD1D1D);
    }

    .captcha-container {
        display: flex;
        align-items: center;
        margin: 20px 0;
        gap: 10px;
    }

    .captcha-box {
        display: flex;
        align-items: center;
        background: #f5f5f5;
        border-radius: 10px;
        padding: 5px 15px;
        flex: 1;
    }

    body.dark-mode .captcha-box {
        background: #3d4548;
    }

    .captcha-text {
        font-family: 'Courier New', monospace;
        font-size: 24px;
        font-weight: bold;
        letter-spacing: 5px;
        background: linear-gradient(to right, #4e54c8, #8f94fb);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        flex: 1;
        text-align: center;
    }

    body.dark-mode .captcha-text {
        background: linear-gradient(to right, #8f94fb, #4ca1af);
        -webkit-background-clip: text;
        background-clip: text;
    }

    .refresh-captcha {
        cursor: pointer;
        color: #888;
        font-size: 20px;
        transition: all 0.3s ease;
    }

    .refresh-captcha:hover {
        transform: rotate(90deg);
        color: #4e54c8;
    }

    body.dark-mode .refresh-captcha:hover {
        color: #8f94fb;
    }

    .captcha-input {
        flex: 1;
    }

    .toggle-box {
        position: absolute;
        width: 100%;
        height: 100%;
    }

    .container.active .toggle-box::before {
        left: 50%;
    }

    .toggle-box::before {
        content: '';
        position: absolute;
        left: -250%;
        width: 300%;
        height: 100%;
        background: linear-gradient(to right, #4e54c8, #8f94fb);
        border-radius: 150px;
        z-index: 2;
        transition: 1.8s ease-in-out;
    }

    body.dark-mode .toggle-box::before {
        background: linear-gradient(to right, #2c3e50, #4ca1af);
    }

    .toggle-panel {
        position: absolute;
        width: 50%;
        height: 100%;
        color: #fff;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        z-index: 2;
        transition: .6s ease-in-out;
        padding: 40px;
        text-align: center;
    }

    .toggle-panel h1 {
        color: white;
        background: none;
        -webkit-background-clip: initial;
        background-clip: initial;
    }

    .toggle-panel.toggle-left {
        left: 0;
        transition-delay: 1.2s;
    }

    .container.active .toggle-panel.toggle-left {
        left: -50%;
        transition-delay: .6s;
    }

    .toggle-panel.toggle-right {
        right: -50%;
        transition-delay: .6s;
    }

    .container.active .toggle-panel.toggle-right {
        right: 0;
        transition-delay: 1.2s;
    }

    .toggle-panel p {
        margin: 15px 0;
        color: rgba(255, 255, 255, 0.8);
    }

    .toggle-panel .btn {
        width: 160px;
        height: 46px;
        background: transparent;
        border: 2px solid #fff;
        border-radius: 10px;
        box-shadow: none;
        color: white;
        margin-top: 20px;
    }

    .toggle-panel .btn:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-2px);
    }

    .password-feedback {
        font-size: 12px;
        margin-top: 5px;
        text-align: left;
        padding-left: 5px;
        transition: all 0.3s ease;
    }

    .password-strength {
        width: 100%;
        height: 4px;
        background: #f1f1f1;
        border-radius: 2px;
        margin-top: 5px;
        overflow: hidden;
    }

    .password-strength-bar {
        height: 100%;
        width: 0%;
        background: #ff4757;
        transition: width 0.3s ease, background 0.3s ease;
    }

    body.dark-mode .password-strength {
        background: #3d4548;
    }

    /* Floating label effect */
    .floating-label {
        position: absolute;
        pointer-events: none;
        left: 20px;
        top: 15px;
        transition: 0.2s ease all;
        color: #888;
        font-size: 16px;
    }

    .input-box input:focus ~ .floating-label,
    .input-box input:not(:placeholder-shown) ~ .floating-label {
        top: -10px;
        left: 15px;
        font-size: 12px;
        background: white;
        padding: 0 5px;
        color: #4e54c8;
    }

    body.dark-mode .input-box input:focus ~ .floating-label,
    body.dark-mode .input-box input:not(:placeholder-shown) ~ .floating-label {
        background: #2d3436;
    }

    /* Terms checkbox */
    .terms-container {
        display: flex;
        align-items: center;
        margin: 15px 0;
        text-align: left;
    }

    .terms-container input {
        margin-right: 10px;
    }

    .terms-container label {
        font-size: 13px;
        color: #666;
    }

    .terms-container a {
        color: #4e54c8;
        text-decoration: none;
    }

    body.dark-mode .terms-container label {
        color: #bbb;
    }

    body.dark-mode .terms-container a {
        color: #8f94fb;
    }

    /* OTP Modal */
    .modal {
        display: none;
        position: fixed;
        z-index: 1001;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        width: 400px;
        max-width: 90%;
        animation: modalopen 0.4s;
    }

    body.dark-mode .modal-content {
        background-color: #2d3436;
        color: #fff;
    }

    @keyframes modalopen {
        from {opacity: 0; transform: translateY(-50px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .close-modal {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    .close-modal:hover {
        color: #333;
    }

    body.dark-mode .close-modal:hover {
        color: #fff;
    }

    .otp-inputs {
        display: flex;
        justify-content: space-between;
        margin: 20px 0;
    }

    .otp-inputs input {
        width: 50px;
        height: 50px;
        text-align: center;
        font-size: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin: 0 5px;
    }

    body.dark-mode .otp-inputs input {
        background: #3d4548;
        border-color: #555;
        color: #fff;
    }

    .resend-otp {
        text-align: center;
        margin-top: 15px;
    }

    .resend-otp a {
        color: #4e54c8;
        text-decoration: none;
        cursor: pointer;
    }

    body.dark-mode .resend-otp a {
        color: #8f94fb;
    }

    @media screen and (max-width:950px) {
        .container {
            width: 90%;
        }
    }

    @media screen and (max-width:650px) {
        .container {
            height: calc(100vh - 4px);
            width: 100%;
            border-radius: 0;
        }

        .form-box {
            bottom: 0;
            width: 100%;
            height: 75%;
            padding: 30px;
        }

        .container.active .form-box {
            right: 0;
            bottom: 20%;
        }

        .toggle-box::before {
            left: 0;
            top: -275%;
            width: 100%;
            height: 300%;
            border-radius: 20vw;
        }

        .toggle-panel {
            width: 100%;
            height: 30%;
            padding: 20px;
        }

        .container.active .toggle-box::before {
            left: 0;
            top: 70%;
        }

        .container.active .toggle-panel.toggle-left {
            left: 0;
            top: -30%;
        }

        .container.active .toggle-panel.toggle-right {
            bottom: 0;
        }

        .toggle-panel.toggle-left {
            top: 0;
        }

        .toggle-panel.toggle-right {
            right: 0;
            bottom: -30%;
        }

        .toggle-panel h1 {
            font-size: 24px;
        }

        .toggle-panel p {
            font-size: 14px;
        }

        .toggle-panel .btn {
            width: 120px;
            height: 40px;
            font-size: 14px;
        }

        .input-row {
            flex-direction: column;
            gap: 0;
        }

        .captcha-container {
            flex-direction: column;
        }

        .captcha-box {
            width: 100%;
        }

        .captcha-input {
            width: 100%;
        }
    }

    @media screen and (max-width:400px) {
        .form-box {
            padding: 20px;
        }

        .container h1 {
            font-size: 28px;
        }

        .input-box input {
            padding: 12px 45px 12px 15px;
            font-size: 14px;
        }

        .btn {
            height: 45px;
            font-size: 16px;
        }

        .social-icons a {
            width: 40px;
            height: 40px;
            font-size: 18px;
        }

        .modal-content {
            padding: 20px;
        }

        .otp-inputs input {
            width: 40px;
            height: 40px;
            font-size: 18px;
        }
    }
    /* CAPTCHA Input Styling */
.captcha-input {
    width: 100%;
    padding: 15px 20px;
    background: #f5f5f5;
    border-radius: 10px;
    border: 2px solid transparent;
    outline: none;
    font-size: 16px;
    color: #333;
    font-weight: 500;
    transition: all 0.3s ease;
    margin-top: 5px;
}

.captcha-input:focus {
    border-color: #4e54c8;
    box-shadow: 0 0 10px rgba(78, 84, 200, 0.3);
    background: white;
}

/* Dark mode styles */
body.dark-mode .captcha-input {
    background: #3d4548;
    color: #f5f5f5;
}

body.dark-mode .captcha-input:focus {
    background: #3d4548;
    border-color: #8f94fb;
}

/* CAPTCHA container styling */
.captcha-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 20px 0;
}

.captcha-box {
    display: flex;
    align-items: center;
    background: #f5f5f5;
    border-radius: 10px;
    padding: 5px 15px;
    flex: 1;
}

body.dark-mode .captcha-box {
    background: #3d4548;
}

/* CAPTCHA text styling */
.captcha-text {
    font-family: 'Courier New', monospace;
    font-size: 24px;
    font-weight: bold;
    letter-spacing: 5px;
    background: linear-gradient(to right, #4e54c8, #8f94fb);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    flex: 1;
    text-align: center;
}

body.dark-mode .captcha-text {
    background: linear-gradient(to right, #8f94fb, #4ca1af);
    -webkit-background-clip: text;
    background-clip: text;
}

/* Refresh button styling */
.refresh-captcha {
    cursor: pointer;
    color: #888;
    font-size: 20px;
    transition: all 0.3s ease;
    margin-left: 10px;
}

.refresh-captcha:hover {
    transform: rotate(90deg);
    color: #4e54c8;
}

body.dark-mode .refresh-captcha:hover {
    color: #8f94fb;
}
    </style>
    <script>
document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("loginForm").enctype = "application/x-www-form-urlencoded";
    document.getElementById("registerForm").enctype = "application/x-www-form-urlencoded";
});
</script>
</head>
<body>
    <!-- Dark/Light Mode Toggle Button -->
    <button id="mode-toggle" title="Toggle Dark Mode">🌙</button>

    <div class="container">
        <div class="form-box login">
            <form action="LibloginSignup" method="post" id="loginForm" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="action" value="login">
                <h1>Login</h1>
                <div class="input-box">
                    <input type="text" name="email" placeholder=" " required autocomplete="off">
                    <label class="floating-label">Email</label>
                    <i class='bx bxs-envelope'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" id="loginPassword" placeholder=" " required autocomplete="off">
                    <label class="floating-label">Password</label>
                    <i class='bx bxs-lock' id="toggleLoginPassword"></i>
                </div>
                <div class="captcha-container">
                    <div class="captcha-box">
                        <span class="captcha-text" id="loginCaptchaText"></span>
                        <i class='bx bx-refresh refresh-captcha' id="refreshLoginCaptcha" title="Refresh CAPTCHA"></i>
                    </div>
                    <input type="text" class="captcha-input" name="captchaInput" id="loginCaptchaInput" placeholder="Enter CAPTCHA" required>
                    <input type="hidden" name="captchaText" id="loginCaptchaHidden">
                </div>
                <div class="forget-link">
                    <a href="#" id="forgotPasswordLink">Forgot Password?</a>
                </div>
                <button type="submit" class="btn">Login</button>
                <p>or login with social platforms</p>
                <div class="social-icons">
                    <a href="#" title="Login with Google" id="googleLogin"><i class='bx bxl-google'></i></a>
                    <a href="#" title="Login with Facebook" id="facebookLogin"><i class='bx bxl-facebook'></i></a>
                    <a href="#" title="Login with Twitter" id="twitterLogin"><i class='bx bxl-twitter'></i></a>
                    <a href="#" title="Login with Instagram" id="instagramLogin"><i class='bx bxl-instagram'></i></a>
                </div>
            </form>
        </div>
        
        <div class="form-box register">
            <form action="LibloginSignup" method="post" id="registerForm" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="action" value="register">
                <h1>Signup</h1>
                <div class="input-row">
                    <div class="input-box">
                        <input type="text" name="firstName" placeholder=" " required autocomplete="off">
                        <label class="floating-label">First Name</label>
                        <i class='bx bx-user'></i>
                    </div>
                    <div class="input-box">
                        <input type="text" name="lastName" placeholder=" " required autocomplete="off">
                        <label class="floating-label">Last Name</label>
                        <i class='bx bx-user'></i>
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-box">
                        <input type="email" name="email" placeholder=" " required autocomplete="off">
                        <label class="floating-label">Email</label>
                        <i class='bx bxs-envelope'></i>
                    </div>
                    <div class="input-box">
                        <input type="tel" name="contactNumber" placeholder=" " required autocomplete="off">
                        <label class="floating-label">Phone Number</label>
                        <i class='bx bx-mobile'></i>
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-box">
                        <input type="password" name="password" id="regPassword" placeholder=" " required>
                        <label class="floating-label">Password</label>
                        <i class='bx bxs-lock' id="toggleRegPassword"></i>
                        <div class="password-feedback"></div>
                        <div class="password-strength">
                            <div class="password-strength-bar"></div>
                        </div>
                    </div>
                    <div class="input-box">
                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder=" " required>
                        <label class="floating-label">Confirm Password</label>
                        <i class='bx bxs-lock' id="toggleConfirmPassword"></i>
                        <div class="password-feedback" id="confirmPasswordFeedback"></div>
                    </div>
                </div>
                <div class="captcha-container">
                    <div class="captcha-box">
                        <span class="captcha-text" id="registerCaptchaText"></span>
                        <i class='bx bx-refresh refresh-captcha' id="refreshRegisterCaptcha" title="Refresh CAPTCHA"></i>
                    </div>
                    <input type="text" class="captcha-input" name="captchaInput" id="registerCaptchaInput" placeholder="Enter CAPTCHA" required>
                    <input type="hidden" name="captchaText" id="registerCaptchaHidden">
                </div>
                <div class="terms-container">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">I agree to the <a href="#" target="_blank">Terms & Conditions</a> and <a href="#" target="_blank">Privacy Policy</a></label>
                </div>
                <button type="submit" class="btn">Create Account</button>
                <p>or signup with social platforms</p>
                <div class="social-icons">
                    <a href="#" title="Sign up with Google" id="googleRegister"><i class='bx bxl-google'></i></a>
                    <a href="#" title="Sign up with Facebook" id="facebookRegister"><i class='bx bxl-facebook'></i></a>
                    <a href="#" title="Sign up with Twitter" id="twitterRegister"><i class='bx bxl-twitter'></i></a>
                    <a href="#" title="Sign up with Instagram" id="instagramRegister"><i class='bx bxl-instagram'></i></a>
                </div>
            </form>
        </div>
        
        <div class="toggle-box">
            <div class="toggle-panel toggle-left">
                <h1>Welcome Back!</h1>
                <p>Enter your personal details to use all of site features</p>
                <button class="btn register-btn">Sign Up</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Hello, Friend!</h1>
                <p>Register with your personal details to use all of site features</p>
                <button class="btn login-btn">Login</button>
            </div>
        </div>
    </div>
    
    <!-- Forgot Password Modal -->
    <div id="forgotPasswordModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>Forgot Password</h2>
            <p>Enter your email or phone number to receive a password reset OTP</p>
            <div class="input-box">
                <input type="text" id="forgotPasswordInput" placeholder="Email or Phone Number" required>
                <i class='bx bx-mail-send'></i>
            </div>
            <button id="sendOtpBtn" class="btn">Send OTP</button>
        </div>
    </div>
    
    <!-- OTP Verification Modal -->
    <div id="otpModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>Verify OTP</h2>
            <p>Enter the 6-digit OTP sent to your email/phone</p>
            <div class="otp-inputs">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
                <input type="text" maxlength="1" class="otp-input" pattern="\d*">
            </div>
            <div class="resend-otp">
                <p>Didn't receive OTP? <a id="resendOtpLink">Resend OTP</a></p>
            </div>
            <button id="verifyOtpBtn" class="btn">Verify OTP</button>
        </div>
    </div>
    
    <!-- Reset Password Modal -->
    <div id="resetPasswordModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2>Reset Password</h2>
            <p>Create a new password for your account</p>
            <div class="input-box">
                <input type="password" id="newPassword" placeholder="New Password" required>
                <i class='bx bxs-lock' id="toggleNewPassword"></i>
            </div>
            <div class="input-box">
                <input type="password" id="confirmNewPassword" placeholder="Confirm New Password" required>
                <i class='bx bxs-lock' id="toggleConfirmNewPassword"></i>
                <div class="password-feedback" id="newPasswordFeedback"></div>
            </div>
            <button id="resetPasswordBtn" class="btn">Reset Password</button>
        </div>
    </div>

    <script>
        // Dark/Light Mode Toggle
        document.addEventListener("DOMContentLoaded", () => {
            const modeToggle = document.getElementById("mode-toggle");
            const body = document.body;

            // Check for saved theme preference or prefer dark mode if OS preference
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const savedTheme = localStorage.getItem("theme");
            
            if (savedTheme === "dark" || (!savedTheme && prefersDark)) {
                body.classList.add("dark-mode");
                modeToggle.innerHTML = "☀";
                modeToggle.title = "Switch to Light Mode";
            } else {
                body.classList.remove("dark-mode");
                modeToggle.innerHTML = "🌙";
                modeToggle.title = "Switch to Dark Mode";
            }

            modeToggle.addEventListener("click", () => {
                body.classList.toggle("dark-mode");

                if (body.classList.contains("dark-mode")) {
                    modeToggle.innerHTML = "☀";
                    modeToggle.title = "Switch to Light Mode";
                    localStorage.setItem("theme", "dark");
                } else {
                    modeToggle.innerHTML = "🌙";
                    modeToggle.title = "Switch to Dark Mode";
                    localStorage.setItem("theme", "light");
                }
            });
        });

        // Login/Signup Toggle
        document.addEventListener("DOMContentLoaded", () => {
            const container = document.querySelector(".container");
            const registerBtn = document.querySelector(".register-btn");
            const loginBtn = document.querySelector(".login-btn");

            registerBtn.addEventListener("click", () => {
                container.classList.add("active");
            });

            loginBtn.addEventListener("click", () => {
                container.classList.remove("active");
            });
        });

        // Generate Random CAPTCHA
        function generateCaptcha() {
            const chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            let captcha = "";
            for (let i = 0; i < 6; i++) {
                captcha += chars.charAt(Math.floor(Math.random() * chars.length));
            }
            return captcha;
        }

        // Initialize CAPTCHA for both forms
        document.addEventListener("DOMContentLoaded", () => {
            const loginCaptchaText = document.getElementById("loginCaptchaText");
            const registerCaptchaText = document.getElementById("registerCaptchaText");
            const refreshLoginCaptcha = document.getElementById("refreshLoginCaptcha");
            const refreshRegisterCaptcha = document.getElementById("refreshRegisterCaptcha");
            const loginCaptchaHidden = document.getElementById("loginCaptchaHidden");
            const registerCaptchaHidden = document.getElementById("registerCaptchaHidden");
            
            let loginCaptcha = generateCaptcha();
            let registerCaptcha = generateCaptcha();
            
            loginCaptchaText.textContent = loginCaptcha;
            registerCaptchaText.textContent = registerCaptcha;
            loginCaptchaHidden.value = loginCaptcha;
            registerCaptchaHidden.value = registerCaptcha;
            
            refreshLoginCaptcha.addEventListener("click", () => {
                loginCaptcha = generateCaptcha();
                loginCaptchaText.textContent = loginCaptcha;
                loginCaptchaHidden.value = loginCaptcha;
            });
            
            refreshRegisterCaptcha.addEventListener("click", () => {
                registerCaptcha = generateCaptcha();
                registerCaptchaText.textContent = registerCaptcha;
                registerCaptchaHidden.value = registerCaptcha;
            });
        });

        // Password Validation with Strength Meter
        document.addEventListener("DOMContentLoaded", () => {
            const passwordInput = document.getElementById('regPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const strengthBar = document.querySelector('.password-strength-bar');
            const feedback = document.querySelector('.password-feedback');
            const confirmFeedback = document.getElementById('confirmPasswordFeedback');
            
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                const strength = calculatePasswordStrength(password);
                
                updateStrengthMeter(strength);
                updateFeedback(password, strength);
                validatePasswordMatch();
            });
            
            confirmPasswordInput.addEventListener('input', validatePasswordMatch);
            
            function calculatePasswordStrength(password) {
                let strength = 0;
                
                // Length check
                if (password.length >= 8) strength += 1;
                if (password.length >= 12) strength += 1;
                
                // Character type checks
                if (/[A-Z]/.test(password)) strength += 1;
                if (/[a-z]/.test(password)) strength += 1;
                if (/[0-9]/.test(password)) strength += 1;
                if (/[^A-Za-z0-9]/.test(password)) strength += 2;
                
                return Math.min(strength, 5); // Max strength of 5
            }
            
            function updateStrengthMeter(strength) {
                const percent = strength * 20;
                strengthBar.style.width = percent + '%';
                
                // Update color based on strength
                if (strength <= 1) {
                    strengthBar.style.backgroundColor = '#ff4757'; // Weak
                } else if (strength <= 3) {
                    strengthBar.style.backgroundColor = '#ffa502'; // Medium
                } else {
                    strengthBar.style.backgroundColor = '#2ed573'; // Strong
                }
            }
            
            function updateFeedback(password, strength) {
                if (password.length === 0) {
                    feedback.textContent = '';
                    return;
                }
                
                const messages = [];
                
                if (password.length < 8) {
                    messages.push('at least 8 characters');
                }
                
                if (!/[A-Z]/.test(password)) {
                    messages.push('one uppercase letter');
                }
                
                if (!/[a-z]/.test(password)) {
                    messages.push('one lowercase letter');
                }
                
                if (!/[0-9]/.test(password)) {
                    messages.push('one number');
                }
                
                if (!/[^A-Za-z0-9]/.test(password)) {
                    messages.push('one special character');
                }
                
                if (messages.length > 0) {
                    feedback.textContent = 'Password should contain: ' + messages.join(', ');
                    feedback.style.color = '#ff4757';
                } else {
                    const strengthText = 
                        strength >= 4 ? 'Strong password!' : 
                        strength >= 2 ? 'Good password' : 'Weak password';
                    
                    feedback.textContent = strengthText;
                    feedback.style.color = strength >= 4 ? '#2ed573' : 
                                          strength >= 2 ? '#ffa502' : '#ff4757';
                }
            }
            
            function validatePasswordMatch() {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                if (confirmPassword.length === 0) {
                    confirmFeedback.textContent = '';
                    return;
                }
                
                if (password !== confirmPassword) {
                    confirmFeedback.textContent = 'Passwords do not match';
                    confirmFeedback.style.color = '#ff4757';
                } else {
                    confirmFeedback.textContent = 'Passwords match';
                    confirmFeedback.style.color = '#2ed573';
                }
            }
        });

        // Toggle Password Visibility
        document.addEventListener("DOMContentLoaded", function() {
            // Login Password
            const toggleLoginPassword = document.getElementById('toggleLoginPassword');
            const loginPassword = document.getElementById('loginPassword');
            
            toggleLoginPassword.addEventListener('click', function() {
                const type = loginPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                loginPassword.setAttribute('type', type);
                this.classList.toggle('bxs-show');
                this.classList.toggle('bxs-lock');
            });
            
            // Register Password
            const toggleRegPassword = document.getElementById('toggleRegPassword');
            const regPassword = document.getElementById('regPassword');
            
            toggleRegPassword.addEventListener('click', function() {
                const type = regPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                regPassword.setAttribute('type', type);
                this.classList.toggle('bxs-show');
                this.classList.toggle('bxs-lock');
            });
            
            // Confirm Password
            const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            
            toggleConfirmPassword.addEventListener('click', function() {
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                this.classList.toggle('bxs-show');
                this.classList.toggle('bxs-lock');
            });
            
            // New Password (in reset modal)
            const toggleNewPassword = document.getElementById('toggleNewPassword');
            const newPassword = document.getElementById('newPassword');
            
            if (toggleNewPassword && newPassword) {
                toggleNewPassword.addEventListener('click', function() {
                    const type = newPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                    newPassword.setAttribute('type', type);
                    this.classList.toggle('bxs-show');
                    this.classList.toggle('bxs-lock');
                });
            }
            
            // Confirm New Password (in reset modal)
            const toggleConfirmNewPassword = document.getElementById('toggleConfirmNewPassword');
            const confirmNewPassword = document.getElementById('confirmNewPassword');
            
            if (toggleConfirmNewPassword && confirmNewPassword) {
                toggleConfirmNewPassword.addEventListener('click', function() {
                    const type = confirmNewPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                    confirmNewPassword.setAttribute('type', type);
                    this.classList.toggle('bxs-show');
                    this.classList.toggle('bxs-lock');
                });
            }
        });

        // Forgot Password Flow
        document.addEventListener("DOMContentLoaded", function() {
            const forgotPasswordLink = document.getElementById('forgotPasswordLink');
            const forgotPasswordModal = document.getElementById('forgotPasswordModal');
            const otpModal = document.getElementById('otpModal');
            const resetPasswordModal = document.getElementById('resetPasswordModal');
            const closeModalButtons = document.querySelectorAll('.close-modal');
            const sendOtpBtn = document.getElementById('sendOtpBtn');
            const verifyOtpBtn = document.getElementById('verifyOtpBtn');
            const resetPasswordBtn = document.getElementById('resetPasswordBtn');
            const resendOtpLink = document.getElementById('resendOtpLink');
            const otpInputs = document.querySelectorAll('.otp-input');
            
            // Store the generated OTP (in a real app, this would be server-side)
            let generatedOtp = '';
            let otpEmail = '';
            
            // Open Forgot Password Modal
            forgotPasswordLink.addEventListener('click', function(e) {
                e.preventDefault();
                forgotPasswordModal.style.display = 'block';
            });
            
            // Close any modal when clicking X
            closeModalButtons.forEach(button => {
                button.addEventListener('click', function() {
                    this.closest('.modal').style.display = 'none';
                });
            });
            
            // Close modal when clicking outside
            window.addEventListener('click', function(e) {
                if (e.target.classList.contains('modal')) {
                    e.target.style.display = 'none';
                }
            });
            
            // Send OTP
            sendOtpBtn.addEventListener('click', function() {
                const emailOrPhone = document.getElementById('forgotPasswordInput').value.trim();
                
                if (!emailOrPhone) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Please enter your email or phone number'
                    });
                    return;
                }
                
                // Generate a 6-digit OTP
                generatedOtp = Math.floor(100000 + Math.random() * 900000).toString();
                otpEmail = emailOrPhone;
                
                // In a real app, you would send this OTP to the user's email/phone
                console.log(`OTP for ${emailOrPhone}: ${generatedOtp}`);
                
                Swal.fire({
                    icon: 'success',
                    title: 'OTP Sent',
                    text: `A 6-digit OTP has been sent to ${emailOrPhone} (demo: ${generatedOtp})`
                });
                
                forgotPasswordModal.style.display = 'none';
                otpModal.style.display = 'block';
                
                // Focus first OTP input
                otpInputs[0].focus();
            });
            
            // Auto-tab between OTP inputs
            otpInputs.forEach((input, index) => {
                input.addEventListener('input', function() {
                    if (this.value.length === 1 && index < otpInputs.length - 1) {
                        otpInputs[index + 1].focus();
                    }
                });
                
                // Handle backspace
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && this.value.length === 0 && index > 0) {
                        otpInputs[index - 1].focus();
                    }
                });
            });
            
            // Verify OTP
            verifyOtpBtn.addEventListener('click', function() {
                let enteredOtp = '';
                otpInputs.forEach(input => {
                    enteredOtp += input.value;
                });
                
                if (enteredOtp.length !== 6) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Please enter the complete 6-digit OTP'
                    });
                    return;
                }
                
                if (enteredOtp === generatedOtp) {
                    Swal.fire({
                        icon: 'success',
                        title: 'OTP Verified',
                        text: 'You can now reset your password'
                    });
                    
                    otpModal.style.display = 'none';
                    resetPasswordModal.style.display = 'block';
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid OTP',
                        text: 'The OTP you entered is incorrect'
                    });
                }
            });
            
            // Resend OTP
            resendOtpLink.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Generate a new OTP
                generatedOtp = Math.floor(100000 + Math.random() * 900000).toString();
                
                // In a real app, you would resend this OTP to the user's email/phone
                console.log(`New OTP for ${otpEmail}: ${generatedOtp}`);
                
                Swal.fire({
                    icon: 'success',
                    title: 'OTP Resent',
                    text: `A new 6-digit OTP has been sent to ${otpEmail} (demo: ${generatedOtp})`
                });
                
                // Clear all OTP inputs
                otpInputs.forEach(input => {
                    input.value = '';
                });
                
                // Focus first OTP input
                otpInputs[0].focus();
            });
            
            // Reset Password
            resetPasswordBtn.addEventListener('click', function() {
                const newPassword = document.getElementById('newPassword').value;
                const confirmNewPassword = document.getElementById('confirmNewPassword').value;
                const feedback = document.getElementById('newPasswordFeedback');
                
                if (!newPassword || !confirmNewPassword) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Please enter and confirm your new password'
                    });
                    return;
                }
                
                if (newPassword !== confirmNewPassword) {
                    feedback.textContent = 'Passwords do not match';
                    feedback.style.color = '#ff4757';
                    return;
                }
                
                // In a real app, you would send the new password to the server
                console.log(`Password reset for ${otpEmail} to: ${newPassword}`);
                
                Swal.fire({
                    icon: 'success',
                    title: 'Password Reset',
                    text: 'Your password has been successfully reset'
                });
                
                resetPasswordModal.style.display = 'none';
                
                // Clear all fields
                document.getElementById('forgotPasswordInput').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmNewPassword').value = '';
                feedback.textContent = '';
                
                otpInputs.forEach(input => {
                    input.value = '';
                });
            });
            
            // Validate new password in reset form
            const newPasswordInput = document.getElementById('newPassword');
            const confirmNewPasswordInput = document.getElementById('confirmNewPassword');
            const newPasswordFeedback = document.getElementById('newPasswordFeedback');
            
            newPasswordInput.addEventListener('input', function() {
                validateNewPassword();
            });
            
            confirmNewPasswordInput.addEventListener('input', function() {
                validateNewPassword();
            });
            
            function validateNewPassword() {
                const password = newPasswordInput.value;
                const confirmPassword = confirmNewPasswordInput.value;
                
                if (password && confirmPassword) {
                    if (password !== confirmPassword) {
                        newPasswordFeedback.textContent = 'Passwords do not match';
                        newPasswordFeedback.style.color = '#ff4757';
                    } else {
                        newPasswordFeedback.textContent = 'Passwords match';
                        newPasswordFeedback.style.color = '#2ed573';
                    }
                } else {
                    newPasswordFeedback.textContent = '';
                }
            }
        });

        // Social Login/Register Functionality
        document.addEventListener("DOMContentLoaded", function() {
            // Google Login/Register
            document.getElementById('googleLogin').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('google', 'login');
            });
            
            document.getElementById('googleRegister').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('google', 'register');
            });
            
            // Facebook Login/Register
            document.getElementById('facebookLogin').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('facebook', 'login');
            });
            
            document.getElementById('facebookRegister').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('facebook', 'register');
            });
            
            // Twitter Login/Register
            document.getElementById('twitterLogin').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('twitter', 'login');
            });
            
            document.getElementById('twitterRegister').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('twitter', 'register');
            });
            
            // Instagram Login/Register
            document.getElementById('instagramLogin').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('instagram', 'login');
            });
            
            document.getElementById('instagramRegister').addEventListener('click', function(e) {
                e.preventDefault();
                socialAuth('instagram', 'register');
            });
            
            // Simulate social authentication
            function socialAuth(provider, action) {
                // In a real app, this would use the provider's SDK (Google, Facebook, etc.)
                // For demo purposes, we'll simulate the response
                
                // Generate random user data based on provider
                const userData = generateSocialUserData(provider);
                
                Swal.fire({
                    title: `${provider.charAt(0).toUpperCase() + provider.slice(1)} Authentication`,
                    html: `You're about to ${action} using your ${provider} account.<br><br>
                           <strong>Name:</strong> ${userData.name}<br>
                           <strong>Email:</strong> ${userData.email}`,
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonText: `Continue with ${provider}`,
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Simulate successful authentication
                        setTimeout(() => {
                            Swal.fire({
                                icon: 'success',
                                title: `${provider.charAt(0).toUpperCase() + provider.slice(1)} ${action} Successful`,
                                text: `Welcome, ${userData.name}! You've been ${action == 'login' ? 'logged in' : 'registered'} using ${provider}.`
                            });
                            
                            // In a real app, you would:
                            // 1. Send the social auth token to your backend
                            // 2. Create/authenticate the user
                            // 3. Redirect or update the UI accordingly
                            
                            console.log(`${provider} ${action} data:`, userData);
                            
                            // For demo, we'll populate the form with the social data
                            if (action == 'register') {
                                const names = userData.name.split(' ');
                                document.querySelector('input[name="firstName"]').value = names[0] || '';
                                document.querySelector('input[name="lastName"]').value = names.slice(1).join(' ') || '';
                                document.querySelector('input[name="email"]').value = userData.email || '';
                                document.querySelector('input[name="contactNumber"]').value = userData.phone || '';
                            } else {
                                document.querySelector('#loginForm input[name="email"]').value = userData.email || '';
                            }
                        }, 1000);
                    }
                });
            }
            
            // Generate mock social user data
            function generateSocialUserData(provider) {
                const firstNames = ['John', 'Jane', 'Alex', 'Emily', 'Michael', 'Sarah', 'David', 'Jessica'];
                const lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis'];
                const domains = {
                    google: 'gmail.com',
                    facebook: 'facebook.com',
                    twitter: 'twitter.com',
                    instagram: 'instagram.com'
                };
                
                const firstName = firstNames[Math.floor(Math.random() * firstNames.length)];
                const lastName = lastNames[Math.floor(Math.random() * lastNames.length)];
                const email = `${firstName.toLowerCase()}.${lastName.toLowerCase()}@${domains[provider]}`;
                const phone = `+1${Math.floor(2000000000 + Math.random() * 8000000000)}`;
                
                return {
                    name: `${firstName} ${lastName}`,
                    email: email,
                    phone: phone,
                    provider: provider,
                    id: `social_${provider}_${Math.floor(100000 + Math.random() * 900000)}`
                };
            }
        });

        // Form submission handling with SweetAlert and CAPTCHA validation
        document.addEventListener("DOMContentLoaded", function() {
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            
            if (loginForm) {
                loginForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    // Check CAPTCHA
                    const captchaText = document.getElementById('loginCaptchaText').textContent;
                    const captchaInput = document.getElementById('loginCaptchaInput').value;
                    
                    if (!captchaInput || captchaInput !== captchaText) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Please enter the correct CAPTCHA'
                        });
                        return;
                    }
                    
                    // Submit the form
                    const formData = new FormData(this);
                    
                    fetch('LibloginSignup', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: data.message,
                                timer: data.delay || 2000,
                                showConfirmButton: false
                            }).then(() => {
                                if (data.redirect) {
                                    window.location.href = data.redirect;
                                }
                            });
                            
                            // Auto-redirect after delay
                            if (data.redirect && data.delay) {
                                setTimeout(() => {
                                    window.location.href = data.redirect;
                                }, data.delay);
                            }
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: data.message
                            });
                        }
                    })
                    .catch(error => {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An unexpected error occurred'
                        });
                    });
                });
            }
            
            if (registerForm) {
                registerForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    // Check terms checkbox
                    if (!document.getElementById('terms').checked) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'You must agree to the Terms & Conditions and Privacy Policy'
                        });
                        return;
                    }
                    
                    // Check CAPTCHA
                    const captchaText = document.getElementById('registerCaptchaText').textContent;
                    const captchaInput = document.getElementById('registerCaptchaInput').value;
                    
                    if (!captchaInput || captchaInput !== captchaText) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Please enter the correct CAPTCHA'
                        });
                        return;
                    }
                    
                    // Check password match
                    const password = document.getElementById('regPassword').value;
                    const confirmPassword = document.getElementById('confirmPassword').value;
                    
                    if (password !== confirmPassword) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Passwords do not match'
                        });
                        return;
                    }
                    
                    // Submit the form
                    const formData = new FormData(this);
                    
                    fetch('LibloginSignup', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 'success') {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: data.message,
                                timer: data.delay || 2000,
                                showConfirmButton: false
                            }).then(() => {
                                if (data.redirect) {
                                    window.location.href = data.redirect;
                                }
                            });
                            
                            // Auto-redirect after delay
                            if (data.redirect && data.delay) {
                                setTimeout(() => {
                                    window.location.href = data.redirect;
                                }, data.delay);
                            }
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: data.message
                            });
                        }
                    })
                    .catch(error => {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An unexpected error occurred'
                        });
                    });
                });
            }
        });
    </script>
</body>
</html>