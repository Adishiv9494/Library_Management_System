package LibraryBackendCode;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/ViewIssuedBooks")
public class ViewIssuedBooks extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/library";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Adishiv@7318";
    private static final int FINE_PER_WEEK = 50;
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            getIssuedBooksWithStatus(response);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("success", false);
            errorResponse.put("message", "Error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(errorResponse.toString());
        }
    }

    private void getIssuedBooksWithStatus(HttpServletResponse response) throws SQLException, IOException {
        List<Map<String, Object>> issuedBooks = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if (conn == null || conn.isClosed()) {
                throw new SQLException("Failed to connect to database");
            }
            
            // Update statuses before fetching
            updateBookStatuses(conn);
            
            // Fetch records excluding SUBMITTED and DEFAULTER status
            String query = "SELECT issue_id, crn, student_name, contact, course, " +
                         "accession_number, book_title, author, edition, " +
                         "issue_date, due_date, status " +
                         "FROM book_issues WHERE status NOT IN ('RETURNED', 'DEFAULTER') " +
                         "ORDER BY issue_date DESC";
            
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                
                while (rs.next()) {
                    Map<String, Object> book = new HashMap<>();
                    book.put("issueId", rs.getInt("issue_id"));
                    book.put("crn", rs.getString("crn"));
                    book.put("studentName", rs.getString("student_name"));
                    book.put("contact", rs.getString("contact"));
                    book.put("course", rs.getString("course"));
                    book.put("accessionNumber", rs.getInt("accession_number"));
                    book.put("bookTitle", rs.getString("book_title"));
                    book.put("author", rs.getString("author"));
                    book.put("edition", rs.getString("edition"));
                    book.put("issueDate", rs.getDate("issue_date") != null ? 
                        DATE_FORMAT.format(rs.getDate("issue_date")) : null);
                    book.put("dueDate", rs.getDate("due_date") != null ? 
                        DATE_FORMAT.format(rs.getDate("due_date")) : null);
                    book.put("status", rs.getString("status"));
                    
                    issuedBooks.add(book);
                }
            }
        }
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("data", new JSONArray(issuedBooks));
        response.getWriter().write(jsonResponse.toString());
    }

    private void updateBookStatuses(Connection conn) throws SQLException {
        Date currentDate = new Date();
        String updateQuery = "UPDATE book_issues SET status = ? WHERE issue_id = ?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(
                "SELECT issue_id, due_date, return_date, status FROM book_issues WHERE status NOT IN ('SUBMITTED', 'DEFAULTER')");
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                int issueId = rs.getInt("issue_id");
                Date dueDate = rs.getDate("due_date");
                Date returnDate = rs.getDate("return_date");
                String currentStatus = rs.getString("status");
                
                if (returnDate == null && dueDate != null && currentDate.after(dueDate)) {
                    long diffInMillies = currentDate.getTime() - dueDate.getTime();
                    long diffInDays = diffInMillies / (1000 * 60 * 60 * 24);
                    
                    String newStatus = diffInDays > 14 ? "DEFAULTER" : "OVERDUE";
                    
                    if (!newStatus.equals(currentStatus)) {
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, newStatus);
                            updateStmt.setInt(2, issueId);
                            updateStmt.executeUpdate();
                        }
                    }
                } else if (returnDate == null && (currentStatus == null || currentStatus.equals("PENDING"))) {
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, "PENDING");
                        updateStmt.setInt(2, issueId);
                        updateStmt.executeUpdate();
                    }
                }
            }
        }
    }
}