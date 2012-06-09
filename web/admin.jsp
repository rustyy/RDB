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
    <title>JSP Page</title>
    <link rel="stylesheet" type="text/css" href="compass/stylesheets/styles.css" />
  </head>
  <body>

    <div id="page">
      <div id="header"></div>
      <div id="content">

        <form action="admin.jsp" method="get">
          <p>Name*</p>
          <input type="text" name="name">
          <p>Preis*</p>
          <input type="text" name="price">
          <p>Hersteller*</p>
          <input type="text" name="producer_name">
          <p>Details</p>
          <input type="text" name="details">
          <p>Kategorie*</p>
          <input type="text" name="category_name">
          <input type="submit" value="submit">
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

            // Get the database driver.
            try {
              Class.forName("org.gjt.mm.mysql.Driver");
              out.println("DB-Treiber da!");
            } catch (ClassNotFoundException e) {
              out.println("DB-Treiber nicht da!");
            }


            try {
              Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rdbshop", "root", "root");
              Statement st = con.createStatement();
              String queryString = "INSERT INTO product(name, price,producer_name, details, category_name) VALUES (\""+name+"\","+price+",\""+producer+"\",\""+details+"\",\""+category+"\")";
              updateQuery = st.executeUpdate(queryString);
              if (updateQuery != 0){
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

      </div>
      <div id="footer"></div>
    </div>
  </body>
</html>
