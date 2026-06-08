<%-- 
    Document   : explore
    Created on : Jun 5, 2026, 4:55:40 AM
    Author     : AynYreve
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olivia's Events Place - Explore Dashboard</title>
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

            --table-header-bg: #073b61;
            --row-light: #a4d2f0;
            --row-mid: #79bce9;
            --row-dark: #4ea4e1;
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
            transition: transform 0.2s ease, background-color 0.2s ease; 
        }

        .action-icon-btn:hover { 
            transform: translateY(-3px); 
            background-color: var(--nav-item-active-bg); 
        }

        /* Layout Grid and Content Boards */
        .explore-section { 
            width: 100%; 
            max-width: 1000px; 
            margin: 0 auto 80px auto; 
            padding-top: 20px; 
            display: flex; 
            flex-direction: column; 
        }
        
        .explore-title { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 56px; 
            font-weight: 700; 
            font-style: italic; 
            color: var(--heading-text-color); 
            letter-spacing: 1px; 
            text-transform: uppercase; 
            margin-bottom: 25px; 
            text-align: center; 
            border-bottom: 3px solid var(--underline-teal); 
            display: inline-block; 
            margin-left: auto; 
            margin-right: auto; 
            padding-bottom: 5px; 
        }

        .explore-subtitle { 
            font-family: 'Barlow Condensed', sans-serif; 
            font-size: 32px; 
            font-weight: 700; 
            font-style: italic; 
            color: var(--heading-text-color); 
            text-transform: uppercase; 
            margin-bottom: 25px; 
            text-align: center; 
            letter-spacing: 1px; 
        }

        /* Matrix Tables Data System */
        .explore-data-table { 
            width: 100%; 
            border-collapse: collapse; 
            border: 3px solid #000000; 
            box-shadow: 0 8px 16px rgba(0,0,0,0.1); 
            margin-bottom: 15px; 
        }

        .explore-data-table th { 
            background-color: var(--table-header-bg); 
            color: #ffffff; 
            font-size: 20px; 
            font-weight: 700; 
            padding: 14px 20px; 
            border: 2px solid #000000; 
            text-align: center; 
        }

        .explore-data-table td { 
            color: #000000; 
            font-size: 18px; 
            font-weight: 700; 
            padding: 18px 20px; 
            border: 2px solid #000000; 
            text-align: center; 
        }
        
        .row-1 { background-color: var(--row-light); }
        .row-2 { background-color: var(--row-mid); }
        .row-3 { background-color: var(--row-dark); }
        .row-4 { background-color: #2b8cbe; } 

        .footer-callout { 
            text-align: right; 
            font-size: 18px; 
            font-weight: 700; 
            color: var(--brand-primary-color); 
            margin-bottom: 35px; 
            padding-right: 5px; 
        }

        /* Information Callout Cards */
        .guidelines-box { 
            width: 100%; 
            padding-left: 10px; 
        }

        .guidelines-list { 
            list-style: none; 
            display: flex; 
            flex-direction: column; 
            gap: 8px; 
        }

        .guidelines-list li { 
            font-size: 16px; 
            font-weight: 700; 
            color: var(--brand-primary-color); 
            position: relative; 
            padding-left: 20px; 
            line-height: 1.4; 
        }

        .guidelines-list li::before { 
            content: "•"; 
            position: absolute; 
            left: 0; 
            top: -2px; 
            font-size: 22px; 
            color: var(--brand-primary-color); 
        }
        
        .divider-line { 
            border: none; 
            border-top: 2px dashed rgba(15, 44, 89, 0.2); 
            margin-bottom: 40px; 
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
                <a href="explore.jsp" class="nav-item active">
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
                <a href="book.jsp" class="nav-item">
                    <i class="fa-solid fa-calendar-days"></i> 
                    <span class="nav-text">Book</span>
                </a>
            </nav>
        </aside>

        <main class="main-content" id="scrollViewport">
            <div class="top-action-bar">
                <a href="home.jsp" class="action-icon-btn" title="Back Home">
                    <i class="fa-solid fa-house"></i>
                </a>
                <a href="book.jsp" class="action-icon-btn" title="Go to Booking">
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <!-- SECTION 1: POOLS -->
            <section class="explore-section" id="pools-section">
                <h1 class="explore-title">EXPLORE POOLS</h1>
                <h2 class="explore-subtitle">POOL AVAILABILITY</h2>

                <table class="explore-data-table">
                    <thead>
                        <tr>
                            <th style="width: 40%;">Pool</th>
                            <th style="width: 30%;">Weekends/Holiday</th>
                            <th style="width: 30%;">Weekdays</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Adult Pool & Children's Pool</td>
                            <td>8am-10pm</td>
                            <td>8am-10pm</td>
                        </tr>
                        <tr class="row-2">
                            <td>Slide Pool</td>
                            <td>8am-7pm</td>
                            <td>8am-8pm</td>
                        </tr>
                        <tr class="row-3">
                            <td>Wave Pool</td>
                            <td>8am-5pm</td>
                            <td>8am-7pm</td>
                        </tr>
                    </tbody>
                </table>

                <div class="footer-callout">*15-minute intervals for Wave Pool</div>

                <div class="guidelines-box">
                    <ul class="guidelines-list">
                        <li>Adult Pool – No children below 12yo after 4pm</li>
                        <li>Children’s Pool – Parent supervision required at all times</li>
                        <li>Slide Pool – Height requirement: minimum 3.5 ft</li>
                        <li>Wave Pool – 15-min wave sessions only. No waves during rest intervals.</li>
                        <li>All pools – No glass containers, no pets, no running</li>
                        <li>Last entry for each pool: 30 minutes before closing time.</li>
                        <li>Emergency: Call lifeguard or approach any staff.</li>
                    </ul>
                </div>
            </section>

            <hr class="divider-line">

            <!-- SECTION 2: COTTAGE -->
            <section class="explore-section" id="cottage-section">
                <h1 class="explore-title">EXPLORE COTTAGE</h1>
                <h2 class="explore-subtitle">COTTAGE TYPE & CAPACITY</h2>

                <table class="explore-data-table">
                    <thead>
                        <tr>
                            <th style="width: 50%;">Cottage Type</th>
                            <th style="width: 50%;">Capacity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Capacity</td>
                            <td>6-8 pax</td>
                        </tr>
                        <tr class="row-2">
                            <td>Family Cottage</td>
                            <td>10-12 pax</td>
                        </tr>
                        <tr class="row-3">
                            <td>Pavilion / Large</td>
                            <td>20-30 pax</td>
                        </tr>
                    </tbody>
                </table>

                <div style="height: 25px;"></div> 

                <div class="guidelines-box">
                    <ul class="guidelines-list">
                        <li>Open Cottage – Table + 8 chairs + grill stand included</li>
                        <li>Family Cottage – 2 tables + 12 chairs + grill stand</li>
                        <li>Pavilion / Large – 4 tables + 30 chairs + 2 grill stands</li>
                        <li>Rental time: 8am – 10pm only</li>
                        <li>Bring your own charcoal</li>
                        <li>₱500 garbage deposit (refundable upon cleaning)</li>
                        <li>Karaoke rental available for Pavilion only: ₱300/hour</li>
                        <li>Reservation required for Pavilion on weekends</li>
                        <li>No corkage for food. ₱100 corkage for liquor.</li>
                    </ul>
                </div>
            </section>

            <hr class="divider-line">

            <!-- SECTION 3: ROOMS -->
            <section class="explore-section" id="rooms-section">
                <h1 class="explore-title">EXPLORE ROOMS</h1>
                <h2 class="explore-subtitle">ROOM TYPES & CAPACITY</h2>

                <table class="explore-data-table">
                    <thead>
                        <tr>
                            <th style="width: 35%;">Room Type</th>
                            <th style="width: 40%;">Bed Type</th>
                            <th style="width: 25%;">Capacity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Standard Room</td>
                            <td>1 queen bed</td>
                            <td>2 pax</td>
                        </tr>
                        <tr class="row-2">
                            <td>Superior Room</td>
                            <td>1 queen + 1 single</td>
                            <td>3-4 pax</td>
                        </tr>
                        <tr class="row-3">
                            <td>Villa</td>
                            <td>2 queen beds + living area</td>
                            <td>4-6 pax</td>
                        </tr>
                        <tr class="row-4">
                            <td>Premier Room</td>
                            <td>1 king bed + workspace</td>
                            <td>2-3 pax</td>
                        </tr>
                    </tbody>
                </table>

                <div style="height: 25px;"></div>

                <div class="guidelines-box">
                    <ul class="guidelines-list">
                        <li>Check-in: 2pm | Check-out: 12nn</li>
                        <li>Extra person charge: ₱___ (with extra bed)</li>
                        <li>No smoking inside the room</li>
                        <li>Free breakfast included (for Villa & Premier only)</li>
                    </ul>
                </div>
            </section>
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
