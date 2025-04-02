package com.addAccountDetails;

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
public class AddAccountDetails extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dbcon db = new dbcon();
        Statement stmt = null;
         response.setContentType("application/json;charset=UTF-8");
         JSONObject jsonResponse = new JSONObject();
        try (PrintWriter out = response.getWriter()) {

            String accountid = request.getParameter("accountid");
            String accountname = request.getParameter("accountname");
            String companyname = request.getParameter("companyname");
            String password = request.getParameter("password");
            String environment = request.getParameter("environment");
            String setup = request.getParameter("setup");
            String department = request.getParameter("department");
           
            int id = 0; // Default value
            try {
                id = Integer.parseInt(accountid); // Convert id to int
            } catch (NumberFormatException e) {
                jsonResponse.put("error", "Invalid ID. ID must be an integer.");
                out.print(jsonResponse);
                return;
            }
            String setup_url = null;
            String api_url_setup = null;
            if ("-1".equals(setup)) {
                api_url_setup = "smppgs";
            } else if ("0".equals(setup)) {
                api_url_setup = "smpp0";
            } else if ("9".equals(setup)) {
                api_url_setup = "smpp9";
            }
           

            setup_url = "https://" +api_url_setup+".sms24hours.com/SMSApi/report/smsSummary?userid=" + accountname + "&password=" + password + "&fromdate=";
            System.out.println("id: " + id);
            System.out.println("setup_url: " + setup_url);
            System.out.println("api_url_setup: " + api_url_setup);
            System.out.println("accountid: " + accountid);
            System.out.println("accountname: " + accountname);
            System.out.println("companyname: " + companyname);
            System.out.println("password: " + password);
            System.out.println("environment: " + environment);
            System.out.println("setup: " + setup);
            System.out.println("department: " + department);

            // Establish connection to the database
            db.getCon("nha_cdr");
            stmt = db.getStmt();
            // Check if the id, username, chatId, or email already exist
            String checkQuery = "SELECT COUNT(*) FROM AccountDetails WHERE accountid = ?";
            System.out.println("checkQuery: " + checkQuery);

            // Use PreparedStatement to prevent SQL injection
            PreparedStatement pstmt = stmt.getConnection().prepareStatement(checkQuery);
            pstmt.setInt(1, id);

            System.out.println("pstmt: " + pstmt);
            ResultSet rs = pstmt.executeQuery();
            System.out.println("rs: " + rs);

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    jsonResponse.put("error", "A record with the same ID already exists.");
                    out.print(jsonResponse);
                    return;
                }
            }

            String sql = "INSERT INTO AccountDetails (accountid, accountname, companyname, setup, password, environment, api_url, department) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
            
            
            System.out.println(" insert sql :"+sql);

            PreparedStatement insertStmt = stmt.getConnection().prepareStatement(sql);
            insertStmt.setInt(1, id);
            insertStmt.setString(2, accountname);
            insertStmt.setString(3, companyname);
            insertStmt.setString(4, setup);
            insertStmt.setString(5, password);
            insertStmt.setString(6, environment);
            insertStmt.setString(7, setup_url);
            insertStmt.setString(8, department);
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
