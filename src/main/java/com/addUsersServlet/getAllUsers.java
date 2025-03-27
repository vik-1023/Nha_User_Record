/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.addUsersServlet;

import db.dbcon;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author vikram
 */
public class getAllUsers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        dbcon db = new dbcon();
        response.setContentType("application/json;charset=UTF-8"); // Set content type to JSON
        try (PrintWriter out = response.getWriter()) {

            db.getCon("nha_cdr");

            String checkQuery = "select * from users;";
            ResultSet rs = db.getResult(checkQuery);
            
            // Create a JSON array to hold the users' data
            JSONArray usersList = new JSONArray();

            while (rs.next()) {
                JSONObject userObj = new JSONObject();
                userObj.put("id", rs.getInt("id"));
                userObj.put("username", rs.getString("username"));
                userObj.put("password", rs.getString("password"));
                userObj.put("chat_id", rs.getString("chat_id"));
                userObj.put("email", rs.getString("email"));
                userObj.put("status", rs.getString("status"));
                userObj.put("user_type", rs.getString("user_type"));
                userObj.put("clients", rs.getString("clients"));
                userObj.put("links", rs.getString("links"));

                usersList.put(userObj);
            }

            // Send the JSON response back to the client
            out.print(usersList.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
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
        return "Returns all users in JSON format";
    }
}

