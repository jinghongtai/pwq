package com.ht.service;

import com.ht.dao.OrderDao;
import com.ht.domain.Order;
import com.ht.utils.BeanUtil;
import com.ht.utils.PageVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.beans.IntrospectionException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@Service("orderService")
public class OrderService {
    @Autowired
    private OrderDao orderDao;


    /**
     * 分页查询用户信息
     * @param order
     * @return
     */
    @Transactional(readOnly = true)
    public PageVo<Order> queryOrderPage(Order order) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(order.getPage()))
            order.setPage(1);
        if(StringUtils.isEmpty(order.getLimit())||order.getLimit()>50)
            order.setLimit(30);
        // 统计带查询的命令信息
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(order);
        List<Order> query = orderDao.query(notNullProperty,"",null,null);
        Long aLong = orderDao.queryCount(notNullProperty,"");
        return PageVo.returnPage(query,aLong);
    }

    /**
     * 保存或者更新命令信息
     * @param order
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,String> saveOrUpdateOrder(Order order){
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(!StringUtils.isEmpty(order.getId())){
            // 更新操作 kdjj
            List<Order> orders = orderDao.query("id", "=", order.getId());
            if(orders==null||orders.size()==0){
                orderDao.save(order);
                map.put("status","success");
            }else{
                BeanUtils.copyProperties(order,orders.get(0));
                orderDao.update(orders.get(0));
                map.put("status","success");
            }
        }
        return map;
    }

    /**
     * 根据id查询命令
     * @param id
     * @return
     */
    @Transactional(readOnly = true)
    public Order modifyOrderById(String id){
        return orderDao.get(id);
    }

    /**
     * 根据id删除对应的命令
     * @param id
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean deleteOrderById(String id){
       return orderDao.delete(id);
    }




}
