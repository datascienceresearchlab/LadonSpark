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
    Document   : launchAlgot
    Created on : 15-mar-2016, 16:25:39
    Author     : antonio
--%>

<%@page import="datalab.upo.ladonspark.model.Parameter"%>
<%@page import="java.util.List"%>
<%@page import="datalab.upo.ladonspark.model.DaoParameter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="datalab.upo.ladonspark.model.lauchAlgoritm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="../include/header.jsp" %>
    </head>
    <body>
        <%@include file="../include/menu.jsp" %>
        <div class="col-lg-12">

            <%            String upa = (String) request.getSession().getAttribute("clusterup");
                if (upa != null && up.equals("up")) {

                    DaoParameter da = new DaoParameter();

                    lauchAlgoritm la = (lauchAlgoritm) request.getSession().getAttribute("launch");
                    List<Parameter> lp = da.getParameterAlg(la.getA().getIdAlg());
                    String caden = "";
                    for (int i = 0; i < la.getParameter().size(); i++) {
                        caden += lp.get(i).getNamePar() + " " + la.getParameter().get(i) + "<br>";
                    }
            %>
            <h1>Algorithm: <%=la.getA().getNameAlg()%></h1>
            <h4>Data Set: <%=la.getDataset()%></h4>
            <h4> <%=caden%></h4>

            <%
                System.out.println("Entra en la ejecución del algoritmo");
                String cadena = "";
                for (int i = 0; i < la.getParameter().size(); i++) {
                    cadena += " " + la.getParameter().get(i);
                }
                String command = "sh /home/" + request.getSession().getAttribute("user") + "/spark/bin/spark-submit --class " + la.getA().getUrlAlg() + " --master spark://" + request.getSession().getAttribute("master") + ":7077 " + request.getSession().getAttribute("algorfiles") + "src/main/webapp/algorithm/dataAlgoritm/" + la.getA().getClass_() + " hdfs://" + request.getSession().getAttribute("master") + ":8020/user/input/" + la.getDataset() + cadena;
             //Nueva versión 
             //String command = "sh /opt/spark/bin/spark-submit --class " + la.getA().getUrlAlg() + " --master spark://" + request.getSession().getAttribute("master") + ":7077 " + request.getSession().getAttribute("algorfiles") + "src/main/webapp/algorithm/dataAlgoritm/" + la.getA().getClass_() + " hdfs://" + request.getSession().getAttribute("master") + ":8020/user/input/" + la.getDataset() + cadena;
              //  String command2="/home/antonio/spark/bin/spark-submit --class KMeans --master spark://192.168.1.101:7077 /opt/hadoop/kmeans.jar /home/antonio/spark/prueba.csv 2 5";
                out.write("Generated command " + command);
                Process k = Runtime.getRuntime().exec(command);
                k.waitFor();
                System.out.println("despues de comando");
                InputStream is = k.getInputStream();
                //InputStream is = k.getErrorStream();
                
                // Se prepara un bufferedReader para poder leer la salida más comodamente. 
                BufferedReader br = new BufferedReader(new InputStreamReader(is));

                // Se lee la primera linea 
                String aux = br.readLine();
%>
            <h4>La solucion ha sido <%=aux%></h4> 
            <%
                // Mientras se haya leido alguna linea 
                while (aux != null) {
                    // Se escribe la linea en pantalla 
                    System.out.println(aux);
            %>
            <h4><%=aux%></h4> 
            <%
                        // y se lee la siguiente. 
                        aux = br.readLine();
                    }
                    //  }
                } else {
                    out.write("<h1>Cluster is not available, Please go to cluster's settings and configure your cluster </h1>");
                }
            %>
        </div>
    </body>
</html>
