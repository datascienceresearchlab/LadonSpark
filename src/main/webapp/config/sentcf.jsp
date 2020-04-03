<%
    /*
* This file is part of LadonSpark.

* LadonSpark is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.

* LadonSpark is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with LadonSpark.  If not, see <https://www.gnu.org/licenses/>.
*/
 %>
<%-- 
    Document   : sendcf
    Created on : 03-mar-2016, 12:37:31
    Author     : antonio
--%>

<%@page import="datalab.upo.ladonspark.model.Host"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>sent a config file</h1>
        <%
            System.out.println("entra en sendfile");
            List<Host> lh=(List<Host>)request.getSession().getAttribute("hostlist");
           String url=(String)request.getSession().getAttribute("url");
           String useros=(String)request.getSession().getAttribute("user");
           String url2="/home/"+useros+"/spark/conf";
           String url3="/home/"+useros+"/spark/sbin/start-all.sh";
         Process p;
        for (int i = 0; i < lh.size(); i++) {
            p = Runtime.getRuntime().exec("scp "+url+"slaves "+useros+"@"+lh.get(i).getIp()+":"+url2);
           if( p.waitFor()==0){
              
        System.out.println("terminado correcto");
        }else {
                System.out.println("fallo en ip "+lh.get(i).getIp());
                }
            
        }
        for (int i = 0; i < lh.size(); i++) {
            p = Runtime.getRuntime().exec("scp "+url+"spark-env.sh "+useros+"@"+lh.get(i).getIp()+":"+url2);
             if( p.waitFor()==0){
              
        System.out.println("terminado correcto");
           }else{
             System.out.println("fallo en ip "+lh.get(i).getIp());
             }
            p = Runtime.getRuntime().exec("sh "+url3);  
            if( p.waitFor()==0){
              request.getSession().setAttribute("clusterup", "up");
               
           }
        }
            response.sendRedirect("../algoritmindex.jsp ");
            %>
    </body>
</html>
