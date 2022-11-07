package DB;

/**
 *
 * @author Ghali
 */
import java.sql.*;

public class DBConnection {

    String serverURL = "jdbc:mysql://localhost:3306/workshopguide?useSSL=false";
    String username = "root";
    String pass = "gali_7173";
    Connection con = null;
    PreparedStatement prepStmt = null;
    ResultSet resSet = null;
    String SQLquery = "";

    public DBConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(serverURL, username, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public ResultSet getInfoStudents() {
        SQLquery = "SELECT * FROM kaustudents;";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    
    public ResultSet getInfoWorkshops() {
        SQLquery = "SELECT * FROM workshops;";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    
    public ResultSet getInfoInstructers() {
        SQLquery = "SELECT * FROM instructors;";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    
    public ResultSet getStudentById(int id) {
        SQLquery = "SELECT * FROM  kaustudents"
                + "WHERE ID = " + id + ";";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    
    public ResultSet getInstructorById(int id) {
        SQLquery = "SELECT * FROM  instructors"
                + "WHERE Id = " + id + ";";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    public ResultSet getWorkshopByName(String name) {
        SQLquery = "SELECT * FROM  workshops"
                + "WHERE Id = '" + name + "';";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }
    
    public ResultSet getWorkshopByInstructor(String instrucotr) {
        SQLquery = "SELECT * FROM  workshops"
                + "WHERE Id = '" + instrucotr + "';";
        try {
            prepStmt = con.prepareStatement(SQLquery);
            resSet = prepStmt.executeQuery();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return resSet;
    }

    public int addStudent(int ID, String Name, String email, String pass, String phone) {
        SQLquery = "INSERT INTO kaustudents(ID, Name, Email, Password, Phone)"
                + "VALUES(" + ID + ",'" + Name + "', '" + email + "', '" + pass + "', '" + phone + "');";
        int i = 0;
        try {
            Statement stmt = con.createStatement();
            i = stmt.executeUpdate(SQLquery);
        } catch (SQLException e) {
            System.out.print(e);
        }
        return i;
    }
    
    public int addInstructor(int ID, String Name, String email, String pass) {
        SQLquery = "INSERT INTO instructors(ID, Name, Email, Password)"
                + "VALUES(" + ID + ",'" + Name + "', '" + email + "', '" + pass + "');";
        int i = 0;
        try {
            Statement stmt = con.createStatement();
            i = stmt.executeUpdate(SQLquery);
        } catch (SQLException e) {
            System.out.print(e);
        }
        return i;
    }
    
    public int addWorkshop(int instructor, String Name, int numberOfSeats, String time) {
        SQLquery = "INSERT INTO instructors(Instructor, Workshopname, NumberOfSeats, Time)"
                + "VALUES('" + instructor + "','" + Name + "', " + numberOfSeats + ",'" + time + "');";
        int i = 0;
        try {
            Statement stmt = con.createStatement();
            i = stmt.executeUpdate(SQLquery);
        } catch (SQLException e) {
            System.out.print(e);
        }
        return i;
    }

}
