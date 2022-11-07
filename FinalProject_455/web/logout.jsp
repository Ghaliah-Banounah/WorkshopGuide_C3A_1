<%-- 
    Document   : logout
    Created on : Nov 5, 2022, 6:12:09 PM
    Author     : afnan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    session.invalidate();
    String redirectURL = "login.jsp";
    response.sendRedirect(redirectURL);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Logout Page</title>
    </head>
    <body>
        
    </body>
</html>
