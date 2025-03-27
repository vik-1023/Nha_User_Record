/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.addUsersServlet;

import db.dbcon;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author vikram
 */
public class addUserRecord extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dbcon db = new dbcon();
        response.setContentType("application/json;charset=UTF-8");
        Statement stmt = null;

        JSONObject jsonResponse = new JSONObject();

        try (PrintWriter out = response.getWriter()) {
            // Retrieve form data from request parameters
            String idString = request.getParameter("id");
            int id = 0; // Default value
            try {
                id = Integer.parseInt(idString); // Convert id to int
            } catch (NumberFormatException e) {
                jsonResponse.put("error", "Invalid ID. ID must be an integer.");
                out.print(jsonResponse);
                return;
            }

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String chatId = request.getParameter("chat_id");
            String email = request.getParameter("email");
            String clients = request.getParameter("clients");
            String status = request.getParameter("status");
            String userType = request.getParameter("user_type");
            String links = request.getParameter("links");

            // Set chatId to null if empty
            if (chatId == null || chatId.isEmpty()) {
                chatId = null;
            }

            System.out.println("id: " + id);
            System.out.println("username: " + username);
            System.out.println("password: " + password);
            System.out.println("chatId: " + chatId);
            System.out.println("email: " + email);
            System.out.println("clients: " + clients);
            System.out.println("status: " + status);
            System.out.println("userType: " + userType);
            System.out.println("links: " + links);

            // Establish connection to the database
            db.getCon("nha_cdr");
            stmt = db.getStmt();
            // Check if the id, username, chatId, or email already exist
            String checkQuery = "SELECT COUNT(*) FROM users WHERE id = ? OR username = ? OR email = ?";
            System.out.println("checkQuery: " + checkQuery);

            // Use PreparedStatement to prevent SQL injection
            PreparedStatement pstmt = stmt.getConnection().prepareStatement(checkQuery);
            pstmt.setInt(1, id);
            pstmt.setString(2, username);

            pstmt.setString(3, email);
            System.out.println("pstmt: " + pstmt);
            ResultSet rs = pstmt.executeQuery();
            System.out.println("rs: " + rs);

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    jsonResponse.put("error", "A record with the same ID, username, chat_id, or email already exists.");
                    out.print(jsonResponse);
                    return;
                }
            }

            // If no duplicates, proceed with the insertion
            String sql = "INSERT INTO users (id, username, password, chat_id, email, status, user_type, clients, links) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

            PreparedStatement insertStmt = stmt.getConnection().prepareStatement(sql);
            insertStmt.setInt(1, id);
            insertStmt.setString(2, username);
            insertStmt.setString(3, password);
            insertStmt.setString(4, chatId);
            insertStmt.setString(5, email);
            insertStmt.setString(6, status);
            insertStmt.setString(7, userType);
            insertStmt.setString(8, clients);
            insertStmt.setString(9, links);

            int i = insertStmt.executeUpdate();
            if (i != 0) {
                jsonResponse.put("success", "Data inserted successfully!");
            } else {
                jsonResponse.put("error", "Something went wrong while inserting data.");
            }

            out.print(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("error", "An error occurred.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        } finally {
            db.closeConection();
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Helper method to check if a field exists
    private boolean isFieldExist(ResultSet rs, String field, String value) throws Exception {
        return rs.getString(field).equals(value);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
