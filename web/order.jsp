<%-- 
    Document   : order
    Created on : 09.06.2012, 20:39:11
    Author     : fhofmann
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page session="true" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>RDBSHOP</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="compass/stylesheets/styles.css" />
  </head>
  <body>
    <div id="page">
      <div id="header">
        <a href="index.jsp"><img src="files/logo.png" /></a>  
      </div>
      <div id="content">
        <h1>Bestellen</h1>


        
        <form class="form-order">
          <h2>Bestellungspositionen</h2>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          <%
      // Get the database driver.
      try {
        Class.forName("org.gjt.mm.mysql.Driver");
      } catch (ClassNotFoundException e) {
        out.println("<div class=\"message error\">Driver is missing!</div>");
      }

      out.write("<div class=\"shopping-cart\">");
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

            out.write("<td class=\"pid\">" + pId + "<input name=\"pid\" type=\"hidden\" value=\"" + pId + "\" /></td>");
            out.write("<td class=\"name\">" + pName + "</td>");
            out.write("<td class=\"manufacturer\">" + pManufacturer + "</td>");
            out.write("<td class=\"price\">" + pPrice + "</td>");

          }
          out.write("<td>" + value + "<input name=\"pamount\" type=\"hidden\" value=\"" + value + "\" /></td>");
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
      out.write("</div>");

    %>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          <h2>Ihre Adressdaten</h2>
          <div>
            <label for="firstname">Vorname</label>
            <input type="text" name="firstname" />
          </div>
          <div>
            <label for="firstname">Nachname</label>
            <input type="text" name="lastname" /> 
          </div>
          <div>
            <label for="firstname">Straße</label>
            <input type="text" name="street" />
          </div>
          <div>
            <label for="firstname">PLZ</label>
            <input type="text" name="zip" />
          </div>
          <div>
            <label for="firstname">Stadt</label>
            <input type="text" name="city" />      
          </div>
          
          <h2>Zahlungsmethode</h2>
          
          
          
          <input type="submit" value="Bestellung abschicken" />
          
          
        </form>

      </div>
      <div id="sidebar">
      </div>
      <div id="footer"></div>




  </body>
</html>
