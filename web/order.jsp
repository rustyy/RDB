<%-- 
    @Document   : order
    @Author     : Felix Hofmann - 2022833
    @file       : This file creates the order page.
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page session="true" %>

<%@ include file="includes/header.inc.jsp" %>

<div id="content">
  <h1>Bestellen</h1>

  <%
    // Check if form has been send.        
    if (request.getParameter("order-confirm") == null) {
  %>

  <form class="form-order" method="POST" action="order.jsp">
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
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
        Statement st = con.createStatement();

        // Show shopping-cart.
        out.write("<table class=\"products\">");
        out.write("<thead>");
        out.write("<tr>");
        out.write("<th>Art.#</th>");
        out.write("<th>Name</th>");
        out.write("<th>Hersteller</th>");
        out.write("<th>Preis</th>");
        out.write("<th>Menge</th>");
        out.write("</tr>");
        out.write("</thead>");
        out.write("<tbody>");

        int finalPrice = 0;
        Enumeration names = session.getAttributeNames();
        int i = 1;
        while (names.hasMoreElements()) {
          String key = (String) names.nextElement();
          Object value = session.getAttribute(key);
          ResultSet rs = st.executeQuery("select * from product WHERE product_id='" + key + "'");

          // Zebra is used to specify whether a data set is even or odd.
          String zebra;
          if (i % 2 == 0) {
            zebra = "even";
          } else {
            zebra = "odd";
          }

          i++;
          out.write("<tr class=\"" + zebra + "\">");

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
            out.write("<td>" + value + "</td>");
          }

          out.write("</tr>");
        }
        out.write("<tr class=\"overall\">");
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
      <label for="lastname">Nachname</label>
      <input type="text" name="lastname" /> 
    </div>
    <div>
      <label for="street">Straße</label>
      <input type="text" name="street" />
    </div>
    <div>
      <label for="zip">PLZ</label>
      <input type="text" name="zip" />
    </div>
    <div>
      <label for="city">Stadt</label>
      <input type="text" name="city" />      
    </div>

    <h2>Zahlungsmethode</h2>
    <div>
      <%
        try {
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
          Statement st = con.createStatement();

          ResultSet rs = st.executeQuery("select * from payment");
          out.write("<select name=\"paymentID\">");
          while (rs.next()) {
            String paymentID = rs.getString("payment_id");
            String paymentService = rs.getString("service");
            out.write("<option value=\"" + paymentID + "\">" + paymentService + "</option>");
          }

          out.write("</select>");
          st.close();
          con.close();
        } catch (Exception e) {
          out.println("! MYSQL Exception: " + e.getMessage());
        }
      %>
    </div>

    <input type="hidden" name="order-confirm" />
    <input type="submit" value="Bestellung abschicken" />
  </form>
  <% } else {%>

  <div class="message success">
    Vielen Dank für Ihre Bestellung.
  </div>

  <%
      // All variables from form.
      String firstName = request.getParameter("firstname");
      String lastName = request.getParameter("lastname");
      String street = request.getParameter("street");
      String zip = request.getParameter("zip");
      String location = request.getParameter("city");
      int paymentID = Integer.parseInt(request.getParameter("paymentID"));
      int customerID = 0;
      int orderID = 0;

      try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
        Statement st = con.createStatement();

        String sqlQuery1 = "SELECT "
                + "customer_id "
                + "FROM "
                + "customer "
                + "WHERE "
                + "firstname='" + firstName + "' "
                + "AND lastname='" + lastName + "'"
                + "AND street='" + street + "' "
                + "AND zip='" + zip + "' "
                + "AND location='" + location + "'";

        ResultSet rs = st.executeQuery(sqlQuery1);
        // Check whether customer already exists or not, if not create a new dataset.
        int rowCount = 0;
        while (rs.next()) {
          rowCount++;
        }
        // No customer found? Create one.
        if (rowCount == 0) {
          String sqlQuery2 = "INSERT INTO customer"
                  + "(firstname, lastname, street, zip, location) "
                  + "VALUES "
                  + "("
                  + "'" + firstName + "', "
                  + "'" + lastName + "', "
                  + "'" + street + "', "
                  + zip + ", "
                  + "'" + location + "'"
                  + ")";
          st.executeUpdate(sqlQuery2);
          // Get the customerID for the new dataset
          rs = st.executeQuery(sqlQuery1);
          while (rs.next()) {
            // S`ave the customerID of the new entry.
            customerID = rs.getInt("customer_id");
          }
        } else {
          rs = st.executeQuery(sqlQuery1);
          while (rs.next()) {
            // Save the customerID of existing user.
            customerID = rs.getInt("customer_id");
          }
        }

        // Create order.
        String queryOrder = "INSERT INTO `order`"
                + "(customer_id, payment_id) "
                + "VALUES (" + customerID + ", " + paymentID + ")";
        st.executeUpdate(queryOrder);

        queryOrder = "SELECT order_id "
                + "FROM `order` "
                + "WHERE customer_id=" + customerID + " "
                + "ORDER BY date DESC "
                + "LIMIT 1";
        rs = st.executeQuery(queryOrder);
        while (rs.next()) {
          // Store orderID for current order.
          orderID = rs.getInt("order_id");
        }

        // Save order items into database.
        Enumeration names = session.getAttributeNames();
        while (names.hasMoreElements()) {
          String key = (String) names.nextElement();
          Object value = session.getAttribute(key);
          String queryOrderItem = "INSERT INTO orderitem(product_id, order_id, amount, session)"
                  + "VALUES (" + Integer.parseInt(key) + ", " + orderID + ", " + (Integer) value + ", '" + session.getId() + "')";
          st.executeUpdate(queryOrderItem);
        }

        st.close();
        con.close();
      } catch (Exception e) {
        out.println("! MYSQL Exception: " + e.getMessage());
      }

      // Destroy session, so shopping-cart is empty again.        
      session.invalidate();
    }

  %>

</div>

<%@ include file="includes/footer.inc.jsp" %>