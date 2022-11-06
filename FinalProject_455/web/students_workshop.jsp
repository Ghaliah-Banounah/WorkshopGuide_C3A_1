<% 
    if(!session.getAttributeNames().hasMoreElements()){
        String redirectURL = "login.jsp";                                                            
        response.sendRedirect(redirectURL);
    }else{
%>

<%-- 
    Document   : students
    Created on : Nov 3, 2022, 10:55:03 PM
    Author     : afnan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.*" %>

<%
    String URL = "jdbc:mysql://localhost:3306/WorkshopGuide_CA3_1?useSSL=false";
    String USERNAME= "root"; // use your username of Mysql server
    String PASSWORD ="root"; // use your password of Mysql server
    Connection connection = null;
    PreparedStatement preparedStmt = null;
    ResultSet resultSet = null;
    String sqlQuery = "";   
    String redirectURL;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
    }catch (SQLException se) {
        %><div class="alert alert-danger" role="alert"><strong>An error occurred!</strong><br/><% out.print(se); %></div><%
    }
%>
        
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WORKSHOP GUIDE</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    </head>
    <body>
        <main>
            <div class="container py-4">
                <header class="pb-3 mb-4 border-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-6">
                                <a href="students.jsp" class="d-flex align-items-center text-dark text-decoration-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" class="me-2" viewBox="0 0 118 94" role="img"><title>Bootstrap</title><path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z" fill="currentColor"></path></svg>
                                    <span class="fs-4">WORKSHOP GUIDE</span>
                                </a>
                            </div>
                            
                            <div class="col-4 text-end">
                                <strong>WELCOME <span class="text-primary"><% out.println(session.getAttribute("usrName").toString().toUpperCase()); %></span></strong>
                            </div>
                            <div class="col-2 text-end">
                                <a type="button" class="btn btn-outline-dark" href="logout.jsp">Sign Out</a>
                            </div>
                        </div>
                    </div>
              
                </header>
                <div class="row">
                    <div class="col-8">
                        <h1>Registered Workshops</h1>
                    </div>
                    <div class="col-4 text-end">
                        <a type="button" class="btn btn-outline-info" href="students.jsp">Back To List</a>
                    </div>
                </div>
<%
    if (request.getParameter("usrworkId") != null) {
        String usrworkId = request.getParameter("usrworkId");
        sqlQuery = "DELETE FROM users_workshop WHERE `users_workshop`.`usrworkId` = '"+ usrworkId +"'";
        try{
            preparedStmt = connection.prepareStatement(sqlQuery);
            preparedStmt.execute();
            %><div class="alert alert-success" role="alert">The workshop registration canceled successfully.</div><%
        }catch(SQLException e){
            %><div class="alert alert-danger" role="alert"><strong>An error occurred!</strong><br/><% out.print(e); %></div><%
        }
    }
%>
                            
<table class="table table-striped table-hover">

  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Instructor</th>
      <th scope="col">Workshop Title</th>
      <th scope="col">Duration</th>
      <th scope="col">Registration ID</th>
      <th scope="col">Registration Date</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
<%
    String usrId = session.getAttribute("usrId").toString();
    sqlQuery = "SELECT * FROM `users_workshop` JOIN workshops ON (workshops.wrkId = users_workshop.wrkId) WHERE users_workshop.usrId = '"+ usrId +"' ORDER BY users_workshop.usrwrkRegDate DESC;";
    try{
        preparedStmt = connection.prepareStatement(sqlQuery);
        resultSet = preparedStmt.executeQuery();
        int rowcount = 0;
        while (resultSet.next()){ rowcount++; %>
            <tr>
              <th scope="row"><% out.print(resultSet.getString("wrkId")); %></th>
              <td><% out.print(resultSet.getString("wrkInstructor")); %></td>
              <td><% out.print(resultSet.getString("wrkName")); %></td>
              <td><% out.print(resultSet.getString("wrkTime")); %></td>
              <td class="table-success"><% out.print(resultSet.getString("usrworkId")); %></td>
              <td class="table-success"><% out.print(resultSet.getString("usrwrkRegDate")); %></td>
              <td>
                <a type="button" class="btn btn-sm btn-danger" href="students_workshop.jsp?usrworkId=<% out.print(resultSet.getString("usrworkId")); %>">Cancel</a>
              </td>                   
            </tr>        
            <% 
        }
        if(rowcount == 0) { %>
            <div class="alert alert-primary d-flex align-items-center" role="alert">
              <div>
                No registered courses or training found!
              </div>
            </div>        
        <% }
        resultSet.close();
    }catch(SQLException e){
        out.print("e " + e);
    }
%>    
  </tbody>
</table>
                
                

                <footer class="pt-3 mt-4 text-muted border-top">
                    &copy; WORKSHOP GUIDE 2022
                </footer>
            </div>
        </main>        
    </body>
</html>
<% } %> 