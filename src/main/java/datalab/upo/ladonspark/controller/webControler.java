/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import datalab.upo.ladonspark.model.Host;
import datalab.upo.ladonspark.model.dateConnect;
import org.jdom2.JDOMException;

/**
 *
 * @author amfergom
 */
public class webControler extends HttpServlet {
  dateConnect dc;
    List<Host> lh;
    Host master;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
      public webControler() throws JDOMException, IOException, InterruptedException {
       
        dc = new dateConnect(null, null);
        master = new Host(null, null, true);
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException,  JDOMException, InterruptedException {
        String accion = request.getParameter("accion");
        HttpSession s = request.getSession();
        String initial = (String) s.getAttribute("initial");
        if (initial != null) {
            accion = "callload";
        }

        if (accion != null) {
            if (accion.equals("loadData")) {

                String redmask = request.getParameter("maskred");;
                String userOs = request.getParameter("user");
                String interfaz = request.getParameter("interfaz");
                if ((validatemask(redmask) && validateuser(userOs) && validateinter(interfaz))) {
                    s.setAttribute("maskred", redmask);
                    s.setAttribute("url", this.getPath());
                    s.setAttribute("user", userOs);
                    s.setAttribute("interfaz", interfaz);
                    dc.setInterfaz(interfaz);
                    dc.setUser(userOs);
                    String url = "config/Script.jsp";
                    response.sendRedirect(url);
                } else {
                    request.getSession().setAttribute("infoset1", "Invalid format: check the Fields Descriptions box");
                    String url = "config/masterconfig.jsp";
                    response.sendRedirect(url);
                }
            }

            if (accion.equals("callload")) {
                Loaddata ld = new Loaddata();
                String interfaz = (String) s.getAttribute("interfaz");
                System.out.println(interfaz);
                ld.loadXml(this.getPath(), interfaz);
                master = ld.getMasterHost();
                s.setAttribute("master", master.getIp());
                this.setLh(ld.getHostfind());

                s.setAttribute("listHost", this.getLh());
                String url = "config/viewHost.jsp";
                response.sendRedirect(url);
            }

            if (accion.equals("selectHost")) {
                lh = (List<Host>) request.getSession().getAttribute("hostlist");
                List<Host> aux = lh;
                List<Host> aux2 = new ArrayList<>();
                String[] ips = request.getParameterValues("ip");
                /*
                LLamada a los metodos de generación de ficheros y copia de los ficheros en los worker. 
                 */
                for (int i = 0; i < ips.length; i++) {
                    Host h = new Host("uname", ips[i], false);
                    for (int j = 0; j < aux.size(); j++) {
                        if (aux.get(j).equals(h)) {
                            aux2.add(aux.get(j));
                        }
                    }
                }
                this.setLh(aux2);
                s.setAttribute("listHost", this.getLh());
                String url = "config/selectedhost.jsp";
                response.sendRedirect(url);

            }
            if (accion.equals("cancelarSeleccion")) {

            }
            if (accion.equals("ok")) {
                if (request.getParameter("button").equals("Select")) {
                    Loaddata ld = new Loaddata();
                    lh = (List<Host>) request.getSession().getAttribute("hostlist");
                    ld.createSlaveFile(lh, getPath());
                    ld.loadXml(this.getPath(), (String) s.getAttribute("interfaz"));
                    String validate = request.getParameter("hidenshow");
                    System.out.println(validate);
                    if (validate != null) {
                        String core = request.getParameter("core");
                        String memory = request.getParameter("memory");
                        String instance = request.getParameter("instances");
                        if (validatecore(core) && isNumeric(core) && validatememory(memory) && validateinstance(instance) && isNumeric(instance)) {
                            ld.createMasterFile(ld.getMasterHost(), this.getPath(),(String)s.getAttribute("user"), core, memory, instance);
                        } else {
                            ld.createMasterFile(ld.getMasterHost(), this.getPath(),(String)s.getAttribute("user"));
                        }
                    } else {
                        ld.createMasterFile(ld.getMasterHost(), this.getPath(),(String)s.getAttribute("user"));
                    }
                    s.setAttribute("url", this.getPath());
                    String url = "config/sentcf.jsp";
                    response.sendRedirect(url);
                } else {
                    Loaddata ld = new Loaddata();
                    s.setAttribute("listHost", ld.loadXml(this.getPath(), (String) s.getAttribute("interfaz")));
                    String url = "config/viewHost.jsp";
                    response.sendRedirect(url);
                }
            }

        } else {

            String url = "config/masterconfig.jsp";
            response.sendRedirect(url);
        }
    }
 public String getPath() {
        String realpath = getServletContext().getRealPath("/");
        String[] x = realpath.split("/");
        realpath = x[0] + "/" + x[1] + "/" + x[2] + "/" + x[3] + "/" + x[4] + "/";
        return realpath;
    }

    public List<Host> getLh() {
        return lh;
    }

    public void setLh(List<Host> lh) {
        this.lh = lh;
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
        } catch (JDOMException ex) {
            Logger.getLogger(webControler.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(webControler.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (JDOMException ex) {
            Logger.getLogger(webControler.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(webControler.class.getName()).log(Level.SEVERE, null, ex);
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

 public boolean validatemask(String key) {
        System.out.println("el key que entra es: " + key);
        boolean result = true;
        if (key == null && key.equals("")) {
            System.out.println("validate mask1");
            result = false;
        }
        String[] cmp = key.split("\\.");
        if (cmp.length != 4) {

            result = false;
        }
        System.out.println("es un numero el 192: "+isNumeric("192"));
        for (int i = 0; i < cmp.length-1; i++) {
            
            if(!isNumeric(cmp[i])){
                System.out.println(cmp[i]);
            result=false;
            }
        }
        System.out.println(cmp[cmp.length-1]);
        String[] cmp2=cmp[cmp.length-1].split("/");
        if(cmp2.length!=2){
        result=false;
        }else{
        if(!isNumeric(cmp2[0]) || !isNumeric(cmp2[1])){
        result=false;
        }
        
        }
        return result;
    }

    public boolean validateuser(String key) {
        boolean result = true;
        if (key == null || key.equals("") || key.equals(" ") || key.length() < 3) {
            System.out.println("validate user");
            result = false;
        }
        return result;
    }

    public boolean validateinter(String key) {
        boolean result = true;
        if (key.length() > 6 || key == null || key.equals("")) {
            System.out.println("validate iface1");
            result = false;
        }
        if (key.charAt(0) != 'e' && key.charAt(0) != 'w') {
            System.out.println("validate iface2");
            result = false;
        }
        return result;
    }

    public boolean validatecore(String key) {
        boolean result = true;
        if (key == null || key.equals("") || key.equals(" ")) {
            System.out.println("validate user");
            result = false;
        }
        return result;
    }

    public boolean validatememory(String key) {
        boolean result = true;
        if (key == null || key.equals("") || key.equals(" ")) {
            System.out.println("validate user");
            result = false;
        }
        return result;
    }

    public boolean validateinstance(String key) {
        boolean result = true;
        if (key == null || key.equals("") || key.equals(" ")) {
            System.out.println("validate user");
            result = false;
        }
        return result;
    }

    private static boolean isNumeric(String cadena) {
        try {
            Integer.parseInt(cadena);
            return true;
        } catch (NumberFormatException nfe) {
            return false;
        }
    }
}
