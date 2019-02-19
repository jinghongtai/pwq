package com.ht.dao;

import com.ht.domain.Resource;
import org.hibernate.query.Query;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:38;
 *
 * @version: 1.0
 */

@Component("resourceDAO")
public class ResourceDao extends BaseDao<Resource,String> {


    /**
     * 获取父节点下面的最大排序
     * @param field
     * @param value
     * @return
     */
    public Long queryMaxOrder(String field,String value){
        String hql = "select max(orderNo) from Resource where "+field + " = :field";
        Query query = getConnection().createQuery(hql);
        query.setParameter("field",value);
        Object obj = query.uniqueResult();
        return obj==null?null:Long.valueOf((int)obj);
    }

    public List<Resource> queryRoleResource(List<String> roleIds){
        String hql = "from Resource re where id in(select pId from RoleAndResource where rId in :rList) ";
        Query query = this.getConnection().createQuery(hql);
        query.setParameterList("rList",roleIds);
        return query.list();
    }

}


