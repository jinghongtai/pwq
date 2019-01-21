package com.ht.dao;

import com.ht.domain.UserAndRole;
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

@Component("userAndRoleDao")
public class UserAndRoleDao extends BaseDao<UserAndRole,String> {


     public void saveList(List<UserAndRole> list){
         StringBuffer  sb = new StringBuffer("");
        for(UserAndRole re:list){
            sb.append("insert into UserAndRole values(replace(uuid(),'-',''),").append("'").append(re.getrId()).append("','").append(re.getuId()).append("');");
        }
         Session connection = this.getConnection();
         NativeQuery sqlQuery = connection.createSQLQuery(sb.toString());
         sqlQuery.executeUpdate();
     }

}


