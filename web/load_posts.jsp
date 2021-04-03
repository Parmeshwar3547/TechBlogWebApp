<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">

<% 
      User user=(User) session.getAttribute("currentUser");
PostDao d= new PostDao(ConnectionProvider.getConnection());
int cid= Integer.parseInt(request.getParameter("cid"));
List<Post> posts=null;
if (cid==0) {
        posts=d.getAllPost(); 
    } else {
    posts= d.getPostByCatId(cid);
    }

    if(posts.size()==0){
        out.println("<h3 class='display-3 text-center'>No posts here!</h3>");
        return;
    }


for(Post p: posts)
{
    %>
    <div class="col-md-12 col-sm-12">
        <div class="card mt-2" >
            <div class="text-center">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap" style=" max-height: 400px; max-width: fit-content"/>
            </div>
            <div class="card-body">
                <h3><%=p.getpTitle()%></h3>
                <p class="p-content"><%=p.getpContent()%></p>
            </div>
            <div class="card-footer text-center primary-background">
                <%
                LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
              
                %>
                
                <a href="#!" onclick="doLike(<%=p.getPid()%>, <%=user.getId()%>)" class="btn btn-sm btn-outline-light mr-2"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%=ld.countLike(p.getPid())%></span></a>
                   <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-sm btn-outline-light mr-2">Read more</a>
             
                <a href="#!" class="btn btn-sm btn-outline-light mr-2"><span class="fa fa-commenting-o"></span></a>
                
            </div>
        </div>
    </div>
    
    
    <%
}
%>
</div>
<script type="text/javaScript">
    $(".p-content").each(function(){
        if($(this).text().length>250)
        {$(this).text($(this).text().substr(0,250)+'...');}
    })
</script>
