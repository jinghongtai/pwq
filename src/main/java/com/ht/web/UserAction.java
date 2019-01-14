package com.ht.web;

import com.ht.domain.Users;
import com.ht.service.UserService;
import com.ht.utils.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.IntrospectionException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月13日 21:40;
 *
 * @version: 1.0
 */
@RequestMapping("/userAction")
@Scope("prototype")
@Controller
public class UserAction {


    @Autowired
    private UserService userService;


    /**
     * 分页查询用户数据
     * @param users
     * @return
     * @throws IllegalAccessException
     * @throws IntrospectionException
     * @throws InvocationTargetException
     */
    @RequestMapping("/queryPage")
    @ResponseBody
    public PageVo queryUserPage(Users users) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        return userService.queryUserPage(users);
    }

    /**
     * 保存用户信息
     * @param users
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @RequestMapping("/saveOrUpdateUser")
    @ResponseBody
    public Map<String,String> saveOrUpdateUser(Users users) throws UnsupportedEncodingException, NoSuchAlgorithmException{
        return userService.saveOrUpdateUser(users);
    }

    /**
     * 删除用户基础信息
     * @param ids
     * @return
     */
    @RequestMapping("/deleteUserByIds")
    @ResponseBody
    public boolean deleteUserByIds(@RequestParam("ids") List<String> ids){
        return userService.deleteUserByIds(ids);
    }

}
