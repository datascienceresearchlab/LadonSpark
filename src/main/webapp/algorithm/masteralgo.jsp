<%-- 
    Document   : masteralgo
    Created on : 09-mar-2016, 13:32:23
    Author     : antonio
--%>

<%@page import="datalab.upo.ladonspark.model.Algorithm"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <%@include file="../include/header.jsp" %>
        <%
            List<Algorithm> la = (List<Algorithm>) request.getSession().getAttribute("algorithm");
        %>
        <script>
            function validate() {
                var fail = true;
                var indice = document.getElementById("namealgo").selectedIndex;
                if (indice == null || indice <= 0) {
                    fail = false;
                    changediv("you have not selected any algorithm", "#namealgoerr");
                }
                var value = $("#dataset").val();
                if (value == null || value.length == 0 || /^\s+$/.test(value)) {
                    fail = false;
                    changediv("This field cannot be empty", "#dataseterr");
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
    <body>
        <%@include file="../include/menu.jsp" %>
        <div class="formleft">
            <div class="col-lg-12">
                <form action="../algoController" method="post" class="form-horizontal">
                    <h1>Algorithm</h1>
                    <%                        String info = (String) request.getSession().getAttribute("info");
                        if (info != null && !info.equals("")) {
                    %>
                    <h3><%=info%></h3>
                    <%
                        }

                    %>
                    <select  name="namealgo" id="namealgo" >
                        <option value="0" selected >Select an algorithm from the list</option>
                        <% 
                            if(la!=null){
                            for (int i = 0; i < la.size(); i++) {

                        %>
                        <option value="<%= la.get(i).getNameAlg()%>"  > <%= la.get(i).getNameAlg()%></option>
                        <%
                            }
}
                        %><
                    </select>
                    <div id="namealgoerr"></div>
                    <div id="parameter" class="parameter" name="parameter" class="form-group">
                        Select an algorithm and its attributes appear
                    </div>
                    <label > Enter the dataset path</label>
                    <input type="text" id="dataset" name="dataset" ><div id="dataseterr" ></div><br>
                    <input type="hidden" name="accion" value="launchalgo">
                    <input type="submit" class="buttonsend" name="enviar" onclick="return validate()" value="Select">
                </form>
            </div>
        </div>
        <div class="formright">

            <form action="../algoController" method="post" >
                <label>If you like to add an algorithm, please click in the button below</label><br>

                <input type="hidden" name="accion" value="add">
                <input type="submit" class="buttonsend"  value="Add a new algorithm">
            </form>
        </div>
        <script>
            $('select#namealgo').on('change', function () {
                var namealg = $(this).val();
                $('#parameter').empty();
                $.post('../ajaxController', {name: namealg}, function (response) {
                    $('#parameter').html(response);
                });
            }
            );

        </script>
    </body>
</html>
