package com.ht.service;

import com.ht.dao.OrderStatusDao;
import com.ht.domain.Order;
import com.ht.domain.Orderstatus;
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
@Service("orderStatusService")
public class OrderStatusService {
    @Autowired
    private OrderStatusDao orderStatusDao;


    /**
     * 分页查询用户信息
     * @param order
     * @return
     */
    @Transactional(readOnly = true)
    public PageVo<Orderstatus> queryOrderPage(Orderstatus orderstatus) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(StringUtils.isEmpty(orderstatus.getPage()))
            orderstatus.setPage(1);
        if(StringUtils.isEmpty(orderstatus.getLimit())||orderstatus.getLimit()>50)
            orderstatus.setLimit(30);
        // 统计带查询的命令信息
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(orderstatus);
        List<Orderstatus> query = orderStatusDao.query(notNullProperty,"",null,null);
        Long aLong = orderStatusDao.queryCount(notNullProperty,"");
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
    public Map<String,String> saveOrUpdateOrder(Orderstatus order){
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(StringUtils.isEmpty(order.getId())){
            List<Orderstatus> orders = orderStatusDao.query("statusNo", "=", order.getStatusNo());
            if(orders!=null&&orders.size()>0){
                map.put("message","已存在该状态码");
                return map;
            }
            orderStatusDao.save(order);
            map.put("status","success");
        }else{
            List<Orderstatus> orders = orderStatusDao.query("id", "=", order.getId());
            BeanUtils.copyProperties(order,orders.get(0));
            orderStatusDao.update(orders.get(0));
            map.put("status","success");
        }
        return map;
    }



    /**
     * 根据id删除对应的命令
     * @param id
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean deleteOrderById(String id){
       return orderStatusDao.delete(id);
    }




}
