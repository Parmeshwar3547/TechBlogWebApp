package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            fetch all data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            //uploading img using servlet
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get user from session
            HttpSession httpSession = request.getSession();
            User user = (User) httpSession.getAttribute("currentUser");

            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            String oldFile=user.getProfile();
            user.setProfile(imageName);

            //update data in database
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = dao.updateUser(user);
            if (ans) {
                //new profile photo path
                String path = request.getServletContext().getRealPath("/") + "profile" + File.separator + user.getProfile();
                out.println(path);
                
                //Delete old profile photo
                String pathOld = request.getServletContext().getRealPath("/") + "profile" + File.separator + oldFile;
                if(!oldFile.equals("default.png")){
                Helper.deleteFile(pathOld);
                }
                
                if (Helper.saveFile(part.getInputStream(), path)) {
                    
                    Message msg = new Message("Profile Updated ", "success", "alert-success");
                    httpSession.setAttribute("msg", msg);
                    
                }else{
                     Message msg = new Message("Something went wrong! ", "error", "alert-danger");
                    httpSession.setAttribute("msg", msg);
                }

            } else {
                 Message msg = new Message("Something went wrong! ", "error", "alert-danger");
                    httpSession.setAttribute("msg", msg);
                    
            }
            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
