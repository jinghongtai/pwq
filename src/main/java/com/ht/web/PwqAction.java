package com.ht.web;

import com.ht.domain.Pwq;
import com.ht.service.PwqService;
import com.ht.utils.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@RequestMapping("/pwqAction")
@Controller
public class PwqAction {

    @Autowired
    private PwqService pwqService;

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
     * @return
     */
    @RequestMapping("/queryPwqPage")
    @ResponseBody
    public PageVo queryPwqPage(Pwq pwq) throws Exception {
        PageVo pageVo = pwqService.queryOrderPage(pwq);
        return pageVo;
    }


    /**
     * 保存或者更新命令
     * @param pwq
     * @return
     */
    @RequestMapping("/saveOrUpdatePwq")
    @ResponseBody
    public Map<String,String> saveOrUpdatePwq(Pwq pwq){
        pwq.setCommunication("1");
        pwq.setAutoMark("1");
        pwq.setFjAutoMark("0");
        pwq.setPwMark("0");
        pwq.setFjGzMark("0");
        pwq.setPwGzMark("0");
        return pwqService.saveOrUpdatePwq(pwq);
    }


    /**
     * 根据主键删除信息
     * @param id
     * @return
     */
    @RequestMapping("/deleteOrderById")
    @ResponseBody
    public Map deleteOrderById(String id){
        Map map = new HashMap();
        boolean result = pwqService.deleteOrderById(id);
        if(result){
            map.put("result","success");
        }else{
            map.put("result","error");
        }
        return map;
    }


}
