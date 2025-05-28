package LibraryBackendCode;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/PendingFineServlet")
public class PendingFineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database connection parameters
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/library";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Adishiv@7318";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Set up database connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            // SQL query to get students with pending fines (OVERDUE or DEFAULTER status)
            String sql = "SELECT crn, student_name as name, contact, issue_date, due_date, " +
                         "SUM(fine_amount) as total_fine, " +
                         "CASE " +
                         "  WHEN MAX(status) = 'DEFAULTER' THEN 'DEFAULTER' " +
                         "  WHEN MAX(status) = 'OVERDUE' THEN 'OVERDUE' " +
                         "  ELSE 'PENDING' " +
                         "END as status " +
                         "FROM book_issues " +
                         "WHERE status IN ('OVERDUE', 'DEFAULTER', 'PENDING') AND fine_amount > 0 " +
                         "GROUP BY crn, student_name, contact, issue_date, due_date " +
                         "ORDER BY total_fine DESC";
            
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            // Process results
            List<StudentFine> studentFines = new ArrayList<>();
            while (rs.next()) {
                StudentFine student = new StudentFine();
                student.setCrn(rs.getString("crn"));
                student.setName(rs.getString("name"));
                student.setContact(rs.getString("contact"));
                student.setIssueDate(rs.getDate("issue_date").toString());
                student.setDueDate(rs.getDate("due_date").toString());
                student.setTotalFine(rs.getDouble("total_fine"));
                student.setStatus(rs.getString("status"));
                
                studentFines.add(student);
            }
            
            // Prepare JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(new Response(true, "Data retrieved successfully", studentFines));
            response.getWriter().write(jsonResponse);
            
        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(response, "Database error: " + e.getMessage());
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(new Response(false, message, null)));
    }
    
    // Helper classes for JSON response
    class Response {
        boolean success;
        String message;
        List<StudentFine> data;
        
        public Response(boolean success, String message, List<StudentFine> data) {
            this.success = success;
            this.message = message;
            this.data = data;
        }
    }
    
    class StudentFine {
        private String crn;
        private String name;
        private String contact;
        private String issueDate;
        private String dueDate;
        private double totalFine;
        private String status;
        
        // Getters and setters
        public String getCrn() { return crn; }
        public void setCrn(String crn) { this.crn = crn; }
        
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        
        public String getContact() { return contact; }
        public void setContact(String contact) { this.contact = contact; }
        
        public String getIssueDate() { return issueDate; }
        public void setIssueDate(String issueDate) { this.issueDate = issueDate; }
        
        public String getDueDate() { return dueDate; }
        public void setDueDate(String dueDate) { this.dueDate = dueDate; }
        
        public double getTotalFine() { return totalFine; }
        public void setTotalFine(double totalFine) { this.totalFine = totalFine; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
}