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
        <h1>Admin Area - Add Product</h1>
        <form action="admin_add_product.jsp" method="get">
          <p>Name*</p>
          <input type="text" name="name">
          <p>Preis*</p>
          <input type="text" name="price">
          <p>Hersteller*</p>
          <%
            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
              Statement st = con.createStatement();
              String listCategory = "select producer_name from manufactura";
              ResultSet rset = st.executeQuery(listCategory);
              out.write("<select name=\"producer_name\" onChange=\"change()\" id=\"selc\" >");
              int i = 1;
              while (rset.next()) {
                String value = rset.getString("producer_name");
                out.write("<option value=\"" + value + "\">" + value + "</option>");
                i++;
              }
              out.write("</select>");

              st.close();
              con.close();
            } catch (Exception e) {
              out.println("! MYSQL Exception: " + e.getMessage());
            }
          %>
          <p>Details</p>
          <input type="text" name="details">
          <p>Kategorie*</p>
          <%
            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
              Statement st = con.createStatement();
              String listCategory = "select category_name from category";
              ResultSet rset = st.executeQuery(listCategory);
              out.write("<select name=\"category_name\" onChange=\"change()\" id=\"selc\" >");
              int i = 1;
              while (rset.next()) {
                String value = rset.getString("category_name");
                out.write("<option value=\"" + value + "\">" + value + "</option>");
                i++;
              }
              out.write("</select>");

              st.close();
              con.close();
            } catch (Exception e) {
              out.println("! MYSQL Exception: " + e.getMessage());
            }
          %>
          <input type="submit" value="Insert">
        </form>
        <%
          //Variables, which getting from form.
          String name = request.getParameter("name");
          String Sprice = request.getParameter("price");
          String producer = request.getParameter("producer_name");
          String details = request.getParameter("details");
          String category = request.getParameter("category_name");

          int updateQuery = 0;

          //Checking whether variables are setting.
          if (name != null && Sprice != null && producer != null && category != null) {
            int price = Integer.parseInt("" + Sprice + "");

            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
              Statement st = con.createStatement();
              String queryString = "INSERT INTO product(name, price,producer_name, details, category_name) VALUES (\"" + name + "\"," + price + ",\"" + producer + "\",\"" + details + "\",\"" + category + "\")";
              updateQuery = st.executeUpdate(queryString);
              if (updateQuery != 0) {
                out.write("Der Eintrag war Erfolgreich!");
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
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from product");

            // All Products to be displayed inside an html-table.
            out.write("<table class=\"\">");
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
              String pId = rs.getString("product_id");

              out.write("<tr class=\"" + zebra + "\">");
              out.write("<td class=\"pid\">" + pId + "</td>");
              out.write("<td class=\"name\">" + pName + "</td>");
              out.write("<td class=\"manufacturer\">" + pManufacturer + "</td>");
              out.write("<td class=\"price\">" + pPrice + "</td>");
              out.write("</tr>");

              i++;
            }
            out.write("</tbody>");
            out.write("</table>"); // /END Producttable.
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"\" href=\"admin_products.jsp\">Zur Produktansicht</a>");
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
