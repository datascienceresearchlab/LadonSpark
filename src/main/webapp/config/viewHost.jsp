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
Document   : viewHost
Created on : 18-feb-2016, 17:12:27
Author     : antonio
--%>

<%@page import="java.util.List"%>
<%@page import="datalab.upo.ladonspark.model.Host"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    List<Host> lh = (List<Host>) request.getSession().getAttribute("listHost");
%>
<html>
    <head>
        <%@include file="../include/header.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script>
            $(document).ready(function () {

                $("#selectall").click(function () {
                    $('input[type=checkbox]').each(function () {
                        $(this).prop("checked", true);
                    });
                });
            });


        </script>
    </head>
    <body>
        <%@include file="../include/menu.jsp" %>
        <h1>All hosts in network</h1>
        <form action="../webControler" method="post">
            <table class="table">

                <tr><th>Name</th><th>IP Address</th><th>Mode</th><th>Check</th></tr>
                        <%                            request.getSession().setAttribute("initial", null);
                            String ipmaster = (String) request.getSession().getAttribute("master");
                            if (lh != null) {

                                for (int i = 0; i < lh.size(); i++) {
                                    String checked = "";
                                    if (lh.get(i).getIp().equals(ipmaster)) {
                                        checked = "checked";

                                    }
                        %>
                <tr>
                    <td><%=lh.get(i).getName()%></td> <td><%=lh.get(i).getIp()%></td> <td><%=lh.get(i).getTypeName()%></td><td><input type="checkbox" id="ip" name="ip" <%=checked%> value="<%=lh.get(i).getIp()%>"</td>
                </tr>
                <%
                    }
                    request.getSession().setAttribute("hostlist", lh);
                %>

            </table>
            <div id="selectall" class="btn btn-default" name="selectall">Select All</div>
            <input type="hidden" name="accion" value="selectHost">
            <input type="submit" class="btn btn-default" value="Select"/>
        </form>
        <%
        } else {
        %>
        <h1>There are not hosts available</h1>
        <%
            }
        %>
    </body>
</html>
