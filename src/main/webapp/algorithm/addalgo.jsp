<%-- 
    Document   : addalgo
    Created on : 11-mar-2016, 11:43:37
    Author     : antonio
--%>

<%@page import="java.util.List"%>
<%@page import="datalab.upo.ladonspark.model.objectresult"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <%@include file="../include/header.jsp" %>
        <script>
            function loadForm() {
                var value = document.getElementById("numParameter").value;
                var texto = "";
                for (var i = 0; i < value; i++) {
                    texto += "<label>Insert name and type</label><br>\n\
                    <input type='text' id='name" + i + "' name='name" + i + "' />\n\
                       <input type='text' id='ty" + i + "' name='ty" + i + "' /><div id='name" + i + "err'></div><div id='ty" + i + "err'></div><br>";
                }
                changeParameter(texto)
            }
            function changeParameter(texto) {
                document.getElementById("parameter").innerHTML = texto;
            }
            function cancelform() {
                window.location = "../algoritmindex.jsp";
            }
            function validate() {
                var fail = true;
                $(document).ready(function ()
                {
                    var value = $("#namealgo").val();
                    if (value.length == 0 || value == null || value == "" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("this fields can not be empty", "#namealgoerr");
                    }
                    var value = $("#pclass").val();
                    if (value.length == 0 || value == null || value == "" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("this fields can not be empty", "#pclasserr");
                    }
                    var value = $("#file").val();
                    if (value.length == 0 || value == null || value == "") {
                        fail = false;
                        changediv("this fields can not be empty", "#fileerr");
                    }
                    var value = $("#numParameter").val();
                    for (var i = 0; i < value; i++) {
                        var p1=$("#name"+i).val();
                         var p2 =$("#ty"+i).val();    
                        if (p1.length == 0 || p1 == null || p1 == "") {
                            fail = false;
                            changediv("this fields can not be empty", "#name"+i+"err");
                        }
                        if (p2.length == 0 || p2 == null || p2 == "") {
                            fail = false;
                            changediv("this fields can not be empty", "#ty"+i+"err");
                        }
                       
                    }
                });
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

                <h1>Complete the form to add a new algorithm</h1>
                <%                      String validate = (String) request.getSession().getAttribute("error");
                    if (validate != null) {
                        request.getSession().setAttribute("error", "");
                %>
                <h3>It has found error in input fields, please read tip and change fields</h3>

                <%
                    }
                %>

                <form action="../uploadFile"  method="post" enctype="multipart/form-data">
                    <label>Name of the Algorithm</label><br>
                    <input type="text" name="namealgo" id="namealgo" ><div id="namealgoerr" class="namealgoerr"></div><br
                        <label>Principal Class</label><br>
                    <input type="text" name="pclass" id="pclass" ><div id="pclasserr" class="pclasserr"></div><br>
                    <label>Select binary file</label><br>
                    <input type="file" name="file" id="file"><div id="fileerr" class="fileerr"></div><br>
                    <label>Number of parameters</label>
                    <input type="text" name="numParameter" id="numParameter" onkeyup="loadForm(this)">
                    <div id="parameter">
                    </div>

                    <input type="submit" class="buttonsend"  onclick="return validate()" value="Create">
                    <input type="button" class="buttonsend" value="Cancel" onclick="cancelform()">
                </form>

            </div>
        </div>
        <div class="formright descriptionfield">
            <h4>Fields description</h4>
            <ol>
                <li>Name of the Algorithm</li>
                <ul>
                    <li>A descriptive name for your algorithm</li>
                </ul>
                <li>Pricipal class</li>
                <ul>
                    <li>This is the main class of the algorithm</li>
                    <li>It does not need extension</li>
                    <li>Example: org.apache.spark.examples.SparkPi</li>
                </ul>
                <li>Binary File</li>
                <ul>
                    <li>The File that you upload, should be a <I>.jar</I> packet</li>
                    <li>You do not upload anything</li>
                </ul>
                <li>Number of parameters</li>
                <ul>
                    <li>This is the number of fields that will be created</li>
                    <li>Remember that you must complete all the fields</li>
                </ul>
            </ol>
        </div>
    </body>
</html>
