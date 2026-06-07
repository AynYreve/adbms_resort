<%-- 
    Document   : usersregistration
    Created on : Jun 5, 2026, 3:22:11 AM
    Author     : Julian Edriel
--%>
<% 
    String userError = (String) session.getAttribute("user_error");
    String passError =(String) session.getAttribute("pass_error");

%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <title>Register</title>
        <link rel="icon" type="image/x-icon" href="Assets/favicon.png">
        
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,700;1,700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
        <style>
            :root {
            --sidebar-width: 240px;
            --sidebar-bg: #ffffff;
            --sidebar-border-color: #a855f7;
            --sidebar-pattern-color: #e5e7eb;
            --brand-primary-color: #104373;
            --nav-item-active-bg: #1d528f;
            --nav-item-active-text: #ffffff;
            
            --bg-gradient-start: #bbf7d0;
            --bg-gradient-mid: #bfdbfe;
            --bg-gradient-end: #93c5fd;
            --heading-text-color: #0f2c59;
            --error-color: #e11d48;
            }

            * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            }

            body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f0f0;
            height: 100vh;
            overflow: hidden;
            }

            .container {
            display: flex;
            width: 100%;
            height: 100vh;
            position: relative;
            }

            .sidebar {
            width: var(--sidebar-width);
            background-color: var(--sidebar-bg);
            border-right: 2px solid var(--sidebar-border-color);
            display: flex;
            flex-direction: column;
            padding: 20px 0;
            position: relative;
            z-index: 100;
            flex-shrink: 0;
            transition: all 0.2s ease-in-out;
            background-image: url('Assets/BG.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            }

            .sidebar.collapsed {
            width: 60px;
            }

            .sidebar.collapsed .logo-box,
            .sidebar.collapsed .sidebar-footer,
            .sidebar.collapsed .nav-text {
            display: none;
            }

            .sidebar.collapsed .logo-container {
            margin-bottom: 60px;
            }

            .sidebar.collapsed .sidebar-toggle-embed {
            left: 18px;
            }

            .sidebar.collapsed .nav-item {
            padding: 12px 0;
            justify-content: center;
            width: 100%;
            border-radius: 0;
            text-indent: -9999px;
            }

            .sidebar.collapsed .nav-item i {
            text-indent: 0;
            margin-right: 0;
            }

            .sidebar.collapsed .nav-menu {
            padding: 0;
            }

            .sidebar-toggle-embed {
            position: absolute;
            top: 15px;
            left: 20px;
            background: transparent;
            border: none;
            font-size: 24px;
            color: var(--brand-primary-color);
            cursor: pointer;
            z-index: 110;
            transition: left 0.2s ease;
            }

            .logo-container {
            padding: 0 20px;
            margin-top: 35px;
            margin-bottom: 40px;
            }

            .logo-box {
            border: 3px solid var(--brand-primary-color);
            padding: 10px;
            background: #fff;
            text-align: center;
            }

            .logo-text-img {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--brand-primary-color);
            letter-spacing: 1px;
            display: block;
            }

            .logo-subtext {
            font-size: 10px;
            font-weight: 600;
            color: var(--brand-primary-color);
            letter-spacing: 0.5px;
            display: block;
            }

            .nav-menu {
            display: flex;
            flex-direction: column;
            gap: 6px;
            padding: 0 15px;
            }

            .nav-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: 600;
            color: var(--brand-primary-color);
            font-size: 16px;
            border-bottom: 1.5px solid var(--brand-primary-color);
            transition: background-color 0.2s ease, transform 0.2s ease, border-radius 0.2s ease;
            }

            .nav-item:hover {
            background-color: rgba(29, 82, 143, 0.1);
            transform: translateX(4px);
            border-radius: 8px;
            }

            .nav-item:active {
            transform: scale(0.98);
            }

            .nav-item i {
            width: 20px;
            text-align: center;
            }

            .sidebar-footer {
            margin-top: auto;
            text-align: center;
            font-size: 12px;
            color: #555;
            }

            .main-content {
            flex: 1;
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-mid) 50%, var(--bg-gradient-end) 100%);
            display: flex;
            flex-direction: column;
            padding: 40px;
            align-items: center;
            justify-content: center;
            overflow-y: auto;
            }

            .booking-title-main {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 72px;
            font-weight: 700;
            font-style: italic;
            color: var(--heading-text-color);
            text-transform: uppercase;
            letter-spacing: 2px;
            text-align: center;
            margin-bottom: 5px;
            }

            .auth-central-card {
            width: 100%;
            max-width: 580px;
            text-align: center;
            padding-top: 10px;
            }

            .auth-card-title {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 48px;
            font-weight: 700;
            font-style: italic;
            color: var(--heading-text-color);
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 30px;
            }

            .form-input-group {
            width: 100%;
            margin-bottom: 20px;
            text-align: left;
            position: relative;
            }

            .form-input-control {
            width: 100%;
            border: 2px solid var(--brand-primary-color);
            border-radius: 12px;
            padding: 16px 20px;
            font-size: 18px;
            font-weight: 600;
            color: var(--brand-primary-color);
            background-color: transparent;
            outline: none;
            transition: background-color 0.2s ease, border-color 0.2s ease;
            }

            .form-input-control::placeholder {
            color: rgba(16, 67, 115, 0.6);
            }

            .form-input-control:focus {
            background-color: rgba(255, 255, 255, 0.4);
            }

            .form-input-control.input-error {
            border-color: var(--error-color) !important;
            background-color: rgba(225, 29, 72, 0.05);
            }

            .inline-error-text {
            color: var(--error-color);
            font-size: 14px;
            font-weight: 600;
            margin-top: 6px;
            margin-left: 10px;
            display: block;
            }

            .submit-action-btn {
            width: 100%;
            max-width: 280px;
            background: linear-gradient(to right, #1d528f, #104373);
            color: #ffffff;
            border: none;
            border-radius: 16px;
            padding: 14px 0;
            font-size: 24px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.2s ease, background 0.2s ease;
            margin: 25px auto 20px auto;
            display: block;
            }

            .submit-action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(29, 82, 143, 0.3);
            background: linear-gradient(to right, #2563eb, #1d528f);
            }

            .submit-action-btn:active {
            transform: translateY(1px) scale(0.98);
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            }

            .toggle-view-footer {
            font-size: 15px;
            font-weight: 600;
            color: #000000;
            text-align: center;
            }

            .toggle-view-footer a {
            color: #000000;
            text-decoration: underline;
            font-weight: 700;
            margin-left: 4px;
            transition: color 0.2s ease;
            }

            .toggle-view-footer a:hover {
            color: var(--brand-primary-color);
            }
        </style>
    </head>
    <body>
        <div class="container">
        <aside class="sidebar" id="sidebar">
            <button class="sidebar-toggle-embed" id="menuToggleBtn" title="Toggle Menu">
                <i class="fa-solid fa-bars"></i>
            </button>

            <div class="logo-container">
                <div class="logo-box">
                    <div class="logo-text-img">OLIVIA'S</div>
                    <div class="logo-subtext">EVENTS PLACE</div>
                </div>
            </div>
            
            <nav class="nav-menu">
                <a href="home.jsp" class="nav-item">
                    <i class="fa-solid fa-house"></i> 
                    <span class="nav-text">Home</span>
                </a>
                <a href="explore.jsp" class="nav-item">
                    <i class="fa-solid fa-map-location-dot"></i> 
                    <span class="nav-text">Explore</span>
                </a>
                <a href="rates.jsp" class="nav-item">
                    <i class="fa-solid fa-tags"></i> 
                    <span class="nav-text">Rates</span>
                </a>
                <a href="contact.jsp" class="nav-item">
                    <i class="fa-solid fa-phone"></i> 
                    <span class="nav-text">Contact</span>
                </a>
                <a href="book.php" class="nav-item">
                    <i class="fa-solid fa-calendar-days"></i> 
                    <span class="nav-text">Book</span>
                </a>
            </nav>
        </aside>

        <main class="main-content">
            <h1 class="booking-title-main">Book Now!</h1>
            
            <div class="auth-central-card">
                <h2 class="auth-card-title">Register</h2>
                
                <form id="registrationForm" action="<%= request.getContextPath() %>/register" method="POST">
                    <div class="form-input-group">
                        <input type="text" 
                               name="username" 
                               class="form-input-control <%= userError != null ? "input-error" : "" %>" 
                               placeholder="Username:"  
                               id="regUser" 
                               required
                               value="<%= request.getParameter("username") != null ? request.getParameter("username"): "" %>"
                        >
                        <span   class="inline-error-text"
                                id="userExistsLabel"
                                style="display: <%= userError != null ? "block" : "none" %>;"> <%= userError != null ? userError : "" %>
                        </span>
                    </div>

                    <div class="form-input-group">
                        <input type="text" 
                               name="fullname" 
                               class="form-input-control" 
                               placeholder="Full Name:" 
                               id="regName" 
                               required
                               value="<%= request.getParameter("fullname") != null ? request.getParameter("fullname"): "" %>"
                        >
                    </div>
                    
                    <div class="form-input-group">
                        <input type="text" 
                               name="email" 
                               class="form-input-control" 
                               placeholder="Email:" 
                               pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"
                               title="Please enter a valid email address (e.g., name@example.com)"
                               required 
                        >
                    </div>

                    <div class="form-input-group">
                        <input type="password" 
                               name="password" 
                               class="form-input-control <%= passError != null ? "input-error" : "" %>" 
                               placeholder="Password:" 
                               id="regPass"
                               required
                        >
                    </div>

                    <div class="form-input-group">
                        <input type="password" 
                               name="repeat_password" 
                               class="form-input-control" 
                               placeholder="Repeat Password:" 
                               id="regRepeatPass"
                               required 
                        >
                        <span   class="inline-error-text"
                                id="passMismatchLabel"
                                style="display: <%= passError != null ? "block" : "none" %>;"> <%= passError != null ? passError : "Password does not match" %>
                        </span>
                    </div>

                    <button type="submit" class="submit-action-btn">Register</button>
                </form>

                <div class="toggle-view-footer">
                    Already have an account? <a href="userslogin.jsp">Login</a>
                </div>
            </div>
        </main>
    </div>
                    
    <script>
        
        document.getElementById("registrationForm").addEventListener("submit", function(e) {
        const password = document.getElementById("regPass").value;
        const repeatPassword = document.getElementById("regRepeatPass").value;
        const errorLabel = document.getElementById("passMismatchLabel");

        if (password !== repeatPassword) {
            e.preventDefault();
            errorLabel.style.display = "block";
            errorLabel.innerText = "Password does not match";
            return false;
        }
        });

        const sidebar = document.getElementById('sidebar');
        const menuToggleBtn = document.getElementById('menuToggleBtn');
        
        if (menuToggleBtn && sidebar) {
        menuToggleBtn.addEventListener('click', () => {sidebar.classList.toggle('collapsed');
        });
}

        document.getElementById('regUser').addEventListener('input', function() {this.classList.remove('input-error');
        document.getElementById('userExistsLabel').style.display = 'none';
        });

</script>                       
    </body>
</html>
