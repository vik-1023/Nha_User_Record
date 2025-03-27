/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.addUsersServlet;

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
public class updateUserDetails extends HttpServlet {
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
            String username = sanitizeInput(jsonData.optString("username", ""));
            String password = sanitizeInput(jsonData.optString("password", ""));
            String chatId = sanitizeInput(jsonData.optString("chat_id", ""));
            String email = sanitizeInput(jsonData.optString("email", ""));
            String status = sanitizeInput(jsonData.optString("status", ""));
            String userType = sanitizeInput(jsonData.optString("user_type", ""));
            String clients = sanitizeInput(jsonData.optString("clients", ""));
            String links = sanitizeInput(jsonData.optString("links", ""));

            // Debug print all values
            System.out.println("ID: " + id);
            System.out.println("Username: " + username);
            System.out.println("Password: " + password);
            System.out.println("Chat ID: " + chatId);
            System.out.println("Email: " + email);
            System.out.println("Status: " + status);
            System.out.println("User Type: " + userType);
            System.out.println("Clients: " + clients);
            System.out.println("Links: " + links);

            db.getCon("nha_cdr");
            // Create SQL with sanitized inputs
            String updateSql = "UPDATE users SET "
                    + "username = '" + username + "', "
                    + "password = '" + password + "', "
                    + "chat_id = '" + chatId + "', "
                    + "email = '" + email + "', "
                    + "status = '" + status + "', "
                    + "user_type = '" + userType + "', "
                    + "clients = '" + clients + "', "
                    + "links = '" + links + "' "
                    + "WHERE id = " + id;

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
