package LibraryBackendCode;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/ViewAllIssuedBook")
public class ViewAllIssuedBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Initialize variables
        int page = 1;
        int limit = 10;
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        int days = 0;
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // Use default value
        }
        
        try {
            limit = Integer.parseInt(request.getParameter("limit"));
        } catch (NumberFormatException e) {
            // Use default value
        }
        
        try {
            days = Integer.parseInt(request.getParameter("days"));
        } catch (NumberFormatException e) {
            // Use default value
        }
        
        int offset = (page - 1) * limit;
        Map<String, Object> responseData = new HashMap<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PreparedStatement countStmt = null;
        ResultSet countRs = null;
        
        try {
            // Get database connection
            conn = DBUtil.getConnection();
            if (conn == null || conn.isClosed()) {
                responseData.put("error", "Database connection failed");
                sendJsonResponse(response, responseData);
                return;
            }
            
            // Build main query
            StringBuilder sql = new StringBuilder(
                "SELECT issue_id, crn, student_name, contact, course, accession_number, " +
                "book_title, author, edition, issue_date, due_date, return_date, " +
                "fine_amount, status, remarks FROM book_issues WHERE 1=1"
            );
            
            // Add search condition if provided
            if (search != null && !search.trim().isEmpty()) {
                sql.append(" AND (crn LIKE ? OR student_name LIKE ? OR book_title LIKE ? OR accession_number LIKE ?)");
            }
            
            // Add status filter if provided
            if (status != null && !status.trim().isEmpty()) {
                sql.append(" AND status = ?");
            }
            
            // Add date range filter
            if (days > 0) {
                sql.append(" AND issue_date >= DATE_SUB(CURRENT_DATE, INTERVAL ? DAY)");
            } else if (dateFrom != null && !dateFrom.trim().isEmpty() && dateTo != null && !dateTo.trim().isEmpty()) {
                sql.append(" AND issue_date BETWEEN ? AND ?");
            } else if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                sql.append(" AND issue_date >= ?");
            } else if (dateTo != null && !dateTo.trim().isEmpty()) {
                sql.append(" AND issue_date <= ?");
            }
            
            // Add sorting and pagination
            sql.append(" ORDER BY issue_date DESC, due_date ASC LIMIT ? OFFSET ?");
            
            pstmt = conn.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            
            // Set search parameters
            if (search != null && !search.trim().isEmpty()) {
                String searchParam = "%" + search + "%";
                pstmt.setString(paramIndex++, searchParam);
                pstmt.setString(paramIndex++, searchParam);
                pstmt.setString(paramIndex++, searchParam);
                pstmt.setString(paramIndex++, searchParam);
            }
            
            // Set status parameter
            if (status != null && !status.trim().isEmpty()) {
                pstmt.setString(paramIndex++, status);
            }
            
            // Set date range parameters
            if (days > 0) {
                pstmt.setInt(paramIndex++, days);
            } else if (dateFrom != null && !dateFrom.trim().isEmpty() && dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setString(paramIndex++, dateFrom);
                pstmt.setString(paramIndex++, dateTo);
            } else if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                pstmt.setString(paramIndex++, dateFrom);
            } else if (dateTo != null && !dateTo.trim().isEmpty()) {
                pstmt.setString(paramIndex++, dateTo);
            }
            
            // Set pagination parameters
            pstmt.setInt(paramIndex++, limit);
            pstmt.setInt(paramIndex, offset);
            
            rs = pstmt.executeQuery();
            
            List<Map<String, Object>> issues = new ArrayList<>();
            
            while (rs.next()) {
                Map<String, Object> issue = new HashMap<>();
                issue.put("issue_id", rs.getInt("issue_id"));
                issue.put("crn", rs.getString("crn"));
                issue.put("student_name", rs.getString("student_name"));
                issue.put("contact", rs.getString("contact"));
                issue.put("course", rs.getString("course"));
                issue.put("accession_number", rs.getInt("accession_number"));
                issue.put("book_title", rs.getString("book_title"));
                issue.put("author", rs.getString("author"));
                issue.put("edition", rs.getString("edition"));
                issue.put("issue_date", rs.getDate("issue_date") != null ? rs.getDate("issue_date").toString() : null);
                issue.put("due_date", rs.getDate("due_date") != null ? rs.getDate("due_date").toString() : null);
                issue.put("return_date", rs.getDate("return_date") != null ? rs.getDate("return_date").toString() : null);
                issue.put("fine_amount", rs.getDouble("fine_amount"));
                issue.put("status", rs.getString("status"));
                issue.put("remarks", rs.getString("remarks"));
                
                issues.add(issue);
            }
            
            // Build count query
            StringBuilder countSql = new StringBuilder(
                "SELECT COUNT(*) AS total FROM book_issues WHERE 1=1"
            );
            
            if (search != null && !search.trim().isEmpty()) {
                countSql.append(" AND (crn LIKE ? OR student_name LIKE ? OR book_title LIKE ? OR accession_number LIKE ?)");
            }
            
            if (status != null && !status.trim().isEmpty()) {
                countSql.append(" AND status = ?");
            }
            
            if (days > 0) {
                countSql.append(" AND issue_date >= DATE_SUB(CURRENT_DATE, INTERVAL ? DAY)");
            } else if (dateFrom != null && !dateFrom.trim().isEmpty() && dateTo != null && !dateTo.trim().isEmpty()) {
                countSql.append(" AND issue_date BETWEEN ? AND ?");
            } else if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                countSql.append(" AND issue_date >= ?");
            } else if (dateTo != null && !dateTo.trim().isEmpty()) {
                countSql.append(" AND issue_date <= ?");
            }
            
            countStmt = conn.prepareStatement(countSql.toString());
            
            paramIndex = 1;
            
            if (search != null && !search.trim().isEmpty()) {
                String searchParam = "%" + search + "%";
                countStmt.setString(paramIndex++, searchParam);
                countStmt.setString(paramIndex++, searchParam);
                countStmt.setString(paramIndex++, searchParam);
                countStmt.setString(paramIndex++, searchParam);
            }
            
            if (status != null && !status.trim().isEmpty()) {
                countStmt.setString(paramIndex++, status);
            }
            
            if (days > 0) {
                countStmt.setInt(paramIndex++, days);
            } else if (dateFrom != null && !dateFrom.trim().isEmpty() && dateTo != null && !dateTo.trim().isEmpty()) {
                countStmt.setString(paramIndex++, dateFrom);
                countStmt.setString(paramIndex++, dateTo);
            } else if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                countStmt.setString(paramIndex++, dateFrom);
            } else if (dateTo != null && !dateTo.trim().isEmpty()) {
                countStmt.setString(paramIndex++, dateTo);
            }
            
            countRs = countStmt.executeQuery();
            
            int totalRecords = 0;
            if (countRs.next()) {
                totalRecords = countRs.getInt("total");
            }
            
            responseData.put("data", issues);
            responseData.put("totalRecords", totalRecords);
            
        } catch (SQLException e) {
            responseData.put("error", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources safely
            closeResources(rs, pstmt, countRs, countStmt, conn);
        }
        
        sendJsonResponse(response, responseData);
    }
    
    private void closeResources(ResultSet rs, PreparedStatement stmt, 
                              ResultSet countRs, PreparedStatement countStmt, 
                              Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try {
            if (countRs != null) countRs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try {
            if (countStmt != null) countStmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> responseData) 
            throws IOException {
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        String jsonResponse = gson.toJson(responseData);
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
}