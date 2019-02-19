package com.ht.dao;

import com.ht.domain.Pwq;
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

@Component("pwqDao")
public class PwqDao extends BaseDao<Pwq,String> {

    /**
     * 查询存在故障的喷雾器
     * @return
     */
    public List<Pwq> queryConkOut(){
        String hql = "from Pwq where communication = '0' or fjGzMark = '1' or pwGzMark = '1'  order by areaId asc";
        Query query = this.getConnection().createQuery(hql);
        return query.list();
    }

}


