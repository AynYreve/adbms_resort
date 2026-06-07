<%-- 
    Document   : book
    Created on : Jun 5, 2026, 6:13:56 AM
    Author     : Julian Edriel
--%>

<%
    boolean isLoggedIn = session.getAttribute("user_id") != null;

    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");

    String loginError =
        (String) session.getAttribute("login_error");

    session.removeAttribute("login_error");
%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olivia's Events Place - Book</title>
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
            --underline-teal: #2dd4bf;

            --card-max-width: 300px;
            --card-border-color: #000000;
            --card-text-color: #1e3a8a;
            --shadow-color: #22b09a;
            --shadow-hover: #1d9c88;
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

        /* Loading Animation Overlay */
        .loader-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(15, 44, 89, 0.95);
            z-index: 99999;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease-in-out;
        }

        .loader-overlay.show { 
            opacity: 1; 
            pointer-events: auto; 
        }

        .spinner { 
            width: 60px; 
            height: 60px; 
            border: 6px solid rgba(255, 255, 255, 0.2); 
            border-top-color: var(--underline-teal); 
            border-radius: 50%; 
            animation: spin 0.8s linear infinite; 
            margin-bottom: 15px; 
        }

        .loader-text { 
            color: #ffffff; 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 24px; 
            letter-spacing: 2px; 
            font-weight: 700; 
            text-transform: uppercase; 
        }

        @keyframes spin { 
            to { transform: rotate(360deg); } 
        }

        /* Sidebar Navigation Panel */
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
            border-right: 2px solid var(--sidebar-border-color); 
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
            cursor: pointer; 
            transition: background-color 0.2s ease, transform 0.2s ease, border-radius 0.2s ease;
        }

        .nav-item:hover { 
            background-color: rgba(29, 82, 143, 0.1); 
            transform: translateX(4px); 
            border-radius: 8px; 
        }

        .nav-item.active { 
            background-color: var(--nav-item-active-bg); 
            color: var(--nav-item-active-text); 
            border-radius: 50px; 
            border-bottom: none; 
        }

        .nav-item i { 
            width: 20px; 
            text-align: center; 
            font-size: 18px; 
        }

        .sidebar-footer { 
            margin-top: auto; 
            text-align: center; 
            font-size: 12px; 
            color: #555; 
        }

        /* Main Content Screen Areas */
        .main-content {
            flex: 1; 
            background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-mid) 50%, var(--bg-gradient-end) 100%);
            display: flex; 
            flex-direction: column; 
            padding: 40px; 
            overflow-y: auto; 
            position: relative;
        }

        .top-action-bar { 
            position: fixed; 
            top: 40px; 
            right: 40px; 
            display: flex; 
            gap: 12px; 
            z-index: 500; 
        }

        .action-icon-btn { 
            background-color: var(--brand-primary-color); 
            color: white; 
            width: 45px; 
            height: 45px; 
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 18px; 
            text-decoration: none; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.15); 
            transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), background-color 0.2s ease; 
        }

        .action-icon-btn:hover { 
            transform: translateY(-3px) scale(1.05); 
            background-color: var(--nav-item-active-bg); 
        }

        .action-icon-btn.logout-accent { 
            background-color: #e11d48; 
        } 

        .action-icon-btn.logout-accent:hover { 
            background-color: #be123c; 
        }

        .booking-sub-wrapper { 
            width: 100%; 
            min-height: calc(100vh - 80px); 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            padding-top: 40px; 
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

        .booking-subtitle-bar { 
            font-size: 14px; 
            font-weight: 700; 
            color: var(--heading-text-color); 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            margin-bottom: 45px; 
            text-align: center; 
        }

        /* Authentication Centered View */
        .auth-central-card { 
            width: 100%; 
            max-width: 580px; 
            text-align: center; 
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

        /* Input error state - turns bubble lines red */
        .form-input-control.input-error-state {
            border-color: #ef4444 !important;
            background-color: rgba(239, 68, 68, 0.05);
        }

        /* Error message style printed below password field */
        .error-message-text {
            color: #ef4444;
            font-size: 14px;
            font-weight: 600;
            margin-top: 8px;
            display: block;
            text-align: left;
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
            transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.2s ease; 
            margin: 0 auto 20px auto; 
            display: block; 
        }

        .submit-action-btn:hover { 
            transform: translateY(-2px); 
            background: linear-gradient(to right, #2563eb, #1d528f); 
        }

        .toggle-view-footer { 
            font-size: 15px; 
            font-weight: 600; 
            color: #000000; 
        }

        .toggle-view-footer a { 
            color: #000000; 
            text-decoration: underline; 
            font-weight: 700; 
            margin-left: 4px; 
        }

        /* Scheduler Selection Dashboard */
        .dashboard-scheduler-grid { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 20px; 
            width: 100%; 
            max-width: 1200px; 
            margin: 0 auto; 
        }

        .schedule-card-node { 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
        }

        .schedule-meta-lbl { 
            font-size: 14px; 
            font-weight: 700; 
            color: var(--brand-primary-color); 
            text-align: center; 
            margin-top: 10px; 
            margin-bottom: 12px; 
            text-transform: uppercase; 
        }
        
        .room-image-frame { 
            width: 100%; 
            aspect-ratio: 3 / 4; 
            border: 4px solid var(--card-border-color); 
            border-radius: 12px; 
            box-shadow: 8px 8px 0px var(--shadow-color); 
            margin-bottom: 18px; 
            background-color: #ffffff; 
            background-size: cover; 
            background-position: center; 
            background-repeat: no-repeat; 
        }
        
        .room-image-frame[data-asset="room-std"] { background-image: url('Assets/Standard.jpg'); }
        .room-image-frame[data-asset="room-sup"] { background-image: url('Assets/Superior.jpg'); }
        .room-image-frame[data-asset="room-vil"] { background-image: url('Assets/Villa.jpg'); }
        .room-image-frame[data-asset="room-pre"] { background-image: url('Assets/Premier.jpg'); }

        .select-booking-action { 
            width: 85%; 
            background-color: #1d528f; 
            color: #ffffff; 
            border: none; 
            border-radius: 20px; 
            padding: 10px 0; 
            font-size: 16px; 
            font-weight: 600; 
            cursor: pointer; 
            text-align: center; 
            box-shadow: 0 3px 6px rgba(0,0,0,0.1); 
            transition: background-color 0.2s ease, transform 0.2s ease; 
        }

        .select-booking-action:hover { 
            background-color: #104373; 
            transform: translateY(-2px); 
        }

        @media (max-width: 900px) {
            .dashboard-scheduler-grid { 
                grid-template-columns: 1fr; 
                display: flex; 
                flex-direction: column; 
                gap: 45px; 
            }
        }
    </style>
</head>
<body>

    <div class="loader-overlay" id="loaderOverlay">
        <div class="spinner"></div>
        <div class="loader-text">Please wait..</div>
    </div>

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
                <a href="book.jsp" class="nav-item active">
                    <i class="fa-solid fa-calendar-days"></i> 
                    <span class="nav-text">Book</span>
                </a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="top-action-bar">
                <a href="home.jsp" class="action-icon-btn" title="Back Home">
                    <i class="fa-solid fa-house"></i>
                </a>
                <% if (isLoggedIn) { %>
                    <a href="LogoutServlet" class="action-icon-btn logout-accent" title="Log Out">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    </a>
                <% } %>
            </div>

            <div class="booking-sub-wrapper">
                <h1 class="booking-title-main">Book Now!</h1>
                
                <% if (!isLoggedIn) { %>
                    <div class="auth-central-card">
                        <h2 class="auth-card-title">Login</h2>
                        
                        <form action="LoginServlet" method="POST">
                            <div class="form-input-group">
                                <input type="text" name="username" class="form-input-control <%= loginError != null ? "input-error-state" : "" %>" placeholder="Username" required>
                            </div>
                            <div class="form-input-group">
                                <input type="password" name="password" class="form-input-control <%= loginError != null ? "input-error-state" : "" %>" placeholder="Password" required>
                                
                                <% if (loginError != null) { %>
                                    <span class="error-message-text">
                                        <i class="fa-solid fa-circle-exclamation"></i> Incorrect user or password
                                    </span>
                                <% } %>
                            </div>
                            <button type="submit" class="submit-action-btn">Login</button>
                        </form>
                        
                        <div class="toggle-view-footer">
                            Don't have an account? <a href="usersregistration.jsp">Register</a>
                        </div>
                    </div>
                <% } else { %>
                    <div class="auth-central-card" style="max-width: 1200px;">
                        <p class="booking-subtitle-bar">Welcome, <%= fullname %>! You are ready to book.</p>
                        <h2 class="auth-card-title" style="font-size: 32px; margin-bottom: 40px;">Choose Your Accommodation</h2>
                        
                        <div class="dashboard-scheduler-grid">
                            <div class="schedule-card-node">
                                <div class="room-image-frame" data-asset="room-std"></div>
                                <h2>Standard Rooms</h2>
                                <span class="schedule-meta-lbl">Maximum 2 persons</span>
                                <button class="select-booking-action" onclick="confirmBookingChoice('booking/standard.jsp')">Select</button>
                            </div>
                            
                            <div class="schedule-card-node">
                                <div class="room-image-frame" data-asset="room-sup"></div>
                                <h2>Superior Rooms</h2>
                                <span class="schedule-meta-lbl">Maximum 4 persons</span>
                                <button class="select-booking-action" onclick="confirmBookingChoice('booking/superior.jsp')">Select</button>
                            </div>
                            
                            <div class="schedule-card-node">
                                <div class="room-image-frame" data-asset="room-vil"></div>
                                <h2>Villas</h2>
                                <span class="schedule-meta-lbl">Maximum 6 persons</span>
                                <button class="select-booking-action" onclick="confirmBookingChoice('booking/villas.jsp')">Select</button>
                            </div>
                            
                            <div class="schedule-card-node">
                                <div class="room-image-frame" data-asset="room-pre"></div>
                                <h2>Premier Rooms</h2>
                                <span class="schedule-meta-lbl">Maximum 3 persons</span>
                                <button class="select-booking-action" onclick="confirmBookingChoice('booking/premier.jsp')">Select</button>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
    <script>
        const loaderOverlay = document.getElementById('loaderOverlay');
        const menuToggleBtn = document.getElementById('menuToggleBtn');
        const sidebar = document.getElementById('sidebar');

        if (menuToggleBtn && sidebar) {
            menuToggleBtn.addEventListener('click', () => {
                sidebar.classList.toggle('collapsed');
            });
        }
        
        function runTimedTransition(callback) {
            loaderOverlay.classList.add('show');
            setTimeout(() => {
                callback();
                loaderOverlay.classList.remove('show');
            }, 1);
        }

        document.querySelectorAll('.nav-menu a, .top-action-bar a').forEach(link => {
            link.addEventListener('click', function(e) {

                e.preventDefault();

                const destUrl = this.getAttribute('href');

                runTimedTransition(() => {
                    window.location.href = destUrl;
                });

            });
        });

        function confirmBookingChoice(targetJspFile) {

            runTimedTransition(() => {
                window.location.href = targetJspFile;
            });

        }
    </script>
</body>
</html>
