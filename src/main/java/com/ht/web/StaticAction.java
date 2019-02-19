package com.ht.web;

import com.ht.domain.Pwq;
import com.ht.service.ConkOutService;
import com.ht.service.PwqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年02月13日 15:51;
 *
 * @version: 1.0
 */
@Controller
@Scope("prototype")
@RequestMapping("/staticAction")
public class StaticAction {


    @Autowired
    private PwqService pwqService;
    @Autowired
    private ConkOutService conkOutService;


    @RequestMapping("/queryConkOut")
    @ResponseBody
    public List<List<Pwq>> queryConkOut() throws Exception{
        return pwqService.queryConkOut();
    }

    @RequestMapping("/queryInfo")
    @ResponseBody
    public Map<String,Object> queryInfo() throws InvocationTargetException, IllegalAccessException{
        return conkOutService.queryInfo();
    }

}
