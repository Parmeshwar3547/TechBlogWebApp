package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    
    Connection con;
    
    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getCategorys() {
        ArrayList<Category> list = new ArrayList<>();
        
        try {
            String q = "select * from categories";
            Statement st = con.createStatement();
            ResultSet set = st.executeQuery(q);
          
            while (set.next()) {    
             
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                
                Category c = new Category(cid, name, description);
                list.add(c);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f=false;
        
        try {
            String q= "insert into posts(Ptitle, pContent, pCode, pPic, catid,userid) values(?,?,?,?,?,?)";
            
            PreparedStatement pstmt= con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2,p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return f;
    }
    
    //getAll post
    public List<Post> getAllPost(){
        List<Post> list =new ArrayList<>();
        //fetch All post
        
        try {
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            ResultSet set= p.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date= set.getTimestamp("pDate");
                int catId= set.getInt("catid");
                int userId = set.getInt("userid");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    //get post by catId
    public List<Post> getPostByCatId(int catId){
        List<Post> list= new ArrayList<>();
        
        try {
            PreparedStatement p = con.prepareStatement("select * from posts where catid=?");
            p.setInt(1, catId);
            ResultSet set= p.executeQuery();
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date= set.getTimestamp("pDate");
              
                int userId = set.getInt("userid");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
