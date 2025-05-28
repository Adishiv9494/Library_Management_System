package LibraryBackendCode;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/BookRecordsServlet")
public class BookRecordsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/library";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Adishiv@7318";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Get pagination and search parameters
            int page = Integer.parseInt(request.getParameter("page"));
            int limit = Integer.parseInt(request.getParameter("limit"));
            String search = request.getParameter("search");
            
            // Build base query
            String baseQuery = "SELECT accession_number, book_name, author, publisher, edition, price FROM booksData";
            String countQuery = "SELECT COUNT(*) AS total FROM booksData";
            
            // Add search condition if provided
            if (search != null && !search.isEmpty()) {
                String searchCondition = " WHERE book_name LIKE ? OR author LIKE ? OR publisher LIKE ? OR accession_number LIKE ?";
                baseQuery += searchCondition;
                countQuery += searchCondition;
            }
            
            // Add sorting and pagination
            baseQuery += " ORDER BY book_name LIMIT ? OFFSET ?";
            
            // First get total count
            int totalRecords = 0;
            PreparedStatement countStmt = conn.prepareStatement(countQuery);
            if (search != null && !search.isEmpty()) {
                String searchParam = "%" + search + "%";
                countStmt.setString(1, searchParam);
                countStmt.setString(2, searchParam);
                countStmt.setString(3, searchParam);
                countStmt.setString(4, searchParam);
            }
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt("total");
            }
            countRs.close();
            countStmt.close();
            
            // Then get paginated data
            stmt = conn.prepareStatement(baseQuery);
            int paramIndex = 1;
            if (search != null && !search.isEmpty()) {
                String searchParam = "%" + search + "%";
                stmt.setString(paramIndex++, searchParam);
                stmt.setString(paramIndex++, searchParam);
                stmt.setString(paramIndex++, searchParam);
                stmt.setString(paramIndex++, searchParam);
            }
            stmt.setInt(paramIndex++, limit);
            stmt.setInt(paramIndex++, (page - 1) * limit);
            
            rs = stmt.executeQuery();
            
            JSONObject result = new JSONObject();
            result.put("totalRecords", totalRecords);
            
            JSONArray books = new JSONArray();
            while (rs.next()) {
                JSONObject book = new JSONObject();
                book.put("accession_number", rs.getInt("accession_number"));
                book.put("book_name", rs.getString("book_name"));
                book.put("author", rs.getString("author"));
                book.put("publisher", rs.getString("publisher"));
                book.put("edition", rs.getString("edition"));
                book.put("price", rs.getDouble("price"));
                books.put(book);
            }
            
            result.put("data", books);
            response.getWriter().write(result.toString());
            
        } catch (ClassNotFoundException e) {
            sendError(response, "Database driver not found");
        } catch (SQLException e) {
            sendError(response, "Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            sendError(response, "Invalid pagination parameters");
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    private void sendError(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        JSONObject error = new JSONObject();
        error.put("error", message);
        response.getWriter().write(error.toString());
    }
    
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}