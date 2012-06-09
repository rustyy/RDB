<%-- 
    Document   : index
    Created on : 09.06.2012, 00:27:47
    Author     : fhofmann
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" type="text/css" href="compass/stylesheets/styles.css" />
  </head>
  <body>

    <div id="page">
      <div id="header"></div>
      <div id="content">


        <%
          // Get the database driver.
          try {
            Class.forName("org.gjt.mm.mysql.Driver");
            out.println("DB-Treiber da!");
          } catch (ClassNotFoundException e) {
            out.println("DB-Treiber nicht da!");
          }

          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from product");


            // All Products to be displayed inside an html-table.
            out.write("<table class=\"products\">");
            out.write("<thead>");
            out.write("<tr>");
            out.write("<th>Name</th>");
            out.write("<th>Hersteller</th>");
            out.write("<th>Preis</th>");
            out.write("<th></th>");
            out.write("</tr>");
            
            out.write("</thead>");
            out.write("<tbody>");

            int i = 1;
            while (rs.next()) {
              // Zebra is used to specify whether a data set is even or odd.
              String zebra;
              if (i % 2 == 0) {
                zebra = "even";
              } else {
                zebra = "odd";
              }
              // Product attributes.  
              String pName = rs.getString("name");
              String pManufacturer = rs.getString("producer_name");
              String pPrice = rs.getString("price");

              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"name\">" + pName + "</td>");
              out.write("<td class=\"manufacturer\">" + pManufacturer + "</td>");
              out.write("<td class=\"price\">" + pPrice + "</td>");
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










        %>

      </div>
      <div id="sidebar"></div>
      <div id="footer"></div>



    </div>





  </body>
</html>
