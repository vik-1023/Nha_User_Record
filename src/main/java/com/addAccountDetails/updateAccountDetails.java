package com.addAccountDetails;

import db.dbcon;
import java.io.BufferedReader;
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
public class updateAccountDetails extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dbcon db = new dbcon();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Read the JSON data from request
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonData = new JSONObject(sb.toString());
            System.out.println("Received JSON: " + jsonData.toString());

            // Get ID - handle both integer and string formats
            int id;
            try {
                if (jsonData.has("id")) {
                    try {
                        id = jsonData.getInt("id");
                    } catch (Exception e) {
                        id = Integer.parseInt(jsonData.getString("id"));
                    }
                } else {
                    throw new IllegalArgumentException("ID is required.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid ID format. Must be a number.");
            }

            // Get other parameters with default empty strings
            String accountname = sanitizeInput(jsonData.optString("accountname", ""));
            String companyname = sanitizeInput(jsonData.optString("companyname", ""));
            String Setup = sanitizeInput(jsonData.optString("Setup", ""));
            String password = sanitizeInput(jsonData.optString("password", ""));
            String environment = sanitizeInput(jsonData.optString("environment", ""));
            String api_url = sanitizeInput(jsonData.optString("api_url", ""));
            String department = sanitizeInput(jsonData.optString("department", ""));

            // Debug print all values
            System.out.println("ID: " + id);
            System.out.println("accountname: " + accountname);
            System.out.println("companyname: " + companyname);
            System.out.println("Setup: " + Setup);
            System.out.println("Email: " + password);
            System.out.println("environment: " + environment);
            System.out.println("api_url: " + api_url);
            System.out.println("department: " + department);

            db.getCon("nha_cdr");
            // Create SQL with sanitized inputs
            String updateSql = "UPDATE AccountDetails SET "
                    + "accountname = '" + accountname + "', "
                    + "companyname = '" + companyname + "', "
                    + "Setup = '" + Setup + "', "
                    + "password = '" + password + "', "
                    + "environment = '" + environment + "', "
                    + "api_url = '" + api_url + "', "
                    + "department = '" + department + "' " // Removed the comma here
                    + "WHERE accountid = " + id;

            System.out.println("updateSql :" + updateSql);
            // Use the basic setUpdate method
            int i = db.setUpdate(updateSql);

            JSONObject jsonResponse = new JSONObject();
            if (i > 0) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "User updated successfully");
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "No changes made or user not found");
                response.setStatus(HttpServletResponse.SC_OK);
            }

            out.print(jsonResponse.toString());

        } catch (IllegalArgumentException e) {
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Validation error: " + e.getMessage());
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
            db.closeConection();
        }
    }

    // Basic input sanitization method
    private String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        // Escape SQL special characters
        return input.replace("'", "''");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating user details";
    }
}
