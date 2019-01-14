package com.ht.domain;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:41;
 *
 * @version: 1.0
 */
public class Pwq {
    private String id;
    private String name;
    private String ip;
    private String areaId;
    private String communication;
    private String autoMark;
    private String fjAutoMark;
    private String pwMark;
    private String fjGzMark;
    private String pwGzMark;
    private Double currentTurn;
    private Double leftPosition;
    private Double rightPosition;

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
        return communication;
    }

    public void setCommunication(String communication) {
        this.communication = communication;
    }

    public String getAutoMark() {
        return autoMark;
    }

    public void setAutoMark(String autoMark) {
        this.autoMark = autoMark;
    }

    public String getFjAutoMark() {
        return fjAutoMark;
    }

    public void setFjAutoMark(String fjAutoMark) {
        this.fjAutoMark = fjAutoMark;
    }

    public String getPwMark() {
        return pwMark;
    }

    public void setPwMark(String pwMark) {
        this.pwMark = pwMark;
    }

    public String getFjGzMark() {
        return fjGzMark;
    }

    public void setFjGzMark(String fjGzMark) {
        this.fjGzMark = fjGzMark;
    }

    public String getPwGzMark() {
        return pwGzMark;
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

        Pwq pwq = (Pwq) o;

        if (id != null ? !id.equals(pwq.id) : pwq.id != null) return false;
        if (name != null ? !name.equals(pwq.name) : pwq.name != null) return false;
        if (ip != null ? !ip.equals(pwq.ip) : pwq.ip != null) return false;
        if (areaId != null ? !areaId.equals(pwq.areaId) : pwq.areaId != null) return false;
        if (communication != null ? !communication.equals(pwq.communication) : pwq.communication != null) return false;
        if (autoMark != null ? !autoMark.equals(pwq.autoMark) : pwq.autoMark != null) return false;
        if (fjAutoMark != null ? !fjAutoMark.equals(pwq.fjAutoMark) : pwq.fjAutoMark != null) return false;
        if (pwMark != null ? !pwMark.equals(pwq.pwMark) : pwq.pwMark != null) return false;
        if (fjGzMark != null ? !fjGzMark.equals(pwq.fjGzMark) : pwq.fjGzMark != null) return false;
        if (pwGzMark != null ? !pwGzMark.equals(pwq.pwGzMark) : pwq.pwGzMark != null) return false;
        if (currentTurn != null ? !currentTurn.equals(pwq.currentTurn) : pwq.currentTurn != null) return false;
        if (leftPosition != null ? !leftPosition.equals(pwq.leftPosition) : pwq.leftPosition != null) return false;
        if (rightPosition != null ? !rightPosition.equals(pwq.rightPosition) : pwq.rightPosition != null) return false;

        return true;
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
