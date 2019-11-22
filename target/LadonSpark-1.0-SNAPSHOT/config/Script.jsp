
        <%
          
           String netmask=(String)request.getSession().getAttribute("maskred");
           String url=(String)request.getSession().getAttribute("url");
            System.out.println("Entra en la pagina script");
             Process p;
             System.out.println(url);
   String xml=url+"nmapData.xml";
   String script=url+"script/nmap.sh";
        System.out.println(netmask);
 /*
     p = new  ProcessBuilder("/bin/bash", script);
    // p.command(new String[]{script,netmask,url});
    final Process pro = p.start();
    */
        System.out.println("antes del comando");
    p=Runtime.getRuntime().exec("nmap -sP "+netmask+" -oX "+xml);
   
  if( p.waitFor()==0){
      request.getSession().setAttribute("initial", "initial");
        response.sendRedirect("../webControler");
        }
            %>

