/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.model;

/**
 *
 * @author antonio
 */
public class dateConnect {
    String user;
    String interfaz;

    public String getInterfaz() {
        return interfaz;
    }

    public void setInterfaz(String interfaz) {
        this.interfaz = interfaz;
    }

    public dateConnect(String user, String interfaz) {
        this.user = user;
        this.interfaz=interfaz;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
    
}
