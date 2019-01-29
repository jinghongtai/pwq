package com.ht.service;

import com.ht.dao.SendOrderDao;
import com.ht.domain.Sendorder;
import config.util.ServerIp;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.sql.Timestamp;
import java.util.*;

/**
 * Created by lenovo on 2019/1/24.
 */
@Service("sendOrderService")
public class SendOrderService {
    @Autowired
    private SendOrderDao sendOrderDao;

    /**
     * 保存发送命令
     * @param sendorder
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public Map<String, String> saveOrUpdateSendOrder(Sendorder sendorder){
        Timestamp tsp = new Timestamp(new Date().getTime());
        //获取当前电脑的ip
        String clientIp = ServerIp.getServerIp();
        sendorder.setClientIp(clientIp);
        sendorder.setSendTime(tsp);
        Map<String,String> map = new HashMap<String,String>();
        map.put("status","error");
        if(!StringUtils.isEmpty(sendorder.getId())){
            // 更新操作 kdjj
            List<Sendorder> sendorders = sendOrderDao.query("id", "=", sendorder.getId());
            BeanUtils.copyProperties(sendorder,sendorders.get(0));
            sendOrderDao.update(sendorders.get(0));
            map.put("status","success");
        }else{
            sendorder.setId(UUID.randomUUID().toString().replace("-",""));
            sendOrderDao.save(sendorder);
            map.put("status","success");
        }
        return map;


    }

    /**
     * 查找场堆对应的喷雾器的指令
     * @param areaId
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public List<Sendorder> query(String feild, String areaId){
        return  sendOrderDao.query(feild,"=",areaId);

    }

}
