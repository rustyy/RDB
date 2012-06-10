<%-- 
    Document   : header.inc
    Created on : 10.06.2012, 00:41:24
    Author     : fhofmann
--%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>RDBSHOP</title>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="compass/stylesheets/styles.css" />
    <script src="http://code.jquery.com/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <script>
      $(document).ready(function(){
        $(".form-order").validate({
          rules: {
            firstname: "required",
            lastname: "required",
            street: "required",
            city: "required",
            zip: {
              required: true,
              minlength: 1,
              maxlength: 5,
              number: true
              
            }
            
          },
          messages: {
            firstname: "Bitte tragen Sie einen Vornamen ein",
            lastname: "Bitte tragen Sie einen Nachnamen ein",
            street: "Bitte tragen Sie eine Straße ein",
            city: "Bitte tragen Sie eine Stadt ein",
            zip: {
              required: "Bitte tragen Sie eine Postleitzahl ein.",
              minlength: "Die Postleitzahl muss exakt 5 Zeichen enthalten",
              maxlength: "Die Postleitzahl muss exakt 5 Zeichen enthalten",
              number: "PLZ muss eine Zahl sein"
            }
            
          }
        });
      });
    </script>

  </head>
  <body>
    <div id="page">
      <div id="header">
        <a href="index.jsp"><img src="files/logo.png" /></a>
      </div>
