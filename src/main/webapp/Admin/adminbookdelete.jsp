<%-- 
    Document   : adminbookdelete
    Created on : Jun 8, 2026, 5:38:22 AM
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
    </head>
    <body>

<%

String bookId = request.getParameter("book_id");

Connection conn = null;
PreparedStatement pst = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/olivia_db",
        "root",
        ""
    );

    String sql = "DELETE FROM booking WHERE book_id = ?";

    pst = conn.prepareStatement(sql);

    pst.setInt(1, Integer.parseInt(bookId));

    pst.executeUpdate();

    response.sendRedirect("admin.jsp");

}
catch(Exception e){

    out.println(e);

}
finally{

    try{
        if(pst != null) pst.close();
    }catch(Exception e){}

    try{
        if(conn != null) conn.close();
    }catch(Exception e){}
}

%>
    </body>
</html>
