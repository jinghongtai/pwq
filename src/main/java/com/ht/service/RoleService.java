package com.ht.service;

import com.ht.dao.RoleAndResourceDao;
import com.ht.dao.RoleDao;
import com.ht.domain.Role;
import com.ht.domain.RoleAndResource;
import com.ht.utils.BeanUtil;
import com.ht.utils.PageVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月25日 11:12;
 * @version: 1.0
 */
@Service("sysRoleService")
public class RoleService {


    @Autowired
    private RoleDao roleDao;
    @Autowired
    private RoleAndResourceDao roleAndResourceDao;


    @Transactional(readOnly = true)
    public List<Role> querySysRoleByEntity(Role sysRole) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(sysRole);
        return roleDao.query(notNullProperty,null,"createtime","asc");
    }

    @Transactional(readOnly = true)
    public PageVo<Role> querySysRoleByPage(Role role) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(role);
        Long total = roleDao.queryCount(notNullProperty,null);
        List<Role> sysRoles = roleDao.query(notNullProperty,null,"createtime","asc");
        return PageVo.returnPage(sysRoles,total);

    }

    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> saveOrUpdateSysRole(Role role) {
        if(StringUtils.isEmpty(role.getId())){
            return saveSysRole(role);
        }else{
            return updateSysRole(role);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> deleteRoleById(List<String> RIDS) {
        Map<String, String> map = new HashMap<String, String>();
        if(RIDS!=null&&RIDS.size()==0){
            map.put("status","error");
            map.put("message","操作异常");
        }
        roleDao.deleteByIDS("id",RIDS);
        // 删除角色对应的数据
        roleDao.deleteByIDS(RoleAndResource.class,"rId",RIDS);
        map.put("status","success");
        return map;
    }

/*
    @Transactional(readOnly = true)
    public List<Role> queryUserRoleAndRole(String uid) throws Exception {
        List<String> userRole = roleDao.queryUserRoleId(uid);
        List<SysRole> sysRoles = this.queryUserDepartRole(uid);
        for(SysRole role:(sysRoles!=null&&sysRoles.size()>0?sysRoles:new ArrayList<SysRole>())){
            if(userRole!=null&&userRole.contains(role.getRID())){
                role.setFalg("true");
            }else
                role.setFalg("false");
        }
        return sysRoles;
    }*/


    /**
     * @Description 新增角色数据
     * 传入参数：@param [role]
     * 创建者:   jinghongtai
     * 创建日期：2018/7/25
     * 返回类型：java.util.Map<java.lang.String,java.lang.String>
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,String> saveSysRole(Role role)throws RuntimeException{
        Map<String,String> map = new HashMap<String, String>();
        map.put("ststua","error");
        try {
            if(StringUtils.isEmpty(role.getRolename())){
                map.put("message","角色名不能为空");
                return map;
            }
            roleDao.save(role);
            // 存在资源则保存资源信息
            List<String> resourcIds = role.getResourcIds();
            List<RoleAndResource> roleAndResourceList = new ArrayList<RoleAndResource>();
            RoleAndResource roleAndResource = null;
            if(resourcIds!=null&&resourcIds.size()>0){
                for(String var:resourcIds){
                    roleAndResource = new RoleAndResource(role.getId(),var);
                    roleAndResourceList.add(roleAndResource);
                }
                // 保存信息
                roleAndResourceDao.saveList(roleAndResourceList);
            }

        }catch (Exception e){
            e.printStackTrace();
            map.put("message","操作异常");
            return map;
        }
        map.put("status","success");
        return map;
    }


    /**
     * @Description 更新系统角色
     * 传入参数：@param [role]
     * 创建者:   jinghongtai
     * 创建日期：2018/7/25
     * 返回类型：java.util.Map<java.lang.String,java.lang.String>
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,String> updateSysRole(Role role){
        Map<String,String> map = new HashMap<String, String>();
        map.put("ststua","error");
        if(StringUtils.isEmpty(role.getId())){
            map.put("message","操作异常");
            return map;
        }
        try{
            Role role1 = roleDao.get(role.getId());
            List<String> nullProperty = BeanUtil.getNullProperty(role1);
            BeanUtils.copyProperties(role,role1,nullProperty.toArray(new String[nullProperty.size()]));
            roleDao.update(role1);
            // 存在资源则保存资源信息
            List<String> resourcIds = role.getResourcIds();
            List<RoleAndResource> roleAndResourceList = new ArrayList<RoleAndResource>();
            RoleAndResource roleAndResource = null;
            if(resourcIds!=null&&resourcIds.size()>0){
                for(String var:resourcIds){
                    roleAndResource = new RoleAndResource(role.getId(),var);
                    roleAndResourceList.add(roleAndResource);
                }
                // 先删除存在的角色全线数据
                roleAndResourceDao.deleteByIDS("rId", Arrays.asList(role.getId()));
                // 保存信息
                roleAndResourceDao.saveList(roleAndResourceList);
            }
        }catch (Exception e){
            e.printStackTrace();
            map.put("message","操作异常");
            return map;
        }
        map.put("status","success");
        return map;
    }
}
