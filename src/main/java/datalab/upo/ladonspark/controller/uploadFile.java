/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import datalab.upo.ladonspark.model.Algorithm;
import datalab.upo.ladonspark.model.DaoAlgoritm;
import datalab.upo.ladonspark.model.DaoParameter;
import datalab.upo.ladonspark.model.Parameter;
import datalab.upo.ladonspark.model.objectresult;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 *
 * @author amfergom
 */
public class uploadFile extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        List<objectresult> lor = new ArrayList<>();
        List<objectresult> loraux = new ArrayList<>();
        boolean result = false;
        String urlf = "";
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

// req es la HttpServletRequest que recibimos del formulario.
// Los items obtenidos serán cada uno de los campos del formulario,
// tanto campos normales como ficheros subidos.
        List items = upload.parseRequest(request);

// Se recorren todos los items, que son de tipo FileItem
        for (Object item : items) {
            FileItem uploaded = (FileItem) item;

            // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
            // subido donde nos interese
            if (!uploaded.isFormField()) {
                // No es campo de formulario, guardamos el fichero en algún sitio
                if (!uploaded.getName().equals("")) {
                    urlf = uploaded.getName();
                    File fichero = new File(this.getPath() + "src/main/webapp/algorithm/dataAlgoritm/", uploaded.getName());
                    uploaded.write(fichero);
                } else {
                    result = true;
                }
            } else {
                // es un campo de formulario, podemos obtener clave y valor
                String key = uploaded.getFieldName();
                String value = uploaded.getString();
                lor.add(new objectresult(key, value));
                if (value == null || value.equals("")) {
                    result = true;
                  
                }
            }
        }

        if (result) {
            request.getSession().setAttribute("error", "error");
            String url = "algorithm/addalgo.jsp";
            response.sendRedirect(url);
        } else {
            Algorithm a = new Algorithm(lor.get(0).getValue(), lor.get(1).getValue(), urlf);
            DaoAlgoritm da = new DaoAlgoritm();
            da.create(a);
            a = da.getAlgoritm(a.getNameAlg());
            DaoParameter dp = new DaoParameter();
            for (int i = 3; i < lor.size(); i++) {
                dp.create(new Parameter(a, lor.get(i).getValue(), lor.get(i + 1).getValue()));
                i++;
            }

            request.getSession().setAttribute("algorithm", new DaoAlgoritm().optenerAlgoritmos());
            String url = "algorithm/masteralgo.jsp";
            response.sendRedirect(url);
        }
    }
      public String getPath() {
        String realpath = getServletContext().getRealPath("/");
        String[] x = realpath.split("/");
        realpath = x[0] + "/" + x[1] + "/" + x[2] + "/" + x[3] + "/" + x[4] + "/";
        return realpath;
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
            Logger.getLogger(uploadFile.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(uploadFile.class.getName()).log(Level.SEVERE, null, ex);
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

}
