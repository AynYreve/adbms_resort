<%-- 
    Document   : contact
    Created on : Jun 5, 2026, 6:06:06 AM
    Author     : Julian Edriel
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olivia's Events Place - Contact Us</title>
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
            border: none;
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 18px; 
            text-decoration: none; 
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15); 
            transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), background-color 0.2s ease; 
        }

        .action-icon-btn:hover { 
            transform: translateY(-3px) scale(1.05); 
            background-color: var(--nav-item-active-bg); 
        }

        /* Contact Details & Layout */
        .contact-wrapper { 
            width: 100%; 
            max-width: 1050px; 
            margin: 0 auto; 
            padding-top: 10px; 
        }
        
        .contact-header-container { 
            text-align: center; 
            margin-bottom: 50px; 
        }

        .contact-title { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 56px; 
            font-weight: 700; 
            font-style: italic; 
            color: var(--heading-text-color); 
            letter-spacing: 1px; 
            text-transform: uppercase; 
            border-bottom: 3px solid var(--underline-teal); 
            display: inline-block; 
            padding-bottom: 5px; 
        }

        .contact-split-grid { 
            display: grid; 
            grid-template-columns: 1fr 420px; 
            gap: 40px; 
            align-items: start; 
        }

        .contact-info-column { 
            display: flex; 
            flex-direction: column; 
            gap: 35px; 
        }
        
        .info-group { 
            display: flex; 
            flex-direction: column; 
            gap: 8px; 
        }

        .info-label { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 34px; 
            font-weight: 700; 
            font-style: italic; 
            color: #073b61; 
            text-transform: uppercase; 
            letter-spacing: 0.5px; 
        }

        .info-detail { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 22px; 
            font-weight: 700; 
            font-style: italic; 
            color: #0f2c59; 
            text-transform: uppercase; 
            line-height: 1.3; 
            letter-spacing: 0.5px; 
        }

        .map-container-box { 
            width: 100%; 
            height: 300px; 
            border: 4px solid #ffffff; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.15); 
            background-color: rgba(255,255,255,0.4); 
            border-radius: 2px; 
            overflow: hidden; 
            position: relative; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
        }

        .map-placeholder-text { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 18px; 
            font-weight: 700; 
            color: #104373; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            text-align: center; 
            padding: 20px; 
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
                <a href="contact.jsp" class="nav-item active">
                    <i class="fa-solid fa-phone"></i> 
                    <span class="nav-text">Contact</span>
                </a>
                <a href="book.jsp" class="nav-item">
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
                <a href="book.jsp" class="action-icon-btn" title="Go to Booking">
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <div class="contact-wrapper">
                <div class="contact-header-container">
                    <h1 class="contact-title">CONTACT</h1>
                </div>

                <div class="contact-split-grid">
                    <div class="contact-info-column">
                        <div class="info-group">
                            <div class="info-label">ADDRESS:</div>
                            <div class="info-detail">BLOCK 85 LOT 7 PHASE 1B-PHASE 4,<br>CARISSA HOMES, BAGTAS, TANZA, 4108 CAVITE</div>
                        </div>

                        <div class="info-group">
                            <div class="info-label">EMAIL:</div>
                            <div class="info-detail">OLIVIAPLACESEVENT@GMAIL.COM</div>
                        </div>

                        <div class="info-group">
                            <div class="info-label">PHONE:</div>
                            <div class="info-detail">
                                MOBILE: 0951 874 0439
                            </div>
                        </div>
                    </div>

                    <div class="map-container-box">
                        <div class="map-placeholder-text">
                            <br>
                            <iframe  src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3865.445964478993!2d120.8494063!3d14.343583699999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33962be8fb9a70f7%3A0x8282740802462b05!2sOlivia&#39;s%20Place!5e0!3m2!1sen!2sph!4v1780817623266!5m2!1sen!2sph" 
                                     alt="Map graphic" style="width: 400px; height: 300px; "  allowfullscreen=""  </iframe>
                        </div>
                    </div>
                </div>
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
    </script>
</body>
</html>
