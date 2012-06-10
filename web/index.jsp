<%-- 
    @Document   : index
    @Author     : Felix Hofmann - 2022833
    @file       : This file creates the product-overview.
--%>

<%@page session="true" contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="includes/header.inc.jsp" %>

<div id="content">
  <h1>Produktübersicht</h1>
  <%
    // Get the database driver.
    try {
      Class.forName("org.gjt.mm.mysql.Driver");
    } catch (ClassNotFoundException e) {
      out.println("<div class=\"message error\">Driver is missing!</div>");
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
      out.write("<th>Art.#</th>");
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
        
        i++;
        
        // Product attributes.  
        String pName = rs.getString("name");
        String pManufacturer = rs.getString("producer_name");
        String pPrice = rs.getString("price");
        String pId = rs.getString("product_id");

        out.write("<tr class=\"" + zebra + "\">");
        out.write("<td class=\"pid\">" + pId + "</td>");
        out.write("<td class=\"name\">" + pName + "</td>");
        out.write("<td class=\"manufacturer\">" + pManufacturer + "</td>");
        out.write("<td class=\"price\">" + pPrice + "</td>");
        out.write("<td class=\"add-to-cart\"><a title=\"Zum Warenkorb hinzufügen\" class=\"to-cart\" href=\"cart.jsp?pid=" + pId + "\">In den Warenkorb</a></td>");
        out.write("</tr>");
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
<div id="sidebar">
  <%@ include file="includes/cart-sidebar.inc.jsp" %>
</div>

  <%@ include file="includes/footer.inc.jsp" %>