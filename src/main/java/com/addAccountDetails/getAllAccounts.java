/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.addAccountDetails;

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
public class getAllAccounts extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        dbcon db = new dbcon();
        response.setContentType("application/json;charset=UTF-8"); // Set content type to JSON
        try (PrintWriter out = response.getWriter()) {

            db.getCon("nha_cdr");

            String checkQuery = "select * from AccountDetails;";
            ResultSet rs = db.getResult(checkQuery);

            // Create a JSON array to hold the users' data
            JSONArray usersList = new JSONArray();

            while (rs.next()) {
                JSONObject userObj = new JSONObject();
                userObj.put("id", rs.getInt("accountid"));
                userObj.put("accountname", rs.getString("accountname"));
                userObj.put("companyname", rs.getString("companyname"));
                userObj.put("Setup", rs.getString("Setup"));
                userObj.put("password", rs.getString("password"));
                userObj.put("environment", rs.getString("environment"));
                userObj.put("api_url", rs.getString("api_url"));
                userObj.put("department", rs.getString("department"));
               

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
        return "Short description";
    }

}
