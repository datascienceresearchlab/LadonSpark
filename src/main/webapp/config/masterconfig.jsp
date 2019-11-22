
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <%@include file="../include/header.jsp" %>
        <script>
            function validate() {
                var fail = true;
                $(document).ready(function ()
                {
                    var value = $("#maskred").val()
                    if (value.length == 0 || value == null || value == "" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("This field cannot be empty", "#maskrederr");
                    } else {

                        var count = value.split(".");
         
                        if (count.length != 4) {
                            fail = false;
                            changediv("Invalid format: check the Fields Descriptions box", "#maskrederr");
                        } else {
                            for (var i = 0; i < count.length - 1; i++) {
                     
                                if (isNaN(count[i])) {
                                    fail = false;
                                }
                            }
                            var count2 = count[count.length - 1].split("/")
                            
                            if (isNaN(count2[0]) || isNaN(count2[1])) {
                                fail = false;
                                changediv("Invalid format: check the Fields Descriptions box", "#maskrederr");
                            }
                        }
                    }
                    value = $("#user").val()
                    if (value.length == 0 || value == null || value == "" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("This field cannot be empty", "#usererr");
                    }


                    value = $("#interfaz").val()
                    if (value.length == 0 || value == null || value == "" || /^\s+$/.test(value)) {
                        fail = false;
                        changediv("this fields can not be empty", "#interfazerr");
                    } else {
                        if (value.charAt(0) != 'e' && value.charAt(0) != 'w' && isNaN(value.charAt(value.length - 1))) {
                            fail = false;
                            changediv("Invalid format: check the Fields Descriptions box", "#interfazerr");
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
                <h1>Cluster settings</h1>

                <%     String info = (String) request.getSession().getAttribute("infoset1");
                    if (info != null && !info.equals("")) {
                %>
                <h3><%=info%></h3>
                <%
                        request.getSession().setAttribute("infoset1", "");
                    }
                %>

                <form method="post" class="form-horizontal"  action="../webControler">

                    <label>Enter the network mask</label><br>


                    <input type="text" id="maskred" name="maskred"  /><div id="maskrederr" class="maskrederr"></div><br>

                    <label> Enter the operating system user</label><br>


                    <input type="text" id="user" name="user"/><div id="usererr" class="usererr"></div><br>


                    <label> Enter network interface</label><br>

                    <input type="text" id="interfaz" name="interfaz"/><div id="interfazerr" class="interfazerr"></div><br>
                    <input type="hidden" name="accion" value="loadData">
                    <input type="submit" class="buttonsend" value="Send" onclick="return validate()" name="principal"/>

                </form>
            </div>
        </div>
        <div class="formright descriptionfield">
            <h4>Fields description</h4>
            <ul>
                <li>Field network mask</li>
                <ol>
                    <li>The format should be XXX.XXX.XXX.0/XX</li>
                    <li>Depending subnetwork some number could change</li>
                    <li>Example: 192.168.1.0/24 </li>
                </ol>
                <li>Operating system user</li>
                <ol>
                    <li>The user must enter the user is created on all machines</li>
                </ol>
                <li>Network interface</li>
                <ol>
                    <li>The interface sould be wlanx ethx</li>
                    <li>Example: wlan0 eth0</li>
                </ol>
            </ul>

        </div>

    </body>
</html>