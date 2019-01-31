package com.ht.utils;

import org.apache.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description: 文件处理
 * @param:
 * @author: shankun
 * @return:
 * @date: 2018/7/26 15:27
 */
public class FileUtil {


	private static Logger log = Logger.getLogger(FileUtil.class);


	/** 文件上传			上传的文件	保存的路径  contentType支持的文件类型集合
	 * 传入参数：@param [file, savePath]
	 * 创建者:   jinghongtai
	 * 创建日期：2018/8/22
	 * 返回类型：java.util.Map<java.lang.String,java.lang.String>
	 */
	public static Map<String,String> uploadFile(MultipartFile file, String savePath, List<String> contentType){
		Map<String,String> map = new HashMap<String,String>();
		map.put("status","error");
		if(file==null){
			map.put("message","文件不能为空");
			return map;
		}
		HttpServletRequest request = getCurrentRequest();
		CommonsMultipartResolver cmResolver = new CommonsMultipartResolver();
		if(cmResolver.isMultipart(request)&&contentType.contains(file.getContentType())){// 判断 request 是否有文件上传,即多部分请求
			try {
				String path = getCurrentRequest().getSession().getServletContext().getRealPath("/WEB-INF/");
				String orginName = file.getOriginalFilename();
				String fileName = new SimpleDateFormat("yyyy_MM_dd_HH_SSS").format(new Date())+orginName.substring(orginName.lastIndexOf("."));
				File outFile = new File(path+File.separator+savePath+File.separator+fileName);
				if(!outFile.getParentFile().exists())
					outFile.getParentFile().mkdirs();
				file.transferTo(outFile);
				map.put("path",savePath+File.separator+fileName);
				map.put("status","success");
			}catch (IOException e) {
				e.printStackTrace();
				map.put("message","上传失败");
			}
		}else{
			map.put("message","文件类型错误");
		}
		return map;
	}


	/** 获取request
	 * 传入参数：@param []
	 * 创建者:   jinghongtai
	 * 创建日期：2018/8/22
	 * 返回类型：javax.servlet.http.HttpServletRequest
	 */
	public static HttpServletRequest getCurrentRequest(){
		return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	}

}
