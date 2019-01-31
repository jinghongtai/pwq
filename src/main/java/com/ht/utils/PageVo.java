package com.ht.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by TT on 2017/12/29.
 */
public class PageVo<T> {

    private int code;
    private String msg;
    private int count;
    private List<T> data ;


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public static PageVo getErrorReturn(String errorMsg) {
        PageVo pageVo = new PageVo();
        pageVo.setCode(500);
        pageVo.setMsg(errorMsg);
        pageVo.setData(new ArrayList());
        return pageVo;
    }

    public PageVo() {
        data = new ArrayList<>();
    }

    public static <T> PageVo returnPage(List<T> t,Long total){
        PageVo pageVo = new PageVo();
        pageVo.setCode(200);
        pageVo.setMsg("");
        pageVo.setData(t);
        pageVo.setCount(total!=null?total.intValue():0);
        return  pageVo;
    }
    public static PageVo returnString(String t){
        PageVo pageVo = new PageVo();
        pageVo.setCode(200);
        pageVo.setMsg(t);
        pageVo.setData(new ArrayList());
        pageVo.setCount(0);
        return  pageVo;
    }
}
