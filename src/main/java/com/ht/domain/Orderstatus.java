package com.ht.domain;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:41;
 *
 * @version: 1.0
 */
public class Orderstatus {
    private String id;
    private String statusNo;
    private String statusDes;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStatusNo() {
        return statusNo;
    }

    public void setStatusNo(String statusNo) {
        this.statusNo = statusNo;
    }

    public String getStatusDes() {
        return statusDes;
    }

    public void setStatusDes(String statusDes) {
        this.statusDes = statusDes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Orderstatus that = (Orderstatus) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (statusNo != null ? !statusNo.equals(that.statusNo) : that.statusNo != null) return false;
        if (statusDes != null ? !statusDes.equals(that.statusDes) : that.statusDes != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (statusNo != null ? statusNo.hashCode() : 0);
        result = 31 * result + (statusDes != null ? statusDes.hashCode() : 0);
        return result;
    }
}
