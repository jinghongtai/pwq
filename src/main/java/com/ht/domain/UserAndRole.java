package com.ht.domain;

import com.ht.utils.PageParam;

/**
 * @Description 角色信息
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2018年07月25日 10:55;
 * @version: 1.0
 */
public class UserAndRole extends PageParam{

    private String id;             //角色主键
    private String rId;        //角色名称
    private String uId;        //排序

    public UserAndRole() {
    }

    public UserAndRole(String rId, String uId) {
        this.rId = rId;
        this.uId = uId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getrId() {
        return rId;
    }

    public void setrId(String rId) {
        this.rId = rId;
    }

    public void setuId(String uId) {
        this.uId = uId;
    }

    public String getuId() {
        return uId;
    }
}
