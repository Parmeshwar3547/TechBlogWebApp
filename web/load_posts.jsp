<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">

<% 
PostDao d= new PostDao(ConnectionProvider.getConnection());
List<Post> posts=d.getAllPost();

for(Post p: posts)
{
    %>
    <div class="col-md-6">
        <div class="card" >
            <img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap"/>
            <div class="card-body">
                <h3><%=p.getpTitle()%></h3>
                <p><%=p.getpContent()%></p>
                <pre><%=p.getpCode() %></pre>
                
            </div>
        </div>
    </div>
    
    
    <%
}
%>
</div>