package com.ht.service;

import com.ht.dao.PwqDao;
import com.ht.domain.Pwq;
import com.ht.utils.BeanUtil;
import com.ht.utils.PageVo;
import com.ht.utils.PwqVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建人me
 * @创建时间 2019/1/16
 * @描述
 */
@Service("pwqService")
public class PwqService {
    @Autowired
    private PwqDao pwqDao;


    /**
     * 分页查询用户信息
     * @param pwq
     * @return
     */
    @Transactional(readOnly = true)
    public PageVo<PwqVo> queryOrderPage(Pwq pwq) throws Exception {
        if(StringUtils.isEmpty(pwq.getPage()))
            pwq.setPage(1);
        if(StringUtils.isEmpty(pwq.getLimit())||pwq.getLimit()>50)
            pwq.setLimit(30);
        // 统计带查询的命令信息
        Map<String, Object> notNullProperty = BeanUtil.getNotNullProperty(pwq);
        List<Pwq> query = pwqDao.query(notNullProperty,null,null,null);
        List<PwqVo> pwqs = new ArrayList<PwqVo>();
        if(query!=null&&query.size()!=0){
            pwqs = BeanUtil.listCopy(query, PwqVo.class);
        }
        Long aLong = pwqDao.queryCount(notNullProperty,null);
        return PageVo.returnPage(pwqs,aLong);
    }

    /**
     * 保存或者更新命令信息
     * @param pwq
     * @return
     * @throws UnsupportedEncodingException
     * @throws NoSuchAlgorithmException
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String,String> saveOrUpdatePwq(Pwq pwq){
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(!StringUtils.isEmpty(pwq.getId())){
            // 更新操作 kdjj
            List<Pwq> orders = pwqDao.query("id", "=", pwq.getId());
            if(orders!=null&&orders.size()>0){
                BeanUtils.copyProperties(pwq,orders.get(0));
                map.put("status","success");
            }
        }else{
            List<Pwq> orders = pwqDao.query("name", "=", pwq.getName());
            if(orders!=null&&orders.size()>0){
                map.put("message","操作失败，喷雾器名称重复");
                return map;
            }
            pwqDao.save(pwq);
            map.put("status","success");
        }
        return map;
    }

    /**
     * 根据id删除对应的命令
     * @param id
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean deleteOrderById(String id){
       return pwqDao.delete(id);
    }


    /**
     * 查询所有的存在故障的喷雾器数据
     * @return
     * @throws Exception
     */
    @Transactional(readOnly = true)
    public List<List<Pwq>> queryConkOut() throws Exception {
        List<List<Pwq>> vo = new ArrayList<List<Pwq>>();
        List<Pwq> pwqs = pwqDao.queryConkOut();
        List<Pwq> voList = new ArrayList<Pwq>();
        if(pwqs!=null&&pwqs.size()>0){
            voList = BeanUtil.listCopy(pwqs,Pwq.class);
        }
        List<Pwq> var = null;
        for (int i = 0; i < voList.size() ; i++) {
            if(i%8==0){
                var = new ArrayList<Pwq>();
            }
            var.add(voList.get(i));
            if(i%8==0){
                vo.add(var);
            }
        }
        return vo;
    }



}
