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
