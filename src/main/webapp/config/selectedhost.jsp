<%-- 
    Document   : selectedhost
    Created on : 25-feb-2016, 13:30:34
    Author     : antonio
--%>

<%@page import="java.util.List"%>
<%@page import="datalab.upo.ladonspark.model.Host"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <%@include file="../include/header.jsp" %>
        <script>

            function avanform() {
                $(document).ready(function () {
                        if ($('input[name=hidenshow]').is(':checked')) {
                            $('#advconf').show();
                        } else { 
                            $('#advconf').hide();
                        }
                    
                });
            }/*
         * 
         * Configurar el changediv y acabar de validar los campos auto generados
   
             * @returns {undefined}          */
            function validate(){
                var fail=true;
                  if ($('input[name=hidenshow]').is(':checked')) {
                      var value = $("#core").val()
                   if (value.length == 0 || value==null || value=="" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("This field cannot be empty", "#corerr");
                    }else if(isNaN(value)){
                        fail=false;
                        changediv("This field should be a number","#corerr")
                    }
                       var value = $("#memory").val()
                   if (value.length == 0 || value==null || value=="" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("This field cannot be empty", "#memoryerr");
                    }
                       var value = $("#instances").val()
                    if (value.length == 0 || value==null || value=="" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("This field cannot be empty", "#instanceserr");
                    }else if(isNaN(value)){
                        fail=false;
                        changediv("This field should be a number","#instanceserr")
                    }
                  }
                  return fail;
            }
            
             function changediv(error, id) {


                $(document).ready(function () {
                    $(id).html(error);
                    $(id).css("color", "red");
                });

            }

        </script>
    </head>
    <%
        List<Host> lh = (List<Host>) request.getSession().getAttribute("listHost");
    %>
    <body>
        <%@include file="../include/menu.jsp" %>
        <h1>Selected Hosts</h1>
        <form action="../webControler" method="post">
            <table class="table">

                <tr>
                    <th>Name</th>
                    <th>IP Address</th>
                    <th>Mode</th>
                </tr>
                <%
                    for (int i = 0; i < lh.size(); i++) {
                %>
                <tr>
                    <td><%=lh.get(i).getName()%></td> <td><%=lh.get(i).getIp()%></td> <td><%=lh.get(i).getTypeName()%></td>
                </tr>
                <%
                    }
                    request.getSession().setAttribute("hostlist", lh);
                %>

            </table>
                <input type="checkbox" name="hidenshow" value="activate" onclick="avanform(this)" > Advanced configuration<br>
            <div id="advconf" hidden>
                <label>SPARK worker cores</label> <br>
                <input type="text" id="core" name="core"><div id="corerr"></div><br>
                <label>SPARK worker memory</label><br> 
                <input type="text" id="memory" name="memory"><div id="memoryerr"></div><br>
                <label>SPARK worker instances </label> <br>
                <input type="text" id="instances" name="instances"><div id="instanceserr"></div><br>

            </div>
                <br>
            <input type="hidden" name="accion" value="ok">
            <input type="submit" class="btn btn-default bettewn" name="button" onclick="return validate()" value="Select">
            <input class="btn btn-default bettewn" type="submit" name="button" value="Cancel">
        </form>
        
    </body>
</html>
