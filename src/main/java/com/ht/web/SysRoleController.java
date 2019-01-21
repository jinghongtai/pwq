package com.ht.web;

import com.ht.domain.Role;
import com.ht.service.RoleService;
import com.ht.utils.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月31日 09:44;
 *
 * @version: 1.0
 */
@Controller
@Scope("prototype")
@RequestMapping("/sysRoleAction")
public class SysRoleController {


    @Autowired
    private RoleService sysRoleService;


    /**
     * 根据条件分页查询数据
     * 传入参数：@param [roleName, dwName, page, limit]
     * 创建者:   jinghongtai
     * 创建日期：2018/7/31
     * 返回类型：com.ht.vo.PageVo<com.ht.role.mapper.domain.SysRole>
     */
    @RequestMapping("/querySysRoleByPage")
    @ResponseBody
    public PageVo<Role> querySysRoleByPage(Role role) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        return sysRoleService.querySysRoleByPage(role);
    }

    /**
     * 更新或者保存角色
     * 传入参数：@param [role]
     * 创建者:   jinghongtai
     * 创建日期：2018/7/31
     * 返回类型：java.util.Map<java.lang.String,java.lang.String>
     */
    @RequestMapping("/saveOrUpdateSysRole")
    @ResponseBody
    public Map<String, String> saveOrUpdateSysRole(Role role){
        return sysRoleService.saveOrUpdateSysRole(role);
    }

    /**
     * 删除指定主键的角色数据
     * 传入参数：@param [RIDS]
     * 创建者:   jinghongtai
     * 创建日期：2018/7/31
     * 返回类型：java.util.Map<java.lang.String,java.lang.String>
     */
    @RequestMapping("/deleteRoleById")
    @ResponseBody
    public Map<String, String> deleteRoleById(@RequestParam("RIDS") List<String> RIDS){
        return sysRoleService.deleteRoleById(RIDS);
    }

}
