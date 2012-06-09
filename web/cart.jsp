<%-- 
    Document   : cart
    Created on : 09.06.2012, 17:23:46
    Author     : fhofmann
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>RDBSHOP</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600' rel='stylesheet' type='text/css' />
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
      } catch (ClassNotFoundException e) {
        out.println("<div class=\"message error\">Driver is missing!</div>");
      }

      out.write("<div class=\"shopping-cart\">");
      // Check if pid-parameter is set.
      if (request.getParameter("pid") != null) {
        String pid = request.getParameter("pid");
        // Check if there is already a pid is set in session-object.
        if (session.getAttribute(pid) != null) {
          // If so, we have to add one more product to the session.
          Object sessionPID = session.getAttribute(pid);
          int intPID = (Integer) sessionPID;
          intPID++;
          session.setAttribute(pid, intPID);
        } else {
          // Else we set the productid to one.
          session.setAttribute(pid, 1);
        }
        out.write("<div class=\"message success\">Produkt wurde dem Warenkorb hinzugefügt.</div>");
      }


      /**
       * *****
       * Output Shopping-cart. *****
       */
      try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
        Statement st = con.createStatement();

        // Show shopping-cart.
        out.write("<table class=\"products\">");
        out.write("<thead>");
        out.write("<tr>");
        out.write("<th>Artikelnummer</th>");
        out.write("<th>Name</th>");
        out.write("<th>Hersteller</th>");
        out.write("<th>Preis</th>");
        out.write("<th>Menge</th>");
        out.write("</tr>");
        out.write("</thead>");
        out.write("<tbody>");

        int finalPrice = 0;
        Enumeration names = session.getAttributeNames();
        while (names.hasMoreElements()) {
          String key = (String) names.nextElement();
          Object value = session.getAttribute(key);
          ResultSet rs = st.executeQuery("select * from product WHERE product_id='" + key + "'");

          out.write("<tr class=\"\">");

          while (rs.next()) {
            int pPriceOverall = 0;
            String pName = rs.getString("name");
            String pManufacturer = rs.getString("producer_name");
            String pPrice = rs.getString("price");

            String pId = rs.getString("product_id");

            pPriceOverall = (Integer) value * Integer.parseInt(pPrice);
            finalPrice += pPriceOverall;

            out.write("<td class=\"pid\">" + pId + "</td>");
            out.write("<td class=\"name\">" + pName + "</td>");
            out.write("<td class=\"manufacturer\">" + pManufacturer + "</td>");
            out.write("<td class=\"price\">" + pPrice + "</td>");

          }
          out.write("<td>" + value + "</td>");
          out.write("</tr>");
        }
        out.write("<tr>");
        out.write("<td colspan=\"3\">Gesamtsumme</td>");
        out.write("<td>" + finalPrice + "</td>");
        out.write("<td></td>");
        out.write("</tr>");

        out.write("</tbody>");
        out.write("</table>"); // /END Producttable.

        st.close();
        con.close();
      } catch (Exception e) {
        out.println("! MYSQL Exception: " + e.getMessage());
      }
      out.write("<a href=\"index.jsp\">Zurück zur Produktliste</a>");
      out.write("<a href=\"#\">Bestellen</a>");
      out.write("</div>");

    %>
    
    
          </div>
      <div id="sidebar">

      </div>
      <div id="footer"></div>



    </div>

    
    
    
    
  </body>
</html>
