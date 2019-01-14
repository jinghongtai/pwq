import com.ht.domain.Users;
import com.ht.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

/**
 * 版权归公司所有
 * 项目名称： 应用支撑平台;
 * 创建者    :  jinghongtai;
 * 创建日期: 2019年01月12日 18:10;
 *
 * @version: 1.0
 */
@RunWith(JunitSpring.class)
@ContextConfiguration(locations = {
    "classpath*:application*.xml","classpath*:spring*.xml"
})
@WebAppConfiguration
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    public void saveOrUpdateUser() throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Users users = new Users();
        users.setUsername("admin");
        users.setPwd("admin");
        users.setState("0");
        users.setUtype("0");
        Map<String, String> stringStringMap = userService.saveOrUpdateUser(users);
        System.out.println(stringStringMap);

    }


    @Test
    public void login() throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Users users = new Users();
        users.setUsername("admin");
        users.setPwd("admin");
        Map<String, String> login = userService.login(users.getUsername(), users.getPwd());
        System.out.println(login);
    }


}
