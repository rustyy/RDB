<%-- 
    Document   : cart
    Created on : 09.06.2012, 17:23:46
    Author     : fhofmann
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<h2>Warenkorb</h2>
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
    out.write("<table class=\"products negative\">");
    out.write("<thead>");
    out.write("<tr>");
    out.write("<th>Name</th>");
    out.write("<th>Preis</th>");
    out.write("<th>Menge</th>");
    out.write("</tr>");
    out.write("</thead>");
    out.write("<tbody>");

    int finalPrice = 0;
    Enumeration names = session.getAttributeNames();
    int i = 1;
    while (names.hasMoreElements()) {
      // Zebra is used to specify whether a data set is even or odd.
      String zebra;
      if (i % 2 == 0) {
        zebra = "even";
      } else {
        zebra = "odd";
      }

      i++;

      String key = (String) names.nextElement();
      Object value = session.getAttribute(key);
      ResultSet rs = st.executeQuery("select name, price from product WHERE product_id='" + key + "'");

      out.write("<tr class=\"" + zebra + "\">");

      while (rs.next()) {
        int pPriceOverall = 0;
        String pName = rs.getString("name");
        String pPrice = rs.getString("price");

        pPriceOverall = (Integer) value * Integer.parseInt(pPrice);
        finalPrice += pPriceOverall;

        out.write("<td class=\"name\">" + pName + "</td>");
        out.write("<td class=\"price\">" + pPrice + "</td>");
      }
      out.write("<td>" + value + "</td>");
      out.write("</tr>");
    }
    out.write("<tr class=\"overall\">");
    out.write("<td>Gesamtsumme</td>");
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
  out.write("<a class=\"go-further negative\" href=\"order.jsp\">Bestellen</a>");
  out.write("</div>");

%>