<% 
    if(!session.getAttributeNames().hasMoreElements()){
        String redirectURL = "login.jsp";                                                            
        response.sendRedirect(redirectURL);
    }else{
%>
<%-- 
    Document   : admin_addnew
    Created on : Nov 4, 2022, 10:37:18 AM
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
                                <a href="admin.jsp" class="d-flex align-items-center text-dark text-decoration-none">
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
                    <div class="col-6">
                        <h1>Add New Workshops</h1>
                    </div>
                    <div class="col-6 text-end">
                        <a type="button" class="btn btn-outline-info" href="admin.jsp">Back To List</a>
                    </div>
                </div>                        

                <div class="row justify-content-center pt-3">                
                    <div class="card col-8 p-0 m-0">
                        <div class="card-header text-bg-success">
                            <h2>Workshops Form</h2>
                        </div>

                        <div class="card-body">
<%
    int err = 0;
    String errText = "";
    if (request.getParameter("submit") != null) {
        String wrkInstructor = request.getParameter("wrkInstructor");
        String wrkName = request.getParameter("wrkName");
        String wrkNumOfSeats = request.getParameter("wrkNumOfSeats");
        String wrkTime = request.getParameter("wrkTime");
        
        if(wrkInstructor.trim().isEmpty()) { 
            err += 1;
            errText += "<li>The Instractor Name is requarid</li>";
        }
        if(wrkName.trim().isEmpty()) { 
            err += 1;
            errText += "<li>The workshop title is requarid</li>";
        }

        if(wrkNumOfSeats.trim().isEmpty()) { 
            err += 1;
            errText += "<li>The Number of seats is requarid</li>";
        }

        if(wrkTime.trim().isEmpty()) { 
            err += 1;
            errText += "<li>The workshop location and duration is requarid</li>";
        }
        
        if(err > 0) {
        %>
            <div class="alert alert-warning" role="alert">
                <strong>Please Check Your Entries!</strong>
              <ul><% out.print(errText); %></ul>
            </div>        
        <%
        }else{
            sqlQuery = "INSERT INTO `workshops` (`wrkId`, `wrkInstructor`, `wrkName`, `wrkNumOfSeats`, `wrkTime`) VALUES (NULL, '"+wrkInstructor+"', '"+wrkName+"', '"+ wrkNumOfSeats +"', '"+wrkTime+"');";
            try{
                preparedStmt = connection.prepareStatement(sqlQuery);
                preparedStmt.execute();
                %><div class="alert alert-success" role="alert">The Workshop information has been inserted successfully.</div><%
            }catch(SQLException e){
                %><div class="alert alert-danger" role="alert"><strong>An error occurred!</strong><br/><% out.print(e); %></div><%
            }
        }
    }    
%>

                        </div> 
                        <div class="card-body">
                            <form action="admin_addnew.jsp" method="post">
                                <div class="row mb-3">
                                    <label for="wrkInstructor" class="col-sm-3 col-form-label">Instructor Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="wrkInstructor" name="wrkInstructor">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label for="wrkName" class="col-sm-3 col-form-label">Workshop Title</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="wrkName" name="wrkName">
                                    </div>
                                </div>    
                                <div class="row mb-3">
                                    <label for="wrkNumOfSeats" class="col-sm-3 col-form-label">Number of Seats</label>
                                    <div class="col-sm-8">
                                        <input type="number" class="form-control" id="wrkNumOfSeats" name="wrkNumOfSeats" min="1" value="1">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="wrkTime" class="col-sm-3 col-form-label">Location & Duration</label>
                                    <div class="col-sm-8">
                                        <textarea class="form-control" id="wrkTime" name="wrkTime" rows="3"></textarea>
                                    </div>
                                </div>

                                <button type="submit" name="submit" value="submit" class="btn btn-primary">Submit</button>
                            </form>                
                        </div>                
                    </div>                
                </div>


                <footer class="pt-3 mt-4 text-muted border-top">
                    &copy; WORKSHOP GUIDE 2022
                </footer>
            </div>
        </main>        
    </body>
</html>                
<% } %>