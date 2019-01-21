package com.ht.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @创建人me
 * @创建时间 2019/1/18
 * @描述
 */
@Controller
@RequestMapping("/sendOrder")
public class SendOrderAction {

    @RequestMapping("/sendOrderPage")
    public String sendOrderPage(){
        return "sendOrder/sendOrderPage";
    }

}
