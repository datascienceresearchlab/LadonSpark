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
