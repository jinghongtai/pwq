package com.ht.service;

import com.ht.dao.RoleAndResourceDao;
import com.ht.domain.RoleAndResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;



/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月25日 11:12;
 * @version: 1.0
 */
@Service("roleAndResourceService")
public class RoleAndResoueceService {


    @Autowired
    private RoleAndResourceDao roleAndResourceDao;



    @Transactional(readOnly = true)
    public List<RoleAndResource> querySysRoleByEntity(String roleId) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(roleId))return null;
        List<RoleAndResource> result = roleAndResourceDao.query("rId", "=", roleId);
        return result;
    }


}
