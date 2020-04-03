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
    Document   : index
    Created on : 08-mar-2016, 16:26:31
    Author     : antonio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="include/header.jsp" %>
    </head>
    <body >
        <%@include file="include/menu.jsp" %>
        <div class="textbienve">
            <div class="col-lg-12">
                <center>
                    <h1>Welcome to LadonSpark</h1>
                </center>
                <img style="float:left; margin:10px;"width="200px" height="200px" alt="" src="include/img/ladon.jpeg"/>The dragon Ladon of Greek mythology was a dragon of a hundred heads (each of which spoke a different language), along with the Hesperides nymphs, was in charge of guarding the garden of the Hesperides.
                <br> 
                Like this information system, capable of having more than 100 nodes and running algorithms in different programming languages as R, Scala, Python, Java.
                <br> 
                La aplicación esta contruida con una integración de las siguientes tecnologias:
                <ul>
                    <li>Apache Spark: Para el proceso de computación es un framework.</li>
                    <li>Apache Hadoop HDFS: El sistema de ficheros ditribuidos</li>
                </ul>
            </div>
        </div>
    </body>
</html>
