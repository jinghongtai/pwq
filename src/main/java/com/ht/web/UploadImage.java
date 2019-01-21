package com.ht.web;

import com.ht.utils.PageVo;
import jdk.nashorn.internal.ir.RuntimeNode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;

/**
 * @创建人me
 * @创建时间 2019/1/15
 * @描述
 */
@Controller
public class UploadImage {

    /**
     * 文件上传
     * @param file
     * @param request
     * @return
     */
    @RequestMapping("/upload")
    @ResponseBody
    public PageVo upload(@RequestParam("file") CommonsMultipartFile file , HttpServletRequest request){
        //检测程序的运行时间
        long startTime = System.currentTimeMillis();
        //获取文件的名字
        String fileName = file.getOriginalFilename();
        String path =  request.getSession().getServletContext().getRealPath("/");
        String staticPath = File.separator+"WEB-INF"+File.separator+"static"+File.separator+"image";
        System.out.println("文件名字："+fileName);
        String outPath = path+staticPath+File.separator+startTime+fileName;
        try {
            //获取输出流
            File file1 = new File(path+staticPath);
            if(!file1.exists()){
                file1.mkdirs();
            }
            OutputStream outputStream = new FileOutputStream(outPath);
            //获取输入流
            InputStream inputStream = file.getInputStream();
            int tem = 0;
            //写入输出流
            while((tem=inputStream.read()) != -1){
                System.out.println(tem);
                outputStream.write(tem);
            }
            inputStream.close();
            outputStream.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return PageVo.returnString(File.separator+"static"+File.separator+"image"+File.separator+startTime+fileName);
    }

}
