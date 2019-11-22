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