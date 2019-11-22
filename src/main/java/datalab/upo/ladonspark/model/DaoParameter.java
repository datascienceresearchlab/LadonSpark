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
public class DaoParameter {

    Session s=HibernateUtil.getSessionFactory().getCurrentSession();

    public void create(Parameter p) {
        if(!s.isOpen()){
        s=HibernateUtil.getSessionFactory().openSession();
        }
        try {
            Transaction tx = s.beginTransaction();
            s.save(p);
            tx.commit();
        } catch (HibernateException e) {
            System.out.append("** Exception in SessionFactory **");
            e.printStackTrace();
        }
    }
    
    public List<Parameter> getParameterAlg(int id) {
        List<Parameter> lp = null;
        try {
            s = HibernateUtil.getSessionFactory().openSession();
            Transaction tx = s.beginTransaction();
            Query q = s.createQuery("from Parameter where id_alg_par='"+id+"'");
            lp = (List<Parameter>) q.list();
        } catch (HibernateException e) {
            System.out.append("** Exception in SessionFactory **");
            e.printStackTrace();
        } finally {
            s.close();
        }
        return lp;
    }
   
}
