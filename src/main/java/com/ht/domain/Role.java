package com.ht.domain;

import com.ht.utils.PageParam;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * @Description 角色信息
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月25日 10:55;
 * @version: 1.0
 */
public class Role extends PageParam{

    private String id;             //角色主键
    private String rolename;        //角色名称
    private Integer orderNo;        //排序
    private Integer isenabled;      //1启用 0禁用
    private Timestamp createTime;   //创建时间
    private String remark;          //备注

    private String flag;

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    private List<String> resourcIds = new ArrayList<String>();

    public List<String> getResourcIds() {
        return resourcIds;
    }

    public void setResourcIds(List<String> resourcIds) {
        this.resourcIds = resourcIds;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getIsenabled() {
        return isenabled;
    }

    public void setIsenabled(Integer isenabled) {
        this.isenabled = isenabled;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
