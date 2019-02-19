package com.ht.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ht.dao.ResourceDao;
import com.ht.domain.Resource;
import com.ht.utils.BeanUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.beans.IntrospectionException;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月14日 22:40;
 *
 * @version: 1.0
 */
@Service("resourceService")
public class ResourceService {



    @Autowired
    private ResourceDao resourceDao;

    @Transactional(readOnly = true)
    public List<Resource> queryRoleResource(List<String> roleIds){
        if(roleIds==null||roleIds.size()==0)
            return Collections.emptyList();
        return resourceDao.queryRoleResource(roleIds);
    }

    @Transactional(readOnly = true)
    public List<Resource> querySysResByEntity(Resource sysResource) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(sysResource);
        return resourceDao.query(notNullProperty,null,"orderNo","asc");
    }


    @Transactional(readOnly = true)
    public List<Resource> querySysResByEntity(List<String> ids) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        if(ids==null||ids.size()==0)return Collections.emptyList();
        return resourceDao.queryIn(Resource.class,"id",ids);
    }


    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> saveOrUpdateSysResource(Resource sysResource) throws Exception {
        if(StringUtils.isEmpty(sysResource.getId())){
            return this.insertSysResource(sysResource);
        }else{
            return this.updateSysResource(sysResource);
        }
    }


    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> deleteById(String RID, String PARENTID) throws InvocationTargetException, NoSuchMethodException,
            IntrospectionException, InstantiationException, IllegalAccessException {
        Map<String, String> map = new HashMap<String, String>();
        map.put("status","error");
        if(StringUtils.isEmpty(RID)){
            map.put("message","参数异常");
            return map;
        }
        if("0".equals(RID)){
            map.put("message","根节点不允许删除");
            return map;
        }
        // 查询当前节点下面的所有子集节点
        List<Resource> resources = this.querySysResByEntity(new Resource());
        // 递归查询所有的子节点数据
        Map<String, List<Resource>> treeMap = BeanUtil.getListToMapKList("pid", resources);
        checkChildrenNode(treeMap,RID);
        // 依次遍历所有的下级节点并删除
        List<Resource> deleteNodes = treeMap.get(RID);
        List<String> nodesIds = this.getNodesIds(deleteNodes);
        if(nodesIds==null){
            nodesIds = Arrays.asList(RID);
        }else
            nodesIds.add(RID);
        if(!StringUtils.isEmpty(nodesIds)&&nodesIds.size()>0){
            resourceDao.deleteByIDS("id",nodesIds);
        }
        map.put("status","success");
        return map;
    }

    /**
     * 递归查询菜单的子集
     * @param map
     * @param pId
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public void checkChildrenNode(Map<String,List<Resource>> map,String pId) throws InvocationTargetException, IllegalAccessException {
        if(map==null||map.size()==0)return ;
        List<Resource> varList = map.get(pId);
        //map.remove(pId);
        if(varList!=null&&varList.size()>0){
            for(Resource re:varList) {
                if(map.containsKey(re.getId())){
                    re.setResourceSet(new HashSet<Resource>(map.get(re.getId())));
                    checkChildrenNode(map,re.getId());
                }
            }
        }
    }

    /**
     * 递归查询所有的子集主键
     * @param list
     * @return
     */
    public List<String> getNodesIds(List<Resource> list){
        if(list==null||list.size()==0)return null;
        List<String> ids = new ArrayList<String>();
        for(Resource re:list){
            ids.add(re.getId());
            List<String> nodesIds ;
            if(re.getResourceSet()!=null&&re.getResourceSet().size()!=0){
                nodesIds = getNodesIds(new ArrayList<Resource>(re.getResourceSet()));
                ids.addAll(nodesIds);
            }
        }
        return ids;
    }


    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class,RuntimeException.class})
    public Map<String, String> insertSysResource(Resource sysResource) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        ObjectMapper objMap = new ObjectMapper();
        map.put("status","error");
        if(StringUtils.isEmpty(sysResource.getResourceName())){
            map.put("message","资源名称不能为空");
            return map;
        }
        List<Resource> checkRoot = this.querySysResByEntity(BeanUtil.setBeanProperty(Resource.class, "id", "1"));
        if(checkRoot==null||checkRoot.size()==0){
            Resource rootResource = new Resource();
            rootResource.setId("1");
            rootResource.setResourceName("资源根节点");
            resourceDao.save(rootResource);
        }
        if(StringUtils.isEmpty(sysResource.getPid()))
            sysResource.setPid("0");
        // 如果为一级资源需要设置最大的排序；二级资源需设置为一级排序+二级排序
        Long max = resourceDao.queryMaxOrder("pid",sysResource.getPid());
        max = max == null?Long.valueOf(0):max;
        String order = max+1+"";
        sysResource.setOrderNo(Integer.valueOf(order));
        sysResource.setId(UUID.randomUUID().toString().replace("-",""));
        resourceDao.save(sysResource);
        map.put("status","success");
        map.put("node",objMap.writeValueAsString(sysResource));
        return map;
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> updateSysResource(Resource sysResource) throws IllegalAccessException, IntrospectionException, InvocationTargetException {
        Map<String,String> map = new HashMap<String, String>();
        map.put("status","error");
        if(StringUtils.isEmpty(sysResource.getId())){
            map.put("message","参数异常");
            return map;
        }
        Resource resource = resourceDao.get(sysResource.getId());
        List<String> nullProperty = BeanUtil.getNullProperty(sysResource);
        BeanUtils.copyProperties(sysResource,resource,nullProperty!=null?nullProperty.toArray(new String[nullProperty.size()]):new String[0]);
        resourceDao.update(resource);
        map.put("status","success");
        return map;

    }


    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,Object> moveNode(String id, String tId, String moveType) throws Exception {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("status",500);
        if(StringUtils.isEmpty(moveType)){
            map.put("message","操作失败");
        }
        Resource param = BeanUtil.setBeanProperty(Resource.class, "id", id);
        List<Resource> resource = resourceDao.query(BeanUtil.getNotNullProperty(param),null,"orderNo","asc");
        Resource targetNode = resourceDao.get(tId);
        Resource param2 = BeanUtil.setBeanProperty(Resource.class,
                "pid", targetNode.getPid());
        List<Resource> resourceList = resourceDao.query(BeanUtil.getNotNullProperty(param2),null,"orderNo","asc");
        List<Resource> orderNodes = new ArrayList<Resource>();
        if("next".equals(moveType)){
            for (int i = 0; i < resourceList.size(); i++) {
                Resource var1 = resourceList.get(i);
                if(tId.equals(var1.getId())){
                    Resource vas = resource.get(0);
                    vas.setPid(var1.getPid());
                    if(i!=0){
                        orderNodes.add(i-1,var1);
                        orderNodes.add(i,vas);
                    }else{
                        orderNodes.add(0,var1);
                        orderNodes.add(vas);
                    }
                }else{ // 同级节点时不在处理
                    if(!id.equals(var1.getId()))
                        orderNodes.add(var1);
                }
            }
        }
        if("prev".equals(moveType)){
            // 此处需考虑同级移动和跨级移动
            for (int i = 0; i < resourceList.size(); i++) {
                Resource var1 = resourceList.get(i);
                if(tId.equals(var1.getId())){
                    Resource vas = resource.get(0);
                    vas.setPid(var1.getPid());
                    if(i!=0){
                        orderNodes.add(i-1,vas);
                        orderNodes.add(i,var1);
                    }else{
                        orderNodes.add(0,vas);
                        orderNodes.add(var1);
                    }
                }else{
                    if(!id.equals(var1.getId()))
                        orderNodes.add(var1);

                }
            }
        }
        for (int i = 0; i < orderNodes.size(); i++) {
            orderNodes.get(i).setOrderNo(i+1);
        }
        // 保存排序数据
        for(Resource r:orderNodes)
            resourceDao.update(r);
        map.put("status",200);
        return map;
    }



}
