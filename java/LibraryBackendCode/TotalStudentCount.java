package LibraryBackendCode;




import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/TotalStudentCount")

public class TotalStudentCount extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int total = 0;
        String[] tables = {"BBA_students", "BCA_students", "MBA_students", "MCA_students", "PTech_students", "BTech_students"};

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "Adishiv@7318");

            for (String table : tables) {
                PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM " + table);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    total += rs.getInt(1);
                }
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(total));
    }
}
