/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.activation.*;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
/**
 *
 * @author amfergom
 */
public class conctactController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String result = "";
        String accion = request.getParameter("accion");
        if (accion != null) {
            String name = request.getParameter("name");
            String lname = request.getParameter("secname");
            String email = request.getParameter("email");
            String description = request.getParameter("description");
            System.out.println(isValidEmailAddress(email));
            if (!(name != null || name.equals("") || lname != null || lname.equals("") || email != null || email.equals("") || description != null || description.equals(""))) {
                request.getSession().setAttribute("info", "Alguncampo esta vacio.");
                String url = "Contact/index.jsp";
                response.sendRedirect(url);

            } else {
                
            
                if (isValidEmailAddress(email)) {
                System.out.println("entraa");
                Properties props = new Properties();
                props.setProperty("mail.smtp.host", "smtp.gmail.com");

                props.setProperty("mail.smtp.starttls.enable", "true");

                props.setProperty("mail.smtp.port", "587");

                props.setProperty("mail.smtp.user", "sparkclusterlaunchalgo@gmail.com");

                props.setProperty("mail.smtp.password", "clusterspark");

                props.setProperty("mail.smtp.auth", "true");

                Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(
                                "sparkclusterlaunchalgo@gmail.com", "clusterspark");
                    }
                });
                mailSession.setDebug(true);

                try {

                    MimeMessage message = new MimeMessage(mailSession);

                    message.setFrom(new InternetAddress(email));

                    message.addRecipient(Message.RecipientType.TO,
                            new InternetAddress(props.getProperty("mail.smtp.user")));

                    message.setSubject("Contact page of sparkcluster");

                    message.setText("Nombre: " + name + "\nApellido: " + lname + "\nemail: " + email + "\nContenido: \n" + description);

                    Transport.send(message);
                    result = "Sent message successfully....";
                } catch (MessagingException mex) {
                    mex.printStackTrace();
                    result = "Error: unable to send message....";
                }
                request.getSession().setAttribute("info", "El correo se enviado con exito.");
                String url = "Contact/index.jsp";
                response.sendRedirect(url);
            } else {
                   request.getSession().setAttribute("info", "El correo no es valido.");
                String url = "Contact/index.jsp";
                response.sendRedirect(url); 
                }
                }
        }else {
            
            String url = "Contact/index.jsp";
            response.sendRedirect(url);
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
 public static boolean isValidEmailAddress(String email) {
        String regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[_A-Za-z0-9-]+)";
        return email.matches(regex);
    }

}
