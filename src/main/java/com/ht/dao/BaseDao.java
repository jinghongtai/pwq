package com.ht.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:09;
 *
 * @version: 1.0
 */
public class BaseDao<T extends Object,ID extends Serializable> {

    private Class<T> clazz ;

    @Autowired
    private SessionFactory sessionFactory;

    private Class<T> getClazz(){
        if(clazz==null)
            clazz =  (Class<T>) ((ParameterizedType)this.getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        return clazz;
    }


    /**
     * 根据字段查询具体的实体信息
     * @param field
     * @param operatorType
     * @param obj
     * @return
     */
    public List<T> query(String field,String operatorType,String obj){
        String sql = "from " + this.getClazz().getName()+" WHERE "+field + operatorType + " :name";
        Query query = this.getConnection().createQuery(sql);
        query.setParameter("name",obj);
        return query.list();
    }

    /**
     * 根据泛型查询具体的实体信息
     * @param e
     * @param field
     * @param operatorType
     * @param obj
     * @param <E>
     * @return
     */
    public <E> List<E> query(Class<E> e,String field,String operatorType,String obj){
        String sql = "from " + e.getName()+" WHERE  1=1 ";
        if(!StringUtils.isEmpty(field)&&!StringUtils.isEmpty(obj))
            sql += "and "+field + operatorType + " :name";
        Query query = this.getConnection().createQuery(sql);
        if(!StringUtils.isEmpty(field)&&!StringUtils.isEmpty(obj))
            query.setParameter("name",obj);
        return query.list();
    }
    /**
     * 分页查询数据
     * @param map
     * @return
     */
    public List<T> query(Map<String,Object> map,String likename,String orderFile,String orderDescOrAsc){
        StringBuffer sql = new StringBuffer("from ").append(this.getClazz().getName()).append(" WHERE  1=1 ");
        for(String key:map.keySet()){
            if("page".equals(key)||"limit".equals(key)||key.indexOf("Set")!=-1||"resourcIds".equals(key))continue;
            if("likeName".equals(key)){
                sql.append(" and ").append(likename).append(" like ").append(" :"+key);
                continue;
            }
            sql.append(" and ").append(key).append(" = ").append(" :"+key);
        }
        if(orderFile!=null&&orderDescOrAsc!=null)
            sql.append(" order by ").append(orderFile).append(" ").append(orderDescOrAsc);
        Query query = this.getConnection().createQuery(sql.toString());
        if(map.containsKey("page")&&map.containsKey("limit")){
            query.setFirstResult(((int)map.get("page")-1)*(int)map.get("limit"));
            query.setMaxResults((int)map.get("limit"));
        }
        for(String key:map.keySet()){
            if("page".equals(key)||"limit".equals(key)||key.indexOf("Set")!=-1||"resourcIds".equals(key))continue;
            if("likeName".equals(key)){
                query.setParameter(key,"%"+map.get(key)+"%");
                continue;
            }
            query.setParameter(key,map.get(key));
        }
        return query.list();
    }


    /**
     * 分页查询数据
     * @param map
     * @return
     */
    public Long queryCount(Map<String,Object> map,String likename){
        StringBuffer sql = new StringBuffer("select count(id) from ").append(this.getClazz().getName()).append(" WHERE  1=1 ");
        for(String key:map.keySet()){
            if("page".equals(key)||"limit".equals(key)||key.contains("Set")||"resourcIds".equals(key))continue;
            if("likeName".equals(key)){
                sql.append(" and ").append(likename).append(" like ").append(" :"+key);
                continue;
            }
            sql.append(" and ").append(key).append(" = ").append(" :"+key);
        }
        Query query = this.getConnection().createQuery(sql.toString());
        for(String key:map.keySet()){
            if("page".equals(key)||"limit".equals(key)||key.contains("Set")||"resourcIds".equals(key)) continue;
            if("likeName".equals(key)){
                query.setParameter(key,"%"+map.get(key)+"%");
                continue;
            }
            query.setParameter(key,map.get(key));
        }
        Object o = query.uniqueResult();
        return o==null?null:(Long)o;
    }

    /**
     * 根据主键删除数据
     * @param filed
     * @param ids
     */
    public void deleteByIDS(String filed,List<String> ids){
        String hql = "delete from "+this.getClazz().getName()+" where "+filed+" in :ids";
        org.hibernate.query.Query query = this.getConnection().createQuery(hql);
        query.setParameterList("ids",ids);
        query.executeUpdate();
    }

    public <E> void deleteByIDS(Class<E> e,String filed,List<String> ids){
        String hql = "delete from "+e.getName()+" where "+filed+" in :ids";
        org.hibernate.query.Query query = this.getConnection().createQuery(hql);
        query.setParameterList("ids",ids);
        query.executeUpdate();
    }
    /**
     * 根据主键查询实体信息
     * @param id
     * @return
     */
    public T get(ID id){
        Session connection = this.getConnection();
        T o = (T)connection.get(this.getClazz(), id);
        return o;
    }

    /**
     * 保存实体信息
     * @param t
     * @return
     */
    public boolean save(T t){
        Session connection = this.getConnection();
        Serializable save = connection.save(t);
        if(save!=null)
            return true;
        return false;
    }

    /**
     * 删除实体信息
     * @param t
     * @return
     */
    public boolean delete(T t){
        Session connection = this.getConnection();
        connection.delete(t);
        return true;
    }

    /**
     * 删除实体信息
     * @param id
     * @return
     */
    public boolean delete(ID id){
        T t = this.get(id);
        if(t!=null)
            delete(t);
        else
            return false;
        return true;
    }

    /**
     * 更新用户信息
     * @param t
     * @return
     */
    public boolean update(T t){
        Session connection = this.getConnection();
        connection.saveOrUpdate(t);
        return true;
    }





    public Session getConnection(){
        return sessionFactory.getCurrentSession();
    }


}
