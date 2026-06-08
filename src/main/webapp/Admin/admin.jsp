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
        
        button{
            background:#ff4d4d;
            color:white;
            border:none;
            padding:8px 14px;
            border-radius:6px;
            cursor:pointer;
        }

        button:hover{
            background:#cc0000;
        }
        
        input[type="text"]{
            outline:none;
            font-size:15px;
        }

        form{
            display:flex;
            gap:10px;
        }

    </style>

</head>
<body>
    <h1>Users Dashboard</h1>
    
    <form method="get" action="admin.jsp" style="margin-bottom:20px;">
        <input  type="hidden"
                name="bookingSearch"
                value="<%= request.getParameter("bookingSearch") != null ? request.getParameter("bookingSearch") : "" %>">
        <input type="text"
           name="search"
           placeholder="Search users..."
           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
           style="
                padding:10px;
                width:250px;
                border:none;
                border-radius:6px;
           ">

        <button type="submit" style="background-color: #04AA6D; color: white;">
            Search
        </button>
    </form>

    <table>

        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Created At</th>
            <th>Role</th>
            <th>Action </th>
        </tr>

<%
String search = request.getParameter("search");
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
    
    String sql;

    if(search != null && !search.trim().equals("")){

            sql = "SELECT id, username, fullname, email, created_at, role " +
              "FROM users " +
              "WHERE username LIKE ? " +
              "OR fullname LIKE ? " +
              "OR email LIKE ?"+
              "OR CAST(id AS CHAR) LIKE ?";
            
            
        pst = conn.prepareStatement(sql);

        String keyword = "%" + search + "%";

        pst.setString(1, keyword);
        pst.setString(2, keyword);
        pst.setString(3, keyword);
        pst.setString(4, keyword); 
    }
    else{
        sql = "SELECT id, username, fullname, email, created_at, role FROM users";
        pst = conn.prepareStatement(sql);
    }
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
            <td>
            <form action="adminuserdelete.jsp" method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <button type="submit" onclick="return confirm('Delete this user?')">
                    Delete
                </button>
            </form>
        </td>
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

<div style="
    display:inline-block;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(10px);
    border-radius:12px;
    padding:20px 35px;
    margin-bottom:20px;
    margin-top:50px;
">
    <div style="font-size:14px; color:rgba(255,255,255,0.6);">Total Customers Booked</div>
    <div style="font-size:36px; font-weight:bold;">
<%
    Connection countConn = null;
    PreparedStatement countPst = null;
    ResultSet countRs = null;
    int totalBookings = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        countConn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/olivia_db",
            "root",
            ""
        );
        countPst = countConn.prepareStatement("SELECT COUNT(*) FROM booking");
        countRs = countPst.executeQuery();
        if (countRs.next()) {
            totalBookings = countRs.getInt(1);
        }
    } catch(Exception e) {
        out.println(e);
    } finally {
        try { if (countRs != null) countRs.close(); } catch(Exception e) {}
        try { if (countPst != null) countPst.close(); } catch(Exception e) {}
        try { if (countConn != null) countConn.close(); } catch(Exception e) {}
    }
%>
        <%= totalBookings %>
    </div>
</div>

<h1 style="margin-top:50px;">Bookings</h1>

<form method="get" action="admin.jsp" style="margin-bottom:20px;">
    
    <input  type="hidden"
            name="search"
            value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    
    <input type="text"
           name="bookingSearch"
           placeholder="Search bookings..."
           value="<%= request.getParameter("bookingSearch") != null ? request.getParameter("bookingSearch") : "" %>"
           style="
                padding:10px;
                width:250px;
                border:none;
                border-radius:6px;
           ">

    <button type="submit" style="background-color: #04AA6D; color: white;">
        Search
    </button>

</form>

<table>
    <tr>
        <th>Booking ID</th>
        <th>User ID</th> 
        <th>Guest Name</th>
        <th>Email</th>
        <th>Room Type</th>
        <th>Adults</th>
        <th>Children</th>
        <th>Reserved Month</th>
        <th>Reserved Day</th>
        <th>Reserved Time</th>
        <th>Created At</th>
        <th>Action </th>
    </tr>

<%

String bookingSearch = request.getParameter("bookingSearch");
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

    String bookingSql;

    if(bookingSearch != null && !bookingSearch.trim().equals("")){
        bookingSql =
            "SELECT * FROM booking " +
            "WHERE guestname LIKE ? " +
            "OR email LIKE ? " +
            "OR room_type LIKE ? " +
            "OR reserved_month LIKE ? " +
            "OR reserved_day LIKE ?";

        bookingPst = bookingConn.prepareStatement(bookingSql);
    
        String keyword = "%" + bookingSearch + "%";
    
        bookingPst.setString(1, keyword);
        bookingPst.setString(2, keyword);
        bookingPst.setString(3, keyword);
        bookingPst.setString(4, keyword);
        bookingPst.setString(5, keyword);
    }
    else{
        bookingSql = "SELECT * FROM booking";
        bookingPst = bookingConn.prepareStatement(bookingSql);
    }
    
    
    bookingRs = bookingPst.executeQuery();
    while(bookingRs.next()){
%>
    <tr>
        <td><%= bookingRs.getInt("book_id") %></td>
        
        <td>
            <a  href="admin.jsp?search=<%= bookingRs.getInt("user_id") %>"
                style="color:#7dd3fc; text-decoration:underline; cursor:pointer;">
                <%= bookingRs.getInt("user_id") %>
            </a>
        </td>
        
        <td><%= bookingRs.getString("guestname") %></td>
        <td><%= bookingRs.getString("email") %></td>
        <td><%= bookingRs.getString("room_type") %></td>
        <td><%= bookingRs.getInt("adult_count") %></td>
        <td><%= bookingRs.getInt("children_count") %></td>
        <td><%= bookingRs.getString("reserved_month") %></td>
        <td><%= bookingRs.getString("reserved_day") %></td>
        <td><%= bookingRs.getString("reserved_time") %></td>
        <td><%= bookingRs.getString("created_at") %></td>
        <td>
            <form action="adminbookdelete.jsp" method="post">
            <input type="hidden" name="book_id" value="<%= bookingRs.getInt("book_id") %>">
                <button type="submit" onclick="return confirm('Delete this booking?')">
                    Delete
                </button>
            </form>
        </td>
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
