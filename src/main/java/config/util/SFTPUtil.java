package config.util;

import com.jcraft.jsch.*;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.log4j.Logger;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.Vector;

/**
 * @descript 使用SFTP上传与下载文件
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月11日 11:09;
 * @see  :STFP 是Secure File Transfer Protocol安全文件传送协议，可以为传输文件提供安全的加密方法，SFTP是SSH的一部分
 * @version: 1.0
 */
public class SFTPUtil {

    private static final Logger log = Logger.getLogger(SFTPUtil.class);

    // FTP的主机地址
    private static String host ;
    // FTP的端口号
    private static int port;
    // FTP的用户名
    private static String username;
    // FTP的密码
    private static String password ;
    // 文件夹
    private static String directory ;

    private static ChannelSftp sftp;

    private static SFTPUtil instance = null;

    private SFTPUtil(){ }

    private SFTPUtil(String username,String pwd,String host,int port,String directory){
        SFTPUtil.username = username;
        SFTPUtil.password = pwd;
        SFTPUtil.host = host;
        SFTPUtil.directory = directory;
        SFTPUtil.port = port;
    }


    /**
     * 获取单例实例对象
     * @param username
     * @param pwd
     * @param host
     * @param port
     * @param directory
     * @return
     */
    public static SFTPUtil getInstance(String username,String pwd,String host,int port,String directory){
        if(instance == null){
            instance = new SFTPUtil(username,pwd,host,port,directory);
            SFTPUtil.sftp = instance.connect();
        }
        return instance;
    }

    /**
     * 连接sftp服务器
     * @return
     */
    public ChannelSftp connect(){
        ChannelSftp sftp = null;
        try {
            JSch jSch = new JSch();
            Session session = jSch.getSession(username, host, port);
            session.setPassword(password);
            session.setConfig("StrictHostKeyChecking","no");
            session.connect();
            log.info("SFTP Session connected ");
            Channel sftp1 = session.openChannel("sftp");
            sftp1.connect();
            sftp = (ChannelSftp) sftp1;
            log.info("Connected to :"+host);
        } catch (JSchException e) {
            log.error(e.getMessage());
        }
        return sftp;
    }


    /**
     * 上传文件
     * @param filename 文件名称
     * @param stream   上传的文件流
     * @return
     */
    public boolean upload(String filename,FileInputStream stream){
        try {
            long varTime = System.currentTimeMillis();
            sftp.cd(directory);
            sftp.put(stream,filename);
            log.info("PUT FILE TIME :"+(System.currentTimeMillis()-varTime)/1000);
            stream.close();
            return true;
        } catch (SftpException e) {
            e.printStackTrace();
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 下载文件
     * @param savePath      存在本地的路径
     * @param downLoadFile  需要下载的文件
     * @return
     */
    public boolean downLoad(String savePath, String downLoadFile){
        try {
            sftp.cd(directory);
            FileOutputStream outputStream = new FileOutputStream(savePath);
            sftp.get(downLoadFile,outputStream);
            outputStream.close();
        } catch (SftpException e) {
            e.printStackTrace();
            return false;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }


    /**
     * 删除目录
     * @param deleteFile
     * @return
     */
    public boolean delet(String deleteFile){
        try {
            sftp.cd(directory);
            sftp.rm(deleteFile);
            return true;
        } catch (SftpException e) {
            e.printStackTrace();
            log.error(e.getMessage());
            return false;
        }
    }

    public void disConnect(){
        try {
            sftp.getSession().disconnect();
            sftp.quit();
            sftp.disconnect();
        } catch (JSchException e) {
            e.printStackTrace();
        }
    }

    /**
     * 列出目录下的文件
     * @return
     */
    public Vector<ChannelSftp.LsEntry> listFiles(){
        try {
            return sftp.ls(directory);
        } catch (SftpException e) {
            e.printStackTrace();
            return null;
        }

    }


    public static void main(String[] args) throws FileNotFoundException {


        SFTPUtil instance = SFTPUtil.getInstance("root", "root", "10.2.65.5", 22, "/home");
        Vector<ChannelSftp.LsEntry> lsEntries = instance.listFiles();

        System.out.println(ReflectionToStringBuilder.toString(lsEntries));

        instance.upload("new book.txt",new FileInputStream("C:\\Users\\96956\\Desktop\\浏览信息.txt"));

        instance.downLoad("C:\\Users\\96956\\Desktop\\浏览信息.txt","new book.txt");
        System.out.println("");

        instance.disConnect();


    }
}
