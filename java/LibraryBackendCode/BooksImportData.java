package LibraryBackendCode;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

@WebServlet("/BooksImportData")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class BooksImportData extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Database configuration
        String dbURL = "jdbc:mysql://localhost:3306/library";
        String dbUser = "root";
        String dbPassword = "Adishiv@7318";
        
        // Initialize counters
        int totalRecords = 0;
        int insertedCount = 0;
        int updatedCount = 0;
        int failedCount = 0;
        List<String> errorMessages = new ArrayList<>();
        
        // Get the uploaded file
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        
        // Validate file type
        if (!fileName.toLowerCase().endsWith(".xlsx") && !fileName.toLowerCase().endsWith(".xls")) {
            sendJsonResponse(response, false, "Invalid file type. Only Excel files (.xlsx, .xls) are allowed.", 
                    0, 0, 0, 0);
            return;
        }
        
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             InputStream fileContent = filePart.getInputStream();
             XSSFWorkbook workbook = new XSSFWorkbook(fileContent)) {
            
            // Prepare statements
            String checkSql = "SELECT COUNT(*) FROM booksData WHERE accession_number = ?";
            String insertSql = "INSERT INTO booksData (accession_number, book_name, author, publisher, edition, price) VALUES (?, ?, ?, ?, ?, ?)";
            String updateSql = "UPDATE booksData SET book_name = ?, author = ?, publisher = ?, edition = ?, price = ? WHERE accession_number = ?";
            
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            
            // Get first sheet
            XSSFSheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();
            
            // Skip header row
            if (rowIterator.hasNext()) {
                rowIterator.next();
            }
            
            // Process each row
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                totalRecords++;
                
                try {
                    int accessionNumber = (int) row.getCell(0).getNumericCellValue();
                    String bookName = getCellStringValue(row.getCell(1));
                    String author = getCellStringValue(row.getCell(2));
                    String publisher = getCellStringValue(row.getCell(3));
                    String edition = getCellStringValue(row.getCell(4));
                    BigDecimal price = new BigDecimal(row.getCell(5).getNumericCellValue());
                    
                    // Check if record exists
                    checkStmt.setInt(1, accessionNumber);
                    ResultSet rs = checkStmt.executeQuery();
                    rs.next();
                    boolean exists = rs.getInt(1) > 0;
                    
                    if (exists) {
                        // Update existing record
                        updateStmt.setString(1, bookName);
                        updateStmt.setString(2, author);
                        updateStmt.setString(3, publisher);
                        updateStmt.setString(4, edition);
                        updateStmt.setBigDecimal(5, price);
                        updateStmt.setInt(6, accessionNumber);
                        updateStmt.executeUpdate();
                        updatedCount++;
                    } else {
                        // Insert new record
                        insertStmt.setInt(1, accessionNumber);
                        insertStmt.setString(2, bookName);
                        insertStmt.setString(3, author);
                        insertStmt.setString(4, publisher);
                        insertStmt.setString(5, edition);
                        insertStmt.setBigDecimal(6, price);
                        insertStmt.executeUpdate();
                        insertedCount++;
                    }
                } catch (Exception e) {
                    failedCount++;
                    errorMessages.add("Row " + (row.getRowNum() + 1) + ": " + e.getMessage());
                }
            }
            
            // Close statements
            checkStmt.close();
            insertStmt.close();
            updateStmt.close();
            
            // Prepare success response
            String message = "Import completed successfully";
            if (!errorMessages.isEmpty()) {
                message += " with " + errorMessages.size() + " errors";
            }
            
            sendJsonResponse(response, true, message, 
                    totalRecords, insertedCount, updatedCount, failedCount);
            
        } catch (SQLException e) {
            sendJsonResponse(response, false, "Database error: " + e.getMessage(), 
                    0, 0, 0, 0);
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error processing file: " + e.getMessage(), 
                    0, 0, 0, 0);
        }
    }
    
    private String getCellStringValue(Cell cell) {
        if (cell == null) {
            return "";
        }
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toString();
                } else {
                    return String.valueOf(cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, 
            String message, int totalRecords, int insertedCount, 
            int updatedCount, int failedCount) throws IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        out.print("{");
        out.print("\"success\": " + success + ",");
        out.print("\"message\": \"" + message + "\",");
        out.print("\"totalRecords\": " + totalRecords + ",");
        out.print("\"insertedCount\": " + insertedCount + ",");
        out.print("\"updatedCount\": " + updatedCount + ",");
        out.print("\"failedCount\": " + failedCount);
        
        if (!success) {
            out.print(",\"error\": \"" + message + "\"");
        }
        
        out.print("}");
    }
}