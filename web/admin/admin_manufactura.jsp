<%-- 
    Document   : admin_products
    Created on : 09.06.2012, 21:12:19
    Author     : ewaldschmidt
--%>

<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>RDBSHOP</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="../compass/stylesheets/styles.css" />
  </head>
  <body>
    <div id="page">
      <div id="header">
        <a href="admin.jsp"><img src="../files/logo.png" /></a>
      </div>
      <%
        // Get the database driver.
        try {
          Class.forName("org.gjt.mm.mysql.Driver");
          //out.println("DB-Treiber da!");
        } catch (ClassNotFoundException e) {
          //out.println("DB-Treiber nicht da!");
        }
      %>
      <div id="header"></div>
      <div id="content">
        <h1>Admin Area - Manufacturas</h1>
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from manufactura");

            // All Products to be displayed inside an html-table.
            out.write("<table class=\"products\">");
            out.write("<thead>");
            out.write("<tr>");
            out.write("<th>Name</th>");
            out.write("<th>Description</th>");
            out.write("</tr>");

            out.write("</thead>");
            out.write("<tbody>");
            // Product attributes.  

            int i = 1;
            while (rs.next()) {
              // Zebra is used to specify whether a data set is even or odd.
              String zebra;
              if (i % 2 == 0) {
                zebra = "even";
              } else {
                zebra = "odd";
              }
              String name = rs.getString("producer_name");
              String description = rs.getString("description");
              
              out.write("<form action=\"admin_manufactura.jsp\" method=\"get\">");
              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"pid\">" + name + "<input name=\"name\" type=\"hidden\" value=\"" + name + "\" /></td>");
              out.write("<td class=\"name\">" + description + "</td>");
              out.write("<td class=\"\"><input type=\"submit\" name=\"Delete\" value=\"Delete\"></td>");
              out.write("</form>");
              out.write("</tr>");

              i++;
            }
            
            out.write("</tbody>");
            out.write("</table>"); // /END Producttable.

            st.close();
            con.close();
          } catch (Exception e) {
            out.println("! MYSQL Exception: " + e.getMessage());
          }

          //Variables, which getting from form.
          String mname = request.getParameter("name");

          int updateQuery = 0;

          //Checking whether variables are setting.
          if (mname != null) {

            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
              Statement st = con.createStatement();
              String queryString = "delete from manufactura where producer_name = '" + mname + "';";
              updateQuery = st.executeUpdate(queryString);
              if (updateQuery != 0) {
                //out.write("Eintrag erfolgreich entfernt");
                response.addHeader("Refresh","1");
              }
              //ResultSet rs = st.executeQuery(queryString);
              st.close();
              con.close();
            } catch (Exception e) {
              out.println("! MYSQL Exception: " + e.getMessage());
            }
          }
        %>
      </div>
      <div id="sidebar">
        <%@ include file="includes/admin_sidebar.inc.jsp" %>
      </div>
      <div id="footer"></div>
    </div>
  </body>
</html>
