<%-- 
    Document   : index
    Created on : 10.06.2012, 19:01:34
    Author     : Eugen Waldschmidt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>RDBSHOP</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="../compass/stylesheets/styles.css" />
    <script src="http://code.jquery.com/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <script src="compass/js/commerce.js" type="text/javascript"></script>
    <script src="../compass/js/commerce.js" type="text/javascript"></script>
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
        <h1>Admin Area</h1>
        <br>
        <h2>Navigation</h2>
        <ul class="admin-navigation">
          <li><a href="admin_add_category.jsp" class="go-further">Kategorie hinzufügen</a></li>
          <li><a href="admin_add_manufactura.jsp" class="go-further">Hersteller hinzufügen</a></li>
          <li><a href="admin_add_payment.jsp" class="go-further">Zahlungsart hinzufügen</a></li>
          <li><a href="admin_add_product.jsp" class="go-further">Produkt hinzufügen</a></li>
          <li><a href="admin_categories.jsp" class="go-further">Kategorie auflisten</a></li>
          <li><a href="admin_manufactura.jsp" class="go-further">Hersteller auflisten</a></li>
          <li><a href="admin_payments.jsp" class="go-further">Payments auflisten</a></li>
          <li><a href="admin_products.jsp" class="go-further">Produkte auflisten</a></li>
        </ul>

      </div>
      <div id="sidebar">
        <h2>Produkte</h2>
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
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
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"go-further negative\" href=\"admin_products.jsp\">Zur Produktansicht</a>");
            st.close();
            con.close();
          } catch (Exception e) {
            out.println("! MYSQL Exception: " + e.getMessage());
          }
        %>
        <h2>Kategorien</h2>
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from category");

            // All Products to be displayed inside an html-table.
            out.write("<table class=\"products\">");
            out.write("<thead>");
            out.write("<tr>");
            out.write("<th>Name</th>");
            out.write("<th>Description</th>");
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
              String cname = rs.getString("category_name");
              String cdescription = rs.getString("description");

              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"name\">" + cname + "</td>");
              out.write("<td class=\"pid\">" + cdescription + "</td>");
              out.write("</tr>");

              i++;
            }
            out.write("</tbody>");
            out.write("</table>"); // /END Producttable.
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"go-further negative\" href=\"admin_categories.jsp\">Zur Kategorie-Ansicht</a>");
            st.close();
            con.close();
          } catch (Exception e) {
            out.println("! MYSQL Exception: " + e.getMessage());
          }
        %>

        <h2>Hersteller</h2>
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
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
              String cname = rs.getString("producer_name");
              String cdescription = rs.getString("description");

              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"name\">" + cname + "</td>");
              out.write("<td class=\"pid\">" + cdescription + "</td>");
              out.write("</tr>");

              i++;
            }
            out.write("</tbody>");
            out.write("</table>"); // /END Producttable.
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"go-further negative\" href=\"admin_manufactura.jsp\">Zur Hersteller-Ansicht</a>");
            st.close();
            con.close();
          } catch (Exception e) {
            out.println("! MYSQL Exception: " + e.getMessage());
          }
        %>

        <h2>Zahlungsmethoden</h2>
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dt40", "dt40", "8Cy8");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from payment");

            // All Products to be displayed inside an html-table.
            out.write("<table class=\"products\">");
            out.write("<thead>");
            out.write("<tr>");
            out.write("<th>Name</th>");
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
              String cname = rs.getString("service");

              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"name\">" + cname + "</td>");
              out.write("</tr>");

              i++;
            }
            out.write("</tbody>");
            out.write("</table>"); // /END Producttable.
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"go-further negative\" href=\"admin_payments.jsp\">Zur Zahlungsmethoden-Ansicht</a>");
            st.close();
            con.close();
          } catch (Exception e) {
            out.println("! MYSQL Exception: " + e.getMessage());
          }
        %>
      </div>
      <div id="footer"></div>
    </div>
  </body>
</html>
