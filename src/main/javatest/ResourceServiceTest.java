
import com.ht.domain.Resource;
import com.ht.service.ResourceService;
import com.ht.utils.BeanUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;

import java.beans.IntrospectionException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
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
public class ResourceServiceTest {

    
    /**
     * 测试版本冲突问题
    **/
    
    @Autowired
    private ResourceService resourceService;

    @Test
    public void querTreeChild() throws UnsupportedEncodingException, NoSuchAlgorithmException, IllegalAccessException, IntrospectionException, InvocationTargetException {
        List<Resource> resources = resourceService.querySysResByEntity(new Resource());
        Map<String, List<Resource>> treeMap = BeanUtil.getListToMapKList("pid", resources);
        resourceService.checkChildrenNode(treeMap,"0");
        resourceService.getNodesIds(treeMap.get("0"));
        System.out.println(treeMap);

    }






    @Test
    public void testMe(){

        System.out.println("测试暂存");


    }





}
