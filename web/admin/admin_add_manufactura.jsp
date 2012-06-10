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
          out.println("DB-Treiber da!");
        } catch (ClassNotFoundException e) {
          out.println("DB-Treiber nicht da!");
        }
      %>
      <div id="header"></div>
      <div id="content">

        <form action="admin_add_manufactura.jsp" method="get">
          <p>Name*</p>
          <input type="text" name="name">
          <p>Description</p>
          <input type="text" name="description">
          <input type="submit" value="Insert">
        </form>
        <%
          //Variables, which getting from form.
          String name = request.getParameter("name");
          String description = request.getParameter("description");

          int updateQuery = 0;

          //Checking whether variables are setting.
          if (name != null) {

            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
              Statement st = con.createStatement();
              String queryString = "INSERT INTO manufactura(producer_name, description) VALUES ('"+name+"', '"+description+"')";
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
        <%
          try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "localhorst");
            Statement st = con.createStatement();

            // Get all products from the database.
            ResultSet rs = st.executeQuery("select * from manufactura");

            // All Products to be displayed inside an html-table.
            out.write("<table class=\"\">");
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
            out.write("<a title=\"Zum Warenkorb hinzufügen\" class=\"\" href=\"admin_categories.jsp\">Zur Kategorie-Ansicht</a>");
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
