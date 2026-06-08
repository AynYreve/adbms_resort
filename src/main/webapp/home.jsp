<%-- 
    Document   : home
    Created on : Jun 5, 2026, 5:09:42 AM
    Author     : AynYreve
--%>
<% boolean isLoggedIn = session.getAttribute("user_id") != null; %>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olivia's Events Place - Home</title>
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

        html { 
            scroll-behavior: smooth; 
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
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.2s ease, border-radius 0.2s ease;
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
            overflow-y: scroll; 
            scroll-behavior: smooth; 
            position: relative;
            z-index: 1;
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
            transition: transform 0.2s ease, background-color 0.2s ease; 
        }

        .action-icon-btn:hover { 
            transform: translateY(-3px); 
            background-color: var(--nav-item-active-bg); 
        }

        .action-icon-btn.logout-accent { 
            background-color: #e11d48; 
        } 

        .action-icon-btn.logout-accent:hover { 
            background-color: #be123c; 
        }

        /* Structural Page Elements */
        .scroll-anchor-section { 
            width: 100%; 
            padding-top: 80px; 
            margin-bottom: 60px; 
            display: flow-root; 
            clear: both; 
        }

        .home-features-section { 
            min-height: calc(100vh - 80px); 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            width: 100%; 
            margin-bottom: 60px; 
        }

        .section-title-header { 
            text-align: center; 
            margin-bottom: 45px; 
        }

        .section-title-header h1 { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 64px; 
            font-style: italic; 
            font-weight: 700; 
            color: var(--heading-text-color); 
            letter-spacing: 2px; 
        }

        .title-underline { 
            width: 180px; 
            height: 4px; 
            background-color: var(--underline-teal); 
            margin: 8px auto 0 auto; 
        }

        /* Feature Graphic Grid system */
        .features-grid { 
            display: flex; 
            justify-content: center; 
            gap: 35px; 
            width: 100%; 
            max-width: 1100px; 
        }
        
        .feature-card { 
            flex: 1; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            text-align: center; 
            max-width: var(--card-max-width); 
            cursor: pointer; 
        }

        .card-image-wrapper { 
            position: relative; 
            width: 100%;
            aspect-ratio: 1 / 1; 
            background-color: #000; 
            border: 4px solid var(--card-border-color); 
            border-radius: 24px; 
            margin-bottom: 25px; 
            box-shadow: 12px 12px 0px var(--shadow-color); 
            transition: transform 0.2s ease, box-shadow 0.2s ease; 
        }

        .card-image { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
            border-radius: 18px; 
            
        }
        
        .feature-card:hover .card-image-wrapper { 
            transform: translate(-4px, -4px); 
            box-shadow: 16px 16px 0px var(--shadow-hover); 
        }

        .feature-card h2 { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 38px; 
            font-style: italic; 
            font-weight: 700; 
            color: var(--heading-text-color); 
            margin-bottom: 10px; 
        }

        .feature-card p { 
            font-size: 14px; 
            line-height: 1.4; 
            color: var(--card-text-color); 
            font-weight: 500; 
        }

        /* Displays and Multi-column setups */
        .standard-display-grid { 
            display: grid; 
            grid-template-columns: repeat(2, 1fr); 
            gap: 40px 50px; 
            width: 100%; 
            max-width: 1100px; 
            margin: 0 auto; 
        }

        .display-item { 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            cursor: pointer; 
        }

        .display-item.large-colspan { 
            grid-column: 1 / span 2; 
            width: 65%; 
            margin: 15px auto 0 auto; 
        }

        .image-placeholder { 
            width: 100%; 
            aspect-ratio: 16 / 10; 
            border: 4px solid var(--card-border-color); 
            border-radius: 4px; 
            box-shadow: 12px 12px 0px var(--shadow-color); 
            margin-bottom: 18px; 
            transition: transform 0.2s ease, box-shadow 0.2s ease; 
            background-color: #ffffff; 
            background-size: cover; 
            background-position: center; 
            background-repeat: no-repeat; 
        }
        
        .display-item:hover .image-placeholder { 
            transform: translate(-4px, -4px); 
            box-shadow: 16px 16px 0px var(--shadow-hover); 
        }
        
        .room-image-frame[data-asset="room-std"] { background-image: url('Assets/Standard.jpg'); }
        .room-image-frame[data-asset="room-sup"] { background-image: url('Assets/Superior.jpg'); }
        .room-image-frame[data-asset="room-vil"] { background-image: url('Assets/Villa.jpg'); }
        .room-image-frame[data-asset="room-pre"] { background-image: url('Assets/Premier.jpg'); }

        .display-item h2 { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 28px; 
            font-style: italic; 
            font-weight: 700; 
            color: var(--heading-text-color); 
            letter-spacing: 0.5px; 
            text-transform: uppercase; 
            text-align: center; 
            margin-bottom: 10px; 
        }

        .display-item p { 
            font-size: 13px; 
            color: var(--card-text-color); 
            text-align: center; 
            line-height: 1.4; 
            font-weight: 500; 
            max-width: 95%; 
        }

        /* Room Segment Custom Displays */
        .rooms-isolated-grid { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr) !important; 
            gap: 25px; 
            width: 100%; 
            max-width: 1200px; 
            margin: 0 auto; 
        }

        .room-image-frame { 
            width: 100%; 
            aspect-ratio: 3 / 4; 
            border: 4px solid var(--card-border-color); 
            border-radius: 12px; 
            box-shadow: 8px 8px 0px var(--shadow-color); 
            margin-bottom: 18px; 
            transition: transform 0.2s ease, box-shadow 0.2s ease; 
            background-color: #ffffff; 
            background-size: cover; 
            background-position: center; 
            background-repeat: no-repeat; 
            background-image: url('Kaguya.png'); 
        }
        
        .display-item:hover .room-image-frame { 
            transform: translate(-4px, -4px); 
            box-shadow: 12px 12px 0px var(--shadow-hover); 
        }

        @media (max-width: 900px) {
            .rooms-isolated-grid { 
                grid-template-columns: 1fr !important; 
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
                <a href="home.jsp" class="nav-item active" id="navHomeBtn">
                    <i class="fa-solid fa-house"></i> 
                    <span class="nav-text">Home</span>
                </a>
                <a href="explore.jsp" class="nav-item" id="navExploreBtn">
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
                <a href="book.jsp" class="nav-item" id="navBookBtn">
                    <i class="fa-solid fa-calendar-days"></i> 
                    <span class="nav-text">Book</span>
                </a>
            </nav>
        </aside>

        <main class="main-content" id="scrollContainer">

            <div class="top-action-bar">
                <a href="#" class="action-icon-btn" id="actionHomeBtn" title="Back to Top">
                    <i class="fa-solid fa-house"></i>
                </a>
                <% if (isLoggedIn) { %>
                    <a href="LogoutServlet" class="action-icon-btn logout-accent" title="Log Out">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    </a>
                <% } %>
            </div>

            <div id="pageViewExplore" class="app-view-page page-active">
                
                <section class="home-features-section" id="home-view">
                    <header class="section-title-header">
                        <h1>FEATURES</h1>
                        <div class="title-underline"></div>
                    </header>

                    <div class="features-grid">
                        <article class="feature-card" id="poolsCardTrigger">
                            <div class="card-image-wrapper">
                                <img src="Assets/Children.jpg" alt="Pools" class="card-image">
                            </div>
                            <h2>POOLS</h2>
                            <p>Relax and enjoy our clean and refreshing swimming pools, perfect for families, friends, and special gatherings.</p>
                        </article>

                        <article class="feature-card" id="cottageCardTrigger">
                            <div class="card-image-wrapper">
                                <img src="Assets/Cottage.jpg" alt="Cottage" class="card-image">
                            </div>
                            <h2>COTTAGE</h2>
                            <p>Comfortable and spacious cottages designed for relaxation, bonding, and unforgettable moments with your loved ones.</p>
                        </article>

                        <article class="feature-card" id="roomsCardTrigger">
                            <div class="card-image-wrapper">
                                <img src="Assets/Rooms.jpg" alt="Rooms" class="card-image">
                            </div>
                            <h2>ROOMS</h2>
                            <p>Cozy and well-maintained rooms that provide comfort and convenience for short stays or overnight accommodations.</p>
                        </article>
                    </div>
                </section>

                <section class="scroll-anchor-section" id="pools-view">
                    <header class="section-title-header">
                        <h1>POOLS</h1>
                        <div class="title-underline" style="width: 140px;"></div>
                    </header>
                    <div class="standard-display-grid">
                        <div class="display-item">
                            <img src="Assets/Children.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Children’s Interactive Pool</h2>
                        </div>
                        <div class="display-item">
                            <img src="Assets/Adult.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Adult Pool</h2>
                        </div>
                        <div class="display-item">
                            <img src="Assets/Wave.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Wave Pool</h2>
                        </div>
                        <div class="display-item">
                            <img src="Assets/Slide.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Slide Pool</h2>
                        </div>
                    </div>
                </section>

                <section class="scroll-anchor-section" id="cottage-view">
                    <header class="section-title-header">
                        <h1>COTTAGE</h1>
                        <div class="title-underline" style="width: 180px;"></div>
                    </header>
                    <div class="standard-display-grid">
                        <div class="display-item">
                            <img src="Assets/Open.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Open Cottage</h2>
                        </div>
                        <div class="display-item">
                            <img src="Assets/Family.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Family Cottage</h2>
                        </div>
                        <div class="display-item large-colspan">
                            <img src="Assets/Large.jpg" alt="Rooms" class="image-placeholder">
                            <h2>Pavilion / Large</h2>
                        </div>
                    </div>
                </section>

                <section class="scroll-anchor-section" id="rooms-view">
                    <header class="section-title-header">
                        <h1>ROOMS</h1>
                        <div class="title-underline" style="width: 150px;"></div>
                    </header>
                    <div class="rooms-isolated-grid">
                        <div class="display-item">
                            <div class="room-image-frame" data-asset="room-std"></div>
                            <h2>Standard Rooms</h2>
                            <p>Comfortable accommodation perfect for couples and solo travelers.</p>
                        </div>
                        <div class="display-item">
                            <div class="room-image-frame"data-asset="room-sup"></div>
                            <h2>Superior Rooms</h2>
                            <p>Enhanced comfort with additional space and modern amenities.</p>
                        </div>
                        <div class="display-item">
                            <div class="room-image-frame" data-asset="room-vil"></div>
                            <h2>Villas</h2>
                            <p>Private and spacious stay ideal for families and group vacations.</p>
                        </div>
                        <div class="display-item">
                            <div class="room-image-frame" data-asset="room-pre"></div>
                            <h2>Premier Rooms</h2>
                            <p>Premium room experience with elegant interiors and added convenience.</p>
                        </div>
                    </div>
                </section>
            </div>
        </main>
    </div>
    
    <script>
        const loaderOverlay = document.getElementById('loaderOverlay');
        const sidebar = document.getElementById('sidebar');
        const menuToggleBtn = document.getElementById('menuToggleBtn');
        const scrollContainer = document.getElementById('scrollContainer');

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
                const hrefValue = this.getAttribute('href');
                
                if (hrefValue.startsWith('#') || hrefValue === '#') {
                    e.preventDefault();
                    document.getElementById('home-view').scrollIntoView({ behavior: 'smooth', block: 'start' });
                } else {
                    e.preventDefault();
                    runTimedTransition(() => { 
                        window.location.href = hrefValue; 
                    });
                }
            });
        });

        document.getElementById('poolsCardTrigger').addEventListener('click', () => {
            document.getElementById('pools-view').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
        
        document.getElementById('cottageCardTrigger').addEventListener('click', () => {
            document.getElementById('cottage-view').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
        
        document.getElementById('roomsCardTrigger').addEventListener('click', () => {
            document.getElementById('rooms-view').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
    </script>
</body>
</html>
