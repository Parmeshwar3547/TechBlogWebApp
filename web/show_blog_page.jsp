<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pd = new PostDao(ConnectionProvider.getConnection());
    Post p = pd.getPostById(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%>|| Tech Blog</title>
        <!--Bootstrap-->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 74% 0, 100% 0, 100% 95%, 73% 95%, 50% 100%, 14% 94%, 0 92%, 0% 35%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-date{
                font-style: italic;
            }
            body{
                background: url(img/bg.jpg);
                background-size:  cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <!--Navbar Begin-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-rss-square"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-laptop"></span> Learn Coding <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-sort"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Languages</a>
                            <a class="dropdown-item" href="#">Data Structures & Algorithms</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Projects</a>
                        </div>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-edit"></span> Create Post</a>
                    </li>


                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-Modal"><span class="fa fa-user-circle "></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--navbar end-->

        <!--Main content of show post page-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <h4 class="post-title"><%=p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <div class="text-center"><img class="card-img-top img-fluid rounded mx-auto d-block" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap" style=" max-height: 400px; max-width: fit-content"/></div>
                            
                            <div class="row">
                                <div class="col-sm-6 text-left">
                                    <%
                                    UserDao ud= new UserDao(ConnectionProvider.getConnection());
                                    
                                    
                                    %>
                                    
                                    
                                    <p>Post by: <%=ud.getUserbyUserId(p.getUserId()).getName()%></p> 
                                </div>
                                <div class="col-sm-6 text-right">
                                    <p class="post-date">Posted on: <%=DateFormat.getDateInstance().format(p.getpDate())%></p>
                                </div>
                            </div>
                            
                            <p class="post-content"><%=p.getpContent()%></p>
                            <br><br>
                            <div class="post-code">
                                 <pre><%=p.getpCode()%></pre>
                            </div>
                        </div>
                        <div class="card-footer  primary-background">
                           <%
                            LikeDao ld= new LikeDao(ConnectionProvider.getConnection());
                           %>
                           
                            
                           <a href="#!" onclick="doLike(<%=p.getPid()%>, <%=user.getId()%>)" class="btn btn-sm btn-outline-light mr-2"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%=ld.countLike(p.getPid())%></span></a>
                            
                            <a href="#!" class="btn btn-sm btn-outline-light mr-2"><span class="fa fa-commenting-o"></span></a>

                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!--End show post-->
        <!--profile-modal-->

        <!-- Modal -->
        <div class="modal fade" id="profile-Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background">
                        <h5 class="modal-title  text-white text-center" id="exampleModalLabel">Tech Blog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">

                            <img src="profile/<%=user.getProfile()%> "  style=" position: relative;
                                 width: 140px;
                                 height: 140px;
                                 overflow: hidden;
                                 border-radius: 50%; "/>

                            <h5 class="modal-title"><%=user.getName()%></h5>

                            <!-- Profile details-->

                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender().toUpperCase()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Registration Date : </th>
                                            <td><%= user.getDateTime().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--Profile Edit-->

                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2">Edit Profile</h3>    
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID :</td> 
                                            <td><%= user.getId()%></td> 
                                        </tr>
                                        <tr>
                                            <td>Name :</td> 
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td> 
                                        </tr>
                                        <tr>
                                            <td>Email :</td> 
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td> 
                                        </tr>
                                        <tr>
                                            <td>Password :</td> 
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td> 
                                        </tr>
                                        <tr>
                                            <td>Gender :</td> 
                                            <td><%= user.getGender().toUpperCase()%></td> 
                                        </tr>
                                        <tr>
                                            <td>Profile Photo :</td> 
                                            <td><input type="file" name="image" class="form-control "></td> 
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit"  class="btn btn-outline-primary ">Save</button>
                                    </div>

                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--profile-modal end-->


        <!--Add post modal-->
        <div class="modal fade " id="add-post-modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Create Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" enctype="multipart/form-data" action="AddPostServlet" method="post">

                            <div class="form-group">
                                <select name="cid" class="form-control" id="inlineFormCustomSelect">
                                    <option selected disabled  >---Category---</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getCategorys();

                                        for (Category c : list) {
                                    %> 


                                    <option value="<%= c.getCid()%>" > <%= c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input name="pTitle" type="text" class="form-control" placeholder="Enter post title"/>
                            </div>
                            <div class="form-group">
                                <textarea name="pContent" class="form-control" placeholder="Enter your content" style="height:130px"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea name="pCode" class="form-control" placeholder="Write code(if any)" style="height:130px"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Select Photo: </label>
                                <input name="pPic" type="file" class="form-control-file"/>
                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-primary" type="submit">Post</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--End post  modal-->
        <!--javaScripts-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                let editStatus = false;
                $('#edit-profile-button').click(function () {

                    if (editStatus === false) {
                        $("#profile-details").hide();
                        $("#profile-edit").show();

                        editStatus = true;
                        $(this).text("Back");
                    } else
                    {
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus = false;
                    }

                });
            });
        </script>
        <script>
//            now add post js
            $(document).ready(function (e) {
                $('#add-post-form').on("submit", function (event) {
                    //this code call when form is submitted
                    event.preventDefault();

                    let form = new FormData(this);

                    //requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'post',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success
                            console.log(data);
                            if (data.trim() === 'done') {
                                swal("Good job!", "Saved Successfully", "success");
                            } else {
                                swal("Error!", "Something went wrong!", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error
                            swal("Error!", "Something went wrong!", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>
    </body>
</html>
