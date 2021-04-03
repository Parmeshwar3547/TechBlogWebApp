
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql.*;
public class UserDao {
   private  Connection  con;

    public UserDao(Connection con) {
        this.con = con;
    }
//   method to insert user to database
    public boolean saveUser(User user){
        boolean f=false;
        try{
            String query = "insert into user(name,email,password,gender) values(?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getGender());
            
            pstmt.executeUpdate();
            f=true;
        }catch (SQLException e){
        }
        return f;
    }
    
//    Get user by useremail and userpassword
    public User getUserByEmailAndPassword(String email, String password){
       User user = null;
       
       try{
           String q="select * from user where email=? and password=?";
           PreparedStatement pstmt = con.prepareStatement(q);
           pstmt.setString(1, email);
           pstmt.setString(2, password);
          ResultSet set= pstmt.executeQuery();
          
          if(set.next()){
              user= new User();
              
              String name= set.getString("name");
              user.setName(name);
              
              user.setId(set.getInt("iduser"));
              user.setEmail(set.getString("email"));
              user.setPassword(set.getString("password"));
              user.setGender(set.getString("gender"));
              user.setDateTime(set.getTimestamp("ts"));
              user.setProfile(set.getString("profile"));
          }
           
       }catch(SQLException e){
       }
        
        return user;
    }
     
    
    //update user data
    
    public boolean updateUser(User user){
        boolean f=false;
        try {
            String q= "update user set name=? , email=? , password=? , gender=? , profile=? where iduser=?";
            
            PreparedStatement pstmt = con.prepareStatement(q);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getProfile());
            pstmt.setInt(6, user.getId());
            
            pstmt.executeUpdate();
            f=true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserbyUserId(int userid){
        User user= null;
        try {
          String q="select * from user where iduser=?";
          PreparedStatement p= this.con.prepareStatement(q);
          p.setInt(1, userid);
          ResultSet set=p.executeQuery();
          
          if(set.next()){
              user= new User();
              
              String name= set.getString("name");
              user.setName(name);
              
              user.setId(set.getInt("iduser"));
              user.setEmail(set.getString("email"));
              user.setPassword(set.getString("password"));
              user.setGender(set.getString("gender"));
              user.setDateTime(set.getTimestamp("ts"));
              user.setProfile(set.getString("profile"));
          }
          
        } catch (Exception e) {
           e.printStackTrace();
        }
        return user;
    }
}
