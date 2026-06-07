<%-- 
    Document   : rates
    Created on : Jun 5, 2026, 5:58:21 AM
    Author     : Julian Edriel
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Olivia's Events Place - Rates Dashboard</title>
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
            --row-extended: #2b8cbe;
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
            to {
                transform: rotate(360deg);
            }
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
            transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275), background-color 0.2s ease;
        }

        .action-icon-btn:hover {
            transform: translateY(-3px) scale(1.05);
            background-color: var(--nav-item-active-bg);
        }

        .rates-section {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto 90px auto;
            padding-top: 10px;
            display: flex;
            flex-direction: column;
        }

        .rates-title {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 56px;
            font-weight: 700;
            font-style: italic;
            color: var(--heading-text-color);
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 10px;
            text-align: center;
            border-bottom: 3px solid var(--underline-teal);
            display: inline-block;
            margin-left: auto;
            margin-right: auto;
            padding-bottom: 5px;
        }

        .rates-subtitle {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 36px;
            font-weight: 700;
            font-style: italic;
            color: var(--heading-text-color);
            text-transform: uppercase;
            margin-bottom: 30px;
            text-align: center;
            letter-spacing: 1px;
        }

        .rates-data-table {
            width: 100%;
            border-collapse: collapse;
            border: 3px solid #000000;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .rates-data-table th {
            background-color: var(--table-header-bg);
            color: #ffffff;
            font-size: 20px;
            font-weight: 700;
            padding: 14px 20px;
            border: 2px solid #000000;
            text-align: center;
        }

        .rates-data-table td {
            color: #000000;
            font-size: 18px;
            font-weight: 700;
            padding: 16px 20px;
            border: 2px solid #000000;
            text-align: center;
        }

        .row-1 { background-color: var(--row-light); }
        .row-2 { background-color: var(--row-mid); }
        .row-3 { background-color: var(--row-dark); }
        .row-4 { background-color: var(--row-extended); }

        .summary-rules-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 30px;
            padding-left: 5px;
        }

        .summary-rules-list li {
            font-size: 15px;
            font-weight: 700;
            color: #000000;
            position: relative;
            padding-left: 18px;
            line-height: 1.4;
        }

        .summary-rules-list li::before {
            content: "•";
            position: absolute;
            left: 0;
            top: -1px;
            font-size: 20px;
            color: #000000;
        }

        .payment-badge-grid {
            display: grid;
            grid-template-columns: 240px 1fr;
            row-gap: 14px;
            column-gap: 20px;
            align-items: center;
            width: 100%;
            padding: 10px 5px;
        }

        .badge-label-block {
            background: linear-gradient(to right, #1d528f, #104373);
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            padding: 10px 15px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-transform: capitalize;
        }

        .badge-value-text {
            font-size: 18px;
            font-weight: 700;
            color: var(--brand-primary-color);
        }

        .pill-container {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .payment-method-pill {
            background: linear-gradient(to bottom, #2563eb, #1d528f);
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            padding: 8px 24px;
            border-radius: 4px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
            min-width: 100px;
            text-align: center;
        }

        .divider-line {
            border: none;
            border-top: 2px dashed rgba(15, 44, 89, 0.2);
            margin-bottom: 45px;
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
                <a href="rates.jsp" class="nav-item active">
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

        <main class="main-content" id="ratesViewport">
            <div class="top-action-bar">
                <a href="home.jsp" class="action-icon-btn" title="Back Home">
                    <i class="fa-solid fa-house"></i>
                </a>
                <a href="book.jsp" class="action-icon-btn" title="Go to Booking">
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <section class="rates-section" id="pool-rates">
                <h1 class="rates-title">RATES</h1>
                <h2 class="rates-subtitle">SWIMMING POOL</h2>

                <table class="rates-data-table">
                    <thead>
                        <tr>
                            <th style="width: 40%;">Rate Type</th>
                            <th style="width: 30%;">Weekdays</th>
                            <th style="width: 30%;">Weekends / Holiday</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Adult (13 yrs old & above)</td>
                            <td>₱200</td>
                            <td>₱300</td>
                        </tr>
                        <tr class="row-2">
                            <td>Child (4-12 yrs old)</td>
                            <td>₱150</td>
                            <td>₱250</td>
                        </tr>
                        <tr class="row-3">
                            <td>Toddler (3ft & below)</td>
                            <td>Free</td>
                            <td>₱100</td>
                        </tr>
                    </tbody>
                </table>

                <ul class="summary-rules-list">
                    <li>Access to ALL pools: Adult Pool, Children's Pool, Slide Pool, Wave Pool</li>
                    <li>Wave Pool operates in 15-min intervals</li>
                    <li>No glass containers, no running</li>
                    <li>Last entry: 30 minutes before closing time</li>
                </ul>

                <div class="payment-badge-grid">
                    <div class="badge-label-block">Payment method:</div>
                    <div class="badge-value-text">Walk-in only (no reservation needed)</div>
                    
                    <div class="badge-label-block">Payment time:</div>
                    <div class="badge-value-text">Pay at entrance / front desk upon arrival</div>
                    
                    <div class="badge-label-block">Accepted payments:</div>
                    <div class="pill-container">
                        <div class="payment-method-pill">Cash</div>
                        <div class="payment-method-pill">Gcash</div>
                        <div class="payment-method-pill">Visa, Mastercard</div>
                    </div>
                </div>
            </section>

            <hr class="divider-line">

            <section class="rates-section" id="cottage-rates">
                <h1 class="rates-title">RATES</h1>
                <h2 class="rates-subtitle">COTTAGE</h2>

                <table class="rates-data-table">
                    <thead>
                        <tr>
                            <th style="width: 30%;">Rate Type</th>
                            <th style="width: 25%;">Capacity</th>
                            <th style="width: 22%;">Weekdays</th>
                            <th style="width: 23%;">Weekends / Holiday</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Open Cottage</td>
                            <td>6-8 pax</td>
                            <td>₱200</td>
                            <td>₱300</td>
                        </tr>
                        <tr class="row-2">
                            <td>Family Cottage</td>
                            <td>10-12 pax</td>
                            <td>₱150</td>
                            <td>₱250</td>
                        </tr>
                        <tr class="row-3">
                            <td>Pavilion / Large</td>
                            <td>20-30 pax</td>
                            <td>Free</td>
                            <td>₱100</td>
                        </tr>
                    </tbody>
                </table>

                <ul class="summary-rules-list">
                    <li>Access to ALL pools: Adult Pool, Children's Pool, Slide Pool, Wave Pool</li>
                    <li>Wave Pool operates in 15-min intervals</li>
                    <li>No glass containers, no pets, no running</li>
                    <li>Last entry: 30 minutes before closing time</li>
                </ul>

                <div class="payment-badge-grid">
                    <div class="badge-label-block">Payment method:</div>
                    <div class="badge-value-text">Walk-in only (no reservation needed)</div>
                    
                    <div class="badge-label-block">Payment time:</div>
                    <div class="badge-value-text">Pay at entrance / front desk upon arrival</div>
                    
                    <div class="badge-label-block">Accepted payments:</div>
                    <div class="pill-container">
                        <div class="payment-method-pill">Cash</div>
                        <div class="payment-method-pill">Gcash</div>
                        <div class="payment-method-pill">Visa, Mastercard</div>
                    </div>
                </div>
            </section>

            <hr class="divider-line">

            <section class="rates-section" id="room-rates">
                <h1 class="rates-title">RATES</h1>
                <h2 class="rates-subtitle">ROOM</h2>

                <table class="rates-data-table">
                    <thead>
                        <tr>
                            <th style="width: 30%;">Rate Type</th>
                            <th style="width: 25%;">Capacity</th>
                            <th style="width: 22%;">Weekdays</th>
                            <th style="width: 23%;">Weekends / Holiday</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="row-1">
                            <td>Standard Room</td>
                            <td>2 pax</td>
                            <td>₱3,000</td>
                            <td>₱4,000</td>
                        </tr>
                        <tr class="row-2">
                            <td>Superior Room</td>
                            <td>3-4 pax</td>
                            <td>₱4,000</td>
                            <td>₱5,000</td>
                        </tr>
                        <tr class="row-3">
                            <td>Villa</td>
                            <td>4-6 pax</td>
                            <td>₱8,000</td>
                            <td>₱9,000</td>
                        </tr>
                        <tr class="row-4">
                            <td>Premier Room</td>
                            <td>2-3 pax</td>
                            <td>₱9,000</td>
                            <td>₱10,000</td>
                        </tr>
                    </tbody>
                </table>

                <div style="height: 15px;"></div>

                <div class="payment-badge-grid">
                    <div class="badge-label-block">Payment method:</div>
                    <div class="badge-value-text">Walk-in only (no reservation needed)</div>
                    
                    <div class="badge-label-block">Payment time:</div>
                    <div class="badge-value-text">Pay at entrance / front desk upon arrival</div>
                    
                    <div class="badge-label-block">Accepted payments:</div>
                    <div class="pill-container">
                        <div class="payment-method-pill">Cash</div>
                        <div class="payment-method-pill">Gcash</div>
                        <div class="payment-method-pill">Visa, Mastercard</div>
                    </div>
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