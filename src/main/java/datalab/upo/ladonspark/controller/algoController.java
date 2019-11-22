/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import datalab.upo.ladonspark.model.Algorithm;
import datalab.upo.ladonspark.model.DaoAlgoritm;
import datalab.upo.ladonspark.model.Parameter;
import datalab.upo.ladonspark.model.lauchAlgoritm;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
/**
 *
 * @author amfergom
 */
public class algoController extends HttpServlet {

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
         String accion = request.getParameter("accion");
        HttpSession s = request.getSession();
        if (accion != null) {
            if (accion.equals("add")) {
                String url = "algorithm/addalgo.jsp";
                response.sendRedirect(url);
            }
            if (accion.equals("launchalgo")) {
                
                String name = request.getParameter("namealgo");
                DaoAlgoritm da = new DaoAlgoritm();
                String dataSet = request.getParameter("dataset");
                if(name==null || name.length()==0 || dataSet==null || dataSet.length()==0){
                s.setAttribute("info", "There is an error in the form");
                String url = "algorithm/masteralgo.jsp";
                response.sendRedirect(url);
                }else{
                request.getSession().setAttribute("algorfiles", this.getPath());
                int nump = Integer.parseInt(request.getParameter("numparameter"));
                List<String> parameter = new ArrayList<>();
                for (int i = 0; i < nump; i++) {
                    parameter.add(request.getParameter("parameter" + i));
                }
                lauchAlgoritm la = new lauchAlgoritm(da.getAlgoritm(name), dataSet, parameter);
                s.setAttribute("launch", la);
                String url = "algorithm/launchAlgot.jsp";
                response.sendRedirect(url);
                }
            }if(accion.equals("shutdown")){
                 String url = "config/shutdown.jsp";
                    response.sendRedirect(url);
            }
        } else {
            DaoAlgoritm da = new DaoAlgoritm();
            s.setAttribute("algorithm", da.optenerAlgoritmos());
            String url = "algorithm/masteralgo.jsp";
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(algoController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(algoController.class.getName()).log(Level.SEVERE, null, ex);
        }

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
public String getPath() {
        String realpath = getServletContext().getRealPath("/");
        String[] x = realpath.split("/");
        realpath = x[0] + "/" + x[1] + "/" + x[2] + "/" + x[3] + "/" + x[4] + "/";
        return realpath;
    }
}
