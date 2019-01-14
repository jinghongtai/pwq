package config.util;

import org.springframework.util.StringUtils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 17:48;
 *
 * @version: 1.0
 */
public class SecurityUtil {


    /**
     * 可使用该工具进行MD5或者SHA加密
     * @param source
     * @param securityType
     * @return
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
    public static String security(String source,String securityType) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        if(StringUtils.isEmpty(securityType))
            securityType="MD5";
        StringBuffer hexStr = new StringBuffer("");
        MessageDigest instance = MessageDigest.getInstance(securityType);
        instance.update(source.getBytes("UTF-8"));
        byte[] digest = instance.digest();
        for (int i = 0; i < digest.length; i++) {
            Integer value = digest[i] & 0xff;           //转换成十六进制的整数
            if(value < 16)
                hexStr.append("0");
            hexStr.append(Integer.toHexString(value));
        }
        return hexStr.toString();
    }


}
