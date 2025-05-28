package LibraryBackendCode;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

@WebServlet("/BTechImportData")
@MultipartConfig
public class BtechStudents extends HttpServlet {
    
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
        
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             InputStream fileContent = filePart.getInputStream();
             Workbook workbook = WorkbookFactory.create(fileContent)) {
            
            // Prepare statements
            String checkSql = "SELECT COUNT(*) FROM BTech_students WHERE crn = ?";
            String insertSql = "INSERT INTO BTech_students (crn, name, course, contact) VALUES (?, ?, ?, ?)";
            String updateSql = "UPDATE BTech_students SET name = ?, course = ?, contact = ? WHERE crn = ?";
            
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            
            // Get first sheet
            Sheet sheet = workbook.getSheetAt(0);
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
                    String crn = getCellValue(row.getCell(0));
                    String name = getCellValue(row.getCell(1));
                    String course = getCellValue(row.getCell(2));
                    String contact = getCellValue(row.getCell(3));
                    
                    // Validate required fields
                    if (crn == null || crn.isEmpty() || name == null || name.isEmpty()) {
                        throw new Exception("Missing required fields (CRN or Name)");
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
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            out.print("{");
            out.print("\"success\": true,");
            out.print("\"message\": \"BTech student import completed successfully\",");
            out.print("\"totalRecords\": " + totalRecords + ",");
            out.print("\"insertedCount\": " + insertedCount + ",");
            out.print("\"updatedCount\": " + updatedCount + ",");
            out.print("\"failedCount\": " + failedCount);
            out.print("}");
            
        } catch (Exception e) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private String getCellValue(Cell cell) {
        // Same implementation as in MBAStudentsImportData
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
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }
}