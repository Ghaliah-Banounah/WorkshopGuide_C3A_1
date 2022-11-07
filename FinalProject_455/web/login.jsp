<%-- 
    Document   : login
    Created on : Nov 3, 2022, 9:43:37 PM
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
                    <a href="login.jsp" class="d-flex align-items-center text-dark text-decoration-none">
                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" class="me-2" viewBox="0 0 118 94" role="img"><title>Bootstrap</title><path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z" fill="currentColor"></path></svg>
                        <span class="fs-4">WORKSHOP GUIDE</span>
                    </a>
                </header>

                <div class="p-5 mb-4 bg-light rounded-3" style="background-image: url('img/background_001.jpg')">
                    <div class="container-fluid py-5">
                        <h1 class="display-5 fw-bold text-light" style="text-shadow: 1px 1px #000;">WORKSHOP GUIDE</h1>
                        <p class="col-md-10 fs-4 text-light" style="text-shadow: 1px 1px #000;">Workshops are defined as an educational program designed to familiarize participants with practical skills, techniques, and ideas that belong to a specific area</p>
                       

                    </div>
                </div>




                <div class="container text-center">
                    <div class="row justify-content-center">
                        <div class="col-6 align-self-center">
                            <div class="h-100 p-5 bg-light border rounded-3">
                                <h2>Sign In</h2>
                                <%
                                    if (request.getParameter("submit") != null) {

                                        String username = request.getParameter("userId");
                                        String password = request.getParameter("usrPassword");

                                        if (username.trim().isEmpty() == false && username.length() > 1 && password.trim().isEmpty() == false && password.length() >= 3) {
                                        sqlQuery = "SELECT * FROM `users` WHERE `usrId` LIKE '"+ username +"' AND `usrPassword` LIKE '"+ password +"'";
                                                    try{
                                                        preparedStmt = connection.prepareStatement(sqlQuery);
                                                        resultSet = preparedStmt.executeQuery();
                                                        //out.print("I Have Executed");
                                                        if(resultSet.next()){
                                                            session.setAttribute("usrId",resultSet.getString("usrId"));
                                                            session.setAttribute("usrName",resultSet.getString("usrName"));
                                                            session.setAttribute("usrType",resultSet.getString("usrType"));
                                                            session.setAttribute("usrMobile",resultSet.getString("usrMobile"));
                                                            //out.print("You Are Authorized User ::");
                                                            int usrType = Integer.parseInt(resultSet.getString("usrType")) ;
                                                            //out.print(usrType);
                                                            if(usrType == 1) {
                                                                redirectURL = "admin.jsp";
                                                            }else{
                                                                redirectURL = "students.jsp";                                                            
                                                            }
                                                            response.sendRedirect(redirectURL);
                                                        }else{
                                                        %>
                                                        <div class="alert alert-warning" role="alert">You Are Unauthorized User !</div>
                                                        <%
                                                        }
                                                    }catch(SQLException e){
                                                        out.print("e " + e);
                                                    }
                                         } else { 
                                %>
                                        <div class="alert alert-danger" role="alert">Please Enter Correct Data  !!</div>
                                <%      
                                } }   
                                %>
                                <form action="login.jsp" method="post">
                                    <div class="mb-3 row">
                                        <label for="userId" class="col-sm-2 col-form-label">ID</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="userId" name="userId" placeholder="Identification Number" min="99999"  />
                                        </div>
                                    </div>

                                    <div class="mb-3 row">
                                        <label for="usrPassword" class="col-sm-2 col-form-label">Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" id="usrPassword" name="usrPassword" placeholder="Password" minlength="3" maxlength="10" />
                                        </div>
                                    </div>
                                    <div class="d-grid gap-2 col-6 mx-auto">
                                        <button class="btn btn-outline-success flot-right" name="submit" value="submit" type="submit">Sign In</button>
                                    </div>
                                </form>
                            </div>
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
