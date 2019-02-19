package com.ht.domain;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年02月13日 14:16;
 *
 * @version: 1.0
 */
public class Conkout {

    private String id;

    private String gzNo;                    //故障代码

    private String gzType;                  //喷雾器类型：PW喷雾  FJ风机

    private String pwqId;                   //喷雾器主键

    private String happenTime;              //发生时间

    public String getHappenTime() {
        return happenTime;
    }

    public void setHappenTime(String happenTime) {
        this.happenTime = happenTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGzNo() {
        return gzNo;
    }

    public void setGzNo(String gzNo) {
        this.gzNo = gzNo;
    }

    public String getGzType() {
        return gzType;
    }

    public void setGzType(String gzType) {
        this.gzType = gzType;
    }

    public String getPwqId() {
        return pwqId;
    }

    public void setPwqId(String pwqId) {
        this.pwqId = pwqId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Conkout conkout = (Conkout) o;

        if (id != null ? !id.equals(conkout.id) : conkout.id != null) return false;
        if (gzNo != null ? !gzNo.equals(conkout.gzNo) : conkout.gzNo != null) return false;
        if (gzType != null ? !gzType.equals(conkout.gzType) : conkout.gzType != null) return false;
        if (pwqId != null ? !pwqId.equals(conkout.pwqId) : conkout.pwqId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (gzNo != null ? gzNo.hashCode() : 0);
        result = 31 * result + (gzType != null ? gzType.hashCode() : 0);
        result = 31 * result + (pwqId != null ? pwqId.hashCode() : 0);
        return result;
    }
}
