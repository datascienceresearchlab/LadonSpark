<%
   
    Process p= Runtime.getRuntime().exec(" sh /home/" + request.getSession().getAttribute("user") + "/spark/sbin/stop-all.sh");
   p.waitFor();
   request.getSession().setAttribute("clusterup", "down");
    String url = "../configindex.jsp";
    response.sendRedirect(url);
%>
