#狂神的Swagger笔记
## 狂神的Swagger笔记

视频链接：https://www.bilibili.com/video/BV1Y441197Lw?from=search&amp;seid=5187609033853264629

学习目标：
- 了解Swagger的作用和概念- 了解前后端分离- 在SpringBoot中集成Swagger
## Swagger简介

**前后端分离**

Vue + SpringBoot 

后端**时代**：前端只用管理静态页面；html ⇒ 后端。模板引擎JSP ⇒ 后端是主力。

前后端分离时代：
-  后端：==后端控制层==，==服务层==，==数据访问层==【后端团队】 
  
-  前端：==前端控制层==，==视图层==【前端团队】 
  
  <ul>- 伪造后端数据，json。已经存在了，不需要后端，前端工程依旧能够跑起来。
  前后端如何交互？ ===&gt; API

前后端相对独立，松耦合；

前后端甚至可以部署在不同的服务器上；

产生一个问题：
- 前后端集成联调，前端人员无法和后端人员无法做到，“即时协商，尽早解决”，最终导致问题集中爆发；
解决方案：
-  首先指定schema[计划的提纲]，实时更新最新API，降低集成的风险； -  早些年：指定word计划文档； <li> 前后端分离： 
  
  <ul>- 前端测试后端接口：postman- 
      后端提供接口，需要实时更新最新的消息及改动！

## Swagger

- 号称世界上最流行的Api框架- RestFul Api 文档在线自动生成工具 =&gt; <mark>Api文档与Api定义同步更新</mark>- 直接运行，可以在线测试API接口；- 支持多种语言：（Java、Php…）
官网：https://swagger.io/

在项目中使用swagger需要springbox；
- swagger2
-  ui
## SpringBoot集成Swagger
1. 新建一个SpringBoot - web项目1. 导入相关依赖 <img src="https://img-blog.csdnimg.cn/20210121215648715.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01lbW9yaWVzTmFuZ29uZw==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述">
```xml
<!-- https://mvnrepository.com/artifact/io.springfox/springfox-swagger2 -->
<dependency>
<groupId>io.springfox</groupId>
<artifactId>springfox-swagger2</artifactId>
<version>3.0.0</version>
</dependency>

<!-- https://mvnrepository.com/artifact/io.springfox/springfox-swagger-ui -->
<dependency>
<groupId>io.springfox</groupId>
<artifactId>springfox-swagger-ui</artifactId>
<version>3.0.0</version>
</dependency>
```
1. 编写一个Hello工程1. 配置Swagger ==&gt; Config
```java
package com.kuang.swagger.config;

import org.springframework.context.annotation.Configuration;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2   // 开启Swagger2
public class SwaggerConfig {

    
}

```
1. 测试运行 http://localhost:8080/swagger-ui.html<img src="https://img-blog.csdnimg.cn/20210121233447652.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01lbW9yaWVzTmFuZ29uZw==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述">
## 配置Swagger

swagger的bean实例Docket；（<mark>在上面SwaggerConfig 类中添加</mark>）

```
@Configuration
@EnableSwagger2   // 开启Swagger2
public class SwaggerConfig {<!-- -->

    //配置了swagger的Docket 的 bean 实例
    @Bean
    public Docket docket(){<!-- -->
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo());
    }
    //配置 swagger 信息 = apiInfo
    private ApiInfo apiInfo(){<!-- -->
        //作者信息
        Contact contact = new Contact("秦疆", "https://blog.kuangstudy.com/", "24736743@qq.com");
        return new ApiInfo("狂神的SwaggerAPI文档",
                "即时在小的帆也能远航",
                "v1.0",
                "http://blog.kuangstudy.com/",
                contact,
                "Apache 2.0",
                "http://www.apache.org/licenses/LICENSE-2.0",
                new ArrayList()
        );
    }
}

```

## Swagger配置扫描接口

Docket.select() <mark>接着上面的docket() 讲解</mark>

```
//配置了swagger的Docket 的 bean 实例
    @Bean
    public Docket docket(){<!-- -->
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                // RequestHandlerSelectors, 配置要扫描的包
                // basePackage(): 指定要扫描的包
                // any(): 扫描全部
                // none(): 都不扫描
                // withClassAnnotation : 扫描类上的注解, 参数是一个注解的反射对象
                // 例如：withClassAnnotation(RestController.class) 只扫描类上有@RestController的生成文档
                // withMethodAnnotation: 扫描方法上的注解, 参数是一个注解的反射对象
                .apis(RequestHandlerSelectors.basePackage("com.kuang.swagger.controller"))
                // paths(): 过滤什么路径
                .paths(PathSelectors.ant("/kuang/**"))
                .build();  //build
    }

```

配置是否启动Swagger（**enable 是否启动Swagger， 如果为false， 则Swagger 不能再浏览器中访问**） <img src="https://img-blog.csdnimg.cn/20210122002055264.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01lbW9yaWVzTmFuZ29uZw==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 问题：我只希望我的Swagger在生产环境中使用，在发布的时候不使用？ 解题思路：
- 判断是不是生产环境 flag = false- 注入enable(flag)
解题步骤： 1.先在resources目录下创建两个properties文件，如下图 <img src="https://img-blog.csdnimg.cn/20210122162603350.png" alt="在这里插入图片描述"> 接下来在application.properties文件中激活环境

```
spring.profiles.active=dev

```

在application-dev.properties中

```
server.port=8081

```

在application-pro.properties中

```
server.port=8082

```

2.<mark>接着上面的docket()</mark>，在方法中加入形参Environment获取application.properties中的设置的环境

```
 @Bean
 public Docket docket(Environment environment){<!-- -->
     // 设置要显示的Swagger环境
     Profiles profiles = Profiles.of("dev", "test");
     // 通过 environment.acceptsProfiles(profiles) 判断是否处在自己设定的环境当中
     boolean flag = environment.acceptsProfiles(profiles);


     return new Docket(DocumentationType.SWAGGER_2)
             .apiInfo(apiInfo())
             //此处判断是生产环境 flag 就是为true 就可以访问Swagger
             .enable(flag)
             
             .select()
             .apis(RequestHandlerSelectors.basePackage("com.kuang.swagger.controller"))
//                .paths(PathSelectors.ant("/kuang/**"))
             .build();  //build
 }

```

3.在浏览器上请求http://localhost:8081/swagger-ui.html#/就可以访问Swagger，我们可以修改spring.profiles.active为pro

```
spring.profiles.active=pro

```

然后在浏览器上请求http://localhost:8082/swagger-ui.html#/会出现😱 Could not render e, see the console.

## 配置API文档的分组

```
.groupName("狂神")

```

配置多个分组，多个Docket实例即可

```
 @Bean
 public Docket docket1(){<!-- -->
     return new Docket(DocumentationType.SWAGGER_2).groupName("A");
 }
 @Bean
 public Docket docket2(){<!-- -->
     return new Docket(DocumentationType.SWAGGER_2).groupName("B");
 }
 @Bean
 public Docket docket3(){<!-- -->
     return new Docket(DocumentationType.SWAGGER_2).groupName("C");
 }

```

Swagger中就会出现多个分组 <img src="https://img-blog.csdnimg.cn/20210122165758163.png" alt="在这里插入图片描述">

```
package com.kuang.swagger.pojo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel("用户实体类")
public class User {<!-- -->

    @ApiModelProperty("用户名")
    public String username;
    @ApiModelProperty("密码")
    public String password;
}


```

controller

```
package com.kuang.swagger.controller;

import com.kuang.swagger.pojo.User;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {<!-- -->

    @GetMapping(value = "/hello")
    public String hello(){<!-- -->
        return "hello";
    }

    // 只要我们的接口中，返回值中存在实体类, 他就会扫描到Swagger中
    @PostMapping(value = "/user")
    public User user(){<!-- -->
        return new User();
    }

    @ApiOperation("hello控制类")
    @GetMapping(value = "/hello2")
    public String hello2(@ApiParam("用户名") String username){<!-- -->
        return "hello " + username;
    }
    @ApiOperation("Post测试类")
    @GetMapping(value = "/postt")
    public User postt(@ApiParam("用户名") User user){<!-- -->
        return user;
    }
}

```

## 总结
1. 我们可以通过Swagger给一些比较比较难理解的属性后接口，增加注释信息1. 接口文档实时更新1. 可以在线测试
本文章完全通过学习狂神的swagger视频，视频链接在文章开头，笔记可能会有小修改，如有错误请给我评论。
