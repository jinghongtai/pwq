package com.ht.service;

import com.ht.dao.UserDao;
import com.ht.domain.Users;
import com.ht.utils.BeanUtil;
import com.ht.utils.PageVo;
import config.util.SecurityUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.jws.WebService;
import java.beans.IntrospectionException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:43;
 *
 * @version: 1.0
 */
@Service("userService")
@WebService
public class UserService {

    @Autowired
    private UserDao userDao;


    /**
     * 登陆验证逻辑
     * @param username
     * @param pwd
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @Transactional(readOnly = true)
    public Map<String,String> login(String username,String pwd) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(StringUtils.isEmpty(username)){
            map.put("message","用户名不能为空");
        }
        if(StringUtils.isEmpty(pwd)){
            map.put("message","密码不能为空");
        }
        if(map.size()==2)return map;
        List<Users> userList = userDao.query("username", "=", pwd);
        if(userList==null||userList.size()==0){
            map.put("message","用户名不存在");
            return map;
        }
        String password = SecurityUtil.security(pwd,"MD5");
        if(password.equals(userList.get(0).getPwd())){
            map.put("status","success");
            return map;
        }else{
            // 密码出错次数限制
            map.put("message","密码错误");
        }
        return map;
    }


    /**
     * 保存或者更新用户信息
     * @param users
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,String> saveOrUpdateUser(Users users) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(StringUtils.isEmpty(users.getId())){
            // 新增操作
            if(StringUtils.isEmpty(users.getUsername())){
                map.put("message","用户名不能为空");
                return map;
            }
            List<Users> username = userDao.query("username", "=", users.getUsername());
            if(username!=null&&username.size()>0){
                map.put("message","该用户已存在");
                return map;
            }
            users.setPwd("111111");
            users.setPwd(SecurityUtil.security(users.getPwd(),"MD5"));
            userDao.save(users);
            map.put("status","success");
            return map;
        }else{
            // 更新操作 kdjj
            List<Users> username = userDao.query("username", "=", users.getUsername());
            if(username==null||username.size()==0){
                map.put("message","该用户不存在");
                return map;
            }
            BeanUtils.copyProperties(users,username.get(0),"id","headImg","pwd");
            userDao.update(username.get(0));
            map.put("status","success");
            return map;
        }


    }

    /**
     * 分页查询用户信息
     * @param users
     * @return
     */
    @Transactional(readOnly = true)
    public PageVo<Users> queryUserPage(Users users) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(users.getPage()))
            users.setPage(1);
        if(StringUtils.isEmpty(users.getLimit())||users.getLimit()>50)
            users.setLimit(30);
        // 统计带查询的用户信息
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(users);
        List<Users> query = userDao.query(notNullProperty,"username",null,null);
        Long aLong = userDao.queryCount(notNullProperty,"username");
        return PageVo.returnPage(query,aLong);
    }

    /**
     * 删除用户数据
     * @param ids
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean deleteUserByIds(List<String> ids){
        if(ids==null||ids.size()==0)
            return false;
        userDao.deleteByIDS("id",ids);
        // 删除用户辅助数据
        return true;
    }

}
