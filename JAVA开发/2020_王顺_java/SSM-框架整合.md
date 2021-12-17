# SSM-框架整合

### 整体目录结构:

![image-20211117100140251](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171001380.png)

### **整合ssm框架做哪些事情?**

#### springMVC

1. web.xml
   1. 前端调度器servlet
   2. 编码过滤器filter
   3. 支持rest的过滤器
2. springmvc.xml
   1. 扫描controller包
   2. 添加<annotation-driver>
   3. 视图解析器
   4. 静态资源解析
3. 添加控制器类。。。



####  Spring

1. web.xml
   1. 监听器(在启动web容器时加载<loadOnStartUp>)
2. spring.xml配置文件
   1. 扫描所有除了controller包的其他包
   2. 声明式事务



#### Mybatis

1. 需要和spring整合
   1. 将sqlSessionFactor配置为spring的bean
      1. 数据源 配置为spring的bean
      2. 配置全局配置文件
      3. 所有的mapper映射文件
   2. 将mapper接口的包交给spring
2. 加入全局配置文件





#### tomcat如果出现控制台输出乱码问题可以尝试:

![image-20211116215318216](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111162153480.png)

![image-20211116215535105](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111162155184.png)





#### springMVC配置的代码

##### pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.example</groupId>
    <artifactId>ssm</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
        <SPRING.VERSION>5.2.6.RELEASE</SPRING.VERSION>
        <ASPECTJWEAVER.VERSION>1.9.7</ASPECTJWEAVER.VERSION>
        <SPRING-ASPECTS.VERSION>5.3.9</SPRING-ASPECTS.VERSION>
        <SPRING-ORM.VERSION>5.3.12</SPRING-ORM.VERSION>
        <SPRING-WEBMVC.VERSION>5.3.10</SPRING-WEBMVC.VERSION>
        <MYBATIS-SPRING.VERSION>2.0.5</MYBATIS-SPRING.VERSION>
        <MYBATIS.VERSION>3.5.5</MYBATIS.VERSION>
        <DRUID.VERSION>1.1.21</DRUID.VERSION>
        <MYSQL-CONNECTOR-JAVA.VERSION>8.0.27</MYSQL-CONNECTOR-JAVA.VERSION>
        <JUNIT.VERSION>4.13.2</JUNIT.VERSION>
        <SLF4J-API.VERSION>1.7.32</SLF4J-API.VERSION>
        <LOGBACK-CLASSIC.VERSION>1.2.3</LOGBACK-CLASSIC.VERSION>
        <MYBATIS-GENERATOR-CORE.VERSION>1.4.0</MYBATIS-GENERATOR-CORE.VERSION>
    </properties>


    <dependencies>
        <!--springmvc依赖-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>${SPRING-WEBMVC.VERSION}</version>
        </dependency>

        <!--spring-AOP-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aop</artifactId>
            <version>${SPRING.VERSION}</version>
        </dependency>

        <!--spring-AOP-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aspects</artifactId>
            <version>${SPRING-ASPECTS.VERSION}</version>
        </dependency>

        <!--spring-AOP依赖-->
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>${ASPECTJWEAVER.VERSION}</version>
        </dependency>

        <!--spring-orm：将对象持久化到数据库中  JDBC事务需要的依赖-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-orm</artifactId>
            <version>${SPRING-ORM.VERSION}</version>
        </dependency>

        <!--spring-mybatis适配器-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>${MYBATIS-SPRING.VERSION}</version>
        </dependency>

        <!--mybatis-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>${MYBATIS.VERSION}</version>
        </dependency>

        <!--druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>${DRUID.VERSION}</version>
        </dependency>

        <!--mysql 对应版本的连接器驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>${MYSQL-CONNECTOR-JAVA.VERSION}</version>
        </dependency>

        <!--测试框架-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>${JUNIT.VERSION}</version>
            <scope>test</scope>
        </dependency>

        <!--log门面-->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>${SLF4J-API.VERSION}</version>
        </dependency>

        <!--log实现类-->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>${LOGBACK-CLASSIC.VERSION}</version>
        </dependency>

        <!--mybatis-代码生成器-->
        <dependency>
            <groupId>org.mybatis.generator</groupId>
            <artifactId>mybatis-generator-core</artifactId>
            <version>${MYBATIS-GENERATOR-CORE.VERSION}</version>
        </dependency>
    </dependencies>
</project>
```



##### web.xml

<span id="web"></span>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

<!--
    web4.0方能使用,tomcat9
    如果使用该文件:
        1.请直接配置spring-mvc.xml的路径即可,对应在<servlet>中
        2.在context-param内配置spring-core.xml路径
-->
<!--
1. 前端调度器servlet
2. 编码过滤器filter
3. 支持rest的过滤器
-->

    <!--配置web启动 加载 spring的ioc容器 和 springmvc的容器-->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    <!--全局参数的方式配置spring配置文件,去通知listener监听器-->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring-core.xml</param-value>
    </context-param>
    
    
    <!--前端调度器-->
    <servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!--设置配置文件的路径-->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:spring-mvc.xml</param-value>
        </init-param>
        <!--设置启动即加载-->
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>dispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <!--编码过滤器filter-->
    <filter>
        <filter-name>characterEncoding</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <!--设置编码格式-->
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <!--设置request和response的编码,这里是全部都设置为上述编码格式-->
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>characterEncoding</filter-name>
        <servlet-name>dispatcherServlet</servlet-name>
    </filter-mapping>


    <!--支持rest的过滤器-->
    <filter>
        <filter-name>hiddenHttpMethod</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>hiddenHttpMethod</filter-name>
        <servlet-name>dispatcherServlet</servlet-name>
    </filter-mapping>

</web-app>
```

##### springmvc.xml

(MVC自己管理的容器)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd">

<!--
    使用该文件需要注意:
        1.扫描包需要自行配置
        2.试图解析器中的文件防止位置自行配置(默认为良好配置,需要遵守约定)
-->
<!--
1. 扫描controller包
2. 添加<annotation-driver>
3. 视图解析器
4. 静态资源解析
-->
    <!--扫描controller包,只允许控制器的类-->
    <context:component-scan base-package="com.jt.controller"/>

    <!--添加annotation-driven-->
    <mvc:annotation-driven/>

    <!--视图解析器-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" id="viewResolver">
        <property name="prefix" value="/WEB_INF/views"/>
    </bean>

    <!--静态资源解析器 2 种方式-->
    <!--<mvc:resources mapping="" location=""/>-->
    <mvc:default-servlet-handler/>

</beans>
```



##### 控制器类EmpController

```java
@Controller
public class EmpController {
    @Autowired
    IEmpService empService;

    @RequestMapping("test")
    public String test() {
        List<Emp> emps = empService.selectEmp();
        System.out.println(emps);
        return "forward:/index.jsp";
    }
}
```



#### spring配置的代码

##### [web.xml](#web)

```xml
<!--添加的部分-->

<!--配置web启动 加载 spring的ioc容器 和 springmvc的容器-->
<listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<!--全局参数的方式配置spring配置文件,去通知listener监听器-->
<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:spring-core.xml</param-value>
</context-param>
```

##### spring-core.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd http://mybatis.org/schema/mybatis-spring http://mybatis.org/schema/mybatis-spring.xsd">

<!--
1. 扫描所有除了controller包的其他包
2. 声明式事务(事务是与数据库打交道的所以一定要有数据源才能配置)
-->

    <!--扫描所有除了controller包的其他包
        spring的容器和spring-mvc的容器是父子容器,需要分开管理!
    -->
    <context:component-scan base-package="com.jt">
        <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
    </context:component-scan>

    <!--引入外部属性资源文件-->
    <context:property-placeholder location="classpath:db.properties"/>

    <!--配置druid数据源-->
    <bean class="com.alibaba.druid.pool.DruidDataSource" id="dataSource">
        <property name="username" value="${mysql.username}"/>
        <property name="password" value="${mysql.password}"/>
        <property name="url" value="${mysql.url}"/>
        <property name="driverClassName" value="${mysql.driverClassName}"/>
    </bean>

    <!--声明式事务:事务管理器-->
    <bean class="org.springframework.jdbc.datasource.DataSourceTransactionManager" id="transactionManager">
        <property name="dataSource" ref="dataSource"></property>
    </bean>

    <!--基于注解方式的事务,开启事务的注解驱动,传入事务管理器-->
    <tx:annotation-driven transaction-manager="transactionManager"/>


    <!--用于声明事务切入的所有方法-->
    <aop:config>
        <aop:pointcut id="transactionCut" expression="execution(* com.jt.service.impl.*.*(..))"/>
    </aop:config>

    <!--用来明确切点匹配到的方法那些方法需要使用事务-->
    <tx:advice id="advice" transaction-manager="transactionManager">
        <tx:attributes>
            <!--可以使用通配符 必须以下面声明的名字来开头 否则不会用上事务!-->
            <tx:method name="add*"/>
            <tx:method name="update*"/>
            <tx:method name="delete*"/>
            <tx:method name="get*" read-only="true" propagation="SUPPORTS"/>
            <tx:method name="query*" read-only="true"/>
        </tx:attributes>
    </tx:advice>

    <!--配置sqlSessionFactory-->
    <bean class="org.mybatis.spring.SqlSessionFactoryBean" id="sqlSessionFactory">
        <!--指定spring中的数据源-->
        <property name="dataSource" ref="dataSource"></property>
        <property name="configLocation" value="classpath:mybatis-config.xml"/>
        <property name="mapperLocations" value="classpath:com/jt/mapper/*.xml"/>
    </bean>

    <!--将mapper接口交给spring管理-->
    <mybatis:scan base-package="com.jt.mapper"/>

</beans>
```



#### Mybatis整合进spring

##### 将sqlSessionFactor配置为spring的bean

[spring-core.xml](#spring-core.xml)

添加的地方:

```xml
    <!--配置sqlSessionFactory-->
    <bean class="org.mybatis.spring.SqlSessionFactoryBean" id="sqlSessionFactory">
        <!--指定spring中的数据源-->
        <property name="dataSource" ref="dataSource"></property>
        <property name="configLocation" value="classpath:mybatis-config.xml"/>
        <property name="mapperLocations" value="classpath:com/jt/mapper/*.xml"/>
    </bean>

    <!--将mapper接口交给spring管理-->
    <mybatis:scan base-package="com.jt.mapper"/>
```

##### 加入全局配置文件

==由于是与交给spring进行管理,所有配置文件mybatis-config.xml文件省略了已经在spring-core.xml中声明过配置==

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>


    <settings>
        <!--开启延迟加载,默认是立即加载-->
        <!--<setting name="lazyLoadingEnabled" value="true"/>-->
        <!--&lt;!&ndash;开启后,使用pojo中任意属性都会启用立即加载延迟查询(贪心),默认是false&ndash;&gt;-->
        <!--<setting name="aggressiveLazyLoading" value="true"/>-->
        <!--&lt;!&ndash;设置对象的那些方法调用会立即加载延迟查询 默认equals,clone,hashCode,toStrin&ndash;&gt;-->
        <!--<setting name="lazyLoadTriggerMethods" value="hashCode"/>-->
        <!--将数据库下划线列名转换为java小驼峰风格-->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
        <!--开启二级缓存,默认为true,在声明一次为了可读性-->
        <setting name="cacheEnabled" value="true"/>
    </settings>

    <!--类型别名可为java类型设置一个缩写名字 它仅用于xml配置,意在降低冗余的全限定类名书写-->
    <typeAliases>
        <!--根据包设置包里面所有的类的别名:会将类的名字作为别名(忽略大小写)
            还可以为包里面的类设置个性别名,@Alias("") (默认的以类的名字作为别名就会失效)
            设置之后 resultType就可以使用简写
        -->
        <package name="com.jt.pojo"/>
    </typeAliases>


</configuration>
```

