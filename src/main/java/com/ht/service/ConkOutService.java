package com.ht.service;

import com.ht.dao.ConkOutDao;
import com.ht.domain.Conkout;
import com.ht.domain.Pwq;
import com.ht.utils.BeanUtil;
import com.ht.utils.PageVo;
import com.ht.utils.PwqVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@Service("conkOutService")
public class ConkOutService {


    @Autowired
    private ConkOutDao conkOutDao;


    /**
     * 分页查询用户信息
     * @param pwq
     * @return
     */
    @Transactional(readOnly = true)
    public PageVo<PwqVo> queryOrderPage(Pwq pwq) throws Exception {
        return null;
    }


    @Transactional(readOnly = true)
    public Map<String,Object> queryInfo() throws InvocationTargetException, IllegalAccessException {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        List<String> times = null;
        List<Conkout> query = conkOutDao.query(Conkout.class, null, null, null);
        Map<String, List<Conkout>> mapTime = BeanUtil.getListToMapKList("happenTime", query);
        mapTime.remove(null);
        times = new ArrayList<String>(mapTime.keySet());
        Collections.sort(times);
        returnMap.put("times",times);
        List<Integer> pwqData = new ArrayList<Integer>();
        List<Integer> txData = new ArrayList<Integer>();
        List<Integer> fjData = new ArrayList<Integer>();
        for(String key:times){
            List<Conkout> conkouts = mapTime.get(key);
            if(conkouts!=null&&conkouts.size()>0){
                Map<String, List<Conkout>> listToMapKList = BeanUtil.getListToMapKList("gzType", conkouts);
                if(listToMapKList.containsKey("FJ")){
                    fjData.add(listToMapKList.get("FJ").size());
                }else{
                    fjData.add(0);
                }
                if(listToMapKList.containsKey("PW")){
                    pwqData.add(listToMapKList.get("PW").size());
                }else{
                    pwqData.add(0);
                }
                if(listToMapKList.containsKey("TX")){
                    txData.add(listToMapKList.get("TX").size());
                }else{
                    txData.add(0);
                }
            }else{
                pwqData.add(0);
                txData.add(0);
                fjData.add(0);
            }
        }
        returnMap.put("FJ",fjData);
        returnMap.put("PW",pwqData);
        returnMap.put("TX",txData);
        return returnMap;
    }



}
