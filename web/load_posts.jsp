<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">

<% 
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
    <div class="col-md-6">
        <div class="card mt-2" >
            <img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap"/>
            <div class="card-body">
                <h3><%=p.getpTitle()%></h3>
                <p><%=p.getpContent()%></p>
            </div>
            <div class="card-footer text-center primary-background">
                   <a href="#!" class="btn btn-sm btn-outline-light mr-2"><span class="fa fa-thumbs-o-up"></span></a>
                   <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-sm btn-outline-light mr-2">Read more</a>
             
                <a href="#!" class="btn btn-sm btn-outline-light mr-2"><span class="fa fa-commenting-o"></span></a>
                
            </div>
        </div>
    </div>
    
    
    <%
}
%>
</div>
