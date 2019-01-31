package com.ht.web;

import com.ht.domain.Orderstatus;
import com.ht.service.OrderStatusService;
import com.ht.utils.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@RequestMapping("/orderStatusAction")
@Controller
public class OrderStatusAction {

    @Autowired
    private OrderStatusService orderStatusService;

    /**
     * 返回列表页面
     * @return
     */
    @RequestMapping("/orderList")
    public String orderList(){
        return "/order/orderList";
    }

    /**
     * 分页查询order指令
     * @param order
     * @return
     */
    @RequestMapping("/queryOrderStatusPage")
    @ResponseBody
    public PageVo<Orderstatus> queryOrderStatusPage(Orderstatus orderstatus) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        PageVo pageVo = orderStatusService.queryOrderPage(orderstatus);
        return pageVo;
    }


    /**
     * 保存或者更新命令
     * @param order
     * @return
     */
    @RequestMapping("/saveOrUpdateOrderStatus")
    @ResponseBody
    public Map<String,String> saveOrUpdateOrder(Orderstatus order){
        return orderStatusService.saveOrUpdateOrder(order);
    }


    /**
     * 根据id删除命令
     * @param id
     */
    @RequestMapping("/deleteOrderStatusById")
    @ResponseBody
    public Map deleteOrderById(String id){
        Map map = new HashMap();
        boolean result = orderStatusService.deleteOrderById(id);
        if(result){
            map.put("result","success");
        }else{
            map.put("result","error");
        }
        return map;
    }


}
