package com.ht.domain;

import java.sql.Timestamp;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:41;
 *
 * @version: 1.0
 */
public class Sendorder {
    private String id;
    private String orderNo;
    private String areaId;
    private String pwqId;
    private String orderState;
    private String clientIp;
    private Timestamp sendTime;
    private String fanOperation;//风机操作
    private String sprayOperation;//喷雾操作
    private String galeStrategy;//大风策略
    private String swingOperation;//摆动操作
    private String galeclFx;
    private String swingFd;

    public String getGaleclFx() {
        return galeclFx;
    }

    public void setGaleclFx(String galeclFx) {
        this.galeclFx = galeclFx;
    }

    public String getSwingFd() {
        return swingFd;
    }

    public void setSwingFd(String swingFd) {
        this.swingFd = swingFd;
    }

    public String getSprayOperation() {
        return sprayOperation;
    }

    public void setSprayOperation(String sprayOperation) {
        this.sprayOperation = sprayOperation;
    }

    public String getGaleStrategy() {
        return galeStrategy;
    }

    public void setGaleStrategy(String galeStrategy) {
        this.galeStrategy = galeStrategy;
    }

    public String getSwingOperation() {
        return swingOperation;
    }

    public void setSwingOperation(String swingOperation) {
        this.swingOperation = swingOperation;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFanOperation() {
        return fanOperation;
    }

    public void setFanOperation(String fanOperation) {
        this.fanOperation = fanOperation;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getPwqId() {
        return pwqId;
    }

    public void setPwqId(String pwqId) {
        this.pwqId = pwqId;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public String getClientIp() {
        return clientIp;
    }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp;
    }

    public Timestamp getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Sendorder sendorder = (Sendorder) o;

        if (id != null ? !id.equals(sendorder.id) : sendorder.id != null) return false;
        if (orderNo != null ? !orderNo.equals(sendorder.orderNo) : sendorder.orderNo != null) return false;
        if (areaId != null ? !areaId.equals(sendorder.areaId) : sendorder.areaId != null) return false;
        if (pwqId != null ? !pwqId.equals(sendorder.pwqId) : sendorder.pwqId != null) return false;
        if (orderState != null ? !orderState.equals(sendorder.orderState) : sendorder.orderState != null) return false;
        if (clientIp != null ? !clientIp.equals(sendorder.clientIp) : sendorder.clientIp != null) return false;
        if (sendTime != null ? !sendTime.equals(sendorder.sendTime) : sendorder.sendTime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (orderNo != null ? orderNo.hashCode() : 0);
        result = 31 * result + (areaId != null ? areaId.hashCode() : 0);
        result = 31 * result + (pwqId != null ? pwqId.hashCode() : 0);
        result = 31 * result + (orderState != null ? orderState.hashCode() : 0);
        result = 31 * result + (clientIp != null ? clientIp.hashCode() : 0);
        result = 31 * result + (sendTime != null ? sendTime.hashCode() : 0);
        return result;
    }
}
