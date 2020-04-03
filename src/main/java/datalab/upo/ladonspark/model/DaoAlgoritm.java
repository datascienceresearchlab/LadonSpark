/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datalab.upo.ladonspark.model;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

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
public class DaoAlgoritm {
    Session s;

    public DaoAlgoritm() {
     this.s = HibernateUtil.getSessionFactory().getCurrentSession();
    
    }
    public List<Algorithm> optenerAlgoritmos(){
        
    List<Algorithm> l= null;
    
    try{
      s=HibernateUtil.getSessionFactory().openSession();
        Transaction tx=s.beginTransaction();
        Query q = s.createQuery("from Algorithm");
        l=(List<Algorithm>) q.list();
    } catch (HibernateException e) {
            System.out.append("** Exception in SessionFactory **");
            e.printStackTrace();
        }finally{
        s.close();
    }
    return l;
    }
    public Algorithm getAlgoritm(String name){
        
    Algorithm a= null;
    
    try{
      s=HibernateUtil.getSessionFactory().openSession();
        Transaction tx=s.beginTransaction();
        Query q = s.createQuery("from Algorithm where name_alg='"+name+"'");
        a=(Algorithm) q.uniqueResult();
    } catch (HibernateException e) {
            System.out.append("** Exception in SessionFactory **");
            e.printStackTrace();
        }finally{
        s.close();
    }
    return a;
    }
    public void create(Algorithm a){
    try{
      s=HibernateUtil.getSessionFactory().openSession();
        Transaction tx=s.beginTransaction();
        s.save(a);
        tx.commit();
    } catch (HibernateException e) {
            System.out.append("** Exception in SessionFactory **");
            e.printStackTrace();
        }finally{
        s.close();
    }
    }
}
