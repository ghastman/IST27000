<%@ page import="java.io.*, java.net.*, org.json.*" %>

<%

//fake path
String dbPath = "/E:/Library/School/IST 270/github/IST27000/database/mydatabase.db";
Connection connection = null;

try {
    Class.forName("org.sqlite.JDBC");
    connection = DriverManager.getConnection("jdbc:sqlite:" + dbPath);
    out.println("Database connection established successfully.");
} catch (Exception e) {
    out.println("Error connecting to the database: " + e.getMessage());
} finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
            out.println("Error closing the database connection: " + e.getMessage());
        }
    }
}


%>