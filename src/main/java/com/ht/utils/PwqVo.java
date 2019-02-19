package com.ht.utils;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年02月13日 11:49;
 *
 * @version: 1.0
 */
public class PwqVo {

    private String id;
    private String name;            //喷雾器名称 T01~T34
    private String ip;              //对应的远程ip地址 射雾器ip或端口号
    private String areaId;          //射雾器所属区域编号
    private String communication;   //通讯状态标志    0异常  1正常
    private String autoMark;        //自动控制标志    1自动  0手动
    private String fjAutoMark;      //风机状态标志    0关闭  1启动
    private String pwMark;          //喷雾状态标志    0关闭  1启动
    private String fjGzMark;        //风机故障标志    0正常  1故障
    private String pwGzMark;        //喷雾故障标志    0正常  1故障
    private Double currentTurn;     //射雾器当前方向值
    private Double leftPosition;    //射雾器能到达的最左方向值
    private Double rightPosition;   //射雾器能到达的最右方向值

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getCommunication() {
        if(null!=communication && !"".equals(communication)&&"1".equals(communication))
            return "正常";
        else
            return "异常";
    }

    public void setCommunication(String communication) {
        this.communication = communication;
    }

    public String getAutoMark() {
        if(null!=autoMark && !"".equals(autoMark)&&"1".equals(autoMark))
            return "自动";
        else
            return "手动";
    }

    public void setAutoMark(String autoMark) {
        this.autoMark = autoMark;
    }

    public String getFjAutoMark() {
        if(null!=fjAutoMark && !"".equals(fjAutoMark)&&"1".equals(fjAutoMark))
            return "启动";
        else
            return "关闭";
    }

    public void setFjAutoMark(String fjAutoMark) {
        this.fjAutoMark = fjAutoMark;
    }

    public String getPwMark() {
        if(null!=pwMark && !"".equals(pwMark)&&"1".equals(pwMark))
            return "启动";
        else
            return "关闭";
    }

    public void setPwMark(String pwMark) {
        this.pwMark = pwMark;
    }

    public String getFjGzMark() {
        if(null!=fjGzMark && !"".equals(fjGzMark)&&"1".equals(fjGzMark))
            return "故障";
        else
            return "正常";
    }

    public void setFjGzMark(String fjGzMark) {
        this.fjGzMark = fjGzMark;
    }

    public String getPwGzMark() {
        if(null!=pwGzMark && !"".equals(pwGzMark)&&"1".equals(pwGzMark))
            return "故障";
        else
            return "正常";
    }

    public void setPwGzMark(String pwGzMark) {
        this.pwGzMark = pwGzMark;
    }

    public Double getCurrentTurn() {
        return currentTurn;
    }

    public void setCurrentTurn(Double currentTurn) {
        this.currentTurn = currentTurn;
    }

    public Double getLeftPosition() {
        return leftPosition;
    }

    public void setLeftPosition(Double leftPosition) {
        this.leftPosition = leftPosition;
    }

    public Double getRightPosition() {
        return rightPosition;
    }

    public void setRightPosition(Double rightPosition) {
        this.rightPosition = rightPosition;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PwqVo pwqVo = (PwqVo) o;

        if (id != null ? !id.equals(pwqVo.id) : pwqVo.id != null) return false;
        if (name != null ? !name.equals(pwqVo.name) : pwqVo.name != null) return false;
        if (ip != null ? !ip.equals(pwqVo.ip) : pwqVo.ip != null) return false;
        if (areaId != null ? !areaId.equals(pwqVo.areaId) : pwqVo.areaId != null) return false;
        if (communication != null ? !communication.equals(pwqVo.communication) : pwqVo.communication != null)
            return false;
        if (autoMark != null ? !autoMark.equals(pwqVo.autoMark) : pwqVo.autoMark != null) return false;
        if (fjAutoMark != null ? !fjAutoMark.equals(pwqVo.fjAutoMark) : pwqVo.fjAutoMark != null) return false;
        if (pwMark != null ? !pwMark.equals(pwqVo.pwMark) : pwqVo.pwMark != null) return false;
        if (fjGzMark != null ? !fjGzMark.equals(pwqVo.fjGzMark) : pwqVo.fjGzMark != null) return false;
        if (pwGzMark != null ? !pwGzMark.equals(pwqVo.pwGzMark) : pwqVo.pwGzMark != null) return false;
        if (currentTurn != null ? !currentTurn.equals(pwqVo.currentTurn) : pwqVo.currentTurn != null) return false;
        if (leftPosition != null ? !leftPosition.equals(pwqVo.leftPosition) : pwqVo.leftPosition != null) return false;
        return rightPosition != null ? rightPosition.equals(pwqVo.rightPosition) : pwqVo.rightPosition == null;

    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (ip != null ? ip.hashCode() : 0);
        result = 31 * result + (areaId != null ? areaId.hashCode() : 0);
        result = 31 * result + (communication != null ? communication.hashCode() : 0);
        result = 31 * result + (autoMark != null ? autoMark.hashCode() : 0);
        result = 31 * result + (fjAutoMark != null ? fjAutoMark.hashCode() : 0);
        result = 31 * result + (pwMark != null ? pwMark.hashCode() : 0);
        result = 31 * result + (fjGzMark != null ? fjGzMark.hashCode() : 0);
        result = 31 * result + (pwGzMark != null ? pwGzMark.hashCode() : 0);
        result = 31 * result + (currentTurn != null ? currentTurn.hashCode() : 0);
        result = 31 * result + (leftPosition != null ? leftPosition.hashCode() : 0);
        result = 31 * result + (rightPosition != null ? rightPosition.hashCode() : 0);
        return result;
    }
}
