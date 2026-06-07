<%-- 
    Document   : admin
    Created on : Jun 7, 2026, 10:31:18 AM
    Author     : AynYreve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){

    response.sendRedirect("../book.jsp");
    return;

}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
            <link rel="icon" type="image/x-icon" href="../Endmin.jpg">

    <style>

        body{
            font-family: Arial, sans-serif;
            margin:0;
            padding:40px;

            background:
            linear-gradient(
                135deg,
                #0f2027,
                #203a43,
                #2c5364
            );

            color:white;
        }

        h1{
            margin-bottom:25px;
        }

        table{
            width:100%;
            border-collapse:collapse;

            background:rgba(255,255,255,0.08);

            backdrop-filter:blur(10px);

            border-radius:12px;

            overflow:hidden;
        }

        th{
            background:rgba(255,255,255,0.15);
        }

        th, td{
            padding:15px;
            text-align:left;
            border-bottom:1px solid rgba(255,255,255,0.1);
        }

        tr:hover{
            background:rgba(255,255,255,0.05);
        }

    </style>

</head>
<body>

    <h1>Admin Dashboard</h1>

    <table>

        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Created At</th>
            <th>Role</th>
        </tr>

<%

Connection conn = null;
PreparedStatement pst = null;
ResultSet rs = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/olivia_db",
        "root",
        ""
    );

    String sql = "SELECT id, username, fullname, email, created_at, role FROM users";

    pst = conn.prepareStatement(sql);

    rs = pst.executeQuery();

    while(rs.next()){

%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("fullname") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("created_at") %></td>
            <td><%= rs.getString("role") %></td>
        </tr>
<%

    }

}
catch(Exception e){

    out.println(e);

}
finally{

    try{
        if(rs != null) rs.close();
    }catch(Exception e){}

    try{
        if(pst != null) pst.close();
    }catch(Exception e){}

    try{
        if(conn != null) conn.close();
    }catch(Exception e){}
}

%>

    </table>

<h1 style="margin-top:50px;">Bookings</h1>

<table>
    <tr>
        <th>Booking ID</th>
        <th>Guest Name</th>
        <th>Email</th>
        <th>Room Type</th>
        <th>Adults</th>
        <th>Children</th>
        <th>Reserved Month</th>
        <th>Reserved Day</th>
        <th>Reserved Time</th>
        <th>Created At</th>
    </tr>

<%

Connection bookingConn = null;
PreparedStatement bookingPst = null;
ResultSet bookingRs = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    bookingConn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/olivia_db",
        "root",
        ""
    );

    String bookingSql = "SELECT * FROM booking";
    bookingPst = bookingConn.prepareStatement(bookingSql);
    bookingRs = bookingPst.executeQuery();
    while(bookingRs.next()){
%>
    <tr>
        <td><%= bookingRs.getInt("book_id") %></td>
        <td><%= bookingRs.getString("guestname") %></td>
        <td><%= bookingRs.getString("email") %></td>
        <td><%= bookingRs.getString("room_type") %></td>
        <td><%= bookingRs.getInt("adult_count") %></td>
        <td><%= bookingRs.getInt("children_count") %></td>
        <td><%= bookingRs.getString("reserved_month") %></td>
        <td><%= bookingRs.getString("reserved_day") %></td>
        <td><%= bookingRs.getString("reserved_time") %></td>
        <td><%= bookingRs.getString("created_at") %></td>
    </tr>

<%

    }

}
catch(Exception e){

    out.println(e);

}
finally{

    try{
        if(bookingRs != null) bookingRs.close();
    }catch(Exception e){}

    try{
        if(bookingPst != null) bookingPst.close();
    }catch(Exception e){}

    try{
        if(bookingConn != null) bookingConn.close();
    }catch(Exception e){}
}

%>

</table>

</body>
</html>

