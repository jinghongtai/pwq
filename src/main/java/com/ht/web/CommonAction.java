package com.ht.web;

import com.alibaba.fastjson.JSON;
import com.ht.domain.Resource;
import com.ht.domain.Sendorder;
import com.ht.service.ResourceService;
import com.ht.service.SendOrderService;
import com.ht.utils.BeanUtil;
import config.util.ServerIp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.*;


/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月13日 14:19;
 *
 * @version: 1.0
 */
@Controller
@RequestMapping("/")
@Scope("prototype")
public class CommonAction {

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private SendOrderService sendOrderService;


    /**
     * 页面跳转控制器
     * @param page
     * @return
     */
    @RequestMapping("/index/{page}")
    public String openJsp(@PathVariable("page") String page){
        if(StringUtils.isEmpty(page))
            return "main";
        return page;
    }

    @RequestMapping("/index/{page}/{page1}")
    public String openJsp(@PathVariable("page") String page,@PathVariable("page1") String page1){
        return page+"/"+page1;
    }
    /**
     * 页面跳转控制器
     * @return
     */
    @RequestMapping("/index")
    public ModelAndView index1(String areaId){
        List<Map> listSendOrder = new ArrayList<>();
        Map<String,Object> map = new HashMap();
        //根据堆场查询对应页面的指令
        List<Sendorder> list = sendOrderService.query("areaId",areaId);
        for(Sendorder sendorder : list){
            String orderNum = sendorder.getOrderNo();
            map.put("pwqid"+orderNum,sendorder.getId());
            Map map1 = ServerIp.convertBeanToMap(sendorder);
            listSendOrder.add(map1);
        }
        map.put("areaId",areaId);

        ModelAndView mv= new ModelAndView();
        mv.setViewName("/index/index");
        mv.addObject("data",map);
        mv.addObject("sendOrders", JSON.toJSONString(listSendOrder));
        return mv;
    }

    /**
     * 程序启动跳转至主页
     * @return
     */
    @RequestMapping("/main")
    public ModelAndView index() throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        ModelAndView mv = new ModelAndView("main");
        // 查询系统的菜单  需根据授权情况查询
        List<Resource> resources = resourceService.querySysResByEntity(new Resource());
        Map<String, List<Resource>> map = BeanUtil.getListToMapKList("pid", resources);
        resourceService.checkChildrenNode(map,"0");
        if(!map.isEmpty()){
            Set<Resource> resourceSet = map.get("0").get(0).getResourceSet();
            List<Resource> returnResource = orderResource(new ArrayList<Resource>(resourceSet));
            mv.addObject("menuList",returnResource);
        }

        return mv;
    }

    /**
     * 对查询的结果进行排序操作
     * @param varList
     */
    private List<Resource> orderResource(List<Resource> varList){
        if(varList==null||varList.size()==0)return null;
        Collections.sort(varList, new Comparator<Resource>() {
            @Override
            public int compare(Resource o1, Resource o2) {
                if(o1.getOrderNo()>o2.getOrderNo())
                    return 1;
                else if(o1.getOrderNo()<o2.getOrderNo())
                    return -1;
                else
                    return 0;
            }
        });
        for(Resource re:varList){
            List<Resource> resources = orderResource(new ArrayList<Resource>(re.getResourceSet()));
        }
        return varList;
    }
}
