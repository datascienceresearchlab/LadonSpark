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
<%@page contentType="text/html" pageEncoding="UTF-8"%>   
<!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container" >
            <center>
            <div>
                <ul class="nav navbar-nav colormenu navnew" >
                    <li >
                        <a href="<%= request.getContextPath()%>">Home</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath()%>/configindex.jsp">Cluster Settings</a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath()%>/algoritmindex.jsp">Algorithm</a>
                    </li>
                    <li>
                         <%
                String up=(String) request.getSession().getAttribute("clusterup");
                if(up!=null && up.equals("up")){
                    %>
                    <a class="shutdown" href="<%= request.getContextPath()%>/config/shutdown.jsp">Shutdown Cluster</a>
                    <%
                }
                %>
                    </li>
                </ul>
            </div>
                    </center>
            <!-- /.navbar-collapse -->
            
        </div>
        <!-- /.container -->
    </nav>