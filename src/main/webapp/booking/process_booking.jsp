<%-- 
    Document   : process_booking
    Created on : Jun 7, 2026, 8:16:39 AM
    Author     : AynYreve
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed</title>
    <link rel="icon" type="image/x-icon" href="../Assets/favicon.png">

    <style>

    body{
        margin:0;
        padding:0;

        font-family: Arial, sans-serif;

        background:
            linear-gradient(
                135deg,
                #0f2027,
                #203a43,
                #2c5364
            );

        height:100vh;

        display:flex;
        justify-content:center;
        align-items:center;
    }

    .confirmation-box{

        background: rgba(255,255,255,0.12);

        backdrop-filter: blur(12px);

        border:1px solid rgba(255,255,255,0.2);

        border-radius:16px;

        padding:40px;

        width:420px;

        text-align:center;

        color:white;

        box-shadow:0 8px 30px rgba(0,0,0,0.25);
    }

    .confirmation-box h1{
        font-size:32px;
        margin-bottom:15px;
    }

    .confirmation-box p{
        font-size:16px;
        margin:10px 0;
        color:#f1f1f1;
    }

    .confirmation-box a{

        display:inline-block;

        margin-top:20px;

        padding:12px 24px;

        border-radius:8px;

        background:white;

        color:black;

        text-decoration:none;

        font-weight:bold;

        transition:0.3s;
    }

    .confirmation-box a:hover{
        transform:scale(1.05);
    }

</style>

</head>
<body>

    <div class="confirmation-box">

        <h1>Booking Confirmed!</h1>

        <p>Your reservation has been successfully processed.</p>

        <p>Thank you for choosing Olivia's.</p>

        <a href="/OliviaEvent/home.jsp">
            Return Home
        </a>

    </div>

</body>
</html>
