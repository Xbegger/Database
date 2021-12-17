## Spring-MVC

### 简介

![image-20211104140805456](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111041408590.png)

1、DispatcherServlet表示前端控制器，是整个SpringMVC的控制中心。用户发出请求， 

DispatcherServlet接收请求并拦截请求。 

2、HandlerMapping为处理器映射。DispatcherServlet调用HandlerMapping,HandlerMapping根据请 

求url查找Handler。 

3、返回处理器执行链，根据url查找控制器，并且将解析后的信息传递给DispatcherServlet 

4、HandlerAdapter表示处理器适配器，其按照特定的规则去执行Handler。 

5、执行handler找到具体的处理器 

6、Controller将具体的执行信息返回给HandlerAdapter,如ModelAndView。 

7、HandlerAdapter将视图逻辑名或模型传递给DispatcherServlet。 

8、DispatcherServlet调用视图解析器(ViewResolver)来解析HandlerAdapter传递的逻辑视图名。 

9、视图解析器将解析的逻辑视图名传给DispatcherServlet。 

10、DispatcherServlet根据视图解析器解析的视图结果，调用具体的视图，进行试图渲染 

11、将响应数据返回给客户端 







### 请求处理

项目目录

> ![image-20211103163248272](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111031632324.png)



配置web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">


    <!--配置前端控制器-->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!--前端控制器初始化参数-->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:spring-mvc.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <!--配置编码过滤器 一定要放在最前面,代表最先经过的过滤器 CharacterEncodingFilter-->
    <filter>
        <filter-name>characterEncodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <!--编码格式-->
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <!--开启request 和 response请求都设为编码UTF8-->
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <!--安装过滤器 _配置拦截那些请求进行过滤-->
    <filter-mapping>
        <filter-name>characterEncodingFilter</filter-name>
        <!--拦截规则  只过滤springmvc的请求-->
        <servlet-name>springmvc</servlet-name>
    </filter-mapping>

    
    
    <!--处理HTML中不支持rest中的PUT和DELETE的问题,配置过滤器,推荐查看源码-->
    <filter>
        <filter-name>hiddenHttpMethod</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>
    <!--安装过滤器,实际上配置映射到的servlet-->
    <filter-mapping>
        <filter-name>hiddenHttpMethod</filter-name>
        <servlet-name>springmvc</servlet-name>
    </filter-mapping>

    
</web-app>
```



过滤器可以配置dispatcher元素

有四种可能的属性：
1、REQUEST
只要发起的操作是一次HTTP请求，比如请求某个URL、发起了一个GET请求、表单提交方式为POST的POST请求、表单提交方式为GET的GET请求。一次重定向则前后相当于发起了两次请求，这些情况下有几次请求就会走几次指定过滤器。
2、FOWARD
只有当当前页面是通过请求转发转发过来的情形时，才会走指定的过滤器
3、INCLUDE
只要是通过<jsp:include page="xxx.jsp" />，嵌入进来的页面，每嵌入的一个页面，都会走一次指定的过滤器。
4、ERROR
假如web.xml里面配置了<error-page></error-page>：





配置基于注解的spring

spring-mvc.xml和pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd">


    <context:component-scan base-package="com.jt"/>

    <!--必配!!用于配置访问静态资源-->
    <mvc:annotation-driven/>
    <!--推荐 将映射的地址直接指向静态资源文件夹,spring不会将此映射作为handler-->
    <mvc:resources mapping="/images/**" location="/images/"/>
    <!--不推荐
        下面这个也可以用来访问静态资源文件
        原理是,springmvc没有映射到handler时,
        就会调用默认servlet来处理
        而默认的可以处理静态资源文件
    -->
    <!--<mvc:default-servlet-handler/>-->
</beans>
```

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>5.3.10</version>
    </dependency>
</dependencies>
```



配置tomcat

> ![image-20211103163146205](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111031631322.png)![image-20211103163200318](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111031632398.png)

**如果需要使用servlet的原生api 需要将依赖加入进来(没什么大用处)知道即可**

![image-20211103173106440](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111031731542.png)



entity下的Role User UserDTO

![image-20211103221123688](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111032211765.png)

controller  和 params.jsp



#### @RequestMapping 和@RequestHeader 和 @CookieValue



```java
package com.jt.controllers;

import com.jt.entity.User;
import com.jt.entity.UserDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author HDU_WS
 * @Classname ParamsController
 * @Description 处理请求参数
 * @Date 2021/11/2 21:21
 * @Created by TheKing_Shun
 */


/*
   在servlet api中
   request。getParamerer("name")
   在springmvc中只需要在处理方法中声明对应的参数就
   可以自动接受请求的参数并且还可以自动转换类型

   匹配规则：
   请求的参数必须跟处理方法的参数名一致
   如果处理方法的参数未传入的情况下会自动传入null

   如果请求的参数和处理方法的参数名不一致:
   可以利用@requestParam("xxx")管理请求参数
   value 用来重命名参数,如果用了这个注解之后必须要传入值否则报错还必须是重名
   required 用来指定参数是否必须传入值
    true 默认 必须传入
    false 可以不需要传入

   不要用基本数据类型作为参数,因为无法接收null

   处理请求参数乱码问题:
   GET  :直接设置tomcat目录下conf下的server.xml Connector加入URIEncoding="UTF-8"
   POST :在servlet的时期 获取参数前设置request.setCharacterEncoding("UTF-8")使用过滤器来处理
        :使用springmvc提供的编码过滤器来解决POST乱码问题CharacterEncodingFilter(web.xml)

   复杂数据参数类型
   对象:
    不用加上参数名字,直接传入该对象对应的属性名字
    如果是包装类型的简单变量,直接输入属性名字= 表单元素的name="id"
    数组 保证这一组的表单元素都是同样的name          name="alias"
    list 必须加上[索引]                          name=list[0] \ name=list[0].name
    map  ....[key]                             name=map[key]
    其他的实体类:给某个属性赋值                     name=Object.xxx

    注意:
    如果出现多个对象参数的情况,建议再次封装一层javaBean(DTO data transfer object)
 */
@Controller
public class ParamsController {

    @RequestMapping("/params01")
    public String params01(@RequestParam(value = "username", required = false) String name) {
        System.out.println(name);
        return "/index.jsp";
    }

    /**
     * 复杂数据类型参数自动绑定演示
     *
     * @param user
     * @return
     */
    @RequestMapping("/params02")
    public String params02(User user) {
        System.out.println(user);
        return "/index.jsp";
    }

    /**
     * 如果参数是两个对象,且两个对象中包含哟相同的字段,那么前端提交表单后
     * 会给两个对象相同的字段(成员变量)都赋上值!!!解决办法解释将两个对象在封装一层
     * 然后用外围封装的对象作为参数,这样表单就能够通过user.id和role.id来
     * 进行区分是哪个对象中字段的数据
     */
    @RequestMapping("/params03")
    public String params03(UserDTO dto) {
        //dto里面包含两个对象User \ Role 用来接收传递的两个对象不同的数据
        System.out.println(dto);
        return "/index.jsp";
    }

    /**
     * 获取请求头中的Host数据
     * 里面也有required 和 defaultValue
     */
    @RequestMapping("/header")
    public String header(@RequestHeader("Host") String host) {
        System.out.println(host);
        return "/index.jsp";
    }

    /**
     * 获取请求头中的所数据
     */
    @RequestMapping("/headerAll")
    public String headerAll(@RequestHeader Map<String, Object> all) {
        System.out.println(all);
        return "/index.jsp";
    }

    /**
     * 获取cookies
     * 没有springmvc前的servlet做法:
     * Cookie[] cookies = request.getCookies;
     * for(Cookie cookie : cookies){
     * if(cookie.getValue.equals("JSESSIONID")){xxxxx}
     * }
     */
    @RequestMapping("/cookie")
    public String cookie(@CookieValue("JSESSIONID") String jsessionid) {
        System.out.println(jsessionid);
        return "/index.jsp";
    }

    /**
     * 支持原生servlet api的支持
     * 支持原生api 和 参数绑定同时使用
     */
    @RequestMapping("/api")
    public String api(String username,
                      HttpSession session,
                      HttpServletRequest request,
                      HttpServletResponse response) {
        System.out.println("servlet api");
        return "/index.jsp";
    }
}
```

注意@Controller方法返回值有三个,其中string是视图路径名

```java
  @RequestMapping("/params01")
    public String params01(@RequestParam(value = "username", required = false) String name) {
        System.out.println(name);
        // 返回视图路径!!!!!!
        return "/index.jsp";
    }
```



```html
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>简单参数演示</h2>
<form action="${pageContext.request.contextPath}/params01" method="post">
    姓名:<input name="username" type="text"><p></p>
    <input type="submit" value="提交"/>
</form>

<h2>复杂类型参数演示</h2>
<form action="${pageContext.request.contextPath}/params02" method="post">
    id:<input name="id" type="text"><p></p>
    姓名:<input name="name" type="text"><p></p>
    外号:<input name="alias" type="checkbox" value="狗剩" checked>狗剩
        <input name="alias" type="checkbox" value="柱子" checked>柱子<p></p>
    爱好:<input name="hobbies" type="checkbox" value="唱歌" checked>唱歌
    <input name="hobbies" type="checkbox" value="跳舞" checked>跳舞<p></p>
    亲属:<input name="relatives['fat']" type="checkbox" value="爸爸" checked>爸爸
    <input name="relatives['mum']" type="checkbox" value="妈妈" checked>妈妈<p></p>
    角色:<input name="role.name" type="text"><p></p>
    朋友:<input name="friends[0].name" type="text" value="张三"><p></p>
        <input name="friends[1].name" type="text" value="李四"><p></p>

    <input type="submit" value="提交"/>
</form>

</body>
</html>
```



@RequestMapping用来匹配客户端发送的请求，可以在方法上使用， 也可以在类上使用。 

* ==方法==：表示用来匹配要处理的请求 
* ==类上==：表示为当前类的所有方法的请求地址添加一个前置路径，访问的时候必须要添加此路径 

```java
package com.jt.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
/**
 * @RequestMapping 用来处理URL映射,将请求映射到处理方法中
 *      除了可以用在方法上 还可以用在类上面
 *      避免请求方法中映射的重复
 *
 * 如果加在类上面,该类所有请求方法的映射都必须加上类的映射@RequestMapping("/mapping")
 * xxx/mapping/xxx
 *
 * value 设置请求的URL映射
 *
 * method 设置请求方式 GET/POST
 *      HTTP状态 405 Request method 'GET' not supported
 *      可以设置多个值同时处理多了请求方式,不写则会匹配所有请求方式
 *  spring4.3提供了简写请求方式的注解
 *     @PostMapping("/mapping02")
 *     @PutMapping
 *     @GetMapping
 *     @DeleteMapping
 *
 * params:设置请求必须携带某些参数
 *      1.必须要有某些参数      params = {"username"}
 *      2.必须没有某些参数      params = {"!username"}
 *      3.参数必须要等于某些值   params = {"username=123"}
 *      4.参数必须不等于某些值   params = {"username!=123"}
 *
 * headers:请求头必须包含某些值
 *
 * consumes:当前请求的内容类型必须是指定值
 *      常见的内容类型:
 *      application/x-www-form-urlencoded   form表单提交默认的内容
 *      multipart/form-data                 form表达提交文件流的内容类型
 *      application/json                    ajax提交的json内容类型
 *      HTTP状态 415 - 不支持的媒体类型
 *
 * produces : 设置当前相应的内容类型
 *
 * 映射的URL还可以支持通配符 /ANT style
 *      1.?     匹配单个字符
 *      2.*     匹配任意个字符
 *      3.**    匹配任意级
 *  如果映射出现包含关系,会优先交给更精确的映射处理
 *  没有通配符 > ? > * > **
 */ 
@Controller
@RequestMapping("/mapping")
public class MappingController {

    @RequestMapping("/mapping01")
    public String mapping01() {
        System.out.println("映射成功");
        return "/index.jsp";
    }
    // @RequestMapping(value = "/mapping02",method = {RequestMethod.POST})
    @PostMapping("/method")  // 等同于method路径 需要匹配post请求方式
    public String mapping02() {
        System.out.println("请求方式");
        return "/index.jsp";
    }

    @RequestMapping(value = "/params",params = {"username=123"})
    public String mapping03() {
        System.out.println("请求参数");
        return "/index.jsp";
    }
    @RequestMapping(value = "/headers",headers = {"Accept-Language=zh-CN,zh;q=0.9,en;q=0.8"})
    public String mapping04() {
        System.out.println("请求头");
        return "/index.jsp";
    }

    @RequestMapping(value = "/consumes",consumes = {"application/x-www-form-urlencoded"})
    public String mapping05() {
        System.out.println("请求内容");
        return "/index.jsp";
    }
    @RequestMapping(value = "/produces",produces = {"application/x-www-form-urlencoded"})
    public String mapping06() {
        System.out.println("响应内容类型!");
        return "/index.jsp";
    }

    //http://localhost:8080/springmvc/mapping/ant1
    // 更细粒度 ,如果出现ant? 与 ant* 同时出现ant1则会优先被ant?匹配
    @RequestMapping("/ant?")
    public String mapping07() {
        System.out.println("通配符 - ?");
        return "/index.jsp";
    }
    //http://localhost:8080/springmvc/mapping/ant123
    @RequestMapping("/ant*")
    public String mapping08() {
        System.out.println("通配符 - *");
        return "/index.jsp";
    }
    //http://localhost:8080/springmvc/mapping/1/ant
    @RequestMapping("/**/ant")
    public String mapping09() {
        System.out.println("通配符 - **");
        return "/index.jsp";
    }
}
```



#### @pathVariable

```java
/**
 * @PathVariable("id") 用在参数上
 * 专门获取URL目录级别的参数
 * 比如 http://localhost:8080/springmvc/path/user/123/youwei
 * 要获得123 id为占位符   @RequestMapping("/user/{id}") : @PathVariable("id") Integer id 获取
 *
 * 如果是单个参数接受的话 必须要使用@PathVariable来声明对应的参数占位符名字
 * 如果是javaBean可以省略@PathVariable,但要保证占位符名字和JavaBean的属性名字一样
 */
@Controller
@RequestMapping("/path")
public class pathVariableController {

    /**
     * 获取用户实体 传入id
     * @return
     */
    @RequestMapping("/user/{id}/{username}")
    public String path01(@PathVariable("id") Integer id,@PathVariable("username") String name) {
        System.out.println(id);
        System.out.println(name);
        return "/index.jsp";
    }
    @RequestMapping("/user02/{id}/{name}")
    public String path02(User user) {
        System.out.println(user);
        return "/index.jsp";
    }

}
```



#### REST

Representational State Transfer (表述性状态传递)

==客户端映射到服务器资源的一种架构设计== 

URL -> restful 

==一种优雅的URL风格:== 

万维网 http协议 http://www.tulingxueyuan.cn 



==看URL就知道要什么==，， 看http method就知道干什么 

* 查询用户: http://localhost:8080/xxx/user/1		    GET ­­查询 
* 查询多个用户: http://localhost:8080/xxx/users      GET 
* 新增用户: http://localhost:8080/xxx/user                POST ­­­新增 
* 修改用户: http://localhost:8080/xxx/user/1             PUT ­­修改 
* 删除用户:http://localhost:8080/xxx/user/1              DELETE ­­删除



![image-20211104100735919](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111041007009.png)

```java
package com.jt.controllers;
/**
 * 用户rest风格的CRUD
 *
 * form表单提交PUT和DELETE出现问题:会将PUT和DELETE作为GET提交,因为HTML现在无法支持PUT和
 * DELETE:解决:
 *      1.需要添加HiddenHttpMethodFilter过滤器
 *      2.在表单中添加一个隐藏域<input type="hidden" value="put" name="_method">
 *          value就是对应的请求方式,
 *      3.将form的method设置为POST
 *      4.过滤器自动将POST请求设置为隐藏域中value的值的请求类型
 *
 *
 * tomcat 7以上版本对request.method更加严格,只支持GET/POST/HEAD
 *  HTTP Status 405  解决:
 *      1.tomcat7
 *      2.不用转发,用重定向
 *      3.自定义过滤器
 */
@Controller
@RequestMapping("/rest")
public class RestController {

    // 查询
    @GetMapping("/user/{id}")
    public String get(@PathVariable("id") Integer id) {
        System.out.println("查询用户:"+id);
        return "/index.jsp";
    }

    // 添加
    @PostMapping("/user")
    public String add(User user) {
        System.out.println("新增用户:"+ user);
        return "/index.jsp";
    }

    // 修改
    @PutMapping("/user/{id}")
    //如果是javaBean可以省略@PathVariable,但要保证占位符名字和JavaBean的属性名字一样
    public String update(User user) {
        System.out.println("修改用户:"+ user);
        return "redirect:/index.jsp";
    }

    // 删除
    @DeleteMapping("/user/{id}")
    public String delete(@PathVariable("id") Integer id) {
        System.out.println("删除用户:"+ id);
        return "redirect:/index.jsp";
    }
}
```

```jsp
<%--
  Created by IntelliJ IDEA.
  User: 00
  Date: 2021/11/4
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

   <!--用于设置正确的访问路径前缀,后续可以简写-->
<% request.setAttribute("basepath",request.getContextPath()); %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!--basepath已被上面声明 action代表请求的完整url-->
<form action="${basepath}/rest/user/1" method="get">
    <input type="submit" value="查询"/>
</form>

<form action="${basepath}/rest/user" method="post">
    id:<input name="id" type="text"></input><p></p>
    姓名:<input name="name" type="text"><p></p>
    <input type="submit" value="新增"/>
</form>

<form action="${basepath}/rest/user/1" method="post">
    <input type="hidden" value="put" name="_method">
    id:<input name="id" type="text"><p></p>
    姓名:<input name="name" type="text"><p></p>
    <input type="submit" value="修改"/>
</form>

<form action="${basepath}/rest/user/1" method="post">
    <input type="hidden" value="delete" name="_method">
    <input type="submit" value="删除"/>
</form>

</body>
</html>
```



#### 静态资源访问

如果servlet中配置的映射url是/  ==则代表除了.jsp以外的所有请求都会被调度器拦截==,这时可能静态资源文件不会被访问,因为dispatcherDervlet会拦截静态文件访问的url,但是找不到对应的handler mapping映射,因此会报错

```xml
<!--
        配置DispatcherServlet映射
        通常会为springmvc映射的路径为:
        /               除了.jsp的请求都会被匹配
        /*              所有的请求都会匹配
        *.do            url结尾以.do的请求会匹配
        *.action        url结尾以.action的请求会匹配
        /request/*      进行约定,将jsp放在/views/ ;所有的servlet请求都用/request/
    -->
<servlet-mapping>
    <servlet-name>springmvc</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```

解决方案:

在spring-mvc.xml中进行配置

```xml
<context:component-scan base-package="com.jt"/>

<!‐‐保证静态资源和动态请求都能够访问‐‐>
<mvc:annotation-driven/>
<!--推荐 将映射的地址直接指向静态资源文件夹,spring不会将此映射作为handler-->
<mvc:resources mapping="/images/**" location="/images/"/>
<!--不推荐
        下面这个也可以用来访问静态资源文件
        原理是,springmvc没有映射到handler时,
        就会调用默认servlet来处理
        而默认的可以处理静态资源文件
    -->
<!--<mvc:default-servlet-handler/>-->
```





### 响应处理

**使用默认内置视图解析器(ViewResolver)** 

```xml
<!--默认视图解析器 配上前缀和后缀,简化逻辑视图名称-->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" name="viewResolver">
    <property name="prefix" value="/WEB-INF/views"/>
    <property name="suffix" value=".jsp"/>
</bean>
```

```java
@RequestMapping("/response01")
public String response1() {
    //如果没有在xml中配置InternalResourceViewResolver的bean就需要只要来访问视图
    // return "/WEB-INF/views/index.jsp";
    //配置后只需
    return "/index";
}
```

**使用视图控制器<view-controller>**

如果我们有些请求只是想跳转页面，不需要来后台处理什么逻辑，我们无法在Action中写 一个空方法来跳转，直接在中配置一个如下的视图跳转控制器即可(不经过Action，直接跳 转页面) 

```xml
<!--视图名称还是会使用试图解析器来解析
        (立即访问)
        path需要映射的路径,view-name对应的试图名称
    -->
<mvc:view-controller path="/" view-name="index"/>
<mvc:view-controller path="/main" view-name="main"/>

<!--默认视图解析器 配上前缀和后缀,简化逻辑视图名称-->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" name="viewResolver">
    <property name="prefix" value="/WEB-INF/views/"/>
    <property name="suffix" value=".jsp"/>
</bean>
```

**使用Model，Map，ModelMap传输数据到页面**

可以在方法的参数上传入Model，ModelMap,Map类型，此时都能够 将数据传送回页面

```java

@Controller
public class DTVController {

    /**
     * 使用servlet API 原生方式传输数据到视图
     */
    @RequestMapping("/servletAPI")
    public String servletAPI(HttpServletRequest request) {
        request.setAttribute("type","servletAPI");
        return "main";
    }
    /**
     *  使用model的方式来传输数据到视图
     *  底层还是使用的是BindingAwareModelMap
     */
    @RequestMapping("/model")
    public String model(Model model) {
        // 表面是model 底层是封装了request的API
        model.addAttribute("type", "model");
        return "main";
    }
    /**
     *  使用modelmap的方式来传输数据到视图
     *  底层还是使用的是BindingAwareModelMap
     */
    @RequestMapping("/modelmap")
    public String model(ModelMap modelMap) {
        // 表面是model 底层是封装了request的API
        modelMap.addAttribute("type", "modelMap");
        return "main";
    }
    /**
     *  使用map的方式来传输数据到视图
     *  底层还是使用的是BindingAwareModelMap
     */
    @RequestMapping("/map")
    public String map(Map map) {
        // 表面是model 底层是封装了request的API
        map.put("type", "modelMap");
        return "main";
    }
    
    /**
     * 通过modelandview来传输数据到视图
     * @return
     */
    @RequestMapping("/ModelAndView")
    public ModelAndView modelAndView() {
        // 设置视图对应的modelandview ,也可以使用setView来设置视图路径
        ModelAndView mv = new ModelAndView("main");
        // 传输具体的值到视图中!
        mv.addObject("type", "modelandview");
        return mv;
    }
}
```
重点是下面的jsp文件中需要用${requestScope.type}接受返回的数据,

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
  冲啊!!!!
    ${requestScope.type}
</body>
</html>
```

**使用ModelAndView对象传输数据到页面** 

发现当使用modelAndView对象的时候，返回值的类型也是此对象， 可以将要跳转的页面设置成view的名称，来完成跳转的功能，同时数据也是放到 request作用中。



**使用session传输数据到页面**

怎么往session设置属性？ 

**1.通过servlet api的方式去读写session** 

1. 通过参数绑定的方式去获取**servlet api** 

2. 通过自动注入的方式去获取**servlet api(推荐使用这种方式）** 

```java
    /**
     * 通过参数绑定的方式来获取servlet api--serssion
     * @return
     */
    @RequestMapping("/servletapi/session")
    public String session(HttpSession session) {
        session.setAttribute("type","servletapi-session");
        return "main";
    }


    /**
     * 通过自动注入的方式去获取servlet api
     */
    @Autowired
    private HttpSession session;

    @RequestMapping("/autowired/session")
    public String session02() {
        session.setAttribute("type","autowired-session");
        return "main";
    }
```



**2.通过springmvc提供的注解方式去读写session** 

1. @SessionAttributes 

   用在类上面的，==写入session的==。

   >  从model中获取指定的属性写入session中 
   >
   >  底层会从model中去找一个叫做type的属性 
   >
   >   找到了会将type设置一份到session中 
   >
   >   这种方式是依赖model的 
   >
   >  ==当前控制器下所有的处理方法 都会将model指定的属性写入session== 

   ```java
    @SessionAttributes("type") 
   public class DTVController {}
   ```

   

2. @SessionAttribute 

   用在参数上面的，==读取session的==

默认指定的属性是必须要存在的，如果不存在则会报错，可以设 置==required =false 不需要必须存在==，不存在默认绑定null 

```java
/**
     *  @SessionAttribute 获取session
     *  required 用来设置session中某个属性必须存在,不存在会报错
     *  model 和 session 是互通的 : session可以通过model中去获取写入指定的属性
     *                          model也会从session中自动写入指定的属性
     */
@RequestMapping("/annotation/session")
public String session03(@SessionAttribute(value = "type",required = false) String type) {
    System.out.println(type);
    return "main";
}
```



**使用@ModelAttribute来获取请求中的数据** 

常用的使用场景 

1. ==写在方法上面== 

   @ModelAttribute的方法会在当前处理器中==所有的处理方法之前调用== 

   * 通过@ModelAttribute来给全局变量赋值(不推荐） 
   * 当我们调用执行全字段的更新数据库操作时，假如提供给用户的修改字段只有 部分几个，这个时候就会造成其他字段更新丢失： 

解决： 

1.自己定制update语句， 只更新指定的那些字段 

2.如果无法定制sql语句， 可以在更新之前进行查询， 怎么在更新之前查询？只 能在springmvc 绑定请求参数之前查询， 利用@ModelAttribute就可以在参数绑定之前查询， 但是怎么将查询出来的对象和参数的对象进行合并？ springmvc具有该特性， 会 将model中和参数名相同的属性拿出来进行合并，将参数中的新自动进行覆盖，没有的字段 进行保留。这样就可以解决这个问题。 



2. ==写在参数上面== 

可以省略，加上则会从model中获取一个指定的属性和参数进行合并，因为model和 sessionAttribute具有共通的特性，所以如果session中有对应的属性也会进行合并 









**3种方式的获取servlet­­api的线程安全问题：** 









# 不想写了!自己去看PDF文件!!



























































































































































































