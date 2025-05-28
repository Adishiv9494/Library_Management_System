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

@WebServlet("/BCAImportData")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class BCAImportData extends HttpServlet {
    
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
            String checkSql = "SELECT COUNT(*) FROM BCA_students WHERE crn = ?";
            String insertSql = "INSERT INTO BCA_students (crn, name, course, contact) VALUES (?, ?, ?, ?)";
            String updateSql = "UPDATE BCA_students SET name = ?, course = ?, contact = ? WHERE crn = ?";
            
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
                    String crn = getCellStringValue(row.getCell(0));
                    String name = getCellStringValue(row.getCell(1));
                    String course = getCellStringValue(row.getCell(2));
                    String contact = getCellStringValue(row.getCell(3));
                    
                    // Validate required fields
                    if (crn == null || crn.isEmpty()) {
                        throw new Exception("CRN is required");
                    }
                    
                    // Check if record exists
                    checkStmt.setString(1, crn);
                    ResultSet rs = checkStmt.executeQuery();
                    rs.next();
                    boolean exists = rs.getInt(1) > 0;
                    
                    if (exists) {
                        // Update existing record
                        updateStmt.setString(1, name);
                        updateStmt.setString(2, course);
                        updateStmt.setString(3, contact);
                        updateStmt.setString(4, crn);
                        updateStmt.executeUpdate();
                        updatedCount++;
                    } else {
                        // Insert new record
                        insertStmt.setString(1, crn);
                        insertStmt.setString(2, name);
                        insertStmt.setString(3, course);
                        insertStmt.setString(4, contact);
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
                    // Avoid scientific notation for long numbers
                    double num = cell.getNumericCellValue();
                    if (num == Math.floor(num)) {
                        return String.valueOf((long) num);
                    } else {
                        return String.valueOf(num);
                    }
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