package com.ht.web;

import com.ht.domain.Sendorder;
import com.ht.service.SendOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/18
 * @描述
 */
@Controller
@RequestMapping("/sendOrder")
public class SendOrderAction {

    @Autowired
    private SendOrderService sendOrderService;

    /**
     * 跳转到发送指令的页面
     * @param areaId
     * @param orderNo
     * @return
     */
    @RequestMapping("/sendOrderPage")
    public ModelAndView sendOrderPage(String areaId, String orderNo, String id){
        ModelAndView mv = new ModelAndView();
        //通过id查询对应的指令数据用于回显
        if(!"".equals(id) && id != null){
            List<Sendorder> sendorders = sendOrderService.query("id",id);
            if(sendorders.size()>0){
                mv.addObject("data",sendorders.get(0));
            }
        }else{
            Map map = new HashMap<>();
            map.put("areaId",areaId);
            map.put("orderNo",orderNo);
            mv.addObject("data",map);
        }
        mv.setViewName("sendOrder/sendOrderPage");
        return mv;
    }

    /**
     * 保存或者更新发送的指令
     * @param sendorder
     * @return
     */
    @RequestMapping("/saveOrUpdateSendOrder")
    @ResponseBody
    public Map<String, String> saveOrUpdateSendOrder(Sendorder sendorder){
        return sendOrderService.saveOrUpdateSendOrder(sendorder);
    }

}
