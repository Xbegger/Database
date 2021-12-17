Spring5系列教程

### 第一章 spring初识

#### 1.framework（框架）

> 框架就是一些类和接口的集合，通过这些类和接口协调来完成一系列的程序实现。
>
> **或者：开发的半成品**
>
> 作用：使用框架来快速的开发成品解决问题！==简化开发，提高效率==

#### 2.架构发展历史

![image-20211013213730327](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110132137437.png)



* 单一应用架构

  > 网站流量跟小，只需一个应用，此时用于简化增删改查工作量的数据访问框架（ORM）是关键
  >
  > <img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/202110132154352.png" alt="image-20211013215426251" style="zoom: 67%;" />

* 垂直应用架构

  > 将应用拆分为互不相干的几个应用，以提升效率（MVC）
  >
  > <img src="C:/Users/00/AppData/Roaming/Typora/typora-user-images/image-20211013215500856.png" alt="image-20211013215500856" style="zoom:67%;" />
  >
  > **SSH：Struts1/Struts2 + Spring + Hibernate**
  >
  > **SSM:  SpringMVC + Mybatis + Spring**
  >
  > ssm框架基本结构：<span id="ssm架构"></span>
  >
  > ![image-20211017101503963](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171015034.png)
  >
  > ![](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171015581.png)
  >
  > 

* 分布式服务架构

  > 将核心业务抽取出来，作为独立的服务，逐渐形成稳定的服务中心（RPC）

* 面向服务架构

  > 面向服务，需要增加一个调度中心基于访问压力实时管理集群容量，提高集群利用率。（SOA）



#### 3.Spring介绍

Spring Framework 是一个**轻量级java开发框架** ，**是模块化的**，**是非侵入性的（轻量级，侵入性：重量级）**

解决开发中的业务层和其它层之间的**耦合问题**。**最根本的使命是解决企业级应用开发的复杂性，简化java开发。**

* IOC：控制反转
* AOP：面向切面编程
* 容器：包含并管理应用对象的生命周期

 <img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/202110132216335.png" alt="image-20211013221607198" style="zoom:150%;" />



#### 3.Ioc：控制反转 

是一种==设计思想==，在java开发中，将设计好的对象交给容器控制，而不是显示的用代码进行对象的创建。

对象由spring**创建、管理、装配**

传统：**任何变更都会加大系统BUG的可能性**

> 
> ioc被初始化后 默认实例化所有的bean

DI :依赖注入(是一种实现)



**面向对象五大原则**

> * 单一职责：==只做一件事==，低耦合高内聚的延申
> * 开放封闭：在设计一个类或者模块时，应该对==扩展开放==，对==修改关闭==
> * 里氏替换：对==继承==进行了==规则上的约束==
> * 依赖倒置：1.==具体实现依赖抽象==  2.==下层依赖上层==
> * 接口分离：接口端不应该依赖它==不需要的接口==，一个类对另一个类的依赖应该==建立在最小的接口==上。

![image-20211014220846266](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110142208356.png)

#### 4.ioc代码实现方式

* 导入jar包-配置xml（菜鸡）

> 1. 导入jar
>
> ![image-20211014222550438](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110142225530.png)
>
> 2. 配置xml

spring Application ContextApplication Context 是 BeanFactory 的子接口，也被称为 Spring 上下文。它可以加载配置文件中定义的 bean，将所有的 bean 集中在一起，当有请求的时候分配 bean。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean class="org.example.dap.impl.UserDaoMysqlImpl" id="userDaoMysql"/>
    <bean class="org.example.service.impl.UserServiceImpl" id="userService">
        <property name="dao" ref="userDaoMysql"></property>
    </bean>

</beans>
```

```java
public class MyTest {
    public static void main(String[] args) {
        // 加载spring，加载ioc容器 ApplicationContext是Spring IoC容器实现的代表，
        //负责实例化，配置和组装Bean
        // 容器实例化后就已经加载了所有的Bean
        // 可以配置多个xml的Bean在参数中
        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring.xml");
		//spring.xml文件放置在xxx/resources/spring.xml
        //获取Bean的方式：
        // 1.通过类来获取Bean，				getBean（User.class）
        // 2.通过bean的名字或者id来获取Bean 	   getBean（“User”）
        // 3.通过名字+类型 					getBean（“user”，User.class）
        IUserService service = ioc.getBean(IUserService.class);
        service.getUser();
    }
}
```

> ApplicationContext是Spring的顶层核心接口，有很多的实现类，常用的：
>
> * ClassPathXMLApplicationContext 根据==项目路径的xml==配置来实例化spring容器
> * FileSystemXMLApplicationContext 根据==磁盘路径的xml==配置来实例化spring容器
> * AnnotationConfigApplicationContext 根据==javaconfig==，纯注解的方式



xml头文件 解析：

> * 问题的出现：
>
>  XML的元素名字是不固定的，当两个不同的文档使用同样的名称描述两个不同类型的元素的时候，或者一个同样的标记表示两个不同含义的内容的时候，就会发生命名冲突。
>
> * 解决方法：命名空间，给他一个独一无二的标志
> * 语法：
>
>  xmlns:[prefix]=”[url of name]”
>
> 其中“xmlns:”是必须的属性（xmlnamespace）。“prefix”是命名空间的别名，它的值不能为xml。
>
> 例如：xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
>
> * 解析xml头文件：
>
>   * `xmlns="http://www.springframework.org/schema/beans"`
>
>     声明xml文件默认的命名空间，表示未使用其他命名空间的所有标签的默认命名空间。
>
>   * ` xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"`
>
>     声明XMLSchema 实例名称空间，并将xsi前缀与该名称空间绑定，这样模式处理器就可以识别xsi:schemaLocation属性。XML Schema实例名称空间的前缀通常使用xsi。
>
>   * `xsi:schemaLocation="http://www.springframework.org/schema/beans `
>
>     模式位置http://www.springframework.org/schema/beans/spring-beans-3.0.xsd相关。
>
>   * `xmlns:context="http://www.springframework.org/schema/context"`
>
>     添加注解后多出来的一个，是添加了context的命名空间



* maven+注解+xml（正常）

> * 需要导入jar，配置maven依赖
> * pom.xml配置
>



* springboot+javaconfig（大神）



#### 总结

**DI与IOC**

IOC与DI是从==不同的角度来描述的同一件事情==，IOC是从==容器==的角度来描述，DI是从应用程序的角度来描述。

区分理解：IOC是依赖倒置原则的==设计思想==，DI是具体的==实现方式==

**把IOC理解为粘合剂**

![image-20211015104526370](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110151045489.png)





### 第二章 Maven下的spring

#### 1.Maven及其结构

Maven就是是专门为Java项目打造的管理和构建工具，它的主要功能有：

- 提供了一套标准化的项目结构；
- 提供了一套标准化的构建流程（编译，测试，打包，发布……）；
- 提供了一套依赖管理机制。



scope：

![image-20211019215908340](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110192159424.png)

**compile** ：为**默认的**依赖有效范围。如果在定义依赖关系的时候，没有明确指定依赖有效范围的话，则默认采用该依赖有效范围。

此种依赖，在编译、运行、测试时均有效。

**provided** ：在编译、测试时有效，但是在运行时无效。

provided意味着打包的时候可以不用包进去，别的设施(Web Container)会提供。

事实上该依赖理论上可以参与编译，测试，运行等周期。相当于compile，但是在打包阶段做了exclude的动作。

例如：servlet-api，运行项目时，容器已经提供，就不需要Maven重复地引入一遍了。

**runtime** ：在运行、测试时有效，但是在编译代码时无效。

说实话在终端的项目（非开源，企业内部系统）中，和compile区别不是很大。比较常见的如JSR×××的实现，对应的API jar是compile的，具体实现是runtime的，compile只需要知道接口就足够了。

例如：JDBC驱动实现，项目代码编译只需要JDK提供的JDBC接口，只有在测试或运行项目时才需要实现上述接口的具体JDBC驱动。

另外runntime的依赖通常和optional搭配使用，optional为true。我可以用A实现，也可以用B实现。

**test** ：只在测试时有效，包括测试代码的编译，执行。例如：JUnit。

==PS: test表示只能在src下的test文件夹下面才可以使用，你如果在a项目中引入了这个依赖，在b项目引入了a项目作为依赖，在b项目中这个注解不会生效，因为scope为test时无法传递依赖。==

**system** ：在编译、测试时有效，但是在**运行时无效**。

和provided的区别是，使用system范围的依赖时必须通过**systemPath元素显式地指定依赖文件的路径**。由于此类依赖**不是通过Maven仓库解析的，而且往往与本机系统绑定**，可能造成构建的不可移植，因此应该谨慎使用。



==一个使用Maven管理的普通的Java项目，它的目录结构默认如下：==

```ascii
a-maven-project
├── pom.xml
├── src					源码
│   ├── main			主程序
│   │   ├── java		存放java源文件
│   │   └── resources	存放框架或其他工具的配置文件
│   └── test			存放测试程序
│       ├── java		存放java测试的源文件
│       └── resources	存放测试的配置文件
└── target				Maven工程的核心配置文件
```

项目描述文件：pom.xml

```xml
<project ...>
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.itranswarp.learnjava</groupId>
	<artifactId>hello</artifactId>
	<version>1.0</version>
	<packaging>jar</packaging>
	<properties>
        ...
	</properties>
	<dependencies>
        <dependency>
            <groupId>commons-logging</groupId>
            <artifactId>commons-logging</artifactId>
            <version>1.2</version>
        </dependency>
	</dependencies>
</project>
```

其中，`groupId`类似于Java的包名，通常是公司或组织名称，`artifactId`类似于Java的类名，通常是项目名称，再加上`version`，一个Maven工程就是由`groupId`，`artifactId`和`version`作为唯一标识。我们在引用其他第三方库的时候，也是通过这3个变量（==坐标==）确定。例如，依赖`commons-logging`

```xml
<dependency>
    <groupId>commons-logging</groupId>
    <artifactId>commons-logging</artifactId>
    <version>1.2</version>
</dependency>
```

使用`<dependency>`声明一个依赖后，Maven就会自动下载这个依赖包并把它放到classpath中。



#### 2.Maven仓库分类



* **本地仓库**：==Maven 在根据坐标查找依赖的构件时，先是在本地仓库中查找==。默认情况下，不管是 Windows 操作系统还是 Linux 操作系统，每个用户在自己的用户目录下都有一个路径名为 .m2/repository/ 的目录，这个目录就是 Maven 的本地仓库目录。
* **私有仓库**：私服是一个==特殊的远程仓库，架设在局域网内==。
* **中央仓库**：由于最原始的本地仓库是空的，Maven 必须知道至少一个远程仓库才能执行 Maven 的命令。这个远程仓库是默认的，这里把它叫作中央仓库。也就是说，==中央仓库就是一个默认的远程仓库。==
* **远程仓库**：安装好 Maven 后，如果不执行任何 Maven 命令的话，本地仓库目录是不存在的。当用户输入第 1 条 Maven 命令后，Maven 才会创建本地仓库。然后根据配置和需要从远程仓库下载对应的构件到本地仓库，以备需要的时候使用。



#### 3.Maven常用命令

![image-20211015140849894](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110151408842.png)

``` xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.13.1</version>
    <scope>test</scope>     		//默认是compile，此处是作用域
</dependency>
```

#### 4.xml标签解释

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">


    <!--使用name也可以设置别名，分隔符为 ， ： 空格-->
    <bean class="com.jt.beans.User" id="user" name="user2,user3">
        <description>用来描述一个Bean的用途</description>
    </bean>

    <!--在一个xml文件中导入另外一个spring的xml文件-->
    <import resource="spring-ioc.xml"/>

    <!--用于给bean取别名的-->
    <alias name="user" alias="bieming"/>
</beans>
```



#### 5.依赖注入

注入Bean当中的属性

* 基于setter方法的依赖注入

```xml
    <!--基于setter方法的依赖注入-->
    <bean class="com.jt.beans.User" id="user6">
        <!--基于setter方法的依赖注入，对应的是set方法后面的名字-->
        <!--比如setId  -> name = “id”    setXXX  -> name=“XXX”-->
        <property name="id" value="1"/>
        <property name="username" value="youwei"/>
        <property name="realname" value="WUWEI"/>
    </bean>
```

```java
// 例如这个方法是setId，name在.xml中的bean的属性name就可以是name="id"
public void setId(Integer id) {
        this.id = id;
    }
```



* 基于构造函数的依赖注入

```xml
    <!--基于构造函数的依赖注入
        1.基于name属性设置构造函数参数
        2.可以只有value属性
        3.如果省略name属性，一定要注意参数顺序
        4.如果参数顺序错乱，
            可以使用name（推荐），
            也可以使用index:设置下标，从0开始
            还可以使用type：在错乱的参数类型一致的情况下不能使用
    -->
    <bean class="com.jt.beans.User" id="user7">
        <constructor-arg index="0" value="1"/>
        <constructor-arg name="username" value="wuwei"/>
        <constructor-arg value="youwei"/>
    </bean>
```



#### 6.依赖和配置的细节

* 直接值（基本类型，string等）
* 对其他bean的引用（装配）
* 内部Bean
* 集合
* null和空的字符串值
* 使用p命名空间简化基于setter属性注入xml配置
* 使用c命名空间简化基于构造函数的xml

```xml
    <!--复杂数据的依赖注入-->
	<!--不指定id是不能按名字寻找的！-->
    <bean class="com.jt.beans.Person" id="person">
        <property name="id" value="1"/>
        <!--设置null-->
        <property name="name">
            <null></null>
        </property>
        <!--设置空值-->
        <property name="gender" value=""/>
        <!--引用外部bean（常用）-->
        <!--<property name="wife" ref="wife"/>-->

        <!--使用内部Bean（不希望别人复用时使用）来依赖注入其他bean-->
        <property name="wife">
            <bean class="com.jt.beans.Wife">
                <property name="age" value="18"/>
                <property name="name" value="迪丽热巴内"/>
            </bean>
        </property>

        <!--配置list：
            如果泛型是基本数据类型 使用<value>
            如果泛型是bean       使用<bean>
        -->
        <property name="hobbies">
            <list>
                <value>唱歌</value>
                <value>跳舞</value>
            </list>
        </property>

        <!--针对map的注入：
            如果map的value是基本数据类型 使用<entry value>
            如果map的value是bean        使用<entry value-ref>
        -->
        <property name="course">
            <map>
                <entry key="1" value="Java"></entry>
                <entry key="2" value="数据库"></entry>
                 <!--<entry key="3" value-ref="wife"></entry>-->
            </map>
        </property>

    </bean>

	<!--外部引用的bean-->
    <bean class="com.jt.beans.Wife" id="wife">
        <property name="name" value="迪丽热巴"/>
        <property name="age" value="18"/>
    </bean>
```

##### P命名空间的使用

```xml
    xmlns:p="http://www.springframework.org/schema/p"

	<!--使用p命名空间简化基于setter属性注入xml配置
        p:IDEA自动添加p命名空间
        设置基本数据类型，或者p:wife-ref 引用外部bean
        如果有集合类型，就不支持，需要额外配置<property>
        支持混用
    -->
    <!--Spring 默认调用无参的构造函数 类中如果只定义了有参构造函数，那么默认的无参构造函数会失效
        导致Spring中的xml文件报错，为了解决这个问题，直需要在类中在添加一个无参的构造函数。
    -->
    <bean class="com.jt.beans.Wife" id="wife" p:age="18" p:name="迪丽热巴"/>
    <bean class="com.jt.beans.Person" id="person2" p:wife-ref="wife">
        <property name="hobbies">
            <list>
                <value>1</value>
                <value>2</value>
            </list>
        </property>
    </bean>

```

##### C命名空间的使用

```xml
    xmlns:c="http://www.springframework.org/schema/c"

	<!--c命名空间简化基于构造函数的xml
        原先需要使用<constructor-arg> 标签，
        现在只需要在bean中使用c:属性来指定参数值，
        如果有集合类型，就不支持
    -->
    <bean class="com.jt.beans.Wife" id="wife2" c:age="20" c:name="林青霞"></bean>
```



#### 7.spring的xml配置高级使用

##### depends-on

> spring中xml的加载顺序是按序加载，即从上至下的顺序加载
>
> 如果需要先加载后面的bean，则需要：depends-on

```xml
    <!--控制加载顺序，需要另一个bean在当前bean之前加载需要设置depends-on
        可以使用“，”来提供多个depends-on
		没有depends-on情况下xml文件会被先加载User后加载Wife
		下面的xml文件在加载时会先加载Wife后加载User
    -->
    <bean class="com.jt.beans.User" id="user" depends-on="wife"></bean>
    <bean class="com.jt.beans.Wife" id="wife"></bean>
```

##### **懒加载**

```xml
    <!--懒加载
        就不会再spring容器加载的时候 加载该bean
        而是在使用的时候加载bean
    -->
    <bean class="com.jt.beans.Wife" id="wife" lazy-init="true"></bean>
```

##### **bean的作用域**

* Singleton 单例 作用域 - 默认
* Prototype 原型 作用域
* request 、 session 、application 、websocket 

```xml
    <!--作用域
        singleton 默认值 同一个id始终只会创建一次bean （存在线程安全的问题）
        prototype 多例（原型） 每一次使用都会创建一个bean
        ************************************************************
        request 、 session 、application 、websocket 等都是在web中使用的作用域
    -->
    <bean class="com.jt.beans.Person" id="person" scope="prototype"/>
```

##### 实例化Bean的几种方法

* 使用构造器实例化 ==默认== 无法干预实例化进程

  根据类中的信息，调用默认的无参构造函数，如果设置了<constractor-arg>标签则会调用有参构造函数

  此过程无法被干预！



* 使用静态工厂方法实例化

  ```xml
  <!--使用静态工厂来实例化Bean
          不需要额外的指定一个factory-bean
          只需要指定bean中的静态方法即可
      -->
  <bean class="com.jt.beans.Person" id="person" factory-method="createPersonFactory"/>
  
  ```

  ```java
  //com.jt.beans.Person 类中的静态工厂方法
  ...
  public static Person createPersonFactory() {
      Child child = new Child();
      child.setName("儿子");
      return child;
  }
  ...
  ```

  

* 使用实例工厂方法实例化

  ```xml
  <!--实例工厂来实例化bean
          需要指定一个factory-bean
          需要指定factory-bean中的工厂方法
      -->
  <bean class="com.jt.beans.PersonFactory" id="factory"></bean>
  <bean class="com.jt.beans.Person" id="person" factory-bean="factory" factory-method="createPersonFactoryMethod"/>
  
  ```

  ```java
  // 新建的类PersonFactory 作为factory-bean来使用 ，
  // createPersonFactoryMethod是该类中的实例工厂方法！
  public class PersonFactory {
      public Person createPersonFactoryMethod() {
          Child child = new Child();
          child.setName("儿子");
          return child;
      }
  }
  ```



##### 自动注入

```xml
    <!--自动注入
        不需要使用set函数来注入，也不需要使用构造函数来注入
        autowire="byType" : 根据类型自动匹配 当出现多个或没有 则报错
        autowire="byName" : 根据setXXX方法的XXX名字来匹配，此处为setWife->id=“wife”
        autowire="constructor": 根据构造器来匹配
                优先根据名字匹配，参数名字没有匹配到，会根据参数类型匹配（byType）
                会根据构造函数的参数进行完整的匹配注入：如果构造函数的参数是：Person（Wife 		 				 wife3,User user）
                ioc容器里面必须同时有Wife bean和User bean
                名字没有匹配到会根据类型匹配 类型出现多个会注入失败会选择其他参数的构造器，都没有则报					错
    -->
    <bean class="com.jt.beans.Person" id="person" autowire="constructor"/>

    <!--当根据类型匹配到多个时
        1.使用primary=true设置某个bean为主要自动注入bean
        2.设置不需要自动注入的bean ：autowire-candidate="false" 忽略自动注入
    -->
    <bean class="com.jt.beans.Wife" id="wife" primary="true">
        <property name="name" value="迪丽热巴"/>
    </bean>
    <bean class="com.jt.beans.Wife" id="wife2">
        <property name="name" value="迪丽热巴2"/>
    </bean>
```



##### 生命周期回调

![image-20211016211828933](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110162118072.png)



* 初始化方法回调

* 销毁方法回调

* 在非Web应用中优雅地关闭Spring IoC容器

> 如果接口和配置同时存在的化，则==先调用接口的回调，后调用配置的回调==！

```java
    /**
     *   回调测试
     *  1.使用接口的方式实现
     *      1.初始化回调，实现InitializingBean，重写afterPropertiesSet
     *      2.销毁回调    实现DisposableBean ，重写destroy
     *  2.基于配置方式
     */

class Person implements InitializingBean , DisposableBean{
    
    .........
        
    // 实例化 接口方式 
    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("实例化Person1");
    }

    // 销毁 接口方式
    @Override
    public void destroy() throws Exception {
        System.out.println("销毁Person1");
    }
	/*********************************************************************************/

    // 实例化 配置方式
    public void initByConfig() throws Exception {
        System.out.println("实例化Person2");
    }

    // 销毁 配置方式
    public void destroyByConfig() throws Exception {
        System.out.println("销毁Person2");
    }
}
```



##### Spring创建第三方Bean对象

日常开发中经常需要外部单实例对象（类似于普通Bean的实现方式），例如数据库连接池：

1. 导入数据库连接池的pom文件
2. 编写配置文件

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid</artifactId>
    <version>1.1.21</version>
</dependency>

<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.47</version>
</dependency>
```

```xml
    <!--配置第三方Bean-->
    <bean class="com.alibaba.druid.pool.DruidDataSource" id="dataSource">
        <!--如果需要用到属性文件中的值需要${xxxx}-->
        <property name="username" value="${mysql.username}"/>
        <property name="password" value="${mysql.password}"/>
        <property name="url" value="jdbc:mysql://localhost:3306/demo"/>
        <property name="driverClassName" value="com.mysql.jdbc.Driver"/>
    </bean>

    <!--配置第三方Bean 引入外部属性文件-->
    <context:property-placeholder location="db.properties"></context:property-placeholder>

```

```java
// db.properties 文件
mysql.username=root
mysql.password=123456
mysql.url=jdbc:mysql://localhost:3306/test
mysql.driverClassName=com.mysql.jdbc.Driver
```



##### SpEL的使用

（用途不多）了解即可

> SpEL：Spring Expressing Language ,spring的表达式语言，支持运行时查询操作对象
>
> 使用#{...}作为语法规则，大括号中的字符都认为是SpEL；

```xml
    <bean class="com.jt.beans.Person" id="person">
        <!--运算表达式-->
        <property name="id" value="#{1+2}"/>
        <!--引用外部Bean-->
        <property name="wife" value="#{wife}"/>
        <!--调用bean的属性-->
        <property name="name" value="#{wife.name}"/>
        <!--调用bean的方法-->
        <property name="gender" value="#{wife.getName()}"/>
        <!--调用静态属性-->
        <property name="birthday" value="#{T(com.jt.beans.PersonFactory).getNowDate()}"/>
    </bean>

    <bean class="com.jt.beans.Wife" id="wife">
        <property name="name" value="迪丽热巴"/>
    </bean>
```

##### 补充：pom

```xml
<!--ioc 注解-->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>

<!--切面-->
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.9.7</version>
</dependency>

<!--切面-->        
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aspects</artifactId>
    <version>5.3.9</version>
</dependency>

```



### 第三章 Spring IoC注解使用

#### 注解+Xml

在引入context的命名空间时 需要注意：

1. 引入xmlns:context="http://www.springframework.org/schema/context"

2. 在xsi:schemaLocation 加入

   http://www.springframework.org/schema/context
   http://www.springframework.org/schema/context/spring-context-4.2.xsd

```xml
<!--
    该xmlns包含的命名空间：
    p 命名空间
    c 命名空间
    context 命名空间
	aop 命名空间
	如果需要引入命名空间，最快的方法是在idea中打出需要的属性：打出cmponent-scan，会自动引入			--context命名空间
-->
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:c="http://www.springframework.org/schema/c"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context-4.2.xsd">
```



```xml
    <!--
    注解：
        @Controller   标记在控制层的类注册为Bean的组件
        @Service      标记在业务逻辑层的类注册为Bean的组件
        @Repository   标记在数据访问层的类注册为Bean的组件
        @Component    标记非三层的普通的类注册为Bean的组件（是其他注解的元注解）
        不是需要每个层对应相应注解，使用对应层的注解的目的在于:
            1.增强可读性
            2.更利于Spring的管理（分类操作）
        怎样使用注解来注册一个类为Bean步骤：
            1.设置扫描包context:component-scan
            2.在对应的类名上加上对应的注解
		使用上面的注解会自动将类名首字母小写作为Bean的名字

    扫描：
        base-package 设置需要扫描的包
            排除扫描<context:exclude-filter：设置需要排除扫描的选项
            包含扫描<context:include-filter：设置需要包含扫描的选项
                type：
                    常用
                    1.annotation：默认 根据注解的完整限定名设置排除|包含
                    2.assignable：    根据类的完整限定名设置排除|包含
                    不常用：
                    3.aspectj：       根据切面表达式设置排除|包含
                    4.regex：         根据正则表达式设置排除|包含
                    5.custom：        根据TypeFilter接口的自定义实现设置排除|包含
                    
         use-default-filters 默认为true，会默认扫描@Controller
                                                @Service
                                                @Repository
                                                @Component
    -->
    <context:component-scan base-package="com.jt" use-default-filters="false">
        <!--排除扫描controller注解，expression中的值是完整注解名-->
        <!--<context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>-->

        <context:include-filter type="assignable" expression="com.jt.controller.UserController"/>
    </context:component-scan>
```

```java
    @Test
    public void test01() {
        AbstractApplicationContext ioc =
                new ClassPathXmlApplicationContext("spring_ioc.xml");
        // "userController" 来自于类名首字母小写作为Bean的名字
        // xml配置spring时 "userController" 来自于xml中配置的id 或 alias（别名）
        UserController bean =
                ioc.getBean( "userController",UserController.class);
        System.out.println(bean);
    }
```



[文件架构](#ssm架构)

![image-20211017110605905](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171106989.png)

![image-20211017110621201](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171106253.png)

![image-20211017110637177](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171106237.png)

![image-20211017110646564](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110171106614.png)



#### 自动注入

```java
@Controller
public class UserController {
    /*
     *	 @AutoWired 可以作用于:构造器、方法、参数、属性
     *   使用@Autowired（也可以使用@Resource）来实现自动注入
     *   byType 、 byName？
     *   1.默认优先根据类型去匹配！（如果是接口，这里会去找接口的实现类作为类型）
     *   2.如果匹配到多个类型则会按照名字取匹配
     *   3.如果名子没有匹配到 就报错
     *      解决：1.修改属性的名字对应bean的名字：userServiceImpl
     *           2.修改bean的名字来对应属性的名字：@Service("userService")
     *           3.通过@Qualifier设置属性的名字
     *           4.通过@Primary设置其中一个bean为主要的自动注入Bean
     *           5.使用泛型作为自动注入限定符！(不常用！)
     * */

     /**
     * @Resource 和 @Autowired 的区别
     * @Resource依赖jdk、 @Autowired依赖spring
     * @Resource 优先根据名字匹配
     * @Autowired 优先根据类型匹配
     */
    
    @Autowired // 会自动装填实现类
    @Qualifier("userServiceImpl") 
    // 这是个接口
    UserService userService;

    public void getUser() {
        userService.getUser();
    }
}

```

![image-20211017220837226](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110172208323.png)

![image-20211017221027544](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110172210620.png)

![image-20211017221133262](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110172211344.png)



![image-20211017222923136](https://gitee.com/ICDM_ws/pic-bed/raw/master/202110172229222.png)



### 第四章 Spring javaConfig使用

JavaConfig原来是Spring项目的一个子项目，它通过Java类的方式提供Bean的定义信息，在Spring3的版本，JavaConfig已正式成为Spring4的核心功能。

#### 基本概念

重点：**==@Bean 和 @Configuration==**

**将一个类注入到IoC中几种方法：**

* xml：<Bean>
* @Component（@Controller，@Service，@Repository）
* @Bean
* @import



```java
package com.jt;

import com.alibaba.druid.pool.DruidDataSource;
import com.jt.beans.MyImportSelector;
import com.jt.beans.Role;
import com.jt.beans.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;

/**
 * @author HDU_WS
 * @Classname IoCJavaConfig
 * @Description TODO
 * @Date 2021/10/18 19:34
 * @Created by TheKing_Shun
 */

// 用于标记一个spring的配置类，之前是根据xml来启动spring上下文，
// 现在根据类来启动，相当于xml文件 <beans></beans>
@Configuration
// 相当于xml文件中的component-scan 用于扫描
// 并且basePackage可以默认不写！
@ComponentScan(basePackages = "com.jt")
//获取外部属性资源文件名
@PropertySource("classpath:db.properties")
  
/*
*  1.引入其他配置类，可以多个{“xxx”,"yyy"}
   2.将类注册为Bean  如果Role没有@Component注解注册为bean，可以Import
*  3.导入ImportSelector实现类，可以注册多个类
* */
// @Import(SecondJavaConfig.class)
// @Import(Role.class)
@Import(MyImportSelector.class)
public class IoCJavaConfig {

    // 将外部属性获取到字段中
    @Value("${mysql.username}")
    private String name;
    @Value("${mysql.password}")
    private String password;
    @Value("${mysql.url}")
    private String url;
    @Value("${mysql.driverClassName}")
    private String driverClassName;

    /**
     * 配置第三方Bean (返回值为xml 中 bean的 class（类型），方法名为 bean的名字)
     * 自己的Bean也可以 只是替换掉原先的bean
     *
     * @Bean（name={"ss"，“dd”}） 设置bean的id，可以只设置一个
     * 可以将一个类的实例（可以干预Bean实例化过程）注册为一个bean
     * @Bean(initMethod="",destroyMethod="") 等价于：
     * <bean class="xx" id="xx" init-method="xxx" destroy-method="xxx"/>
     *
     * 如何自动装配外部bean :在方法里面协商需要需要的参数
     * 如何自动装配内部bean（在同一个配置类中的bean） :直接调用方法即可！
     */
    @Bean(initMethod = "", destroyMethod = "")
    public DruidDataSource dataSource(Role role) {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setName(name);
        dataSource.setPassword(password);
        dataSource.setUrl(url);
        dataSource.setDriverClassName(driverClassName);
        // 自动装配外部bean
        System.out.println(role);
        // 自动装配内部bean
        System.out.println(user3());
        return dataSource;
    }

    @Bean
    public User user3() {
        return new User();
    }
}

```

```java
@ComponentScan
public class SecondJavaConfig {
    @Bean
    public User user2() {
        return new User();
    }
}

```



### 第五章 Spring AOP介绍

**面向切面编程**

基于oop基础之上的新的编程思想，oop面向的是类，Aop面向的切面，在处理日志、安全管理、

事务管理很重要。

> 不修改原有代码的情况下，增强跟主要业务没有关系的 公共功能代码 到之前写好的方法中的指定位置

AOP的底层是==代理==

#### 静态代理

* **静态代理**

  需要为**每一个被代理**的类创建一个“代理类”，成本太高！

  ![image-20211021213528365](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110212135449.png)

```java
public interface IGamePlayer {

    void start();

    void play();
}

```

```java
public class GamePlayer implements IGamePlayer {
    private String name = "";

    public GamePlayer(String name) {
        this.name = name;
    }

    @Override
    public void start() {
        System.out.println("登录游戏");
        System.out.println(name + "开始游戏");
        this.name = name;
    }

    @Override
    public void play() {
        System.out.println(name + "被玩家击毙！");
    }
}
```

```java
// 这个就是所谓的代理类！
public class GameProxyPlayer implements IGamePlayer {

    private String name;
    private GamePlayer gamePlayer;

    public GameProxyPlayer(String name) {
        this.name = name;
        this.gamePlayer = new GamePlayer(name);
    }

    @Override
    public void start() {
        System.out.println("拿到"+name+"用户名 密码");
        gamePlayer.start();
    }

    @Override
    public void play() {
        System.out.println("代练击毙敌军，赢得游戏！");
    }
}
```

```java
public class MainTest {

    @Test
    public void test() {
        IGamePlayer gamePlayer = new GameProxyPlayer("youwei");
        gamePlayer.start();
        gamePlayer.play();
    }
}
```





* **动态代理**（Spring AOP底层使用动态,将jdk代理和cglib代理集成，使得给用户更简单的方式实现代理）
  * jdk动态代理 ：**必须保证被代理的类实现了接口才能被代理**
  * cglib动态代理：不需要接口

#### 动态代理

jdk步骤：

1. 获取类加载器、类型、处理类
2. 在处理类中编写业务逻辑
3. 动态创建代理类，将**1.**作为参数传入到代理类中

![image-20211021213957402](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110212139474.png)



```java
public interface ICalculator {
    Integer add(Integer i, Integer j);

    Integer sub(Integer i, Integer j);

    Integer mul(Integer i, Integer j);

    Integer div(Integer i, Integer j);
}

```

```java
public class Calculator implements ICalculator{
    @Override
    public Integer add(Integer i, Integer j) {
        Integer result = i + j;
        return result;
    }

    @Override
    public Integer sub(Integer i, Integer j) {
        Integer result = i - j;
        return result;
    }

    @Override
    public Integer mul(Integer i, Integer j) {
        Integer result = i * j;
        return result;
    }

    @Override
    public Integer div(Integer i, Integer j) {
        Integer result = i / j;
        return result;
    }
}
```

```java
public class MyInvocationHandler implements InvocationHandler {

    // 被代理对象
    Object target;

    public MyInvocationHandler(Object target) {
        // 处理函数获取一个被代理对象赋值给target
        this.target = target;
    }

    /*
     *  被代理类的所有方法都会经过这个invoke方法！
     */

    // 代理类的执行方法
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

        if (args == null || args.length == 0) {

            System.out.println("日志：调用add方法，无参数");
        } else {
            System.out.println("日志：调用add方法，参数是：" + Arrays.asList(args));
        }


        // 执行被代理的方法
        /*
         * Object obj,       被代理的对象
         * Object... args    被代理的方法参数，直接将args传入
         *
         * */
        // 调用真正方法的地方！
        Object result = method.invoke(target, args);

        System.out.println("日志：" + result);

        return result;
    }
}
```

```java
// jdk 动态代理完成增加日志的功能
public class MainTest {
    @Test
    public void test() {

        // 用对应的接口来接受
        IGamePlayer proxy = (IGamePlayer)MainTest.createProxy(new GamePlayer("wuwei"));
        proxy.play();

    }
    /**
     *  公共jdk动态代理对象生成
     * @return
     */

    public static Object createProxy(Object needProxy) {
        /**
         * ClassLoader loader       类加载器,通常指定的被代理类的接口的类加载器
         * Class<?>[] interfaces,   类型，通常指定的被代理类的接口的类型
         * InvocationHandler h      委托执行的处理类：例如日志功能
         */

        ClassLoader classLoader = needProxy.getClass().getClassLoader();
        Class<?>[] interfaces = needProxy.getClass().getInterfaces();
        //传入被代理的对象
        InvocationHandler handler = new MyInvocationHandler(needProxy);

        // 动态创建代理类(反射包中)
        Object o = Proxy.newProxyInstance(classLoader, interfaces, handler);
        //cmd: class com.sun.proxy.$Proxy4
        // 带$ 就是jdk动态代理类！！！！
        System.out.println(o.getClass());

        return o;
    }
}
```



#### Spring AOP

![image-20211021215624178](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110212156340.png)

![image-20211022191138691](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110221911816.png)

* 切面

> 涉及多个类别的关注点的模块化。事务 Management 是企业 Java 应用程序中横切关注的一个很好的例子。在 Spring AOP 中，方面是通过使用常规类([schema-based approach](https://www.docs4dev.com/docs/zh/spring-framework/5.1.3.RELEASE/reference/core.html#aop-schema))或使用`@Aspect`注解([@AspectJ style](https://www.docs4dev.com/docs/zh/spring-framework/5.1.3.RELEASE/reference/core.html#aop-ataspectj))注解 的常规类来实现的。



* 连接点

> 在程序执行过程中的一点，例如方法的执行或异常的处理。在 Spring AOP 中，连接点始终代表方法的执行。



* 通知

> 方面在特定的连接点处采取的操作。不同类型的建议包括“周围”，“之前”和“之后”建议。 (建议类型将在后面讨论.)包括 Spring 在内的许多 AOP 框架都将建议建模为拦截器，并在连接点周围维护一系列拦截器。



* 切点

> 与连接点匹配的谓词。建议与切入点表达式关联，并在与该切入点匹配的任何连接点处运行(例如，执行具有特定名称的方法)。切入点表达式匹配的连接点的概念是 AOP 的核心，并且 Spring 默认使用 AspectJ 切入点表达语言。



**简单配置：**

1. 在ioc的基础上添加pom依赖

```xml
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.9.7</version>
</dependency>

// AOP 与 spring相互配合的jar
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aspects</artifactId>
    <version>5.3.9</version>
</dependency>

```

是使用注解的形式，所以要是用xml进行配置，xml头省略，具体查看[命名空间配置](#注解+Xml)

必须要设置扫描宝和注解AOP

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans .............
    <!--扫描包：扫描类中所有注解，不扫描注解不生效-->
    <context:component-scan base-package="com.jt"/>
    <!--使用的是注解方式的AOP，所以要开启注解AOP功能！-->
    <aop:aspectj-autoproxy/>
</beans>
```



2. 配置

   * 设置程序中的切面类

   > ```java
   > @Aspect     // 声明为切面
   > @Component  //不仅要声明为切面，还有将其注册在ioc中作为组件管理，因为如果要增强ioc中的Bean就				必须注册在IoC中
   > ```

   * 设置切面类中的方法在什么时候执行

   ```java
   package com.jt.aspect;
   
   import org.aspectj.lang.annotation.*;
   import org.springframework.stereotype.Component;
   
   import java.lang.reflect.Method;
   import java.util.Arrays;
   
   @Aspect     // 声明为切面
   @Component  //不仅要声明为切面，还有将其注册在ioc中作为组件
   public class LogUtil {
        
       // 前置通知
       @Before("execution(* com.jt.service..*.*(..))") //后面是切入表达式！
       public static void before() {
           System.out.println("方法前");
       }
   
       // 后置通知
       @After("execution(* com.jt.service..*.*(..))")
       public static void after() {
           System.out.println("方法后");
       }
   
       // 后置异常通知
       @AfterThrowing("execution(* com.jt.service..*.*(..))")
       public static void afterException() {
           System.out.println("方法异常");
       }
   
       // 后置返回通知
       @AfterReturning("execution(* com.jt.service..*.*(..))")
       public static void afterEnd() {
           System.out.println("方法结束");
       }
   }
   ```

   

![image-20211022191547718](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110221915831.png)



### 第六章 Spring AOP使用详解

* 注解方式
* xml方式



SSM项目结构（**示例**）：

![image-20211024101125567](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110241011659.png)

|       包名        |                             描述                             |
| :---------------: | :----------------------------------------------------------: |
|        dao        |  数据访问层-存放与数据库交互相关代码（Data access object）   |
|        dto        |    存放与业务相关性不大的数据实体类(Data Transfer Object)    |
|      entity       |                  存放与业务相关性大的实体类                  |
|       enums       |             存放枚举类型，这里主要是存放一些常亮             |
|     exception     |                 存放自定义的一些运行时异常类                 |
|      service      |               存放service层的业务相关功能的类                |
| web（controller） |                   存放controller层的控制类                   |
|     resources     | 即classpath，mapper文件夹存放Mybatis的mapper.xml，spring文件夹放spring的配置文件。 |

#### 配置

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--扫描注解的包-->
    <context:component-scan base-package="com.jt"/>

    <!--启动aop的注解方式-->
    <aop:aspectj-autoproxy/>
</beans>
```

测试类：

```java
public class SpringTest {
    @Test
    public void test() {
        ClassPathXmlApplicationContext ioc =
                new ClassPathXmlApplicationContext("classpath:/spring.xml");
        IUserService bean = ioc.getBean(IUserService.class);
        /*
        *  当开启了aop后，结果是class com.sun.proxy.$Proxy19
        *  这是一个jdk动态代理类，实现了IUserService接口
        *  因此这个类 与 UserServiceImpl是两个完全不同的两个类，
        *  故不能使用UserServiceImpl来接受这个动态代理类！
        *
        *  aop：当被代理的类实现了接口 会默认使用jdk代理
        *       当被代理的类未实现接口 会使用cglib代理
        *
        *  总结，aop实现的代理类可以理解为：被代理类在注册到ioc中时会被AOP截胡
        *       从而生成动态代理类，因此ioc.getBean需要使用接口来接受，
        *       (当被代理类没有实现接口则可以使用被代理类接受)
        * */
        System.out.println(bean.getClass());
    }
}
```

#### 切入点表达式

* **execution**：用于匹配方法执行连接点。主要切点标识符。
* **within**：限制匹配特定类型中的连接点（在使用Spring AOP时，只需执行在匹配类型中声明的方法）
* this：匹配实现了某个接口的类
* target：限制匹配到连接点（使用Spring AOP时方法的执行），其中目标对象（正在代理的应用程序对象）是给定类型的实例
* args：限制与连接点的匹配（使用Spring AOP时方法的执行），其中变量是给定类型的实例
* @target：限制与连接点的匹配（使用Spring AOP时方法的执行），其中执行对象的类具有给定类型的注解
* @args：限制匹配连接点（使用Spring AOP时方法的执行），其中传递的实际参数的运行时类型具有给定类型的注解
* @within：限制与具有给定注解的类型中的连接点匹配（使用Spring AOP时在具有给定注解的类型中声明的方法的执行）
* @annotation：限制匹配连接点（在Spring AOP中执行的方法具有给定的注解）有对应注解的就匹配上 



==例子：==

```java
execution(modifiers-pattern? ret-type-pattern declaring-type-pattern?name-pattern(param-pattern) throws-pattern?)
```

 这里问号表示当前项可以有也可以没有，其中各项的语义如下：

- modifiers-pattern：**方法的修饰符**，如public，protected；
- ret-type-pattern：**方法的返回值类型**（==必须====，非jdk自带类型必须写完整现定名==：com.jt.user）
- declaring-type-pattern：**方法所在类的全路径名**，如com.spring.Aspect；
- name-pattern：**方法名类型**，如buisinessService()；
- param-pattern：**方法的参数类型**，如java.lang.String； 
- throws-pattern：**方法抛出的异常类型**，如java.lang.Exception；

![image-20211024170409319](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110241704487.png)



> cn.*  == cn.jt ==cn.任意名字，但是只能匹配一级。（cn.jt.service就无法匹配）
>
> cn.jt.* 可以匹配cn.jt.service
>
> cn.jt..* 可以匹配cn.jt.service.impl

类名：

> 可以写***** 代表任意名字的类名。
>
> 可以***ServiceImpl** 能够匹配诸如：1.UserServiceImpl 、 2.RoleServiceImpl  、 3...

 

以下示例显示了一些常见的切点表达式：

- 匹配任意公共方法的执行:

  ```
  execution(public * *(..))
  ```

- 匹配任意以`set`开始的方法:

  ```
  execution(* set*(..))
  ```

- 匹配定义了`AccountService`接口的任意方法:

  ```
  execution(* com.xyz.service.AccountService.*(..))
  ```

- 匹配定义在`service` 包中的任意方法:

  ```
  execution(* com.xyz.service.*.*(..))
  ```

- 匹配定义在service包和其子包中的任意方法:

  ```
  execution(* com.xyz.service..*.*(..))
  ```

- 匹配在service包中的任意连接点（只在Spring AOP中的方法执行）:

  ```
  within(com.xyz.service.*)
  ```

- 匹配在service包及其子包中的任意连接点（只在Spring AOP中的方法执行）:

  ```
  within(com.xyz.service..*)
  ```

- 匹配代理实现了`AccountService` 接口的任意连接点（只在Spring AOP中的方法执行）：

  ```
  this(com.xyz.service.AccountService)
  ```

  'this' 常常以捆绑的形式出现. 见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用代理对象。

- 匹配当目标对象实现了`AccountService`接口的任意连接点（只在Spring AOP中的方法执行）:

  ```
  target(com.xyz.service.AccountService)
  ```

  'target' 常常以捆绑的形式出现. 见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用目标对象。

- 匹配使用了单一的参数，并且参数在运行时被传递时可以序列化的任意连接点（只在Spring的AOP中的方法执行）。:

  ```
  args(java.io.Serializable)
  ```

  'args' 常常以捆绑的形式出现.见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用方法参数。

  注意在这个例子中给定的切点不同于`execution(* *(java.io.Serializable))`. 如果在运行时传递的参数是可序列化的，则与execution匹配，如果方法签名声明单个参数类型可序列化，则与args匹配。

- 匹配当目标对象有`@Transactional`注解时的任意连接点（只在Spring AOP中的方法执行）。

  ```
  @target(org.springframework.transaction.annotation.Transactional)
  ```

  '@target' 也可以以捆绑的形式使用.见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用注解对象。

- 匹配当目标对象的定义类型有`@Transactional`注解时的任意连接点（只在Spring的AOP中的方法执行）:

  ```
  @within(org.springframework.transaction.annotation.Transactional)
  ```

  '@within' 也可以以捆绑的形式使用.见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用注解对象。

- 匹配当执行的方法有`@Transactional`注解的任意连接点（只在Spring AOP中的方法执行）:

  ```
  @annotation(org.springframework.transaction.annotation.Transactional)
  ```

  '@annotation' 也可以以捆绑的形式使用.见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用注解对象。

- 匹配有单一的参数并且在运行时传入的参数类型有`@Classified`注解的任意连接点（只在Spring AOP中的方法执行）:

  ```
  @args(com.xyz.security.Classified)
  ```

  '@args' 也可以以捆绑的形式使用.见后续的章节讨论如何在[声明通知](https://github.com/DocsHome/spring-docs/blob/master/pages/core/aop.md#aop-advice)中使用注解对象。

- 匹配在名为`tradeService`的Spring bean上的任意连接点（只在Spring AOP中的方法执行）:

  ```
  bean(tradeService)
  ```

- 匹配以`Service`结尾的Spring bean上的任意连接点（只在Spring AOP中方法执行） :

  ```
  bean(*Service)
  ```



#### 合并切点表达式

可以使用 `&&,` `||` 和 `!`等符号进行合并操作

```
@Pointcut("anyPublicOperation() && inTrading()")
```



#### 通知方法执行顺序

* 正常执行

  > @Before -> @After -> @AfterReturning 

* 异常执行

  > @Before -> @After -> @AfterThrowing

![image-20211026192106665](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110261921756.png)

==手动写动态代理的时候如上图所示，各个通知所在位置是固定的，只是使用SpringAOP后，spring会帮我们将这些通知放在不同位置上。简化我们的操作==上面的图片仅供理解，AOP实际上并不是这样。



任何通知方法都可以声明一个类型为 `org.aspectj.lang.JoinPoint`的参数作为其第一个参数（注意，需要使用around advice来声明一个类型为`ProceedingJoinPoint`的第一个参数， 它是`JoinPoint`的一个子类。`JoinPoint`接口提供很多有用的方法：:

- `getArgs()`: 返回方法参数.
- `getThis()`: 返回代理对象.
- `getTarget()`: 返回目标对象.
- `getSignature()`:返回正在通知的方法的描述.
- `toString()`: 打印方法被通知的有用描述.

```java
// 前置通知
@Before("execution(* com.jt.service.impl.*.*(..))")
public void before(JoinPoint joinpoint) {
    String methodName = joinpoint.getSignature().getName();
    // 所有的参数
    Object[] args = joinpoint.getArgs();
    System.out.println(methodName+"方法运行，参数是"+ Arrays.asList(args));
}
```

如果需要获取返回值

```java
// 1.注解中的value不能省略了，以为需要多个参数
// 2.在注解中加入returning=“xxxx” ， 其中xxxx为返回值，由于类型不知道是什么，采用object
@AfterReturning(value = "execution(* com.jt.service.impl.*.*(..))",
                returning = "returnValue")
public void afterReturning(Object returnValue) {
    System.out.println("返回值"+returnValue);
}
```

如果需要获取异常信息

*  注解中的value不能省略了，以为需要多个参数

*  在注解中加入throwing=“xxxx” ， 其中xxxx为异常返回值，类型为Exception

  ```java
  // 注：修饰符、返回值些什么无所谓，但是函数名一定要对应
  @AfterThrowing(value = "execution(* com.jt.service.impl.*.*(..))",
                 throwing = "ex")
  public void afterThrowing(Exception ex) {
      StringWriter sw = new StringWriter();
      ex.printStackTrace(new PrintWriter(sw,true));
      String ret = sw.getBuffer().toString();
      System.out.println("后置异常通知" + ret);
  }
  ```



**问题：**每次写代理类的时候都要写切点表达式，很麻烦！怎么办？

解决：声明切点，其他方法来引用

```java
    // 采用切点的方式让其他通知引用，重用性更强
    @Pointcut("execution(* com.jt.service.impl.*.*(..))")
    public void pointcut() {}

    // 前置通知 @annotation里面 一定要是函数中参数的名字
	// 通知里面的参数不是随便写的，其中JoinPoint是所有的通知都可以用！
    @Before("pointcut() && @annotation(logger)")
    public void before(JoinPoint joinpoint,Logger logger) {
		xxxxxxxxx
        System.out.println("注解的值为:"+logger.name());
    }
```

#### 环绕通知

![image-20211026211405494](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110262114674.png)



#### 基于schema（XML）的AOP支持

```xml
    <!--AOP的xml方式实现-->
    <aop:config>
        <aop:aspect ref="logAspectTwo">
            <aop:pointcut id="all" expression="execution(* com.jt.service.impl.*.*(..))"/>
            <aop:before method="before" pointcut-ref="all"/>
            <aop:after method="after" pointcut-ref="all"/>
            <aop:after-throwing method="afterThrowing" throwing="ex" pointcut-ref="all"/>
            <aop:after-returning method="afterReturning" returning="returnValue" pointcut-ref="all"/>
        </aop:aspect>
    </aop:config>
```

![image-20211026215324694](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110262153779.png)





### 第七章 Spring 声明式事务

什么是事务：

> 把一组业务当成一个业务来做，要么都成功，要么都失败，保证业务操作完整性的数据库机制



#### Spring JdbcTemplate

在Spring中为了更加方便的操作jdbc，在JDBC的基础上定义了一个抽象层，目的是为了不同类型的JDBC操作提供模板方法，每个模板方法都能空值整个过程，并允许覆盖过程中的特定任务，通过这种方式，可以尽可能保留灵活性，将数据库存取的工作量降到最低。



**配置xml**：

```xml
    <dependencies>

        <!--Spring ioc容器-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.2.6.RELEASE</version>
            <scope>compile</scope>
        </dependency>

        <!--单元测试-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.1</version>
            <scope>test</scope>
        </dependency>

        <!--阿里巴巴数据库连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.1.21</version>
        </dependency>

        <!--mysql 数据库-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.47</version>
        </dependency>

        <!--AOP-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aop</artifactId>
            <version> 5.2.6.RELEASE</version>
        </dependency>

        <!--AOP-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aspects</artifactId>
            <version>5.3.9</version>
        </dependency>

        <!--AOP依赖-->
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.9.7</version>
        </dependency>

        <!--JDBC事务需要的依赖-->
        <!--orm：将对象持久化到数据库中-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-orm</artifactId>
            <version>5.3.12</version>
        </dependency>
    </dependencies>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">

    <!--扫描-->
    <context:component-scan base-package="com.jt"/>

    <!--配置JDBC Template Bean组件-->
    <bean class="org.springframework.jdbc.core.JdbcTemplate" id="jdbcTemplate">
        <!--引用数据源-->
        <property name="dataSource" ref="dataSource"/>
    </bean>

    <!--配置druid数据源-->
    <bean class="com.alibaba.druid.pool.DruidDataSource" id="dataSource">
        <property name="username" value="${mysql.username}"/>
        <property name="password" value="${mysql.password}"/>
        <property name="url" value="${mysql.url}"/>
        <property name="driverClassName" value="${mysql.driverClassName}"/>
    </bean>

    <!--引入外部属性资源文件-->
    <context:property-placeholder location="db.properties"/>
</beans>
```

```java
public class JDBCTest {

    ClassPathXmlApplicationContext ioc;

    @Before
    public void before() {

        ioc = new ClassPathXmlApplicationContext("classpath:spring.xml");
    }

    @Test
    public void test01() {
        DruidDataSource bean = ioc.getBean(DruidDataSource.class);
        System.out.println(bean);
    }

    /**
     *  jdbcTemplate 演示
     *  查询单个值 , 必需保证sql语句返回的是一行一列,且返回值是参数2中所给出的类
     */
    @Test
    public void test02() {
        JdbcTemplate jdbcTemplate = ioc.getBean(JdbcTemplate.class);
        Long aLong = jdbcTemplate.queryForObject("select count(*) from pet", Long.class);
        System.out.println(aLong);


    }

    /**
     * 查询实体
     * 数据库字段名和属性名一样:
     * 利用BeanPropertyRowMapper来与实体类自动映射
     *
     * 也可以使用lambda
     */
    @Test
    public void test04() {
        JdbcTemplate jdbcTemplate = ioc.getBean(JdbcTemplate.class);
        // User user = jdbcTemplate.queryForObject("select * from suser where id = 1",
        //         new BeanPropertyRowMapper<>(User.class));

        User user = jdbcTemplate.queryForObject("select * from suser where id = 1",
                (rs, rowNum) -> {
                    User o = new User();
                    o.setId(rs.getInt("id"));
                    return o;
                });

        System.out.println(user);

    }

    /**
     * 查询list实体
     */
    @Test
    public void test05() {
        JdbcTemplate jdbcTemplate = ioc.getBean(JdbcTemplate.class);
        // new BeanPropertyRowMapper<>(User.class)参数为对应的对象类
        List<User> query = jdbcTemplate.query("select * from suser where id=1", new BeanPropertyRowMapper<>(User.class));

    }
    // 增删改查 思路都一样 去看文档!!!!!
}
```



#### 事务

- Atomicity（原子性）：==一个事务（transaction）中的所有操作，要么全部完成，要么全部不完成，不会结束在中间某个环节==。事务在执行过程中发生错误，会被恢复（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。
- Consistency（一致性）：==在事务开始之前和事务结束以后，数据库的完整性没有被破坏==。这表示写入的资料必须完全符合所有的预设规则，这包含资料的精确度、串联性以及后续数据库可以自发性地完成预定的工作。
- Isolation（隔离性）：==数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致==。事务隔离分为不同级别，包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）。
- Durability（持久性）：==事务处理结束后，对数据的修改就是永久的==，即便系统故障也不会丢失。 [1] 

  ![image-20211028222302000](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110282223199.png)



**配置事务管理器**

> 配置数据源->配置事务管理器->开启事务注解驱动

基于注解的事务声明配置

```xml
<!--配置druid数据源-->
<bean class="com.alibaba.druid.pool.DruidDataSource" id="dataSource">
    <property name="username" value="${mysql.username}"/>
    <property name="password" value="${mysql.password}"/>
    <property name="url" value="${mysql.url}"/>
    <property name="driverClassName" value="${mysql.driverClassName}"/>
</bean>

<!--引入外部属性资源文件-->
<context:property-placeholder location="db.properties"/>

<!--事务管理器,需要将数据源交给事务管理器-->
<bean class="org.springframework.jdbc.datasource.DataSourceTransactionManager" 				 id="transactionManager">
    <property name="dataSource" ref="dataSource"/>
</bean>

<!--基于注解方式的事务,开启事务的注解驱动,传入事务管理器
	如果注解 和 xml 都配置了 会以注解优先
-->
<tx:annotation-driven transaction-manager="transactionManager"/>
```

基于xml的事务声明配置

```xml


<!--用于声明事务切入的所有方法-->
<aop:config>
    <aop:pointcut id="transactionCut" expression="execution(* com.jt.service.impl.*.*(..))"/>

</aop:config>

<!--用来明确切点匹配到的方法那些方法需要使用事务-->
<tx:advice>
    <tx:attributes>
        <!--可以使用通配符 必须以下面声明的名字来开头 否则不会用上事务!-->
        <tx:method name="add*"/>
        <tx:method name="update*"/>
        <tx:method name="delete*"/>
        <tx:method name="get*" read-only="true" propagation="SUPPORTS"/>
        <tx:method name="query*" read-only="true"/>
    </tx:attributes>
</tx:advice>
```





对事务加上注解==@Transactional==

```java
	/**
     * 转账
     */
@Transactional
public void trans() {
    sub();  		//张三扣钱
    int i = 1 / 0;	//出现异常回滚事务
    save(); 		//李四加钱
}
```

@Transactional标记位置:

* **标记在类上面**:当前类所有方法都运用上了事务
* **标记在方法**:当前方法运用上了事务(推荐--这样的话控制力度比较细)



**事务配置的属性:**

通常采用简单的注解配置属性：
`@Transactional(属性名称=属性值)`

* Isolation 指定事务的隔离级别`@Transactional(isolation = Isolation.DEFAULT)`

  * 读已提交 READ_COMMITTED
  * 读未提交 READ_UNCOMMITTED
  * 可重复读 REPEATABLE_READ
  * 串行化 SERIALIZABLE
  * 默认值 DEFAULT： （MySQL： 可重复读、Oracle： 读已提交）

* timeout 设置单位为秒的超时。 默认值是 -1 表示使用数据库的设置。

* readOnly` 设置是否是只读事务(常用，用来标识是否是只读操作)。`@Transactional(readOnly = false)

  > 当你能确保整个事务过程中只对数据库执行Select操作的时候，如果将此属性设置为true，则会自动进行优化，提高性能。

* Propagation 事务的传播属性（特有的精细化的控制），解决的是事务嵌套的问题，例如：service依赖其他多个service进行数据操作，并且需要保证各个service执行中的事务控制@Transactional(propagation = Propagation.SUPPORTS)

![在这里插入图片描述](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202110311711776.png)

* noRollbackFor:那些异常事务可以不会滚
* rollbackFor:那些异常事务需要回滚



#### 脏读

> 1、在事务A执行过程中，事务A对数据资源进行了修改，事务B读取了事务A修改后的数据。
>
> 2、由于某些原因，事务A并没有完成提交，发生了RollBack操作，则事务B读取的数据就是脏数据。
>
> 这种读取到另一个事务未提交的数据的现象就是脏读(Dirty Read)。
>
> ![image-20211101152051060](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011520122.png)
>
> ==解决方法:@Transcation(isolation = isolation.READ_COMMITTED)==
>
> 读已提交
>
> ==要求事务B只能读取事务A已提交的修改==



#### 不可重复读

> 事务B读取了两次数据资源，在这两次读取的过程中事务A修改了数据，导致事务B在这两次读取出来的数据不一致。
>
> 这种在同一个事务中，前后两次读取的数据不一致的现象就是不可重复读(Nonrepeatable Read)。
>
> ![image-20211101152147668](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011521730.png)
>
> ==解决方法:@Transcation(isolation = isolation.REPEATABLE_READ)==
>
> 可重复读
>
> ==确保事务X可以多次从一个字段中读取到相同的值,即事务X执行期间禁止其他事物对这个字段进行更新(**行锁**)==



#### 幻读

> 事务B前后两次读取同一个范围的数据，在事务B两次读取的过程中事务A新增了数据，导致事务B后一次读取到前一次查询没有看到的行。
>
> **幻读和不可重复读有些类似，但是幻读强调的是集合的增减，而不是单条数据的更新。**
>
> ![image-20211101152253130](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011522198.png)
>
> ==解决方法:@Transcation(isolation = isolationSERIALIZABLE)==
>
> 串行化
>
> ==确保事务X可以多次从一个字段中读取到相同的行,即事务X执行期间禁止其他事物对这表进行添加,更新,删除==可以避免任何并发问题,性能十分低下(**表锁**)



什么是并发操作？

并发操作是指同一时间可能有多个用户对同一数据进行读写操作.

并发（concurrency）和并行（parallellism）是：

1. 解释一：并行是指两个或者多个事件在同一时刻发生；而并发是指两个或多个事件在同一时间间隔发生。

   ​				操作系统上讲就是指令

2. 解释二：并行是在不同实体上的多个事件，并发是在同一实体上的多个事件。

3. 解释三：并行是在多台处理器上同时处理多个任务。如 hadoop 分布式集群，并发是在一台处理器上“同时”处理多个任务。



![image-20211101161401025](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011614135.png)

**安全性越高,效率越差**



#### 事务的传播性

指的是当一个事物方法被另一个事物方法调用时,这个事务方法应该如何执行?

==前三个 重点==

![image-20211101162200843](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011622030.png)

 ```java
 @Transactional()
 public void trans() {
     sub();  	//也是一个事务 被融合到trans中(我的理解是代码都存在于trans中然后全部执行完毕才行)
     save(); 	//也是一个事务 如果调用trans 则 save属于外部存在事务 调用save则属于外部不存在事务
 }
 @Transactional
 public void sub() {
 
 }
 @Transactional
 public void save() {
 
 }
 ```

```java
@Service
public class LogServiceImpl implements ILogService {
    @Autowired
    IUserDao userDao;
    
    @Override
    // 如果事务传播行为是挂起事务，需要将父事务方法和子事务方法写在不同的类中
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void log() {
        userDao.sub();
    }
}
```



#### 超时属性

指定事务等待的最长时间(秒)

当前事务访问数据时,有可能访问的数据被别的事务进行加锁的处理,那么此时事务就必须等待,如果等待时间过长给用户造成的体验极差!

![image-20211101171708636](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111011717741.png)

 **==Spring事务的实现方式和原理==**

在使用Spring框架时,可以有两种使用事务的方式，一种是编程式的，另一种是声明式。

首先，事务这个概念是数据库层面的，Spring只是基于数据库中的事务进行了扩展，以及提供了一些能让程序员更加方便操作事务的方式。

比如我们可以通过在某个方法上增加@Transaction注解，就可以开启事务，这个方法所有的sql都会在一个事务中执行，统一成功或失败。

在一个方法上加了@Transaction注解后，Spring会基于这个类生成一个代理对象，会将这个代理对象作为bean，当在使用这个代理对象的方法时，如果这个方法上存在@Transaction注解，那么代理逻辑会先把事务的自动提交设置为false,然后再去执行原本的业务逻辑方法，如果执行业务逻辑方法没有出现异常，那么代理逻辑中就会将事务进行提交，如果执行业务逻辑方法出现了异常，那么则会将事务进行回滚。

当然，针对哪些异常回滚，事务是可以配置的。可以利用@Transaction注解中的rollbackFor属性进行配置，默认情况下会对RuntimeException和Error进行回滚。





### 第八章 Spring源码讲解

https://mp.weixin.qq.com/s/0zDCy0eQycdM8M9eHGuLEQ

https://mp.weixin.qq.com/s?__biz=MzU5MDgzOTYzMw==&mid=2247484564&idx=1&sn=84bd8fee210c0d00687c3094431482a7&chksm=fe396eaac94ee7bcf54aae99aecab9fcfbefa7b2be17961061874d0f5cf9c95c81258ddae1b5&scene=178&cur_album_id=1344425436323037184#rd

所有知识的源码部分打算22年5月份开始学习







































































