package LibraryBackendCode;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BooksCount")
public class BooksCount extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/library", "root", "Adishiv@7318");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM booksData");

            if (rs.next()) {
                count = rs.getInt(1);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(count));
    }
}
