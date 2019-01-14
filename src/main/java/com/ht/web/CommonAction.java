package com.ht.web;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月13日 14:19;
 *
 * @version: 1.0
 */
@Controller
@RequestMapping("/index")
@Scope("prototype")
public class CommonAction {


    /**
     * 页面跳转控制器
     * @param page
     * @return
     */
    @RequestMapping("/{page}")
    public String openJsp(@PathVariable("page") String page){
        if(StringUtils.isEmpty(page))
            return "main";
        return page;
    }


}
