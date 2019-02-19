package com.ht.service;

import com.ht.dao.UserAndRoleDao;
import com.ht.domain.Role;
import com.ht.domain.UserAndRole;
import com.ht.utils.BeanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月25日 11:12;
 * @version: 1.0
 */
@Service("userAndRoleService")
public class UserAndRoleService {


    @Autowired
    private UserAndRoleDao userAndRoleDao;



    @Transactional(readOnly = true)
    public List<Role> querySysRoleByEntity(String uId) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(uId))return null;
        List<Role> query = userAndRoleDao.query(Role.class, null, null, null);
        List<UserAndRole> result = userAndRoleDao.query("uId", "=", uId);
        if(result!=null&&result.size()>0){
            Map<String, UserAndRole> listToMapKT = BeanUtil.getListToMapKT("rId", result);
            for(Role ur:query){
                if(listToMapKT.containsKey(ur.getId())){
                    ur.setFlag("true");
                }
            }
        }
        return query;
    }


    @Transactional(readOnly = true)
    public List<UserAndRole> queryUserRole(String uId) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(uId))return null;
        List<UserAndRole> result = userAndRoleDao.query("uId", "=", uId);
        return result;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public boolean saveUserRole(List<UserAndRole> list){
        if(list==null||list.size()==0)return false;
        userAndRoleDao.deleteByIDS(UserAndRole.class,"uId", Arrays.asList(list.get(0).getuId()));
        userAndRoleDao.saveList(list);
        return true;
    }

}
