
<%@page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! Something went wrong</title>
        <!--Bootstrap-->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        
     
        
    </head>
    <body>
        <div class="container text-center ">
            <img src="img/error.png" alt="Error occured!" class="img-fluid " style="width: 40%"/>
            <h3 class="display-4">Sorry! Something went wrong.</h3>
            <%= exception %>
            <a href="index.jsp" class="btn btn-lg primary-background text-white" style="margin: 10px">Home</a>
        </div>
    </body>
</html>
