/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import datalab.upo.ladonspark.model.Host;
import org.jdom2.*;
import org.jdom2.input.SAXBuilder;

/**
 *
 * @author antonio
 */
public class Loaddata {

    
    private List<Host> hostfind;

    public Loaddata() throws JDOMException, IOException, InterruptedException {
        
    }

    public List<Host> getHostfind() {
        return hostfind;
    }

    public void setHostfind(List<Host> hostfind) {
        this.hostfind = hostfind;
    }

    /*
    Metodo para obtener los datos del XML
     */
    public List<Host> loadXml(String url,String interfaz) throws JDOMException, IOException, InterruptedException {
        System.out.println("\n\ncargando datos xml\n\n");
        List<Host> hostfind = new ArrayList<>();
        String name = "";
        String ip = "";

        String myIp = findMyIp(interfaz);
        boolean type = false;

        FileReader xmlFile = new FileReader(url + "nmapData.xml");
        System.out.println("pasa file");
        SAXBuilder builder = new SAXBuilder();
        Document document = (Document) builder.build(xmlFile);
        Element rootNode = document.getRootElement();
        /*
        obtain the host list in XML file
        sacamos la lista de Host del fichero XML
         */
        List<Element> hosts = rootNode.getChildren("host");
        // hosts=hosts.get(0).getChildren("host");

        for (int i = 0; i < hosts.size(); i++) {
            Element host = hosts.get(i);
            /*
            Obtain the hostname list in list host and obtain the address list in self list host
            
             */
            List<Element> hostnames = host.getChildren("hostnames");
            List<Element> address = host.getChildren("address");

            if (hostnames.get(0).getChild("hostname") != null) {
                name = hostnames.get(0).getChild("hostname").getAttributeValue("name");
                ip = address.get(0).getAttributeValue("addr");

            } else {
                name = "unamed";
                ip = address.get(0).getAttributeValue("addr");
            }
            if (ip.equals(myIp)) {
                type = true;
            } else {
                type = false;
            }
            hostfind.add(new Host(name, ip, type));
        }
        hostfind.remove(hostfind.get(0));
        this.setHostfind(hostfind);
        return hostfind;
    }
    public String findMyIp(String interfaz) throws IOException, InterruptedException {
String ip="";       
// Replace eth0 with your interface name
System.out.println(interfaz);
        NetworkInterface i = NetworkInterface.getByName(interfaz);

        if (i != null) {

            Enumeration<InetAddress> iplist = i.getInetAddresses();

            InetAddress addr = null;

            while (iplist.hasMoreElements()) {
                InetAddress ad = iplist.nextElement();
                byte bs[] = ad.getAddress();
                if (bs.length == 4 && bs[0] != 127) {
                    addr = ad;
// You could also display the host name here, to 
// see the whole list, and remove the break.
                    break;
                }
            }

            ip=addr.getHostAddress();
        }
        return ip;
    }

    public void changeMaster(Host h) {
        h.setType(true);
    }

    public void viewHost() {
        for (int i = 0; i < hostfind.size(); i++) {
            System.out.println(hostfind.get(i).toString());
        }
    }

    public void removeHost(Host h) {
        this.getHostfind().remove(h);
    }

    public void createSlaveFile(List<Host> lh,String url) throws IOException {
        String ruta = url+"slaves";
        File archivo = new File(ruta);
        BufferedWriter bw;

        bw = new BufferedWriter(new FileWriter(archivo));
        for (int i = 0; i < lh.size(); i++) {
            if (lh.get(i).getType() == false) {
                bw.write(lh.get(i).getIp() + "\n");
            }
        }

        bw.close();
    }

    public void createMasterFile(Host h,String url, String user) throws IOException {

        File archivo = new File(url+"spark-env.sh");
        BufferedWriter bw;

        bw = new BufferedWriter(new FileWriter(archivo));
        bw.write("#!/usr/bin/env bash \n"); 
        bw.write("export SPARK_MASTER_IP='" + h.getIp() + "'\n");
        bw.write("export SPARK_LOCAL_DIRS='/home/"+user+"/sparkDataSet/' \n");
        /*bw.write("export SPARK_WORKER_CORES=1\n");
        bw.write("export SPARK_WORKER_MEMORY=800m\n");
        bw.write("export SPARK_WORKER_INSTANCES=2*/

        bw.close();
    }
    
    public void createMasterFile(Host h,String url,String user,String core, String memory, String instance) throws IOException {

        File archivo = new File(url+"spark-env.sh");
        BufferedWriter bw;

        bw = new BufferedWriter(new FileWriter(archivo));
        bw.write("#!/usr/bin/env bash \n");
        bw.write("export SPARK_MASTER_IP='" + h.getIp() + "'\n");
        bw.write("export SPARK_LOCAL_DIRS='/home/"+user+"/sparkDataSet/' \n");
        bw.write("export SPARK_WORKER_CORES="+core+"\n");
        bw.write("export SPARK_WORKER_MEMORY="+memory+"\n");
        bw.write("export SPARK_WORKER_INSTANCES="+instance+"\n");

        bw.close();
    }

    public Host getMasterHost() {
        Host h = null;
        for (int i = 0; i < this.getHostfind().size(); i++) {
            if (this.getHostfind().get(i).getType() == true) {
                h = this.getHostfind().get(i);
            }
        }
        return h;
    }

    public void findIp2(String interfaz) throws SocketException {



    }
}
