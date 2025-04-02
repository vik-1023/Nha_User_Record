
package com.addAccountDetails;

import db.dbcon;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author vikram
 */
public class deleteAccountDetails extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        dbcon db = new dbcon();

        try {
            // Get the user ID from request parameter
            String idParam = request.getParameter("id");
            
            if (idParam == null || idParam.isEmpty()) {
                throw new IllegalArgumentException("User ID is required");
            }

            int userId;
            try {
                userId = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid user ID format");
            }

            // Connect to database
            db.getCon("nha_cdr");
            
            // Delete the user
            String deleteSql = "DELETE FROM AccountDetails WHERE accountid = " + userId;
            int rowsAffected = db.setUpdate(deleteSql);

            // Prepare JSON response
            JSONObject jsonResponse = new JSONObject();
            
            if (rowsAffected > 0) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "User deleted successfully");
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "User not found or could not be deleted");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
            
            out.print(jsonResponse.toString());

        } catch (IllegalArgumentException e) {
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("status", "error");
            errorResponse.put("message", e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(errorResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Server error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(errorResponse.toString());
        } finally {
            out.close();
            if (db != null) {
                try {
                    db.closeConection();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For testing purposes only - in production, only allow DELETE method
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for deleting users";
    }

}
