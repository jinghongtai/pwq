package com.ht.domain;

import com.ht.utils.PageParam;

import java.io.Serializable;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:41;
 *
 * @version: 1.0
 */

public class Users extends PageParam implements Serializable{

    private String id;
    private String username;
    private String pwd;
    private String telphone;
    private String headImg;
    private String state;  //0 禁用  1启用
    private String utype;   // 0管理员 1 普通用户
    private String address;
    private String remark;

    private String likeName;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getLikeName() {
        return likeName;
    }

    public void setLikeName(String likeName) {
        this.likeName = likeName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }


    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }


    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }


    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }


    public String getUtype() {
        return utype;
    }

    public void setUtype(String utype) {
        this.utype = utype;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Users users = (Users) o;

        if (id != null ? !id.equals(users.id) : users.id != null) return false;
        if (username != null ? !username.equals(users.username) : users.username != null) return false;
        if (pwd != null ? !pwd.equals(users.pwd) : users.pwd != null) return false;
        if (telphone != null ? !telphone.equals(users.telphone) : users.telphone != null) return false;
        if (headImg != null ? !headImg.equals(users.headImg) : users.headImg != null) return false;
        if (state != null ? !state.equals(users.state) : users.state != null) return false;
        if (utype != null ? !utype.equals(users.utype) : users.utype != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (pwd != null ? pwd.hashCode() : 0);
        result = 31 * result + (telphone != null ? telphone.hashCode() : 0);
        result = 31 * result + (headImg != null ? headImg.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (utype != null ? utype.hashCode() : 0);
        return result;
    }
}
