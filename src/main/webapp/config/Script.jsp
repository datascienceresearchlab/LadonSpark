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

