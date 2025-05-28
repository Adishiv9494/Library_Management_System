// IssuesBooksCount.java - Updated to count actually issued books (not pending)
package LibraryBackendCode;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/IssuesBooksCount")
public class IssuesBooksCount extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int count = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/library", "root", "Adishiv@7318");

            // Changed to count actually issued books (not pending)
            String sql = "SELECT COUNT(*) FROM book_issues WHERE status = 'ISSUED'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

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