package com.ht.dao;

import com.ht.domain.RoleAndResource;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;
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

@Component("roleAndResourceDAO")
public class RoleAndResourceDao extends BaseDao<RoleAndResource,String> {


     public void saveList(List<RoleAndResource> list){
         StringBuffer  sb = new StringBuffer("");
        for(RoleAndResource re:list){
            sb.append("insert into RoleAndResource values(replace(uuid(),'-',''),").append("'").append(re.getrId()).append("','").append(re.getpId()).append("');");
        }
         Session connection = this.getConnection();
         NativeQuery sqlQuery = connection.createSQLQuery(sb.toString());
         sqlQuery.executeUpdate();
     }

}


