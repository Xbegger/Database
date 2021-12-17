# Spring Boot2 简介



<img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111172151609.png" alt="image-20211117215141492" style="zoom:150%;" />

![image-20211118095520822](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111180955027.png)



### spring boot的快速搭建

pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.example</groupId>
    <artifactId>springboot2-1</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

    <!--引入了一个父项目,继承父maven项目中所有的配置信息
        又引入了spring-boot-dependencies的父maven项目,帮我们管理了springboot所有依赖的版本
        因此 导入已有的依赖就不需要写版本号,它帮我们解决了第三方库直接的版本冲突问题
        名词:SpringBoot的版本仲裁中心
    -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.6</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <!--starter 场景启动器
        不同的场景启动器维护了所对应的所有依赖,从而简化maven的书写
        spring-boot-starter-aop , spring-boot-starter-data-elasticsearch , spring-boot-starter-data-jdbc ...
    -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <!--部署springboot的插件,只有加了这个插件,当我们运行java -jar -->
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
```

application.properties(约定大于配置,文件名必须是这个,位置放在resources根目录下)

```properties
# 约定大于配置
# 文件名:application.properties
# 位置:resources的根目录下
server.port=8080
server.servlet.context-path=/happy
```



Application 类(springboot启动类,唯一)

```java
package com.jt;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
/**
 * @SpringBootApplication: springboot的启动类(入口)
 *
 * 包含@Configuration:也是一个配置类
 *
 * 包含@ComponentScan:扫描包 设置basePackages
 *
 * spring底层在解析配置类时,会去解析@ComponentScan , 读取basePackages
 * 如果没有读取到,会将当前配置类所在的包当做是basePackages的扫描包
 *
 * 位置最好放在需要扫描的包的根路径下!!!或者放在所有bean的顶层目录中
 */
@SpringBootApplication //标记成springboot的启动类
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class,args);
    }
}
```

HelloController类

```java
package com.jt.controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // 等于@Controller + @ResponseBody
@RequestMapping("/hello")
public class HelloController {

    @RequestMapping("/world")
    public String sayHi() {
        return "Hello world";
    }
}
```



### 配置文件和配置原理

* 使用Spring Initializer新建一个父Maven项目
* 使用Spring Initializer新建一个子Maven项目
* 修改子项目中的继承方式

之前:

![image-20211118110250451](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111181102568.png)

之后:

![image-20211118110312206](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111181103289.png)



> ==spring_init== 继承自 ==spring_parent== 继承自 ==spring-boot-starter-parent==



### 自定义SpringApplication

```java
    public static void main(String[] args) {
        // SpringApplication.run(SpringInitializerApplication.class, args);
        SpringApplication app = new SpringApplication(SpringInitializerApplication.class);
        app.setBannerMode(Banner.Mode.OFF);// 关闭springboot的启动横幅
        app.run(args);
    }

```

* 可以通过SpringApplication.run方法直接启动
* 可以通过实例化SpringApplication来进行自定义配置在启动run方法



### 配置文件的使用

全局配置文件的名字一定要叫:==application.properties==(也可以更改,但不推荐)

* application.properties

![image-20211119110212521](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191102592.png)

* application.yml(==推荐使用== 可读性强!)

![image-20211119110219846](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191102899.png)

* application.yaml(书写方式等同于yml)



> 如果同时出现properties文件和yml文件,则springboot会优先选择yml文件作为配置文件
>
> (spring-boot-starter-parent中的设置,==yml文件优先!==(**前提是同一个目录里下**))
>
> ![image-20211119110911542](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191109636.png)
>
> 允许多个配置文件共存:
>
> * 以yml文件中的配置为主
> * 其他文件作为配置的互补!!



**外部约定配置文件加载顺序(==从低到高==):**

* classpath根目录下

![image-20211119111938672](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191119761.png)

* classpath根config/

![image-20211119111953595](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191119661.png)



* 项目根目录

​		如果当前项目是继承\耦合 关系maven项目的话,项目根目录=父maven项目的根目录

![image-20211119112201867](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191122938.png)

* 项目根目录/config

![image-20211119112234748](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191122803.png)

* 直接子目录(可能就是直接在命令行直接指定配置文件位置)/config

![image-20211119112327955](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111191123015.png)



### profile文件的加载

对于应用程序来说,不同环境需要不同的配置.

![image-20211119212340201](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111192123314.png)





所有配置文件按一下顺序考虑:优先级==从低到高==

* 打包在jar中配置文件

* 打包在jar中profile

* 打包的jar之外的配置文件

* 打包的jar之外的profile 

  

### 配置文件值注入

松散绑定:

```yml
user:
  userName: 张胜男

user:
  user-ame: 张胜男

user:
  user_ame: 张胜男

user:
  USERNAME: 张胜男

user:
  username: 张胜男
```

以上几种命名是可以自动绑定bean属性`User.username`

![image-20211121151451825](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211514972.png)



```java
package com.jt.beans;

/**
 * 可以通过@value + SPEL 直接绑定springboot配置文件中的值
 *
 * @ConfigurationProperties(prefix = "user")
 * 常用于bean属性和yml配置文件的绑定
 *  prefix属性指定配置文件中某一个节点,该节点中的子节点将自动和属性进行绑定
 */

@Component
@ConfigurationProperties(prefix = "user") //可以省略 后续的@Value("${user.username}")
public class User {
    // @Value("${user.username}")
    private String username;
    // @Value("${user.age}")
    private Integer age;
    private Date birthday;
    private List<String> hobbies;
    private Map<Integer, String> girlFriend;
    private Address address;

//此处省略 getter setter toString等方法!!!!
}
```

```java

package com.jt.beans;

public class Address {
    private Integer id;
    private String dest;
//此处省略 getter setter toString等方法!!!!
}

```

***application.yml***

```yaml
# 注意每个冒号后面都有空格!!!
server:
  port: 8080
  servlet:
    context-path: /yml

spring:
  main:
    lazy-initialization: true

user:
  user-name: 张胜男
  age: 18
  birthday: 2020/01/01
  hobbies: [ 唱歌,跳舞 ]  # 行内写法
  girl-friend: {18: 李冰冰,20: 迪丽热巴} # 行内写法
  address:
    id: 1
    desc: 北京
#  girl-friend:
#    18: 范冰冰
#    20: 迪丽热巴
#  hobbies:
#    - 唱歌
#    - 跳舞
```



### 随机数和属性引用

```yml
my:
  secret: "${random.value}"
  number: "${random.int}"
  bignumber: "${random.long}"
  uuid: "${random.uuid}"
  number-less-than-ten: "${random.int(10)}"
  number-in-range: "${random.int[1024,65536]}"
```

The `random.int*` syntax is `OPEN value (,max) CLOSE` where the `OPEN,CLOSE` are any character and `value,max` are integers. If `max` is provided, then `value` is the minimum value and `max` is the maximum value (exclusive).

```yml
user:
  user-name: ${random.value}
  age: ${random.int(1,150)}
  birthday: 2020/01/01
  hobbies: [ 唱歌,跳舞 ]  # 行内写法
  girl-friend: {18: 李冰冰,20: 迪丽热巴} # 行内写法
  address:
    id: 1
    dest: ${user.user-name}的家在北京 # 属性占位符 只支持引用,不支持SpEL表达式
```



### jsr-303数据校验

Bean Validation 中内置的 constraint

![image-20211121150718676](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211507800.png)

Hibernate Validator 附加的 constraint

![image-20211121150754083](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211507185.png)



还有其他方法的注入(引入外部xxx.properties):

```java
@Component
@ConfigurationProperties(prefix = "user") //可以省略 后续的@Value("${user.username}")
@Validated
@PropertySource("classpath:data/user.properties")
public class User {
    private String username;
    private Integer age;
    private Date birthday;
    private List<String> hobbies;
    private Map<Integer, String> girlFriend;
    private Address address;
```

***data/user.properties***

```properties
user.age=12
```



### [?]自动配置原理

https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core



***org.springframework.boot.autoconfigure.==SpringBootApplication==:***

![image-20211121154752373](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211547546.png)

```java
@Target(ElementType.TYPE)				// 设置当前注解标记位置(当前:类)
@Retention(RetentionPolicy.RUNTIME)		// 注解保留策略,保留在什么级别下   注解会被在运行时由 VM 保留，因此它们可以被反射读取。
@Documented								// java doc会生成注解信息
@Inherited								// 会不会被继承
```

```java
@SpringBootConfiguration				//表示这是一个springboot的配置类
@EnableAutoConfiguration				// springboot开启自动配置功能,自动加载自动配置类
@ComponentScan							// 扫描包 相当于在spring.xml中的					  <context:comonent-scan> 但是没有指定basePackages 	默认将当前配置类所在包作为扫描包	
```

```
TypeExcludeFilter 是springboot对外提供的扩展类,可以供我们全照我们的方式进行排除
AutoConfigurationExcludeFilter 排除所有配置类且是自动配置类的类
```





### 热部署与日志

热部署 配置!!!

1. 加入依赖!

```xml
<!--devtools热部署-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>
```

2. 配置IDEA（settings）

![image-20211121163732386](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211637515.png)



3. compile.automake.allow.when.app.running

![image-20211121164056284](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111211640448.png)





springboot日志框架!

![image-20211121213716507](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111212137687.png)



日志格式详细介绍:

```java
2021-11-21 21:46:12.968  INFO 16288 --- [  restartedMain] o.a.catalina.core.AprLifecycleListener   : APR/OpenSSL configuration: useAprConnector [false], useOpenSSL [true]
```



![image-20211121214901530](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111212149684.png)

==注意:==

在yml基本语法中如果有特殊字符% & 记得用单引号`'`包起来



可以使用

```
logging:
	pattern:
  		console:
```

来修改默认的控制的日志格式

```yml
'%clr(%d{${LOG_DATEFORMAT_PATTERN:-yyyy-MM-dd HH:mm:ss.SSS}}){faint} %clr(${LOG_LEVEL_PATTERN:-%5p}) %clr(${PID:- }){magenta} %clr(---){faint} %clr([%15.15t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}'

```



```
%clr(%d{${LOG_DATEFORMAT_PATTERN:-yyyy-MM-dd HH:mm:ss.SSS}}){faint}
```

* `%clr` :指定当前内容以什么颜色输出  {faint}

```
(%d{${LOG_DATEFORMAT_PATTERN:-yyyy-MM-dd HH:mm:ss.SSS}})
```

* `${value:value2}`springboot==占位符+null条件表达式==(如果value为null,使用value2)
* LOG_DATEFORMAT_PATTERN:系统环境变量中的值,spring底层会根据对应的配置项将值设置到对应的环境变量中.

![image-20211122144100392](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221441518.png)



* `%d`:logback日期显示方式

* `-%5`:当前内容占字符的长度(向左对齐,保持五个字符的宽度)

* `p` :输出级别
* `${PID:- }`:线程id



### 日志文件输出

```yml
logging:
 	file:
       name: hello.log #可以设置文件的名称,如果没有设置路径会默认在项目的相对路径下
       path: D:/		#不可以指定文件名称,必须要指定一个物理文件夹路径,会默认使用spring.log
```

#### 日志迭代

|                             名称                             |             描述             |               默认值               |
| :----------------------------------------------------------: | :--------------------------: | :--------------------------------: |
| [`logging.logback.rollingpolicy.clean-history-on-start`](https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core.logging.logback.rollingpolicy.clean-history-on-start) | 是否在启动时清除存档日志文件 |              `false`               |
| [`logging.logback.rollingpolicy.file-name-pattern`](https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core.logging.logback.rollingpolicy.file-name-pattern) |     过渡日志文件名的模式     | `${LOG_FILE}.%d{yyyy-MM-dd}.%i.gz` |
| [`logging.logback.rollingpolicy.max-file-size`](https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core.logging.logback.rollingpolicy.max-file-size) |       最大日志文件大小       |               `10MB`               |
| [`logging.logback.rollingpolicy.max-history`](https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core.logging.logback.rollingpolicy.max-history) |  归档日志文件的最大保留天数  |                `7`                 |
| [`logging.logback.rollingpolicy.total-size-cap`](https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html#application-properties.core.logging.logback.rollingpolicy.total-size-cap) |   要保留的日志备份的总大小   |                `0B`                |



#### 自定义日志配置文件

如果使用自定义配置文件 会使得springboot中全局配置文件的logging相关配置失效



#### 切换日志框架

* 将logback切换成log4j2

```xml
<!--自动添加了starter-logging 也就是logback的依赖-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <!--排除starter-logging 也就是logback的依赖 为了其他日志框架的切换-->
    <exclusions>
        <exclusion>
            <artifactId>spring-boot-starter-logging</artifactId>
            <groupId>org.springframework.boot</groupId>
        </exclusion>
    </exclusions>
</dependency>

<!--Log4j2的场景启动器 桥接器-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-log4j2</artifactId>
</dependency>
```



* 将logback切换成log4j

1. logback的桥接器排除
2. 添加log4j的桥接器
3. 添加配置文件

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <exclusions>
        <exclusion>
            <artifactId>logback-classic</artifactId>
            <groupId>ch.qos.logback</groupId>
        </exclusion>
    </exclusions>
</dependency>

<!--log4j桥接器-->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-log4j12</artifactId>
</dependency>
```





### 排除maven依赖操作

前提:安装插件:==maven helper==

![image-20211122163805232](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221638413.png)

![image-20211122163950191](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221639407.png)

![image-20211122163846758](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221638893.png)



### springboot 与 Web开发

![image-20211122164540296](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221645456.png)



#### 推荐使用构造器注入

https://www.cnblogs.com/joemsu/p/7688307.html

![image-20211122171752812](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221717942.png)



#### 如何将写好的mvc进行测试?

![image-20211122173335560](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111221733728.png)



#### restTemplate

适用于微服务架构下  服务之间的远程调用 ,ps 以后使用微服务架构,==spring cloud feign==

> WebClient 与 restTemplate:
>
> 都可以调用远程服务,区别:
>
> webclient 依赖 webflux
>
> webclient 请求远程服务是无阻塞,响应式

>  restTemplate是阻塞式的 ,需要等待请求响应后才能执行下一句代码

掌握:

* DELETE
* GET
* POST
* PUT

![image-20211123144146965](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111231441162.png)





**springboot_web**

UserController

```java
package com.jt.springbootweb.controller;

@RestController
@RequestMapping("/user")
public class UserController {

    // spring 推荐使用构造器注入的方式
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 查询
    @GetMapping("/{id}")
    //@PathVariable:代表将URL中的占位符 绑定到方法的形参之中!!!
    public Result getUser(@PathVariable("id") Integer id) {
        User user = userService.getUserById(id);
        return new Result<>(200, "查询成功", user);
    }

    // 添加
    @PostMapping("/add")
    // 添加@RequestBody注解是为了接受json类型数据
    public Result addUser(@RequestBody User user) {
        userService.add(user);
        return new Result<>(200, "添加成功",userService.getAllUser());
    }

    // 修改
    @PutMapping("/{id}")
    // 这里没有用到@Pathvariable 是因为id 会自动注入到User对应的字段中!!!!!
    public Result editUser(@RequestBody User user) {
        userService.update(user);
        return new Result<>(200, "修改成功",userService.getAllUser());
    }

    // 删除
    @DeleteMapping("/{id}")
    public Result editUser(@PathVariable Integer id) {
        userService.delete(id);
        return new Result<>(200, "删除成功",userService.getAllUser());
    }
}
```

**springboot_web_rest**

OrderController

```java
package com.jt.springboot_web_rest.controller;

@RestController
public class OrderController {

    // 声明了一个RestTemplate
    private final RestTemplate restTemplate;

    // 当bean 没有无参构造函数的时候,spring 将自动拿到有参的构造函数,参数进行自动注入
    // 不需要加@Autowired 当有多个构造器的时候会选择有@Autowired注解的构造器进行注入
    @Autowired
    public OrderController(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    @RequestMapping("/order")
    public String order() {
 
        /**
         * 调用删除
         *  不需要额外在传递参数,所以不需要使用HttpEntity
         */
        ResponseEntity<Result> resultResponseEntity = restTemplate.exchange("http://localhost:8080/user/{id}", HttpMethod.DELETE, null, Result.class, 1);
        System.out.println(resultResponseEntity.toString());
        return resultResponseEntity.getBody().toString();
    }
}
```

```java
// 下单 远程访问rest服务!
// 基于restTemplate 调用查询
Result forObject = restTemplate.getForObject("http://localhost:8080/user/{id}", Result.class, 1);
return forObject.toString();
```



```java

/**
         *  调用新增,这里的对象user 会被转化为json格式!
         *  url         :请求的远程rest url
         *  object      :post请求的参数
         *  Class<T>    :返回的类型
         *  ...Object   :@PathVariable占位符的参数,地址栏上没有占位符的不需要使用
         */
User user = new User("无为","地球");
ResponseEntity<Result> resultResponseEntity = restTemplate.postForEntity("http://localhost:8080/user/add", user, Result.class);
System.out.println(resultResponseEntity.toString());
return resultResponseEntity.getBody().toString();


```

```java

/**
         * 调用修改restTemplate.put
         *  但是 put方法没有返回值,如果在当前springboot中想看到返回结果
         *  可以使用restTemplate.exchange!!!!
         */
 User user = new User(1, "修改", "修改");
// restTemplate.put("http://localhost:8080/user/{id}",user,Result.class);

 HttpEntity<User> userHttpEntity = new HttpEntity<>(user);
 ResponseEntity<Result> resultResponseEntity = restTemplate.exchange("http://localhost:8080/user/{id}", HttpMethod.PUT, userHttpEntity, Result.class, 1);
 System.out.println(resultResponseEntity.toString());
 return resultResponseEntity.getBody().toString();
```



Result

```java
public class Result<T> {
    private Integer code;
    private String message;
    private T data;
    // restTemplate会调用无参构造函数 把数据赋值到该对象
    public Result() {
    }
//省略setter getter tostring.....
```





#### MockMVC测试

如何在idea编写string的json文件?

1. ![image-20211123162734839](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111231627025.png)
2. ![image-20211123162825414](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111231628580.png)
3. ![image-20211123162922329](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111231629501.png)



**如何进行测试?**



```java
package com.jt.springbootweb;

@SpringBootTest
@AutoConfigureMockMvc // 专门做mockmvc的 有spring-test提供,依赖junit5
public class MockMvcTests {
    
    @Autowired
    MockMvc mockMvc;

    @Test   //这里的注解是junit5的直接(jupiter)
    public void testMockMVC() throws Exception {
        // 发起一个模拟请求 不依赖网络,web服务 不需要启动web应用!
        ResultActions resultActions = mockMvc.perform(
                // 注意url 是controller中的url
                MockMvcRequestBuilders.get("/user/{id}", 2)// 发送了get请求
                        //设置响应文本类型
                        .accept(MediaType.APPLICATION_JSON)
                        .characterEncoding("UTF-8")
        );
        resultActions.andReturn().getResponse().setCharacterEncoding("utf-8");  // 设置response的编码格式
        resultActions
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.username").value("张飒2"))
                .andDo(MockMvcResultHandlers.print());//断言并打印
    }

    @Test   //这里的注解是junit5的直接(jupiter)
    public void testMockMVCpost() throws Exception {

        //language=JSON
        String userJson = "{\n" +
                "  \"username\": \"张三\",\n" +
                "  \"address\": \"mockMVC\"\n" +
                "}";

        // 发起一个模拟请求 不依赖网络,web服务 不需要启动web应用!
        ResultActions resultActions = mockMvc.perform(
                MockMvcRequestBuilders.post("/user/add")// 发送了get请求
                        // 设置响应文本类型
                        .accept(MediaType.APPLICATION_JSON)
                        // 请求的字符编码
                        .characterEncoding("UTF-8")
                        // 设置请求的文本类型
                        .contentType(MediaType.APPLICATION_JSON)
                        // 传入准备好的json 字符串
                        .content(userJson)
        );
        resultActions.andReturn().getResponse().setCharacterEncoding("utf-8");  // 设置response的编码格式
        resultActions
                .andExpect(MockMvcResultMatchers.status().isOk())
                // 使用JsonPath json路径表达式 响应断言以检查正确性。
                .andExpect(MockMvcResultMatchers.jsonPath("$.data.length()").value(6))
                .andDo(MockMvcResultHandlers.print());//断言并打印
    }
}
```





### springboot的自动配置

Spring Boot 为Spring MVC 提供了自动配置,可与大多数应用程序完美配合

自动配置在spring的默认值之上添加了一下功能:

* 包含`ContentNegotiatingViewResolver`和`BeanNameViewResolver`

  * ViewResovler都是SpringMVC内置的视图解析器

    * `ContenNegotiatingViewResolver`

    > 不解析视图本身，而是委托给其他视图解析程序，并选择与客户端请求的表示类似的视图。可以从Accept标头或查询参数（例如，“/path？format=pdf”）确定表示形式。
    >
    > **所有的视图解析器 , 都会根据返回的视图名称进行解析视图**
    >
    > ```java
    > @Override
    > 	@Nullable
    > 	public View resolveViewName(String viewName, Locale locale) throws Exception {
    > 		RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
    > 		Assert.state(attrs instanceof ServletRequestAttributes, "No current ServletRequestAttributes");
    > 		List<MediaType> requestedMediaTypes = getMediaTypes(((ServletRequestAttributes) attrs).getRequest());
    > 		if (requestedMediaTypes != null) {
    >             // 获得所有匹配的视图
    > 			List<View> candidateViews = getCandidateViews(viewName, locale, requestedMediaTypes);
    >             // 获取最终的
    > 			View bestView = getBestView(candidateViews, requestedMediaTypes, attrs);
    > 			if (bestView != null) {
    > 				return bestView;
    > 			}
    > 		}
    >         ....................
    > ```
    >
    > 委派给其他视图解析器进行解析:
    >
    > ![image-20211123221828541](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111232218807.png)
    >
    > 由以上代码得出结论,它是从spring IOC容器获得ViewResolver类型Bean,那么我们可以自己定制一个ViewResolver,
    >
    > `ContenNegotiatingViewResolver`也会帮我们委派解析

    * `BeanNameViewResolver`

    > 会根据handler方法返回的视图名称 对应到具体视图并解析,==去ioc容器中找到名字叫xushu的一个Bean,并且这个bean实现了View!!==
    >
    > 示例:
    >
    > ![image-20211123223050862](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111232230084.png)
    >
    > 可以配置一个叫Xushu的视图
    >
    > ![image-20211123223136642](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111232231888.png)

* 支持提供静态资源. 包括对WebJars的支持

  * 以前要访问jpg\css js等 这些静态资源文件,需要在web.xml中进行配置,在springboot不需要配置,只需要放在约定文件夹中就可以(约定大于配置)

  * 原理

    * webjars就是将静态资源放在jar包中进行访问(webjars.org)

    * 当访问webjars时 就会去`"classpath:/META-INF/resources/webjars/"`对应进行映射

      * 当访问http://localhost:8080/webjars/jquery/3.5.1/jquery.js 对应映射到`/META-INF/resources/webjars/jquery/3.5.1/jquery.js`

        

    > ```java
    > 		@Override
    > 		public void addResourceHandlers(ResourceHandlerRegistry registry) {
    > 			if (!this.resourceProperties.isAddMappings()) {
    > 				logger.debug("Default resource handling disabled");
    > 				return;
    > 			}
    > 			Duration cachePeriod = this.resourceProperties.getCache().getPeriod();
    > 			CacheControl cacheControl = this.resourceProperties.getCache().getCachecontrol().toHttpCacheControl();
    > 			if (!registry.hasMappingForPattern("/webjars/**")) {
    > 				customizeResourceHandlerRegistration(registry.addResourceHandler("/webjars/**")
    > 						.addResourceLocations("classpath:/META-INF/resources/webjars/")
    > 						.setCachePeriod(getSeconds(cachePeriod)).setCacheControl(cacheControl)
    > 						.setUseLastModified(this.resourceProperties.getCache().isUseLastModified()));
    > ```
    >
    > 
    >
    > ![image-20211124102854116](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241028335.png)![image-20211124103234067](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241032275.png)

  * 在static访问静态资源原理? 会依次访问下面的路径

    > ```java
    > // getStaticLocations 地址下的数组内容!!!!
    > { "classpath:/META-INF/resources/",
    > "classpath:/resources/", 
    > "classpath:/static/", 
    > "classpath:/public/" };
    > ```
    >
    > ```java
    > 	@Override
    > 		public void addResourceHandlers(ResourceHandlerRegistry registry) {
    > 							//xxxxxxxx省略xxxxxxxx
    > 			String staticPathPattern = this.mvcProperties.getStaticPathPattern();
    > 			if (!registry.hasMappingForPattern(staticPathPattern)) {
    > 				customizeResourceHandlerRegistration(registry.addResourceHandler(staticPathPattern)
    > 						.addResourceLocations(getResourceLocations(this.resourceProperties.getStaticLocations()))
    > 						.setCachePeriod(getSeconds(cachePeriod)).setCacheControl(cacheControl)
    > 						.setUseLastModified(this.resourceProperties.getCache().isUseLastModified()));
    > 			}
    > 		}
    > ```

  * 配置欢迎页

    > ```java
    > private Optional<Resource> getWelcomePage() {
    >     String[] locations = getResourceLocations(this.resourceProperties.getStaticLocations());
    >     return Arrays.stream(locations).map(this::getIndexHtml).filter(this::isReadable).findFirst();
    > }
    > ```
    >
    > 直接将index.html防止在resources下的static中即可

  * 也可以通过配置文件指定具体的静态资源地址

* 自动注册`Converter` `GenericConverter` `Formatter` Bean类

  * 使用方式参考springmvc课程

* 支持`HttpMessageConverters`

  * 负责http请求和响应的文本处理

  * > ![image-20211124105134896](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241051157.png)

* 自动注册`MessageCodeResolver`

  * 修改4xx错误下格式转换出错 类型转化出错的 错误代码

* 静态`index.html`支持

  * 在springboot 中可以直接返回html的视图,因为在`WebMvcAutoConfiguration`类中配置了

  > ```java
  > @Bean
  > @ConditionalOnMissingBean
  > public InternalResourceViewResolver defaultViewResolver() {
  >    InternalResourceViewResolver resolver = new InternalResourceViewResolver();
  >    resolver.setPrefix(this.mvcProperties.getView().getPrefix());
  >    resolver.setSuffix(this.mvcProperties.getView().getSuffix());
  >    return resolver;
  > }
  > ```
  >
  > 所以就可以通过全局配置文件(**application.properties**)中完成
  >
  > ```xml
  > spring.mvc.view.prefix=/pages/
  > spring.mvc.view.suffix=.html
  > ```

* 自动使用`ConfigurableWebBindingInitializer` Bean

  * 





### 定制SpringMvc的自动配置

springmvc的自动配置类：==WebMvcAutoConfiguration==

1. 在大多数情况下,springboot在自动配置类中标记了很多`@ConditionalOnMissingBean(HiddenHttpMethodFilter.class)`就是如果容器中没有当前的bean才会生效,我们只需要在自己的配置类中==配置对应的bean就可以覆盖默认的配置类==



#### 自定义拦截器

1. 创建一个包`interceptors`

2. 在包里创建一个类`Timeinterceptor`

3. 实现接口`HandlerInterceptor`

4. 重写三个方法

   1. `preHandle`:请求之前
   2. `postHandle`:请求之后,视图渲染之前
   3. `afterCompletion`:视图渲染之后

5. 将`preHandle`中的返回值设置为`true`:为了方法往下面继续执行
   
5. 通过`WebMvcConfigure`来配置拦截器
   
   ```java
   @Configuration
   public class MyWebMvcConfigurer implements WebMvcConfigurer {
   
       /**
        * 添加拦截器
        * @param registry
        */
       @Override
       public void addInterceptors(InterceptorRegistry registry) {
           registry.addInterceptor(new TimeInterceptor())  // 添加拦截器
                   .addPathPatterns("/**");                // 拦截映射规则
       }
   }
   ```
   
   
   
   ```java
   package com.jt.springbootweb.interceptors;
   public class TimeInterceptor implements HandlerInterceptor {
   
       LocalDateTime begin;
       private static final Logger LOGGER = LoggerFactory.getLogger(TimeInterceptor.class);
   
       @Override
       public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
           // 开始时间
           begin = LocalDateTime.now();
           // 如果这里不是true 就不会被拦截处理
           return true;
       }
   
       @Override
       public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
           // 结束时间
           LocalDateTime end = LocalDateTime.now();
           // 计算两个时间差
           Duration between = Duration.between(begin, end);
           // 获得相差的毫秒
           long l = between.toMillis();
           LOGGER.info("当前请求:"+request.getRequestURI()+"请求执行时间为 : "+l+"毫秒");
       }
   }
   ```
   
   
   

#### 跨域资源共享(CORS)

* 注解实现跨域:在controller中的方法上添加注解`@CrossOrigin`

```java
// 查询
@GetMapping("/{id}")
@CrossOrigin //支持跨域资源共享
//@PathVariable:代表将URL中的占位符 绑定到方法的形参之中!!!
public Result getUser(@PathVariable("id") Integer id) {
    User user = userService.getUserById(id);
    return new Result<>(200, "查询成功", user);
}
```

* 全局配置跨域请求

   ```java
   package com.jt.springbootweb.config;
   @Configuration
   public class MyWebMvcConfigurer implements WebMvcConfigurer {
   
    
       @Override
       public void addCorsMappings(CorsRegistry registry) {
           registry.addMapping("/user/*") // 映射服务器中那些http接口允许跨域访问
                   .allowedMethods("GET", "POST", "PUT", "DELETE");// 配置允许跨域访问的请求的方法
       }
   }
   ```



#### WebMvcConfigure原理

实现`WebMvcConfigure`接口可以扩展mvc实现,又保留了springboot的自动配置

在`WebMvcAutoConfiguration`类中也有一个实现了`WebMvcConfigure`接口的类

```java
public static class WebMvcAutoConfigurationAdapter implements WebMvcConfigurer
```

`WebMvcAutoConfigurationAdapter`也是利用实现接口的方法来进行配置,所以直接学习这个类~!!!!并且他帮我们实现了其他不常用的方法,帮助我们进行自动配置,我们只需要定制(==拦截器,视图控制器,CORS==)等在开发中需要额外定制的功能

   当添加了`@EnableWebMvc`注解在配置类后,就不会使用springMVC自动配置类的默认配置

   ```java
   //将此注释添加到@Configuration类会从WebMvcConfigurationSupport导入 Spring MVC 配置，例如：
   @Configuration
   @EnableWebMvc
   @ComponentScan(basePackageClasses = MyConfiguration.class)
   public class MyConfiguration {
   }
   ```

> 在 `WebMvcAutoConfiguration`类中有一行注解:`@ConditionalOnMissingBean(WebMvcConfigurationSupport.class)`代表着,只有当`WebMvcConfigurationSupport`bean不存在时才会使得当前自动配置类生效!
>
> 正是因为通过注解`@EnableWebMvc`导入了`WebMvcConfigurationSupport`的bean,所以自动配置类才会==失效==



### json开发

springboot集成了三款json框架

* Gson
* ==jackson默认==
* JSON-B



**jackson的使用:**

* `@JsonIgnore `:进行排除json序列化,将它标注在属性上将不会进行json序列化

* `@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss",locale = "zh")`:可以进行日期格式化

* `@JsonInclude(JsonInclude.Include.NON_NULL)`:当属性为null时,则不进行序列化,还有其他的值:`EMPTY`等

* `@JsonProperty("uname")`:来设置别名,这样显示的就是别名

  ```java
  @JsonProperty("uname")
  private String username;
  //{"code":200,"message":"查询成功","data":{"id":1,"address":"北京","birthday":"2021-11-24 06:20:37","uname":"张飒1"}}
  ```



#### 序列化反序列化

springboot还能提供`@JsonComponent`来根据自己的业务要求进行json的序列化个反序列化

* 创建一个json自定义类
* 添加注解`@JsonComponent`
* 添加静态内部类,并提供需要进行序列化和反序列化的**泛型**
  * `public static class Serializer extends JsonObjectSerializer<User>`
  * `public static class Deserializer extends JsonObjectDeserializer<User>`
* 重写方法并添加逻辑



例子:

```java
package com.jt.springbootweb.config;

@JsonComponent
public class UserJsonCustom {
    public static class Serializer extends JsonObjectSerializer<User> {

        @Override
        protected void serializeObject(User user, JsonGenerator jgen, SerializerProvider provider) throws IOException {
            jgen.writeObjectField("id",user.getId()); // 序列化了{"id","xxx"}
            jgen.writeObjectField("uname","xxxxx"); // 序列化了{"id","xxx"}
        }
    }

    public static class Deserializer extends JsonObjectDeserializer<User> {
        @Override
        protected User deserializeObject(JsonParser jsonParser, DeserializationContext context, ObjectCodec codec, JsonNode tree) throws IOException {
            User user = new User();
            user.setId(tree.findValue("id").asInt());
            return user;
        }
    }
}

```

#### [?]国际化



### [?]统一异常处理

1. springboot有统一异常处理自动配置类,可以进行==二次开发==

`ErrorMvcAutoConfiguration`:统一异常处理配置类
重要组件:

* `DefaultErrorViewResolver`
* `BasicErrorController`
* `DefaultErrorAttributes`

![image-20211124145742882](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241457166.png)



当时用浏览器发送请求时,请求头是`Accept:text/html`,会交给`errorHtml`方法处理,除了text/html的其他请求都会交给`error`方法处理

BasicErrorController类中包含的两个方法:`errorHtml` `error`

* `errorHtml`怎么去定制返回页面? 
  * `getEoorAttributes`获取所需要的的异常信息
  * `resolveErrorView`解析视图

> 默认情况下在`resources-static-error-400.html`中编写错误页面视图即可!

![image-20211124154944977](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241549259.png)

总结:从errorHtml方法可以得出结论:我们需要使用自定义的页面响应错误只需要在对应的路径上创建对应错误代码的页面就行了,**但是想记录日志就需要自己定制**



* `error`:是怎么返回json数据的,从而要定制自己的





2. springmvc中的`@ControllerAdvce`也可以使用



### springboot的嵌入式servlet容器

springboot 默认的servlet容器是tomcat

* 嵌入式servlet容器配置修改

  * 可以通过server.xxx来配置web服务,如果带了具体的服务器名称则是单独对该服务器进行设置

    > server.tomcat.xxxx

  * 可以通过WebServeFactoryCustomizer的Bean修改

  ![image-20211124161816552](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241618821.png)



* 注册servlet的三大组件

  * ==servlet==   ==listener==   ==filter==

    **servlet3.0提供的注解方式注册**

    > `@WebServlet` `WebListener` `WebFilter`三个注解对应上述三个组件

   1. 声明servlet及映射

      ```java
      package com.jt.servlet;
      
      @WebServlet(name = "helloServlet" , urlPatterns = "/HelloServlet")
      public class HelloServlet extends HttpServlet {
          @Override
          protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
              PrintWriter writer = resp.getWriter();
              writer.print("hello servlet!");
      
          }
      }
      
      ```

   2. 在启动类上加上注解`@servletCompinentScan`才会扫描三大组件

```java
@SpringBootApplication
@ServletComponentScan
public class SpringbootServletApplication {
    public static void main(String[] args) {
        SpringApplication.run(SpringbootServletApplication.class, args);
    }
}				
```



**springboot提供的注册**

使用`ServletRegistrationBean` `FilterRegistrationBean` `ServletListenerRegistrationBean`

```java
public class BeanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter writer = resp.getWriter();
        writer.print("hello bean servlet!");
    }
}
```

```java
package com.jt.config;

@Configuration
public class MyWebMvcConfigurer {

    @Bean
    public ServletRegistrationBean myServlet() {
        // 声明一个servlet注册器Bean
        ServletRegistrationBean<Servlet> servletServletRegistrationBean = new ServletRegistrationBean<>();
        // 注册写好的servlet
        servletServletRegistrationBean.setServlet(new BeanServlet());
        servletServletRegistrationBean.setName("BeanServlet");
        // 添加映射规则
        servletServletRegistrationBean.addUrlMappings("/BeanServlet");
        return servletServletRegistrationBean;

    }
}
```



**切换其他servlet容器**

springboot包含对嵌入式Tomcat,jetty,undertow服务器的支持

* tomcat(默认)
* jetty(socket)
* Undertow(响应式)

==要切换 ,先从pom.xml中排除==

下面是排除Tomcat 并 依赖**jetty**

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <exclusions>
        <exclusion>
            <artifactId>spring-boot-starter-tomcat</artifactId>
            <groupId>org.springframework.boot</groupId>
        </exclusion>
    </exclusions>
</dependency>
<!--切换成了jetty-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jetty</artifactId>
</dependency>
<!--切换undertow-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-undertow</artifactId>
</dependency>
```





### [?]嵌入式servlet容器自动配置原理



### 使用外部servlet容器

外部servlet容器

* 服务器安装tomcat 环境变量
* 部署：war---运维---tomcat webapp startup.sh --启动
* 开发:将开发绑定本地tomcat

内嵌servlet容器

* 部署:jar->运维->java-jar启动

  



### [?]使用外部servlet容器原理





### springboot作为单体web应用的使用

模板技术

![image-20211124170610572](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111241706833.png)



以FreeMarker为例

* 添加freemarker的依赖
* 设置freemarker的全局配置
* 添加freemarker的页面
* 对应的控制器





### Springboot 集成MyBatis

#### 整合Durid连接池

* **普通版 **

**pom.xml**

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid</artifactId>
    <version>1.2.8</version>
</dependency>
```

**application.yml**

```yml
# 数据源
spring:
  datasource:
    username: root
    password: 123123
    url: jdbc:mysql://localhost:3306/springboot_mybatis?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone = GMT
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource
```

**DruidConfiguration配置类**

```java
package com.jt.springboot_mybatis.config;
@Configuration
@ConditionalOnProperty("spring.datasource.type") // 确保配置文件中有该项配置
public class DruidConfiguration {


    // @Bean
    // // 会绑定application.yml中所有spring.datasource开头的属性绑定到Datasource
    // // @ConfigurationProperties(prefix = "spring.datasource")
    // public DataSource dataSource() {
    //     DruidDataSource dataSource = new DruidDataSource();
    //     dataSource.setUrl();
    // }

    @Bean
    // 或者直接将DataSourceProperties自动注入进来 , 后续使用创建者模式进行构建
    public DataSource dataSource(DataSourceProperties properties) {
        // 直通过配置动态构建一个DataSource
        System.out.println("正在将配置文件中的数据源进行配置!!!!");
        return properties.initializeDataSourceBuilder().build();
    }

    /**
     * 配置服务器监控器
     * <p>
     * 配置监控台
     */
    @Bean
    public ServletRegistrationBean statViewServlet() {
        ServletRegistrationBean<Servlet> servletRegistrationBean = new ServletRegistrationBean<>();
        servletRegistrationBean.setServlet(new StatViewServlet());
        servletRegistrationBean.addUrlMappings("/druid/*");
        // 添加IP白名单
        servletRegistrationBean.addInitParameter("allow" , "127.0.0.1");
        // 添加IP黑名单,黑白名单重复,优先认可黑名单
        servletRegistrationBean.addInitParameter("deny","127.0.0.1");
        // 添加控制台管理用户
        servletRegistrationBean.addInitParameter("loginUsername","admin");
        servletRegistrationBean.addInitParameter("loginPassword","123123");
        // 是否能够重置数据
        servletRegistrationBean.addInitParameter("resetEnable","false");
        return servletRegistrationBean;
    }

    // 配置过滤器
    @Bean
    public FilterRegistrationBean statFilter() {
        FilterRegistrationBean<Filter> filterRegistrationBean = new FilterRegistrationBean<>(new WebStatFilter());
        // 添加过滤规则
        filterRegistrationBean.addUrlPatterns("/*");
        // 忽略过滤格式
        filterRegistrationBean.addInitParameter("exclusions","*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
        return filterRegistrationBean;
    }
}
```



* **强力版**

**pom.xml**

```xml
<!--druid 场景启动器-->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.2.8</version>
</dependency>
```

**application.yml**

```yml
# 数据源
spring:
  datasource:
    username: root
    password: 123123
    url: jdbc:mysql://localhost:3306/springboot_mybatis?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone = GMT
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource

    # 数据源其他配置
    schema: classpath:sql/springboot.sql
    druid:
      stat-view-servlet:
        enabled: true # 启动druid控制
```





#### 整合MyBatis

1. 添加pom依赖

```xml
<!--mybatis依赖 mybatis自己提供的-->
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>2.1.4</version>
</dependency>
```

2. 添加Mybatis-generator插件

```xml
<plugin>
    <!--Mybatis-generator插件,用于自动生成Mapper和POJO-->
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-maven-plugin</artifactId>
    <version>1.4.0</version>
    <configuration>
        <!--配置文件的位置-->
        <configurationFile>src/main/resources/generatorConfig.xml</configurationFile>
        <verbose>true</verbose>
        <overwrite>true</overwrite>
    </configuration>
    <dependencies>
        <!--必须要引入数据库驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <!--必须指定版本-->
            <version>8.0.22</version>
        </dependency>
    </dependencies>
</plugin>
```

3. 配置mybatis配置文件

```xml
<!DOCTYPE generatorConfiguration PUBLIC
        "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<!--该文将请放置在项目同级目录下!!
    需要配置的地方:
    1.配置数据源
    2.pojo mapper 那些表
-->
<generatorConfiguration>

    <!--如果需要使用command的方式生成需要配置数据库驱动的jar包,需要配置classPathEntry-->
    <!--<classPathEntry location=""/>-->

    <!--context上下文 配置生成规则
        id:随意
        targetRuntime:生成策略
            MyBatis3DynamicSql:默认的 , 会生成 动态生成sql的方式(没有xml)
            MyBatis3:生成通用的查询,可以指定动态where条件
            MyBatis3Simple:最简单的只生成简单的CRUD(一般场景下推荐使用)
    -->
    <context id="simple" targetRuntime="MyBatis3Simple">


        <commentGenerator>
            <!--设置是否生成注释 true不生成 注意:如果不生成注释,代码将不会进行合并-->
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>

        <!--配置数据源-->
        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/springboot_mybatis?serverTimezone = UTC"
                        userId="root"
                        password="123123"/>

        <!--pojo
            javaModelGenerator:java实体生成规则(POJO)
            targetPackage:生成到那个包下
            targetProject:生成到当前文件的那个相对路径下
        -->
        <javaModelGenerator targetPackage="com.jt.springboot_mybatis.pojo" targetProject="src/main/java"/>

        <!--mapper xml映射文件
            sqlMapGenerator:Mapper.xml映射文件生成规则
            targetPackage:生成到那个包下
            targetProject:生成到当前文件的那个相对路径下
        -->
        <sqlMapGenerator targetPackage="com.jt.springboot_mybatis.mapper" targetProject="src/main/resources"/>

        <!--mapper接口
            type:指定生成方式
                ANNOTATEDMAPPER:注解方式
                XMLMAPPER:接口绑定方式 要配置<sqlMapGenerator
        -->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.jt.springboot_mybatis.mapper" targetProject="src/main/java"/>

        <!--配置那些表需要进行代码生成
                tableName:表名
                domainObjectName:pojo类名
                mapperName:对应mapper接口的类名 和 mapper.xml文件名

        -->
        <table tableName="emp" domainObjectName="Emp" mapperName="EmpMapper"/>
        <table tableName="dept" domainObjectName="Dept" mapperName="DeptMapper"/>
    </context>
</generatorConfiguration>

```

4. 利用maven插件生成mybatis的文件

![image-20211124204011035](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111242040334.png)



5. 全局配置文件加上mybatis配置

```yml
mybatis:
# 映射文件所在地
  mapper-locations: classpath:com/jt/springboot_mybatis/mapper/*.xml
#  如果依然想使用mybatis全局配置文件,需要使用下面这个 并且拥有mybatis-config.xml,启动器会自动配置
  config-location: classpath:mybatis-config.xml
  # 更过配置请自己去找资料学习
```



如果要设置mybatis的**stttings**

* 可以通过设置全局文件方式

* 也可以通过application.yml中配置configuration

  * configuration封装了mybatis所有信息

  ```yml
  mybatis:
    configuration: 
    	xxxx: yyyy
  ```

  



### [?]springboot启动原理

### springboot自定义starters

### 集成中间件

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!完结撒花!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

















