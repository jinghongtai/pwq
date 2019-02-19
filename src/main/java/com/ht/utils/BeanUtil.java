package com.ht.utils;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.util.StringUtils;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;


public class BeanUtil {


    public static <T>  T setBeanProperty(Class<T> clazz,String field,Object obj) throws Exception {
        PropertyDescriptor[] propertyDescriptors = PropertyUtils.getPropertyDescriptors(clazz);
        Method writeMethod = null;
        for(PropertyDescriptor p:propertyDescriptors){
            if(field.equals(p.getName())){
                writeMethod = p.getWriteMethod();
                break;
            }
        }
        T instance = clazz.newInstance();
        writeMethod.invoke(instance,obj);
        return instance;
    }


    public static <T> List<String> getNullProperty(T t) throws IntrospectionException,
            InvocationTargetException, IllegalAccessException {
        BeanInfo beanInfo = Introspector.getBeanInfo(t.getClass());
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
        List<String> nullProperties = new ArrayList<String>();
        for (PropertyDescriptor p:propertyDescriptors) {
            if(StringUtils.isEmpty(p.getReadMethod().invoke(t))){
                nullProperties.add(p.getName());
            }
        }
        return  nullProperties;
    }


    public static <T> Map<String,Object> getNotNullProperty(T t) throws IntrospectionException,
            InvocationTargetException, IllegalAccessException {
        BeanInfo beanInfo = Introspector.getBeanInfo(t.getClass());
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
        Map<String,Object> notNullProperties = new HashMap<String,Object>();
        for (PropertyDescriptor p:propertyDescriptors) {
            if("class".equals(p.getName())||"start".equals(p.getName()))continue;
            Object value = p.getReadMethod().invoke(t);
            if(!StringUtils.isEmpty(value)){
                notNullProperties.put(p.getName(),value);
            }
        }
        return  notNullProperties;
    }


    public static <K,V,T> Map<K,V> beanToMapKV(K k, V v, List<T> tlists) throws InvocationTargetException, IllegalAccessException {
        if(tlists==null||tlists.size()==0)
            return Collections.emptyMap();
        Map<K,V> map = new HashMap<K, V>();
        Method kRead = null;
        Method vRead = null;
        for(PropertyDescriptor p: PropertyUtils.getPropertyDescriptors(tlists.get(0).getClass())){
            if(k.equals(p.getName()))
                kRead = p.getReadMethod();
            if(v.equals(p.getName()))
                vRead = p.getReadMethod();
        }
        for (T t:tlists) {
            Object read1 = kRead.invoke(t);
            Object read2 = vRead.invoke(t);
            if(read1!=null)
                map.put((K)read1 ,(V)read2);
        }
        return map;
    }


    public static <K,T> Map<K,List<T>> getListToMapKList(K k,List<T> tlist) throws InvocationTargetException, IllegalAccessException {
        if(tlist==null || tlist.size() ==0)
            return Collections.emptyMap();
        Map<K,List<T>> map = new HashMap<K, List<T>>();
        Method readMethod = null;
        for(PropertyDescriptor p: PropertyUtils.getPropertyDescriptors(tlist.get(0).getClass())){
            if(k.equals(p.getName())){
                readMethod = p.getReadMethod();
                break;
            }
        }
        for(T t:tlist){
            Object invoke = readMethod.invoke(t);
            if(map.containsKey(invoke)){
                map.get(invoke).add(t);
            }else{
                ArrayList<T> mList = new ArrayList<>();
                mList.add(t);
                map.put((K) invoke,mList);
            }
        }
        return map;
    }


    public static <K,T> Map<K,T> getListToMapKT(K k,List<T> tlist) throws InvocationTargetException, IllegalAccessException {
        if (tlist == null || tlist.size() == 0)
            return Collections.emptyMap();
        Map<K, T> map = new HashMap<K, T>();
        Method readMethod = null;
        for (PropertyDescriptor p : PropertyUtils.getPropertyDescriptors(tlist.get(0).getClass())) {
            if (k.equals(p.getName())) {
                readMethod = p.getReadMethod();
                break;
            }
        }
        for (T t : tlist) {
            if(t==null)continue;
            Object invoke = readMethod.invoke(t);
            map.put((K) invoke, t);
        }
        return map;
    }


    public static <E> List<E> listCopy(List<?> source, Class<E> destinationClass) throws Exception {
        if (source.size()==0) return Collections.emptyList();
        List<E> res = new ArrayList<E>(source.size());
        for (Object o : source) {
            E e = destinationClass.newInstance();
            BeanUtils.copyProperties(o,e);
            res.add(e);
        }
        return res;
    }


}
