<%-- 
    Document   : superior
    Created on : Jun 5, 2026, 7:15:52 AM
    Author     : Julian Edriel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Olivia's Events Place - Superior Room</title>
  <link rel="icon" type="image/x-icon" href="../Assets/favicon.png">
  
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
      --card-bg-white: rgba(255, 255, 255, 0.85);
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Inter', sans-serif; background-color: #f0f0f0; height: 100vh; overflow: hidden; }
    .container { display: flex; width: 100%; height: 100vh; position: relative; }
    .loader-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(15, 44, 89, 0.95); z-index: 99999; display: flex; flex-direction: column; align-items: center; justify-content: center; opacity: 0; pointer-events: none; transition: opacity 0.3s ease-in-out; }
    .loader-overlay.show { opacity: 1; pointer-events: auto; }
    .spinner { width: 60px; height: 60px; border: 6px solid rgba(255, 255, 255, 0.2); border-top-color: var(--underline-teal); border-radius: 50%; animation: spin 0.8s linear infinite; margin-bottom: 15px; }
    .loader-text { color: #ffffff; font-family: 'Barlow Condensed', sans-serif; font-size: 24px; letter-spacing: 2px; font-weight: 700; text-transform: uppercase; }
    @keyframes spin { to { transform: rotate(360deg); } }
    
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
      
      background-image: url('../Assets/BG.jpg'); 
      background-size: cover;                 
      background-position: center;            
      background-repeat: no-repeat;            
    }
    .sidebar.collapsed { width: 60px; }
    .sidebar.collapsed .logo-box, .sidebar.collapsed .sidebar-footer, .sidebar.collapsed .nav-text { display: none; }
    .sidebar.collapsed .logo-container { margin-bottom: 60px; }
    .sidebar.collapsed .sidebar-toggle-embed { left: 18px; }
    .sidebar.collapsed .nav-item { padding: 12px 0; justify-content: center; width: 100%; border-radius: 0; text-indent: -9999px; }
    .sidebar.collapsed .nav-item i { text-indent: 0; margin-right: 0; }
    .sidebar.collapsed .nav-menu { padding: 0; }
    
    .sidebar-toggle-embed { position: absolute; top: 15px; left: 20px; background: transparent; border: none; font-size: 24px; color: var(--brand-primary-color); cursor: pointer; z-index: 110; }
    .logo-container { padding: 0 20px; margin-top: 35px; margin-bottom: 40px; }
    .logo-box { border: 3px solid var(--brand-primary-color); padding: 10px; background: #fff; text-align: center; }
    .logo-text-img { font-family: 'Barlow Condensed', sans-serif; font-size: 22px; font-weight: 700; color: var(--brand-primary-color); letter-spacing: 1px; display: block; }
    .logo-subtext { font-size: 10px; font-weight: 600; color: var(--brand-primary-color); letter-spacing: 0.5px; display: block; }
    
    .nav-menu { display: flex; flex-direction: column; gap: 6px; padding: 0 15px; }
    .nav-item { display: flex; align-items: center; gap: 15px; padding: 12px 20px; text-decoration: none; font-weight: 600; color: var(--brand-primary-color); font-size: 16px; border-bottom: 1.5px solid var(--brand-primary-color); cursor: pointer; transition: background-color 0.2s ease, transform 0.2s ease, border-radius 0.2s ease; }
    .nav-item:hover { background-color: rgba(29, 82, 143, 0.1); transform: translateX(4px); border-radius: 8px; }
    .nav-item.active { background-color: var(--nav-item-active-bg); color: var(--nav-item-active-text); border-radius: 50px; border-bottom: none; }
    .nav-item.active:hover { transform: none; }
    .nav-item i { width: 20px; text-align: center; font-size: 18px; }
    .sidebar-footer { margin-top: auto; text-align: center; font-size: 12px; color: #555; }
    
    .main-content { flex: 1; background: linear-gradient(135deg, var(--bg-gradient-start) 0%, var(--bg-gradient-mid) 50%, var(--bg-gradient-end) 100%); display: flex; flex-direction: column; padding: 30px 40px; overflow-y: auto; position: relative; }
    .top-action-bar { position: fixed; top: 30px; right: 40px; display: flex; gap: 12px; z-index: 500; }
    .action-icon-btn { background-color: var(--brand-primary-color); color: white; width: 45px; height: 45px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; text-decoration: none; box-shadow: 0 4px 6px rgba(0,0,0,0.15); transition: all 0.2s ease; }
    .action-icon-btn:hover { transform: translateY(-3px); background-color: var(--nav-item-active-bg); }
    .booking-wrapper { width: 100%; display: flex; flex-direction: column; margin-top: 20px; }
    .header-section { display: flex; flex-direction: column; align-items: center; margin-bottom: 25px; }
    .title-book-now { font-family: 'Barlow Condensed', sans-serif; font-size: 54px; font-weight: 700; font-style: italic; color: var(--brand-primary-color); text-transform: uppercase; letter-spacing: 2px; line-height: 1; margin-bottom: 5px; }
    .title-room-type { font-family: 'Barlow Condensed', sans-serif; font-size: 42px; font-weight: 700; font-style: italic; color: var(--heading-text-color); text-transform: uppercase; letter-spacing: 1px; }
    .workspace-grid { display: grid; grid-template-columns: 1.12fr 0.88fr; gap: 35px; width: 100%; max-width: 1250px; margin: 0 auto; align-items: start; }
    .selection-pane { display: flex; flex-direction: column; gap: 20px; }
    .datetime-bar { background-color: #1e4b7a; color: white; border-radius: 12px; padding: 12px 20px; display: inline-flex; align-items: center; gap: 12px; font-weight: 600; font-size: 15px; width: max-content; }
    .datetime-inputs { display: inline-flex; align-items: center; gap: 5px; color: white; font-family: inherit; font-size: 15px; }
    .datetime-inputs input, .datetime-inputs select { background: white; color: #1e4b7a; border: none; border-radius: 4px; padding: 2px 6px; font-weight: 700; text-align: center; outline: none; }
    .datetime-inputs input[type="number"] { width: 45px; }
    .calculation-card { background: var(--card-bg-white); border-radius: 20px; padding: 25px; box-shadow: 0 8px 24px rgba(0,0,0,0.08); border: 1px solid rgba(255,255,255,0.5); }
    .pax-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 18px; font-size: 18px; font-weight: 600; color: var(--brand-primary-color); }
    .pax-label span { font-size: 11px; color: #666; font-weight: 500; display: block; }
    .counter-field { display: flex; align-items: center; background: white; border: 2px solid var(--brand-primary-color); border-radius: 6px; overflow: hidden; }
    .counter-val { width: 50px; text-align: center; font-size: 18px; font-weight: 700; border: none; color: var(--brand-primary-color); outline: none; }
    .counter-btn { width: 35px; height: 35px; background: #e0f2fe; color: var(--brand-primary-color); border: none; font-size: 16px; font-weight: 700; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background 0.2s; }
    .counter-btn:hover { background: #bae6fd; }
    .counter-btn.btn-down { border-right: 2px solid var(--brand-primary-color); }
    .counter-btn.btn-up { border-left: 2px solid var(--brand-primary-color); }
    .selection-meta-text { font-size: 12px; font-weight: 600; color: var(--brand-primary-color); text-align: center; margin: -5px 0 15px 0; }
    .total-display-wrapper { display: flex; align-items: center; justify-content: space-between; border-top: 2px dashed rgba(16, 67, 115, 0.2); padding-top: 15px; margin-top: 10px; }
    .total-title { font-size: 20px; font-weight: 700; color: var(--brand-primary-color); }
    .total-amount-box { background: white; border: 2px solid #000; border-radius: 8px; padding: 10px 25px; font-size: 22px; font-weight: 700; color: #000; min-width: 160px; text-align: right; }
    .amenities-list { list-style: none; display: flex; flex-direction: column; gap: 8px; padding-left: 5px; }
    .amenities-list li { display: flex; align-items: center; gap: 10px; font-size: 14.5px; font-weight: 600; color: #1e3a8a; }
    .amenities-list li::before { content: "•"; color: #1e3a8a; font-size: 20px; }
    .media-pane { display: flex; flex-direction: column; align-items: center; }
    .showcase-frame { width: 100%; aspect-ratio: 1.45 / 1; border: 4px solid #000000; border-radius: 12px; box-shadow: 8px 8px 0px #22b09a; background-size: cover; background-position: center; margin-bottom: 12px; background-color: #fff; }
    .rate-indicator-bar { font-weight: 700; font-size: 14px; color: var(--brand-primary-color); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 25px; text-align: center; }
    .submit-booking-now { width: 100%; max-width: 260px; background-color: #0284c7; color: white; border: none; border-radius: 50px; padding: 12px 0; font-size: 18px; font-weight: 700; cursor: pointer; box-shadow: 0 4px 10px rgba(0,0,0,0.15); text-align: center; text-decoration: none; transition: all 0.2s ease; }
    .submit-booking-now:hover { background-color: #0369a1; transform: translateY(-2px); }
    @media (max-width: 900px) { .workspace-grid { grid-template-columns: 1fr; gap: 30px; } body { overflow-y: auto; height: auto; } .container { height: auto; min-height: 100vh; } }

    .showcase-frame {
      background-image: url('../Assets/Superior.jpg');
    }
  </style>
</head>
<body>

  <div class="loader-overlay" id="loaderOverlay">
    <div class="spinner"></div>
    <div class="loader-text">Processing reservation...</div>
  </div>

  <div class="container">
    <aside class="sidebar" id="sidebar">
      <button class="sidebar-toggle-embed" id="menuToggleBtn" title="Toggle Menu"><i class="fa-solid fa-bars"></i></button>
      <div class="logo-container">
        <div class="logo-box">
          <div class="logo-text-img">OLIVIA'S</div>
          <div class="logo-subtext">EVENTS PLACE</div>
        </div>
      </div>
      <nav class="nav-menu">
        <a href="../home.jsp" class="nav-item"><i class="fa-solid fa-house"></i> <span class="nav-text">Home</span></a>
        <a href="../explore.jsp" class="nav-item"><i class="fa-solid fa-map-location-dot"></i> <span class="nav-text">Explore</span></a>
        <a href="../rates.jsp" class="nav-item"><i class="fa-solid fa-tags"></i> <span class="nav-text">Rates</span></a>
        <a href="../contact.jsp" class="nav-item"><i class="fa-solid fa-phone"></i> <span class="nav-text">Contact</span></a>
        <a href="../book.jsp" class="nav-item active"><i class="fa-solid fa-calendar-days"></i> <span class="nav-text">Book</span></a>
      </nav>
    </aside>

    <main class="main-content">
      <div class="top-action-bar">
        <a href="../book.jsp" class="action-icon-btn" title="Back to Selection"><i class="fa-solid fa-arrow-left"></i></a>
        <a href="../home.jsp" class="action-icon-btn" title="Back Home"><i class="fa-solid fa-house"></i></a>
      </div>

      <div class="booking-wrapper">
        <div class="header-section">
          <h1 class="title-book-now">Book Now!</h1>
          <h2 class="title-room-type">Superior Room</h2>
        </div>
        
        <form action="<%= request.getContextPath() %>/processBooking" method="POST" id="bookingForm">
          <input type="hidden" name="room_type" value="Superior Room">
          
          <div class="workspace-grid">
            <div class="selection-pane">
              <div class="datetime-bar">
                <i class="fa-solid fa-calendar-days"></i>
                <div class="datetime-inputs">
                  <select name="booking_month">
                    <option value="01" selected>January</option>
                    <option value="02">February</option>
                    <option value="03">March</option>
                    <option value="04">April</option>
                    <option value="05">May</option>
                    <option value="06">June</option>
                    <option value="07">July</option>
                    <option value="08">August</option>
                    <option value="09">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                  </select>
                  <span>/</span>
                  <input type="number" name="booking_day" value="15" min="1" max="31">
                  <span>/</span>
                  <select name="booking_time">
                    <option value="02:00">02:00</option>
                    <option value="12:00" selected>12:00</option>
                    <option value="14:00">14:00</option>
                  </select>
                  <select name="booking_period">
                    <option value="AM">AM</option>
                    <option value="PM" selected>PM</option>
                  </select>
                </div>
              </div>

              <div class="calculation-card">
                <input type="hidden" name="roomType" value="Superior Room">
                <div class="pax-row">
                  <div class="pax-label">Adults:</div>
                  <div class="counter-field">
                    <button type="button" class="counter-btn btn-down" onclick="adjustCount('adult', -1)">∨</button>
                    <input type="hidden" id="adult_hidden" name="adultCount" value="1">
                    <input type="text" id="adult_count" name="adult" class="counter-val" value="1" readonly>
                    <button type="button" class="counter-btn btn-up" onclick="adjustCount('adult', 1)">∧</button>
                  </div>
                </div>

                <div class="pax-row">
                  <div class="pax-label">Children: <span>&le; 11 years old</span></div>
                  <div class="counter-field">
                    <button type="button" class="counter-btn btn-down" onclick="adjustCount('children', -1)">∨</button>
                    <input type="hidden" id="children_hidden" name="childrenCount" value="0">
                    <input type="text" id="children_count" name="children" class="counter-val" value="0" readonly>
                    <button type="button" class="counter-btn btn-up" onclick="adjustCount('children', 1)">∧</button>
                  </div>
                </div>

                <p class="selection-meta-text">Your Choosing (Superior Room) Maximum: 4 persons</p>

                <div class="total-display-wrapper">
                  <span class="total-title">Total:</span>
                  <div class="total-amount-box" id="total_price_box">₱ 4,000</div>
                </div>
              </div>

              <ul class="amenities-list">
                <li>1 Queen Bed</li>
                <li>1 Single Bed</li>
                <li>Perfect for small families (up to 4 pax)</li>
                <li>Airconditioning + ceiling fan</li>
                <li>40" LED TV with cable channels</li>
                <li>Hot & cold shower</li>
                <li>Mini refrigerator</li>
                <li>Free WiFi</li>
                <li>Coffee & tea setup</li>
              </ul>
            </div>

            <div class="media-pane">
              <div class="showcase-frame"></div>
              <div class="rate-indicator-bar">
                Weekdays: ₱ 4,000 / Weekends / Holiday: ₱ 5,000
              </div>
              <button type="submit" class="submit-booking-now">Book now</button>
            </div>
          </div>
        </form>
      </div>
    </main>
  </div>

  <script>
    const sidebar = document.getElementById('sidebar');
    const menuToggleBtn = document.getElementById('menuToggleBtn');

    if (menuToggleBtn && sidebar) {
        menuToggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
        });
    }

    const bookingForm = document.getElementById('bookingForm');
    const loaderOverlay = document.getElementById('loaderOverlay');

    if (bookingForm && loaderOverlay) {
        bookingForm.addEventListener('submit', function() {
            loaderOverlay.classList.add('show');
        });
    }
    
    function adjustCount(type, change) {

    const input = document.getElementById(type + '_count');
    if (!input) {
        return;
    }

    const MAX_PERSONS = 4;
    const adultInput = document.getElementById('adult_count');
    const childrenInput = document.getElementById('children_count');

    let adults = parseInt(adultInput.value) || 0;
    let children = parseInt(childrenInput.value) || 0;
    let totalPersons = adults + children;
    let currentValue = parseInt(input.value) || 0;

    if (change > 0 && totalPersons >= MAX_PERSONS) {
        alert("Maximum of " + MAX_PERSONS + " persons only.");
        return;
    }

    if (change < 0 && totalPersons <= 1) {
        alert("At least 1 guest is required.");
        return;
    }

    let updatedValue = currentValue + change;

    if (updatedValue < 0) {
        updatedValue = 0;
    }
    input.value = updatedValue;
    
    document.getElementById('adult_hidden').value = document.getElementById('adult_count').value;
    document.getElementById('children_hidden').value = document.getElementById('children_count').value;
}
    
  </script>
</body>
</html>