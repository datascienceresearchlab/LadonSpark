/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.model;

import java.util.List;

/**
 *
 * @author antonio
 */
public class lauchAlgoritm {
    Algorithm a;
    String dataset;
    List<String> parameter;

    public lauchAlgoritm(Algorithm a, String dataset, List<String> parameter) {
        this.a = a;
        this.dataset = dataset;
        this.parameter = parameter;
    }

    public Algorithm getA() {
        return a;
    }

    public void setA(Algorithm a) {
        this.a = a;
    }

    public String getDataset() {
        return dataset;
    }

    public void setDataset(String dataset) {
        this.dataset = dataset;
    }

    public List<String> getParameter() {
        return parameter;
    }

    public void setParameter(List<String> parameter) {
        this.parameter = parameter;
    }
    
}
