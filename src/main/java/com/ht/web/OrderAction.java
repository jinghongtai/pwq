package com.ht.web;

import com.ht.domain.Order;
import com.ht.service.OrderService;
import com.ht.utils.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@RequestMapping("/order")
@Controller
public class OrderAction {

    @Autowired
    private OrderService orderService;

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
    @RequestMapping("/queryOrderPage")
    @ResponseBody
    public PageVo queryOrderPage(Order order) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        System.out.println("--------》进入queryOrderPage方法");
        PageVo pageVo = orderService.queryOrderPage(order);
        return pageVo;
    }

    /**
     * 返回命令添加页面
     * @return
     */
    @RequestMapping("/orderAddPage")
    public ModelAndView orderAddPage(String id){
        ModelAndView mv = new ModelAndView();
        //查询命令根据id
        Order order = new Order();
        if(id != null){
            order = orderService.modifyOrderById(id);
        }
        mv.setViewName("/order/orderAdd");
        mv.addObject("orderData",order);
        return mv;
    }

    /**
     * 保存或者更新命令
     * @param order
     * @return
     */
    @RequestMapping("/saveOrUpdateOrder")
    @ResponseBody
    public Map<String,String> saveOrUpdateOrder(Order order){
        return orderService.saveOrUpdateOrder(order);
    }


    /**
     * 根据id删除命令
     * @param id
     */
    @RequestMapping("/deleteOrderById")
    @ResponseBody
    public Map deleteOrderById(String id){
        Map map = new HashMap();
        boolean result = orderService.deleteOrderById(id);
        if(result){
            map.put("result","success");
        }else{
            map.put("result","error");
        }
        return map;
    }


}
