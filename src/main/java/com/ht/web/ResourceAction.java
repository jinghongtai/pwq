package com.ht.web;

import com.ht.domain.Resource;
import com.ht.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月14日 22:39;
 *
 * @version: 1.0
 */
@RequestMapping("/resourceAction")
@Controller
@Scope("prototype")
public class ResourceAction {


    @Autowired
    private ResourceService resourceService;

    /**
     * 查询系统资源数据
     * @param sysResource
     * @return
     * @throws IllegalAccessException
     * @throws IntrospectionException
     * @throws InvocationTargetException
     */
    @RequestMapping("querySysResByEntity")
    @ResponseBody
    public List<Resource> querySysResByEntity(Resource sysResource) throws IllegalAccessException,
            IntrospectionException, InvocationTargetException{
        return resourceService.querySysResByEntity(sysResource);
    }

    /**
     * 保存或者更新系统资源
     * @param resource
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveOrUpdateSysResource")
    @ResponseBody
    public Map<String, String> saveOrUpdateSysResource(Resource resource) throws Exception {
        return resourceService.saveOrUpdateSysResource(resource);
    }

    /**
     * 删除节点
     * @param id
     * @return
     */
    @RequestMapping("/deleteNode")
    @ResponseBody
    public Map<String,String> deleteNode(String id,String pid) throws NoSuchMethodException, IntrospectionException, InstantiationException, IllegalAccessException, InvocationTargetException {
        return resourceService.deleteById(id,pid);
    }

    /**
     * 节点移动操作
     * @param id
     * @param tId
     * @param moveType
     * @return
     * @throws Exception
     */
    @RequestMapping("/moveNode")
    @ResponseBody
    public Map<String,Object> moveNode(String id, String tId, String moveType) throws Exception{
        return resourceService.moveNode(id,tId,moveType);
    }
}
