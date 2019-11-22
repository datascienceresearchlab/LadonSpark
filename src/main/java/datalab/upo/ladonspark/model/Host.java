/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.model;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author antonio
 */
public class Host implements Serializable{
   private String name;
   private String ip;
   private boolean type;

    public Host(String name, String ip, boolean type) {
        this.name = name;
        this.ip = ip;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public boolean isType() {
        return type;
    }

    public void setType(boolean type) {
        this.type = type;
    }
    public boolean getType(){
        return this.type;
    }
public String getTypeName(){
    String result="Master";
    if(this.getType()== false){
        result="Worker";
    }
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        Host h= (Host) obj;
        boolean result=false;
        if(h.getIp().equals(this.getIp())){
        result=true;
        }
        return result;
    }
    
    @Override
    public String toString() {
        String cadena= "host{" + "name=" + name + ", ip=" + ip + ", type=";
        if(this.type==true){
        cadena+="Master }";
        }else{
        cadena+="Worker }";
        }
        return cadena;
    }


    
}
