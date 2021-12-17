 

# spring boot 练手实战项目说明



码神之路网站所使用的博客，项目简单，需求明确，容易上手，非常适合做为练手级项目。

最终成品



项目讲解说明：
1. 提供前端工程，只需要实现后端接口即可1. 项目以单体架构入手，先快速开发，不考虑项目优化，降低开发负担1. 开发完成后，开始优化项目，提升编程思维能力1. 比如页面静态化，缓存，云存储，日志等1. docker部署上线1. 云服务器购买，域名购买，域名备案等
项目使用技术 ：

springboot + mybatisplus+redis+mysql

# 基础知识

​    

推荐安装插件 配好@Data使用

 <img src="https://img-blog.csdnimg.cn/e2f5c4eb9cf2423b842381af83257bf4.png" alt="在这里插入图片描述">

查看文章代码结构

 <img src="https://img-blog.csdnimg.cn/0f0504a431af4295b66f3052c7839feb.png" alt="在这里插入图片描述"> 

自动提示编写的代码

 <img src="https://img-blog.csdnimg.cn/b2850ef527484df88701916ef89bd8a8.png" alt="在这里插入图片描述">

快速生成xml文件

 <img src="https://img-blog.csdnimg.cn/223ecf8d35ef49bf9d961dad5b3b1a86.png" alt="在这里插入图片描述">

区分括号

 <img src="https://img-blog.csdnimg.cn/d01a13fe992743b984e4d249593fc756.png" alt="在这里插入图片描述"> 

vscode插件

 <img src="https://img-blog.csdnimg.cn/8085dedbac7b4db6aba46639ea34e9d7.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_12,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">



解决通过构造器注入时出现的==循环依赖问题==

![image-20211130171452025](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111301714120.png)

在构造器上加上`@Lazy`注解与`@Autowired`共同使用

```java
@Lazy
@Autowired
public SysUserServiceImpl(SysUserMapper sysUserMapper, LoginService loginService) {
    this.sysUserMapper = sysUserMapper;
    this.loginService = loginService;
}
```





# 面试准备

# 1. 工程搭建

前端的工程：

```shell
npm install
npm run build
npm run dev
```

## 1.1 新建maven工程

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.mszlu</groupId>
    <artifactId>blog-parent</artifactId>
    <version>1.0-SNAPSHOT</version>


    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.5.0</version>
        <relativePath/>
    </parent>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
            <!-- 排除 默认使用的logback  -->
            <exclusions>
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- log4j2 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-log4j2</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>


        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
            <version>1.2.76</version>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>

        <dependency>
            <groupId>commons-collections</groupId>
            <artifactId>commons-collections</artifactId>
            <version>3.2.2</version>
        </dependency>

        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>3.4.3</version>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
        <!-- https://mvnrepository.com/artifact/joda-time/joda-time -->
        <dependency>
            <groupId>joda-time</groupId>
            <artifactId>joda-time</artifactId>
            <version>2.10.10</version>
        </dependency>
    </dependencies>

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

==删除src文件==

maven中的`dependencyMangement`的作用其实相当于一个对所依赖jar包进行版本管理的管理器。

> * `<dependencyManagement> `:只是对版本进行管理，不会实际引入jar 
> * `<dependencies> `:会实际下载jar包  



## 1.1.2遇到的bug



==mybatis-plus在springboot中的常用配置一览==

```properties
#mybatis-plus
# 如果是放在src/main/java目录下 classpath:/com/yourpackage/*/mapper/*Mapper.xml
# 如果是放在resource目录 classpath:/mapper/*Mapper.xml
mybatis-plus.mapper-locations=classpath:/com/springboot/study/mapper/*Mapper.xml
#实体扫描，多个package用逗号或者分号分隔
mybatis-plus.type-aliases-package=com.springboot.study.entity
#主键类型  0:"数据库ID自增", 1:"用户输入ID",2:"全局唯一ID (数字类型唯一ID)", 3:"全局唯一ID UUID";
mybatis-plus.global-config.id-type=3
#字段策略 0:"忽略判断",1:"非 NULL 判断"),2:"非空判断"
mybatis-plus.global-config.field-strategy=2
#驼峰下划线转换
mybatis-plus.global-config.db-column-underline=true
#mp2.3+ 全局表前缀 mp_
#mybatis-plus.global.table-prefix: mp_
#刷新mapper 调试神器
mybatis-plus.global-config.refresh-mapper=true
#数据库大写下划线转换
mybatis-plus.global-config.capital-mode=true
# Sequence序列接口实现类配置
mybatis-plus.global-config.key-generator=com.baomidou.mybatisplus.incrementer.OracleKeyGenerator
#逻辑删除配置（下面3个配置）
mybatis-plus.global-config.logic-delete-value=1
mybatis-plus.global-config.logic-not-delete-value=0
mybatis-plus.global-config.sql-injector=com.baomidou.springboot.MyMetaObjectHandler
#配置返回数据库(column下划线命名&&返回java实体是驼峰命名)，自动匹配无需as（没开启这个，SQL需要写as： select user_id as userId）
mybatis-plus.configuration.map-underscore-to-camel-case=true
mybatis-plus.configuration.cache-enabled=false
#配置JdbcTypeForNull, oracle数据库必须配置
mybatis-plus.configuration.jdbc-type-for-null=null
```





## 1.2 配置

```properties
#server
server.port= 8888
spring.application.name=mszlu_blog
# datasource
spring.datasource.url=jdbc:mysql://localhost:3306/blog?useUnicode=true&characterEncoding=UTF-8&serverTimezone=GMT%2B8
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

#mybatis-plus
mybatis-plus.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
mybatis-plus.global-config.db-config.table-prefix=ms_
```





```java
package com.mszlu.blog.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
//扫包，将此包下的接口生成代理实现类，并且注册到spring容器中
@MapperScan("com.mszlu.blog.dao")
public class MybatisPlusConfig {
	//分页插件
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor(){
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());
        return interceptor;
    }
}
```

==分页插件设置步骤==

* 创建`MybatisPlusInterceptor`主拦截器
* 拦截器中注册`PaginationInnerInterceptor`分页拦截器
* 返回主拦截器本身



```java
package com.mszlu.blog.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig  implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) { 
        //跨域配置，不可设置为*，不安全, 前后端分离项目，可能域名不一致
        //本地测试 端口不一致 也算跨域
        registry.addMapping("/**").allowedOrigins("http://localhost:8080");
    }
}
```

## 1.3 启动类

```java
package com.mszlu.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BlogApp {

    public static void main(String[] args) {
        SpringApplication.run(BlogApp.class,args);
    }
}
```

# 2. 首页-文章列表

## 2.1 接口说明

接口url：/articles

请求方式：POST

请求参数：

|参数名称|参数类型|说明|
| -------- | -------- | ---- |
|page|int|当前页数|
|pageSize|int|每页显示的数量|


返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id": 1,
            "title": "springboot介绍以及入门案例",
            "summary": "通过Spring Boot实现的服务，只需要依靠一个Java类，把它打包成jar，并通过`java -jar`命令就可以运行起来。\r\n\r\n这一切相较于传统Spring应用来说，已经变得非常的轻便、简单。",
            "commentCounts": 2,
            "viewCounts": 54,
            "weight": 1,
            "createDate": "2609-06-26 15:58",
            "author": "12",
            "body": null,
            "tags": [
                {
                    "id": 5,
                    "avatar": null,
                    "tagName": "444"
                },
                {
                    "id": 7,
                    "avatar": null,
                    "tagName": "22"
                },
                {
                    "id": 8,
                    "avatar": null,
                    "tagName": "11"
                }
            ],
            "categorys": null
        },
        {
            "id": 9,
            "title": "Vue.js 是什么",
            "summary": "Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式框架。",
            "commentCounts": 0,
            "viewCounts": 3,
            "weight": 0,
            "createDate": "2609-06-27 11:25",
            "author": "12",
            "body": null,
            "tags": [
                {
                    "id": 7,
                    "avatar": null,
                    "tagName": "22"
                }
            ],
            "categorys": null
        },
        {
            "id": 10,
            "title": "Element相关",
            "summary": "本节将介绍如何在项目中使用 Element。",
            "commentCounts": 0,
            "viewCounts": 3,
            "weight": 0,
            "createDate": "2609-06-27 11:25",
            "author": "12",
            "body": null,
            "tags": [
                {
                    "id": 5,
                    "avatar": null,
                    "tagName": "444"
                },
                {
                    "id": 6,
                    "avatar": null,
                    "tagName": "33"
                },
                {
                    "id": 7,
                    "avatar": null,
                    "tagName": "22"
                },
                {
                    "id": 8,
                    "avatar": null,
                    "tagName": "11"
                }
            ],
            "categorys": null
        }
    ]
}

```

## 2.2 编码

## 2.2.0 Spring—基于注解开发

 

### 2.2.1 表结构

==文章表==

```mysql
CREATE TABLE `blog`.`ms_article`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `comment_counts` int(0) NULL DEFAULT NULL COMMENT '评论数量',
  `create_date` bigint(0) NULL DEFAULT NULL COMMENT '创建时间',
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `view_counts` int(0) NULL DEFAULT NULL COMMENT '浏览数量',
  `weight` int(0) NOT NULL COMMENT '是否置顶',
  `author_id` bigint(0) NULL DEFAULT NULL COMMENT '作者id',
  `body_id` bigint(0) NULL DEFAULT NULL COMMENT '内容id',
  `category_id` int(0) NULL DEFAULT NULL COMMENT '类别id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

==标签表== id，文章id，标签id，通过文章id可以间接查到标签id

```mysql
CREATE TABLE `blog`.`ms_tag`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(0) NOT NULL,
  `tag_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

==用户表==

```mysql
CREATE TABLE `blog`.`ms_sys_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `account` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `admin` bit(1) NULL DEFAULT NULL COMMENT '是否管理员',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_date` bigint(0) NULL DEFAULT NULL COMMENT '注册时间',
  `deleted` bit(1) NULL DEFAULT NULL COMMENT '是否删除',
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `last_login` bigint(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `mobile_phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

### entity层

`别名`： model层 ，domain层

`用途`： 实体层，用于存放我们的实体类，与数据库中的属性值基本保持一致，实现set和get的方法。 例子：user表的实体User 

==文章==

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class Article {

    public static final int Article_TOP = 1;

    public static final int Article_Common = 0;

    private Long id;

    private String title;

    private String summary;

    private int commentCounts;

    private int viewCounts;

    /**
     * 作者id
     */
    private Long authorId;
    /**
     * 内容id
     */
    private Long bodyId;
    /**
     *类别id
     */
    private Long categoryId;

    /**
     * 置顶
     */
    private int weight = Article_Common;


    /**
     * 创建时间
     */
    private Long createDate;
}

```

==用户==

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class SysUser {

    private Long id;

    private String account;

    private Integer admin;

    private String avatar;

    private Long createDate;

    private Integer deleted;

    private String email;

    private Long lastLogin;

    private String mobilePhoneNumber;

    private String nickname;

    private String password;

    private String salt;

    private String status;
}


```

==标签==

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class Tag {

    private Long id;

    private String avatar;

    private String tagName;

}


```

### 2.2.2 Controller

controller层。控制器，导入service层，因为service中的方法是我们使用到的，controller通过接收前端传过来的参数进行业务操作，在返回一个指定的路径或者数据表

```java
package com.mszlu.blog.api;

import com.mszlu.blog.dao.pojo.Article;
import com.mszlu.blog.service.ArticleService;
import com.mszlu.blog.vo.Archive;
import com.mszlu.blog.vo.ArticleVo;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("articles")
public class ArticleController {
    @Autowired
    private ArticleService articleService;
	//Result是统一结果返回
    @PostMapping
    public Result articles(@RequestBody PageParams pageParams) {
        //ArticleVo 页面接收的数据
        List<ArticleVo> articles = articleService.listArticlesPage(pageParams);

        return Result.success(articles);
    }
}
```

上述的`@RequestMapping("articles")`中的`articles`没有加`/`是可以的,因为springboot底层会判断有没有`/`没有的话会自己给加上,详情请见`org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping的createRequestMappingInfo`



**java的(PO,VO,TO,BO,DAO,POJO)解释**

* ==PO(persistant object) 持久对象==
  在o/r映射的时候出现的概念，如果没有o/r映射，没有这个概念存在了。通常对应数据模型(数据库),本身还有部分业务逻辑的处理。可以看成是与数据库中的表相映射的java对象。最简单的PO就是对应数据库中某个表中的一条记录，多个记录可以用PO的集合。PO中应该不包含任何对数据库的操作。

* ==VO(value object) 值对象==
  通常用于业务层之间的数据传递，和PO一样也是仅仅包含数据而已。但应是抽象出的业务对象,可以和表对应,也可以不,这根据业务的需要.个人觉得同DTO(数据传输对象),在web上传递。

* ==TO(Transfer Object)，数据传输对象==
  在应用程序不同tie(关系)之间传输的对象

* ==BO(business object) 业务对象==
  从业务模型的角度看,见UML元件领域模型中的领域对象。封装业务逻辑的java对象,通过调用DAO方法,结合PO,VO进行业务操作。

* ==POJO(plain ordinary java object) 简单无规则java对象==
  纯的传统意义的java对象。就是说在一些Object/Relation Mapping工具中，能够做到维护数据库表记录的persisent object完全是一个符合Java Bean规范的纯Java对象，没有增加别的属性和方法。我的理解就是最基本的Java Bean，只有属性字段及setter和getter方法！。

* ==DAO(data access object) 数据访问对象==
  是一个sun的一个标准j2ee设计模式，这个模式中有个接口就是DAO，它负持久层的操作。为业务层提供接口。此对象用于访问数据库。通常和PO结合使用，DAO中包含了各种数据库的操作方法。通过它的方法,结合PO对数据库进行相关的操作。夹在业务逻辑与数据库资源中间。配合VO, 提供数据库的CRUD操作...

* ==O/R Mapper 对象/关系 映射==
  定义好所有的mapping之后，这个O/R Mapper可以帮我们做很多的工作。通过这些mappings,这个O/R Mapper可以生成所有的关于对象保存，删除，读取的SQL语句，我们不再需要写那么多行的DAL代码了。
* ==DTO (Data Transfer Object)数据传输对象==
  主要用于远程调用等需要大量传输对象的地方。
  比如我们一张表有100个字段，那么对应的PO就有100个属性。
  但是我们界面上只要显示10个字段，
  客户端用WEB service来获取数据，没有必要把整个PO对象传递到客户端，
  这时我们就可以用只有这10个属性的DTO来传递结果到客户端，这样也不会暴露服务端表结构.到达客户端以后，如果用这个对象来对应界面显示，那此时它的身份就转为VO

统一最后的结果

```java
package com.mszlu.blog.vo;

import com.mszlu.blog.dao.pojo.Article;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Result {

    private boolean success;

    private Integer code;

    private String msg;

    private Object data;


    public static Result success(Object data) {
        return new Result(true,200,"success",data);
    }
    public static Result fail(Integer code, String msg) {
        return new Result(false,code,msg,null);
    }
}


```

==建立与前端交互的Vo文件==

```java
@Data
public class ArticleVo {

    private Long id;

    private String title;

    private String summary;

    private int commentCounts;

    private int viewCounts;

    private int weight;
    /**
     * 创建时间
     */
    private String createDate;

    private String author;

    private ArticleBodyVo body;

    private List<TagVo> tags;

    private List<CategoryVo> categorys;

}


```

### 2.2.3 Service

**service层主要是写业务逻辑方法，service层经常要调用dao层（也叫mapper层）的方法对数据进行增删改查的操作。***

## 2.2.3.0 解决mapper爆红

建立service接口

```java
package com.mszlu.blog.service;

import com.mszlu.blog.vo.Archive;
import com.mszlu.blog.vo.ArticleVo;
import com.mszlu.blog.vo.params.PageParams;

import java.util.List;

public interface ArticleService {

    /**
     * 分页查询文章列表
     * @param pageParams
     * @return
     */

    List<ArticleVo> listArticlesPage(PageParams pageParams);

}


```

建立service接口的实现类

```java
package com.mszlu.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mszlu.blog.dao.ArticleMapper;
import com.mszlu.blog.dao.SysUserMapper;
import com.mszlu.blog.dao.pojo.Article;
import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.dao.pojo.Tag;
import com.mszlu.blog.service.ArticleService;
import com.mszlu.blog.service.SysUserService;
import com.mszlu.blog.service.TagsService;
import com.mszlu.blog.vo.ArticleBodyVo;
import com.mszlu.blog.vo.ArticleVo;
import com.mszlu.blog.vo.TagVo;
import com.mszlu.blog.vo.params.PageParams;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private TagService tagService;

    @Autowired
    private SysUserService sysUserService;

    @Override
    public Result listArticle(PageParams pageParams) {
        /**
         * 1、分页查询article数据库表
         */
        Page<Article> page = new Page<>(pageParams.getPage(), pageParams.getPageSize());
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        //是否置顶进行排序,        //时间倒序进行排列相当于order by create_data desc
        queryWrapper.orderByDesc(Article::getWeight,Article::getCreateDate);
        Page<Article> articlePage = articleMapper.selectPage(page, queryWrapper);
        //分页查询用法 https://blog.csdn.net/weixin_41010294/article/details/105726879
        List<Article> records = articlePage.getRecords();
        // 要返回我们定义的vo数据，就是对应的前端数据，不应该只返回现在的数据需要进一步进行处理
        List<ArticleVo> articleVoList =copyList(records,true,true);
        return Result.success(articleVoList);
    }

    private List<ArticleVo> copyList(List<Article> records,boolean isTag,boolean isAuthor) {

        List<ArticleVo> articleVoList = new ArrayList<>();

        for (Article record : records) {
            articleVoList.add(copy(record,isTag,isAuthor));
        }
        return articleVoList;

    }

    //"eop的作用是对应copyList，集合之间的copy分解成集合元素之间的copy
    private ArticleVo copy(Article article,boolean isTag,boolean isAuthor){
        ArticleVo articleVo = new ArticleVo();
        //BeanUtils.copyProperties用法   https://blog.csdn.net/Mr_linjw/article/details/50236279
        BeanUtils.copyProperties(article, articleVo);
        articleVo.setCreateDate(new DateTime(article.getCreateDate()).toString("yyyy-MM-dd HH:mm"));
        //并不是所有的接口都需要标签和作者信息
        if(isTag){
            Long articleId = article.getId();
            articleVo.setTags(tagService.findTagsByArticleId(articleId));
        }
        if (isAuthor) {
            //拿到作者id
            Long authorId = article.getAuthorId();

            articleVo.setAuthor(sysUserService.findUserById(authorId).getNickname());
        }
        return articleVo;

    }
}


```

`BeanUtils.copyProperties(article, articleVo);`:

> 上面的这个工具类是spring提供的用于两个具有很多相同属性的JavaBean之间的赋值
>
> **但是有几点我们需要注意：**
>
> BeanUtils.copyProperties(a, b);
>
> * ==b中的存在的属性，a中一定要有，但是a中可以有多余的属性==；
> * a中与b中==相同的属性都会被替换==，不管是否有值；
> * a、 b中的==属性要名字相同==，才能被赋值，不然的话需要手动赋值；
> * Spring的BeanUtils的CopyProperties方法需要对应的==属性有getter和setter方法==；
> * 如果存在属性完全相同的内部类，但是不是同一个内部类，即分别属于各自的内部类，则spring会认为==属性不同，不会copy==；
> * ==spring和apache的copy属性的方法源和目的参数的位置正好相反==，所以导包和调用的时候都要注意一下。

建立用户的service接口

```java
package com.mszlu.blog.service;
import com.mszlu.blog.dao.pojo.SysUser;
public interface UserService {
    SysUser findUserById(Long userId);
}
```

建立用户的service接口实现类

```
package com.mszlu.blog.service.impl;

import com.mszlu.blog.dao.SysUserMapper;
import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public SysUser findUserById(Long id) {
        //根据id查询
        //为防止sysUser为空增加一个判断
        SysUser sysUser = sysUserMapper.selectById(id);
        if (sysUser == null){
            sysUser = new SysUser();
            sysUser.setNickname("码神之路");
        }
        return sysUser;
    }
}


```

## 2.2.3.1mybatisplus遇到多表查询怎么办

TagMapper的建立中遇到这个问题了，办法是在建立到TagMapper后需要建立xml文件进行读写 xml文件放到resource文件夹下 文件夹名和xml文件名必须和TagMapper.java文件夹保持一致 <img src="https://img-blog.csdnimg.cn/af3eab062ffa4da3b9ed70c395286ad3.png" alt="在这里插入图片描述">

<img src="https://img-blog.csdnimg.cn/a9e8bd190451491fb200164568abfdd7.png" alt="在这里插入图片描述">

## 2.2.3.2创建文件夹时遇到的坑

使用IntelliJ IDEA创建多级文件夹时，文件夹名为com.immer.monitor.persistence 和 com/immer/monitor/persistence 均会显示为如下图所示

<img src="https://img-blog.csdnimg.cn/012a9edbeba84c0e904e8af06de2ea53.png" alt="在这里插入图片描述">

但实际结构确实截然不同 ==com.immer.monitor.persistence 是单个文件夹==== 而 ==com/immer/monitor/persistence 是一个文件夹嵌套==

会导致资源文件not found 的问题，而且很难排查得到 要不会显示找不到文件夹路径的问题，因为我们要保证mapper.xml要和mapper的文件夹和路径保持一致



建立标签的service接口

```
package com.mszlu.blog.service;

import com.mszlu.blog.dao.pojo.Tag;
import com.mszlu.blog.vo.TagVo;

import java.util.List;

public interface TagsService {


    List<TagVo> findTagsByArticleId(Long id);
}


```

建立tag的service接口的实现类

```
package com.mszlu.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.dao.TagMapper;
import com.mszlu.blog.dao.pojo.Tag;
import com.mszlu.blog.service.TagsService;
import com.mszlu.blog.vo.TagVo;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class TagsServiceImpl implements TagsService {
    @Autowired
    private TagMapper tagMapper;

    /**
     * ms_article_tag是文章和标签的关联表
     * ms_tag为单纯的标签的表
     * @param articleId
     * @return
     */

    @Override
    public List<TagVo> findTagsByArticleId(Long articleId) {
        //mybatisplus无法进行多表查询
        List<Tag> tags = tagMapper.findTagsByArticleId(articleId);
        return copyList(tags);
    }

    private List<TagVo> copyList(List<Tag> tagList) {
        List<TagVo> tagVoList = new ArrayList<>();
        for (Tag tag : tagList) {
            tagVoList.add(copy(tag));
        }
        return tagVoList;

    }

    private TagVo copy(Tag tag) {
        TagVo tagVo = new TagVo();
        BeanUtils.copyProperties(tag, tagVo);
        return tagVo;
    }
}


```

### 2.2.4 Dao层

**mapper层=dao层**，现在用mybatis逆向工程生成的mapper层，其实就是dao层。 dao层对数据库进行数据持久化操作，他的方法语句是直接针对数据库操作的，而service层是针对我们controller，也就是针对我们使用者。service的impl是把mapper和service进行整合的文件。

**dao层和service层关系**：service层经常要调用dao层的方法对数据进行增删改查的操作，现实开发中，对业务的操作会涉及到数据的操作，而对数据操作常常要用到数据库，所以service层会经常调用dao层的方法。

文章的dao层 由于我们直接继承了mybatisplus的BaseMapper所以基本的增删改查都不用再写了。

```
package com.mszlu.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.Article;
import com.mszlu.blog.vo.ArticleVo;

import java.util.List;

public interface ArticleMapper extends BaseMapper<Article> {
	
}


```

标签的dao层

```
package com.mszlu.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.Tag;

import java.util.List;

public interface TagMapper extends BaseMapper<Tag> {

    List<Tag> findTagsByArticleId(Long articleId);
}


```

作者的dao层

```
package com.mszlu.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.SysUser;

public interface SysUserMapper extends BaseMapper<SysUser> {
}


```

这就是上文提到的mybatisplus遇到多表查询怎么办，我们需要建立自己的xml文件进行联合查询操作 <img src="https://img-blog.csdnimg.cn/746f8eb6eb7a41fe879444adbe05afea.png" alt="在这里插入图片描述">

在mapper文件中 利用mapperX插件我们可以创建 方法名为select的命令

```
    <select id="findTagsByArticleId" resultType="com.mszlu.blog.dao.pojo.Tag"></select>

```

总的xml文件如下所示

```
<?xml version="1.0" encoding="UTF-8" ?>
<!--MyBatis配置文件-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.mszlu.blog.dao.mapper.TagMapper">

    <sql id="all">
        id,avatar,tag_name as tagName
    </sql>

<!--        List<Tag> findTagsByArticleId(Long articleId);
在这个文件中，id代表方法名，parameterType表示输入变量的名字，resultType表示泛型的类型-->

    <select id="findTagsByArticleId" parameterType="long" resultType="com.mszlu.blog.dao.pojo.Tag">
        select  id,avatar,tag_name as tagName from ms_tag
        where id in (select tag_id from ms_article_tag where article_id=#{articleId})
    </select>
</mapper>

```

### 2.2.5 测试

<img src="https://img-blog.csdnimg.cn/937739ee77074de7ab0ee5f8fedeffdb.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 3. 首页-最热标签

## 3.1 接口说明

接口url：/tags/hot

请求方式：GET

请求参数：无

id 标签名称 我们期望点击标签关于文章的所有列表都显示出来

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id":1,
            "tagName":"4444"
        }
    ]
}
```

## 3.2 编码

### 3.2.1 Controller

```java
package com.mszlu.blog.api;

import com.mszlu.blog.service.ArticleService;
import com.mszlu.blog.service.TagsService;
import com.mszlu.blog.vo.Archive;
import com.mszlu.blog.vo.ArticleVo;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.TagVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//@RestController代表我们返回的是json数据,@RequestMapping("tags")表示路径映射
@RestController
@RequestMapping("tags")
public class TagsController {

    @Autowired
    private TagService tagService;

    // 路径 tags/hot
    @GetMapping("hot")
    public Result hot(){
        int limit =6;
        return  tagService.hots(limit);
    }
}

```

vo表示后端与前端交互的数据

```java
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class TagVo {

    private Long id;

    private String tagName;
}


```

### 3.2.2 Service

建立service接口

```
package com.mszlu.blog.service;

import com.mszlu.blog.vo.TagVo;

import java.util.List;

public interface TagsService {

    Result hots(int limit);

}


```

建立serviceimpl实现类

```java
package com.mszlu.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.dao.TagMapper;
import com.mszlu.blog.dao.pojo.Tag;
import com.mszlu.blog.service.TagsService;
import com.mszlu.blog.vo.TagVo;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class TagsServiceImpl implements TagsService {
    @Autowired
    private TagMapper tagMapper;

     @Override
    public Result hots(int limit) {
        /**
         * 最热标签就是对标签ms_article_tag中的tag_id进行排序数量最多的就是我们的最热标签
         * 1、标签所拥有的文章数量最多就是最热标签
         * 2、查询 根据tag_id分组计数，从大到小排列取前limit个
         */
        List<Long> tagIds = tagMapper.findHotsTagIds(limit);
        //因为id in（1,2,3） 里面不能为空所以我们需要进行判断
        //  CollectionUtils.isEmpty作用 https://blog.csdn.net/qq_42848910/article/details/105717235
        if(CollectionUtils.isEmpty(tagIds)){
            return Result.success(Collections.emptyList());
        }
        //需求的是tagId 和tagName Tag对象
        //我们的sql语句类似于select * from tag where id in (1,2,3)
        List<Tag> tagList = tagMapper.findTagsByTagIds(tagIds);
        return Result.success(tagList);
    }


}

```

### 3.2.3 Dao

TagMapper.java

```
package com.mszlu.blog.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.Tag;

import java.util.List;

public interface TagMapper extends BaseMapper<Tag> {

    /**
     * 查询最热的标签前n条
     * @param limit
     * @return
     */
    List<Long> findHotsTagIds(int limit);

    List<Tag> findTagsByTagIds(List<Long> tagIds);
}


```

TagMapper.xml文件 一定要了解所有表的业务逻辑，知道自己要返回什么值再进行操作 我们通过findHotsTagIds这个方法在ms_article_tag表中找到了tag_id <img src="https://img-blog.csdnimg.cn/c8bd6331b3614f7e844f95066a68318e.png" alt="在这里插入图片描述"> 然后多表查询，tag_id就是ms_tag表中的id我们在findHotsTagIds这个方法中找到了我们想要的前两条id，然后再利用动态mysql这个方法将id，tagName两个选项选择出来。多写多看基本上可以成为一个合格的crud工程师 <img src="https://img-blog.csdnimg.cn/c8b18849666a4e9a83d5afb73d944d1b.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_12,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

```
<?xml version="1.0" encoding="UTF-8" ?>
<!--MyBatis配置文件-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.mszlu.blog.dao.TagMapper">

<!--    List<Long> findHotsTagIds(int limit);-->
<!--    parameterType="int"是自己加的因为不会自动生成我们输入的标签,#{limit}为我们自己传的参数-->
<!--  GROUP by 用法  https://www.runoob.com/sql/sql-groupby.html-->
<!--    sql语句的意思是在ms_article_tag表中查找tag_id，根据tag_id将其聚合在一起，再根据count（*）的数量以递减的顺序排序最后限制输出两条数据-->
    <select id="findHotsTagIds" parameterType="int" resultType="java.lang.Long">
        select tag_id from ms_article_tag GROUP BY tag_id ORDER BY count(*) DESC LIMIT #{limit}
    </select>
<!--    List<Tag> findTagsByTagIds(List<Long> tagIds);因为输入的类型是list所以parameterType的值是list-->
<!--    foreach用法 https://www.cnblogs.com/fnlingnzb-learner/p/10566452.html
            相当于for循环找传进来的一个id集合，每个id通过sql语句找到对应的tag对象-->
    <select id="findTagsByTagIds" parameterType="list" resultType="com.mszlu.blog.dao.pojo.Tag">
        select id,tag_name as tagName from ms_tag
        where  id in
        <foreach collection="tagIds" item="tagId" separator="," open="(" close=")">
            #{tagId}
        </foreach>
    </select>

</mapper>

```

### 3.2.4 测试

最热标签显示出来 <img src="https://img-blog.csdnimg.cn/e8695ffe43854fc8a8252fc404eb8dc8.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_19,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 4.1. 统一异常处理

不管是controller层还是service，dao层，都有可能报异常，如果是预料中的异常，可以直接捕获处理，如果是意料之外的异常，需要统一进行处理，进行记录，并给用户提示相对比较友好的信息。

```java
package com.mszlu.blog.handler;

import com.mszlu.blog.vo.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

//对加了@controller注解的方法进行拦截处理 Aop的实现
@ControllerAdvice
public class AllExceptionHandler {

    //进行异常处理，处理Exception.class的异常
    @ExceptionHandler(Exception.class)
    @ResponseBody //返回json数据如果不加就返回页面了
    public Result doException(Exception ex) {
        //e.printStackTrace();是打印异常的堆栈信息，指明错误原因，
        // 其实当发生异常时，通常要处理异常，这是编程的好习惯，所以e.printStackTrace()可以方便你调试程序！
        ex.printStackTrace();
        return Result.fail(-999,"系统异常");

    }
}
```

<img src="https://img-blog.csdnimg.cn/a7ffc2c8842f493497a22c025d27d837.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 4.2. 首页-最热文章

在ms_article表中的view_counts表示浏览数量，越多表示越火热 <img src="https://img-blog.csdnimg.cn/f6d1555209ff4628b043d13e88f31d4a.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

## 4.2.1 接口说明

接口url：/articles/hot

请求方式：POST

请求参数：

|参数名称|参数类型|说明
|------|-----------|-------------|

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id": 1,
            "title": "springboot介绍以及入门案例",
        },
        {
            "id": 9,
            "title": "Vue.js 是什么",
        },
        {
            "id": 10,
            "title": "Element相关",
            
        }
    ]
}

```

## 4.2.2 Controller

ArticleController.java

```java
    /**
     * 首页最热文章
     * @return
     */
@PostMapping("hot")
    public Result hotArticle(){
        int limit = 5;
        return articleService.hotArticle(limit);
    }

```

## 4.2.3 Service

src/main/java/com/mszlu/blog/service/ArticleService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.PageParams;

/**
 * @Author ljm
 * @Date 2021/10/11 10:30
 * @Version 1.0
 */
public interface ArticleService {

    /**
     * 分页查询文章列表
     * @param pageParams
     * @return
     */
    Result listArticle(PageParams pageParams);

    /**
     * 最热文章
     * @param limit
     * @return
     */
    Result hotArticle(int limit);
}


```

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java
    @Override
    public Result hotArticle(int limit) {
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.orderByDesc(Article::getViewCounts);
        queryWrapper.select(Article::getId,Article::getTitle);
        //"limit"字待串后要加空格，不要忘记加空格，不然会把数据拼到一起
        queryWrapper.last("limit "+limit);
        //select id,title from article order by view_counts desc limt 5
        List<Article> articles = articleMapper.selectList(queryWrapper);

        //返回vo对象
        return Result.success(copyList(articles,false,false));
    }

```

## 4.2.4 测试

<img src="https://img-blog.csdnimg.cn/139dbd5acc69437281fb8df373741291.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_15,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 4.3. 首页-最新文章

和最热文章非常类似，一个是根据浏览量来选择，一个是根据最新创建时间来选择

## 4.3.1 接口说明

接口url：/articles/new

请求方式：POST

请求参数：

| 参数名称 | 参数类型 | 说明 |
| -------- | -------- | ---- |
|          |          |      |

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id": 1,
            "title": "springboot介绍以及入门案例",
        },
        {
            "id": 9,
            "title": "Vue.js 是什么",
        },
        {
            "id": 10,
            "title": "Element相关",
            
        }
    ]
}

```

## 4.3.1 Controller

```java
 /**
     * 首页 最新文章
     * @return
     */
    @PostMapping("new")
    public Result newArticles(){
        int limit = 5;
        return articleService.newArticles(limit);
    }

```

## 4.3.2 Service

src/main/java/com/mszlu/blog/service/ArticleService.java

```java
    /**
     * 最新文章
     * @param limit
     * @return
     */
    Result newArticles(int limit);

```

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java

@Override
    public Result newArticles(int limit) {
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.orderByDesc(Article::getCreateDate);
        queryWrapper.select(Article::getId,Article::getTitle);
        queryWrapper.last("limit "+limit);
        //select id,title from article order by create_date desc limit 5
        List<Article> articles = articleMapper.selectList(queryWrapper);

        return Result.success(copyList(articles,false,false));
    }

```

# 4.4. 首页-文章归档

每一篇文章根据创建时间某年某月发表多少篇文章

## 4.4.1接口说明

接口url：/articles/listArchives

请求方式：POST

请求参数：

| 参数名称 | 参数类型 | 说明 |
| -------- | -------- | ---- |
|          |          |      |

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "year": "2021",
            "month": "6",
            "count": 2
        }
            
    ]
}
```

```sql
select year(create_date) as year,month(create_date) as month,count(*) as count from ms_article group by year,month
```

但是 p9 up主给的sql里面create_date 为bigint 13位，直接year()不行，需要先转date型后year()。

```sql
select year(FROM_UNIXTIME(create_date/1000)) year,month(FROM_UNIXTIME(create_date/1000)) month, count(*) count from ms_article group by year,month;
```

这样才能查出来结果

## 4.4.1 Controller

src/main/java/com/mszlu/blog/controller/ArticleController.java

```java
  /**
     * 首页 文章归档
     * @return
     */
    @PostMapping("listArchives")
    public Result listArchives(){
        return articleService.listArchives();
    }

```

下面这个是在src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java中使用的返回值

```java
package com.mszlu.blog.dao.dos;

import lombok.Data;

/**
 * @Author ljm
 * @Date 2021/10/12 17:19
 * @Version 1.0
 * do 对象 数据库 查询出来的对象但是不需要持久化，由于do是关键字所以加了个s成为dos
 */
@Data
public class Archives {

    private Integer year;

    private Integer month;

    private Long count;
}


```

## 4.4.2 Service

src/main/java/com/mszlu/blog/service/ArticleService.java

```java
    /**
     * 文章归档
     * @return
     */
    Result listArchives();


```

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java
@Override
public Result listArchives() {
        /*
        文章归档
         */
    List<Archives> archivesList = articleMapper.listArchives();
    return Result.success(archivesList);
}

```

## 4.4.3 Dao

src/main/java/com/mszlu/blog/dao/mapper/ArticleMapper.java

```java
package com.mszlu.blog.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.Article;

import java.util.List;
import java.util.Map;

public interface ArticleMapper extends BaseMapper<Article> {

  List<Archives> listArchives();

}


```

src/main/resources/com/mszlu/blog/dao/mapper/ArticleMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!--MyBatis配置文件-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--创立ArticleMapper.xml文件后再利用mybatisX一键生成select语句-->
<mapper namespace="com.mszlu.blog.dao.mapper.ArticleMapper">


    <select id="listArchives" resultType="com.mszlu.blog.dao.dos.Archives">
        select year(FROM_UNIXTIME(create_date/1000)) as year,month(FROM_UNIXTIME(create_date/1000)) as month, count(*) as count from ms_article
        group by year,month
    </select>

</mapper>

```

## 4.4.4 测试

<img src="https://img-blog.csdnimg.cn/bc18c928a8d24021906d4e235cca0275.png" alt="在这里插入图片描述">

注意：前端工程 需使用当天资料下的app

# 5.1. 登录

## 5.1.1 接口说明

接口url：/login

请求方式：==POST==

请求参数：

|参数名称|参数类型|说明|
|------|------|------|
|account|string|账号|
|password|string|密码|

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": "token"
}
```

## 5.1.2 JWT

==登录使用JWT技术。==

jwt 可以生成 一个加密的token，做为用户登录的令牌，当用户登录成功之后，发放给客户端。

请求需要登录的资源或者接口的时候，将token携带，后端验证token是否合法。

jwt 有三部分组成：A.B.C

==A：==Header，{“type”:“JWT”,“alg”:“HS256”} 固定

==B：==playload，存放信息，比如，用户id，过期时间等等，可以被解密，不能存放敏感信息

==C  :== 签证，A和B加上秘钥 加密而成，只要秘钥不丢失，可以认为是安全的。

jwt 验证，<font  color='orange'>主要就是验证C部分 是否合法</font>。

<font  color='red'>导入依赖包</font>

依赖包:

```xml
<dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt</artifactId>
    <version>0.9.1</version>
</dependency>
```

src/main/java/com/mszlu/blog/utils/JWTUtils.java 工具类:

```java
package com.mszlu.blog.utils;

import io.jsonwebtoken.Jwt;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JWTUtils {

    private static final String jwtToken = "123456Mszlu!@#$$";

    public static String createToken(Long userId){
        Map<String,Object> claims = new HashMap<>();
        claims.put("userId",userId);
        JwtBuilder jwtBuilder = Jwts.builder()
                .signWith(SignatureAlgorithm.HS256, jwtToken) // 签发算法，秘钥为jwtToken
                .setClaims(claims) // body数据，要唯一，自行设置
                .setIssuedAt(new Date()) // 设置签发时间
                .setExpiration(new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000));// 一天的有效时间
        String token = jwtBuilder.compact();
        return token;
    }

    public static Map<String, Object> checkToken(String token){
        try {
            Jwt parse = Jwts.parser().setSigningKey(jwtToken).parse(token);
            return (Map<String, Object>) parse.getBody();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
```

## 5.1.3 Controller

src/main/java/com/mszlu/blog/controller/LoginController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("login")
public class LoginController {

    @Autowired
    private LoginService loginService;
    //@RequestBody,@ResponseBody的用法 和理解 https://blog.csdn.net/zhanglf02/article/details/78470219
    //浅谈@RequestMapping @ResponseBody 和 @RequestBody 注解的用法与区别
//https://blog.csdn.net/ff906317011/article/details/78552426?utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.no_search_link&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.no_search_link
//@RequestBody主要用来接收前端传递给后端的json字符串中的数据的(请求体中的数据的)；而最常用的使用请求体传参的无疑是POST请求了，所以使用@RequestBody接收数据时，一般都用POST方式进行提交。

    @PostMapping
    public Result login(@RequestBody LoginParam loginParam){
        //登陆 验证用户 访问用户表
        return loginService.login(loginParam);

    }
}


```

构造LoginParam也就是我们的请求数据 src/main/java/com/mszlu/blog/vo/params/LoginParam.java

```java
package com.mszlu.blog.vo.params;

import lombok.Data;

/**
 * @Author ljm
 * @Date 2021/10/12 20:06
 * @Version 1.0
 */
@Data
public class LoginParam {
    private String account;

    private String password;
}


```

## 5.1.4 Service

src/main/java/com/mszlu/blog/service/LoginService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;

public interface LoginService {
    /**
     * 登录
     * @param loginParam
     * @return
     */
    Result login(LoginParam loginParam);
}


```

导入依赖包 md5加密的依赖包：

```xml
<dependency>
    <groupId>commons-codec</groupId>
    <artifactId>commons-codec</artifactId>
</dependency>
```

src/main/java/com/mszlu/blog/service/impl/LoginServiceImpl.java

```java
package com.mszlu.blog.service.impl;

import com.alibaba.fastjson.JSON;
import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.service.SysUserService;
import com.mszlu.blog.utils.JWTUtils;
import com.mszlu.blog.vo.ErrorCode;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;
//Spring 自动扫描组件// https://blog.csdn.net/u010002184/article/details/72870065
// @Component – 指示自动扫描组件。
//@Repository – 表示在持久层DAO组件。
//@Service – 表示在业务层服务组件。
//@Controller – 表示在表示层控制器组件。
@Service
public class LoginServiceImpl implements LoginService {

	//加密盐用于加密
    private static final String slat = "mszlu!@#";
    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Override
    public Result login(LoginParam loginParam) {
            /**
         * 1. 检查参数是否合法
         * 2. 根据用户名和密码去user表中查询 是否存在
         * 3. 如果不存在 登录失败
         * 4. 如果存在 ，使用jwt 生成token 返回给前端
         * 5. token放入redis当中，redis  token：user信息 设置过期时间
         *  (登录认证的时候 先认证token字符串是否合法，去redis认证是否存在)
         */
        String account = loginParam.getAccount();
        String password = loginParam.getPassword();
        if (StringUtils.isBlank(account) || StringUtils.isBlank(password)){
            return Result.fail(ErrorCode.PARAMS_ERROR.getCode(),ErrorCode.PARAMS_ERROR.getMsg());
        }
        String pwd = DigestUtils.md5Hex(password + slat);
        SysUser sysUser = sysUserService.findUser(account,pwd);
        if (sysUser == null){
            return Result.fail(ErrorCode.ACCOUNT_PWD_NOT_EXIST.getCode(),ErrorCode.ACCOUNT_PWD_NOT_EXIST.getMsg());
        }
        //登录成功，使用JWT生成token，返回token和redis中
        String token = JWTUtils.createToken(sysUser.getId());
        // JSON.toJSONString 用法    https://blog.csdn.net/antony9118/article/details/71023009
        //过期时间是一百天
        //redisTemplate用法  https://blog.csdn.net/lydms/article/details/105224210 
        redisTemplate.opsForValue().set("TOKEN_"+token, JSON.toJSONString(sysUser),100, TimeUnit.DAYS);
        return Result.success(token);
    }

//生成我们想要的密码，放于数据库用于登陆
    public static void main(String[] args) {
        System.out.println(DigestUtils.md5Hex("admin"+slat));
    }
}


```

src/main/java/com/mszlu/blog/service/impl/SysUserServiceImpl.java

```
   @Override
    public SysUser findUser(String account, String password) {
        LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SysUser::getAccount,account);
        queryWrapper.eq(SysUser::getPassword,password);
        //account id 头像 名称
        queryWrapper.select(SysUser::getAccount,SysUser::getId,SysUser::getAdmin,SysUser::getNickname);
        //增加查询效率，只查询一条
        queryWrapper.last("limit 1");

        return sysUserMapper.selectOne(queryWrapper);
    }

```

src/main/java/com/mszlu/blog/service/SysUserService.java

```
    SysUser findUser(String account, String pwd);

```

## 5.1.5 登录参数，redis配置，统一错误码

src/main/resources/application.properties

```
spring.redis.host=localhost
spring.redis.port=6379

```

src/main/java/com/mszlu/blog/vo/ErrorCode.java

```java
package com.mszlu.blog.vo;

public enum  ErrorCode {

    PARAMS_ERROR(10001,"参数有误"),
    ACCOUNT_PWD_NOT_EXIST(10002,"用户名或密码不存在"),
    NO_PERMISSION(70001,"无访问权限"),
    SESSION_TIME_OUT(90001,"会话超时"),
    NO_LOGIN(90002,"未登录"),;

    private int code;
    private String msg;

    ErrorCode(int code, String msg){
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}


```

## 5.1.6 测试

使用postman测试，因为登录后，需要跳转页面，进行token认证，有接口未写，前端会出现问题。

token前端获取到之后，会存储在 storage中 h5 ，本地存储

postman <img src="https://img-blog.csdnimg.cn/2260e7b6a61849aca769c8ac09c12942.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">redis查看 <img src="https://img-blog.csdnimg.cn/f4848f105e9d46ac819b98d7ac6fa13d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 5.2. 获取用户信息

为什么实现完获取用户信息才能登陆测试呢？

token前端获取到之后，会存储在 storage中 h5 ，本地存储，存储好后，拿到storage中的token去获取用户信息，如果这个接口没实现，他就会一直请求陷入死循环

## 5.2.1 接口说明

得从http的head里面拿到这个参数，这样传参相对来说安全一些， 返回是数据是我们用户相关的数据，id，账号、昵称和头像

接口url：/users/currentUser

请求方式：GET

请求参数：

| 参数名称 | 参数类型 | 说明 |
| ------ | ------ | ------ |
| Authorization | string | 头部信息(TOKEN) |



返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": {
        "id":1,
        "account":"1",
        "nickaname":"1",
        "avatar":"ss"
    }
}

```

## 5.2.2 Controller

src/main/java/com/mszlu/blog/controller/UsersController.java

```
package com.mszlu.blog.controller;

import com.mszlu.blog.service.SysUserService;
import com.mszlu.blog.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

//浅谈@RequestMapping @ResponseBody 和 @RequestBody 注解的用法与区别
//https://blog.csdn.net/ff906317011/article/details/78552426?utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.no_search_link&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.no_search_link
//@RequestBody主要用来接收前端传递给后端的json字符串中的数据的(请求体中的数据的)；而最常用的使用请求体传参的无疑是POST请求了，所以使用@RequestBody接收数据时，一般都用POST方式进行提交。
@RestController
@RequestMapping("users")
public class UserController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("currentUser")
    public Result currentUser(@RequestHeader("Authorization") String token){

        return sysUserService.findUserByToken(token);
    }
}


```

## 5.2.3 Service

src/main/java/com/mszlu/blog/service/SysUserService.java

```java
    /**
     * 根据token查询用户信息
     * @param token
     * @return
     */
 Result findUserByToken(String token);

```

src/main/java/com/mszlu/blog/service/impl/SysUserServiceImpl.java

```java
//这个爆红只需要在对应的mapper上加上@Repository,让spring识别到即可解决爆红的问题
@Autowired
private SysUserMapper sysUserMapper;
@Autowired
private LoginService loginService;
@Override
public Result findUserByToken(String token) {
    /**
         * 1、token合法性校验
         * 是否为空 ，解析是否成功，redis是否存在
         * 2、如果校验失败，返回错误
         *3、如果成功，返回对应结果 LoginUserVo
         */

    //去loginservice中去校验token
    SysUser sysUser = loginService.checkToken(token);
    if(sysUser == null){
        return Result.fail(ErrorCode.TOKEN_ERROR.getCode(),ErrorCode.TOKEN_ERROR.getMsg());
    }
    LoginUserVo loginUserVo = new LoginUserVo();
    loginUserVo.setId(sysUser.getId());
    loginUserVo.setNickname(sysUser.getNickname());
    loginUserVo.setAvatar(sysUser.getAvatar());
    loginUserVo.setAccount(sysUser.getAccount());
    return Result.success(loginUserVo);

}

```

src/main/java/com/mszlu/blog/service/LoginService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;

/**
 * @Author ljm
 * @Date 2021/10/12 20:04
 * @Version 1.0
 */
public interface LoginService {
    /**
     * 登陆功能
     * @param loginParam
     * @return
     */
    Result login(LoginParam loginParam);

    SysUser checkToken(String token);
}


```

src/main/java/com/mszlu/blog/service/impl/LoginServiceImpl.java

```java
    @Override
    public SysUser checkToken(String token) {
        //token为空返回null
        if(StringUtils.isBlank(token)){
            return null;
        }
        Map<String, Object> stringObjectMap = JWTUtils.checkToken(token);
        //解析失败
        if(stringObjectMap ==null){
            return null;
        }
        //如果成功
        String userJson =  redisTemplate.opsForValue().get("TOKEN_"+token);
        if (StringUtils.isBlank(userJson)) {
            return null;
        }
        //解析回sysUser对象
        SysUser sysUser = JSON.parseObject(userJson, SysUser.class);
        return sysUser;
    }

```

## 5.2.4 LoginUserVo

src/main/java/com/mszlu/blog/vo/LoginUserVo.java

```java
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class LoginUserVo {
	//与页面交互

    private Long id;

    private String account;

    private String nickname;

    private String avatar;
}


```

5.2.5 测试

# 5.3. 退出登录

登陆一个的对token进行认证，一个是在redis中进行注册，token字符串没法更改掉，只能由前端进行清除，后端能做的就是把redis进行清除

## 5.3.1 接口说明

接口url：/logout

请求方式：GET

请求参数：

| 参数名称 | 参数类型 | 说明 |
|------ |------ | ------ |
| Authorization | string | 头部信息(TOKEN) |



返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": null
}

```

## 5.3.2 Controller

src/main/java/com/mszlu/blog/controller/LogoutController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("logout")
public class LogoutController {

    @Autowired
    private LoginService loginService;

//获取头部信息这样一个参数
    @GetMapping
    public Result logout(@RequestHeader("Authorization") String token){
        return loginService.logout(token);
    }
}


```

## 5.3.3 Service

src/main/java/com/mszlu/blog/service/LoginService.java

```java
    /**
     * 退出登陆
     * @param token
     * @return
     */
    Result logout(String token);

```

src/main/java/com/mszlu/blog/service/impl/LoginServiceImpl.java

```java
  @Override
    public Result logout(String token) {
    //后端直接删除redis中的token
        redisTemplate.delete("TOKEN_"+token);
        return Result.success(null);
    }

```

## 5.3.4 测试

# 6.1. 注册

## 6.1.1 接口说明

接口url：/register

请求方式：POST ==post传参意味着请求参数是按照json方式传== 

请求参数：

|参数名称|参数类型|说明 |
|:----: |:----: |:----: |
|account|string|账号 |
|password|string|密码 |
|nickname|string|昵称 |

返回数据：

```java
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": "token"
}
```

## 6.1.2 Controller

src/main/java/com/mszlu/blog/controller/RegisterController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("register")
public class RegisterController {

    @Autowired
    private LoginService loginService;
    
//后端传递多个参数，前端只选用其需要的参数就可以了
    @PostMapping
    public Result register(@RequestBody LoginParam loginParam){
    //sso 单点登录，后期如果把登录注册功能 提出去（单独的服务，可以独立提供接口服务）
        return loginService.register(loginParam);
    }
}


```

参数LoginParam中 添加新的参数nickname。 src/main/java/com/mszlu/blog/vo/params/LoginParam.java

```java
package com.mszlu.blog.vo.params;

import lombok.Data;

@Data
public class LoginParam {

    private String account;

    private String password;

    private String nickname;
}


```

## 6.1.3 Service

src/main/java/com/mszlu/blog/service/impl/LoginServiceImpl.java

```java
 @Override
    public Result register(LoginParam loginParam) {
            /**
         * 1. 判断参数 是否合法
         * 2. 判断账户是否存在，存在 返回账户已经被注册
         * 3. 不存在，注册用户
         * 4. 生成token
         * 5. 存入redis 并返回
         * 6. 注意 加上事务，一旦中间的任何过程出现问题，注册的用户 需要回滚
         */
         String account = loginParam.getAccount();
        String password = loginParam.getPassword();
        String nickname = loginParam.getNickname();
        if (StringUtils.isBlank(account)
                || StringUtils.isBlank(password)
                || StringUtils.isBlank(nickname)
        ){
            return Result.fail(ErrorCode.PARAMS_ERROR.getCode(),ErrorCode.PARAMS_ERROR.getMsg());
        }
        SysUser sysUser = this.sysUserService.findUserByAccount(account);
        if (sysUser != null){
            return Result.fail(ErrorCode.ACCOUNT_EXIST.getCode(),ErrorCode.ACCOUNT_EXIST.getMsg());
        }
        sysUser = new SysUser();
        sysUser.setNickname(nickname);
        sysUser.setAccount(account);
        sysUser.setPassword(DigestUtils.md5Hex(password+slat));
        sysUser.setCreateDate(System.currentTimeMillis());
        sysUser.setLastLogin(System.currentTimeMillis());
        sysUser.setAvatar("/static/img/logo.b3a48c0.png");
        sysUser.setAdmin(1); //1 为true
        sysUser.setDeleted(0); // 0 为false
        sysUser.setSalt("");
        sysUser.setStatus("");
        sysUser.setEmail("");
        this.sysUserService.save(sysUser);

        //token
        String token = JWTUtils.createToken(sysUser.getId());

        redisTemplate.opsForValue().set("TOKEN_"+token, JSON.toJSONString(sysUser),1, TimeUnit.DAYS);
        return Result.success(token);
    }


```

在ErrorCode.java中添加一条 src/main/java/com/mszlu/blog/vo/ErrorCode.java

```java
ACCOUNT_EXIST(10004,"账号已存在"),

```

sysUserService中save 和findUserByAccount方法没有需要构造接口和实现类 src/main/java/com/mszlu/blog/service/SysUserService.java

```java
    /**
     * 根据账户查找用户
     * @param account
     * @return
     */
 SysUser findUserByAccount(String account);
    /**
     * 保存用户
     * @param sysUser
     */
    void save(SysUser sysUser);

```

src/main/java/com/mszlu/blog/service/impl/SysUserServiceImpl.java

```java
  	@Override
    public SysUser findUserByAccount(String account) {
        LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SysUser::getAccount,account);
        //确保只能查询一条
        queryWrapper.last("limit 1");
        return sysUserMapper.selectOne(queryWrapper);
    }

    @Override
    public void save(SysUser sysUser) {
         //保存用户这 id会自动生成
        //这个地方 默认生成的id是 分布式id 雪花算法
        //mybatis-plus
        this.sysUserMapper.insert(sysUser);
    }

```

## 6.1.4 加事务

出现错误就进行回滚防止添加异常 增加@Transactional注解 src/main/java/com/mszlu/blog/service/impl/LoginServiceImpl.java

```java
@Service
@Transactional // 理论上应该加载xxxService上 但是实现类一般只有一个,所以加在实现类上也可!
public class LoginServiceImpl implements LoginService {}

```

==当然 一般建议将事务注解@Transactional加在 接口上，通用一些。== src/main/java/com/mszlu/blog/service/LoginService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.params.LoginParam;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author ljm
 * @Date 2021/10/12 20:04
 * @Version 1.0
 */

@Transactional
public interface LoginService {
    /**
     * 登陆功能
     * @param loginParam
     * @return
     */
    Result login(LoginParam loginParam);

    SysUser checkToken(String token);

    /**
     * 退出登陆
     * @param token
     * @return
     */
    Result logout(String token);


    /**
     * 注册
     * @param loginParam
     * @return
     */
    Result register(LoginParam loginParam);

}


```

测试的时候 可以将redis 停掉，那么redis连接异常后，新添加的用户 应该执行回滚操作。

## 6.1.5 测试

# 6.2. 登录拦截器

每次访问需要登录的资源的时候，都需要在代码中进行判断，一旦登录的逻辑有所改变，代码都得进行变动，非常不合适。

那么可不可以统一进行登录判断呢？

springMVC中拦截器

可以，使用拦截器，进行登录拦截，如果遇到需要登录才能访问的接口，如果未登录，拦截器直接返回，并跳转登录页面。 

## 6.2.1 拦截器实现

src/main/java/com/mszlu/blog/handler/LoginInterceptor.java

```java
package com.mszlu.blog.handler;

import com.alibaba.fastjson.JSON;
import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.vo.ErrorCode;
import com.mszlu.blog.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {
    @Autowired
    private LoginService loginService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
            //在执行controller方法(Handler)之前进行执行
        /**
         * 1. 需要判断 请求的接口路径 是否为 HandlerMethod (controller方法)
         * 2. 判断 token是否为空，如果为空 未登录
         * 3. 如果token 不为空，登录验证 loginService checkToken
         * 4. 如果认证成功 放行即可
         */
        //如果不是我们的方法进行放行
        if (!(handler instanceof HandlerMethod)){
        //handler 可能是 RequestResourceHandler springboot 程序 访问静态资源 默认去classpath下的static目录去查询
            return true;
        }
        String token = request.getHeader("Authorization");
        
        log.info("=================request start===========================");
        String requestURI = request.getRequestURI();
        log.info("request uri:{}",requestURI);
        log.info("request method:{}",request.getMethod());
        log.info("token:{}", token);
        log.info("=================request end===========================");

        if(StringUtils.isBlank(token)){
            Result result = Result.fail(ErrorCode.NO_LOGIN.getCode(), "未登录");
            //设置浏览器识别返回的是json
            response.setContentType("application/json;charset=utf-8");
            //https://www.cnblogs.com/qlqwjy/p/7455706.html response.getWriter().print()
            //SON.toJSONString则是将对象转化为Json字符串
            response.getWriter().print(JSON.toJSONString(result));
            return false;
        }
        SysUser sysUser = loginService.checkToken(token);
        if (sysUser == null){
            Result result = Result.fail(ErrorCode.NO_LOGIN.getCode(), "未登录");
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(JSON.toJSONString(result));
            return false;
        }
        //是登录状态，放行
                //登录验证成功，放行
        //我希望在controller中 直接获取用户的信息 怎么获取?

        return true;
    }
}


```

## 6.2.2 使拦截器生效

src/main/java/com/mszlu/blog/config/WebMVCConfig.java

```java
package com.mszlu.blog.config;

import com.mszlu.blog.handler.LoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMVCConfig implements WebMvcConfigurer {

    @Autowired
    private LoginInterceptor loginInterceptor;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        //跨域配置
        registry.addMapping("/**").allowedOrigins("http://localhost:8080");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    //假设拦截test接口后续实际遇到拦截的接口是时，再配置真正的拦截接口
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/test");
    }
}


```

## 6.2.3 测试

src/main/java/com/mszlu/blog/controller/TestController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.vo.Result;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("test")
public class TestController {

    @RequestMapping
    public Result test(){
        return Result.success(null);
    }
}


```

src/main/java/com/mszlu/blog/handler/LoginInterceptor.java返回true进行放行，test这个接口就可以正常访问了 <img src="https://img-blog.csdnimg.cn/183b7c0f640f4ea0934e769d30bc542f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 6.3. ThreadLocal保存用户信息

redis中只放了token我们希望直接获取用户信息 好处和如何使用的  

==使用ThreadLocal替代Session完成保存用户登录信息功能==

使用ThreadLocal替代Session的好处：

```java
 可以在同一线程中很方便的获取用户信息，不需要频繁的传递session对象。
```

具体实现流程：

```java
   在登录业务代码中，当用户登录成功时，生成一个登录凭证存储到redis中，
   将凭证中的字符串保存在cookie中返回给客户端。
   使用一个拦截器拦截请求，从cookie中获取凭证字符串与redis中的凭证进行匹配，获取用户信息，
   将用户信息存储到ThreadLocal中，在本次请求中持有用户信息，即可在后续操作中使用到用户信息。
```

相关问题  

src/main/java/com/mszlu/blog/utils/UserThreadLocal.java

```java
package com.mszlu.blog.utils;

import com.mszlu.blog.dao.pojo.SysUser;

public class UserThreadLocal {

    private UserThreadLocal(){}
    //线程变量隔离
    private static final ThreadLocal<SysUser> LOCAL = new ThreadLocal<>();

    public static void put(SysUser sysUser){
        LOCAL.set(sysUser);
    }
    public static SysUser get(){
        return LOCAL.get();
    }
    public static void remove(){
        LOCAL.remove();
    }
}
```

src/main/java/com/mszlu/blog/handler/LoginInterceptor.java

```java
package com.mszlu.blog.handler;

import com.alibaba.fastjson.JSON;
import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.service.LoginService;
import com.mszlu.blog.utils.UserThreadLocal;
import com.mszlu.blog.vo.ErrorCode;
import com.mszlu.blog.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {
    @Autowired
    private LoginService loginService;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //在执行controller方法(Handler)之前进行执行
        /**
         * 1. 需要判断 请求的接口路径 是否为 HandlerMethod (controller方法)
         * 2. 判断 token是否为空，如果为空 未登录
         * 3. 如果token 不为空，登录验证 loginService checkToken
         * 4. 如果认证成功 放行即可
         */
        if (!(handler instanceof HandlerMethod)){
            //handler 可能是 RequestResourceHandler springboot 程序 访问静态资源 默认去classpath下的static目录去查询
            return true;
        }
        String token = request.getHeader("Authorization");

        log.info("=================request start===========================");
        String requestURI = request.getRequestURI();
        log.info("request uri:{}",requestURI);
        log.info("request method:{}",request.getMethod());
        log.info("token:{}", token);
        log.info("=================request end===========================");


        if (StringUtils.isBlank(token)){
            Result result = Result.fail(ErrorCode.NO_LOGIN.getCode(), "未登录");
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(JSON.toJSONString(result));
            return false;
        }
        SysUser sysUser = loginService.checkToken(token);
        if (sysUser == null){
            Result result = Result.fail(ErrorCode.NO_LOGIN.getCode(), "未登录");
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(JSON.toJSONString(result));
            return false;
        }
        //登录验证成功，放行
        //我希望在controller中 直接获取用户的信息 怎么获取?
        UserThreadLocal.put(sysUser);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
       //如果不删除 ThreadLocal中用完的信息 会有内存泄漏的风险
        UserThreadLocal.remove();
    }
}


```

src/main/java/com/mszlu/blog/controller/TestController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.dao.pojo.SysUser;
import com.mszlu.blog.utils.UserThreadLocal;
import com.mszlu.blog.vo.Result;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("test")
public class TestController {

    @RequestMapping
    public Result test(){
//        SysUser
        SysUser sysUser = UserThreadLocal.get();
        System.out.println(sysUser);
        return Result.success(null);
    }
}
```

# 7.1. ThreadLocal内存泄漏

 <img src="https://img-blog.csdnimg.cn/9e256d87362c4d9295589e3d72e69211.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

**实线代表强引用,虚线代表弱引用**

每一个Thread维护一个ThreadLocalMap, key为使用**弱引用**的ThreadLocal实例，value为线程变量的副本。

**强引用**，使用最普遍的引用，一个对象具有强引用，不会被垃圾回收器回收。当内存空间不足，Java虚拟机宁愿抛出OutOfMemoryError错误，使程序异常终止，也不回收这种对象。

**如果想取消强引用和某个对象之间的关联，可以显式地将引用赋值为null，这样可以使JVM在合适的时间就会回收该对象。**

**弱引用**，JVM进行垃圾回收时，无论内存是否充足，都会回收被弱引用关联的对象。在java中，用java.lang.ref.WeakReference类来表示。

# 7.2. 文章详情

## 7.2.1 接口说明

接口url：/articles/view/{id}

请求方式：POST

请求参数：

|参数名称|参数类型|说明 |
|------ |------ |------ |
|id|long|文章id（路径参数）|

返回数据：

```json
{success: true, code: 200, msg: "success",…}
code: 200
data: {id: "1405916999732707330", title: "SpringBoot入门案例", summary: "springboot入门案例", commentCounts: 0,…}
msg: "success"
success: true

```

## 7.2.2 涉及到的表

内容表

content存放makedown格式的信息 content_html存放html格式的信息

```sql
CREATE TABLE `blog`.`ms_article_body`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `content_html` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `article_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

src/main/java/com/mszlu/blog/dao/pojo/ArticleBody.java

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;
//内容表
@Data
public class ArticleBody {

    private Long id;
    private String content;
    private String contentHtml;
    private Long articleId;
}


```

类别表 avata分类图标路径 category_name图标分类的名称 description分类的描述 <img src="https://img-blog.csdnimg.cn/8670bb51483e4d3cb9f6df0cd3886508.png" alt="在这里插入图片描述">

```sql
CREATE TABLE `blog`.`ms_category`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

src/main/java/com/mszlu/blog/dao/pojo/Category.java

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;
//类别表
@Data
public class Category {

    private Long id;

    private String avatar;

    private String categoryName;

    private String description;
}


```

## 7.2.3 Controller

src/main/java/com/mszlu/blog/controller/ArticleController.java

```java
@PostMapping("view/{id}")
public Result findArticleById(@PathVariable("id") Long articleId){
    return articleService.findArticleById(articleId);
}
```

## 7.2.4 Service

src/main/java/com/mszlu/blog/service/ArticleService.java

```java
    /**
     * 查看文章详情
     * @param articleId
     * @return
     */
    Result findArticleById(Long articleId);

```

文章表里面只有tiltle以及一些简介 ms_article 中body_id对应第二张表ms_article_body上的id ms_category会映射到ms_article 中的category_id 需要做一些相对的关联查询 <img src="https://img-blog.csdnimg.cn/e09cf9dda3284c99996f4ac67a8dc71a.png" alt="表一"><img src="https://img-blog.csdnimg.cn/e9f889a0f76546c8b0c03cabd136bb61.png" alt="在这里插入图片描述">

<img src="https://img-blog.csdnimg.cn/c15c079de7b44d37bdacd7e1127875a0.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"><img src="https://img-blog.csdnimg.cn/88ae15f8289e4ec3ab0cef393b7bf9b1.png" alt="在这里插入图片描述">

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java

    @Override
    public Result findArticleById(Long articleId) {
        /**
         * 1. 根据id查询 文章信息
         * 2. 根据bodyId和categoryid 去做关联查询
         */
        Article article = this.articleMapper.selectById(articleId);
        ArticleVo articleVo = copy(article, true, true,true,true);
        //查看完文章了，新增阅读数，有没有问题呢？
        //查看完文章之后，本应该直接返回数据了，这时候做了一个更新操作，更新时加写锁，阻塞其他的读操作，性能就会比较低
        // 更新 增加了此次接口的 耗时 如果一旦更新出问题，不能影响 查看文章的操作
        //线程池  可以把更新操作 扔到线程池中去执行，和主线程就不相关了
       //threadService.updateArticleViewCount(articleMapper,article);
        return Result.success(articleVo);
    }

```

src/main/java/com/mszlu/blog/vo/ArticleVo.java

```java
package com.mszlu.blog.vo;

import lombok.Data;

import java.util.List;

@Data
public class ArticleVo {

    private Long id;

    private String title;

    private String summary;

    private int commentCounts;

    private int viewCounts;

    private int weight;
    /**
     * 创建时间
     */
    private String createDate;

    private String author;

    private ArticleBodyVo body;

    private List<TagVo> tags;

    private CategoryVo category;

}


```

src/main/java/com/mszlu/blog/vo/ArticleBodyVo.java

```java
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class ArticleBodyVo {

//内容
    private String content;
}


```

src/main/java/com/mszlu/blog/vo/CategoryVo.java

```java
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class CategoryVo {

//id，图标路径，图标名称
    private Long id;

    private String avatar;

    private String categoryName;
}


```

ArticleVo中的属性填充： src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java


//方法重载，方法名相同参数数量不同
    private List<ArticleVo> copyList(List<Article> records, boolean isTag, boolean isAuthor) {
        List<ArticleVo> articleVoList = new ArrayList<>();
        for (Article record : records) {
            articleVoList.add(copy(record,isTag,isAuthor,false,false));
        }
        return articleVoList;
    }

    private List<ArticleVo> copyList(List<Article> records, boolean isTag, boolean isAuthor,boolean isBody) {
        List<ArticleVo> articleVoList = new ArrayList<>();
        for (Article record : records) {
            articleVoList.add(copy(record,isTag,isAuthor,isBody,false));
        }
        return articleVoList;
    }
    private List<ArticleVo> copyList(List<Article> records, boolean isTag, boolean isAuthor,boolean isBody,boolean isCategory) {
        List<ArticleVo> articleVoList = new ArrayList<>();
        for (Article record : records) {
            articleVoList.add(copy(record,isTag,isAuthor,isBody,isCategory));
        }
        return articleVoList;
    }

    @Autowired
    private CategoryService categoryService;
//带body信息，带category信息
    private ArticleVo copy(Article article, boolean isTag, boolean isAuthor, boolean isBody,boolean isCategory){
        ArticleVo articleVo = new ArticleVo();
        articleVo.setId(String.valueOf(article.getId()));
        BeanUtils.copyProperties(article,articleVo);
        //时间没法copy因为是long型
        articleVo.setCreateDate(new DateTime(article.getCreateDate()).toString("yyyy-MM-dd HH:mm"));
        //并不是所有的接口 都需要标签 ，作者信息
        if (isTag){
            Long articleId = article.getId();
            articleVo.setTags(tagService.findTagsByArticleId(articleId));
        }
        if (isAuthor){
            Long authorId = article.getAuthorId();
            articleVo.setAuthor(sysUserService.findUserById(authorId).getNickname());
        }
        if (isBody){
            Long bodyId = article.getBodyId();
            articleVo.setBody(findArticleBodyById(bodyId));
        }
        if (isCategory){
            Long categoryId = article.getCategoryId();
            articleVo.setCategory(categoryService.findCategoryById(categoryId));
        }
        return articleVo;
    }

    @Autowired
    private CategoryService categoryService;

    private CategoryVo findCategory(Long categoryId) {
        return categoryService.findCategoryById(categoryId);
    }
    //构建ArticleBodyMapper
    @Autowired
    private ArticleBodyMapper articleBodyMapper;

    private ArticleBodyVo findArticleBodyById(Long bodyId) {
        ArticleBody articleBody = articleBodyMapper.selectById(bodyId);
        ArticleBodyVo articleBodyVo = new ArticleBodyVo();
        articleBodyVo.setContent(articleBody.getContent());
        return articleBodyVo;
    }


```

src/main/java/com/mszlu/blog/dao/mapper/ArticleBodyMapper.java

```java
package com.mszlu.blog.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.ArticleBody;

public interface ArticleBodyMapper extends BaseMapper<ArticleBody> {
}


```

src/main/java/com/mszlu/blog/dao/mapper/CategoryMapper.java

```java
package com.mszlu.blog.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.Category;

public interface CategoryMapper extends BaseMapper<Category> {
}


```

src/main/java/com/mszlu/blog/service/CategoryService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.vo.CategoryVo;


public interface CategoryService {

    CategoryVo findCategoryById(Long id);
}


```

src/main/java/com/mszlu/blog/service/impl/CategoryServiceImpl.java

```java
package com.mszlu.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.dao.mapper.CategoryMapper;
import com.mszlu.blog.dao.pojo.Category;
import com.mszlu.blog.service.CategoryService;
import com.mszlu.blog.vo.CategoryVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


//注入spring 
@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public CategoryVo findCategoryById(Long id){
        Category category = categoryMapper.selectById(id);
        CategoryVo categoryVo = new CategoryVo();
        //因为category,categoryVo属性一样所以可以使用 BeanUtils.copyProperties
        BeanUtils.copyProperties(category,categoryVo);
        return categoryVo;
    }
}


```

## 7.2.5 测试

# 7.3. 使用线程池 更新阅读次数

//查看完文章了，新增阅读数，有没有问题呢？ 

//查看完文章之后，本应该直接返回数据了，这时候做了一个更新操作，更新时加写锁，阻塞其他的读操作，性能就会比较低（没办法解决，增加阅读数必然要加锁） 

//更新增加了此次接口的耗时（考虑减少耗时）如果一旦更新出问题，不能影响查看操作 想到了一个技术 线程池 可以把更新操作扔到 线程池中去执行和主线程就不相关了  

## 7.3.1 线程池配置

做一个线程池的配置来开启线程池 src/main/java/com/mszlu/blog/config/ThreadPoolConfig.java

```java
package com.mszlu.blog.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

//https://www.jianshu.com/p/0b8443b1adc9   关于@Configuration和@Bean的用法和理解
@Configuration
@EnableAsync //开启多线程
public class ThreadPoolConfig {

    @Bean("taskExecutor")
    public Executor asyncServiceExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        // 设置核心线程数
        executor.setCorePoolSize(5);
        // 设置最大线程数
        executor.setMaxPoolSize(20);
        //配置队列大小
        executor.setQueueCapacity(Integer.MAX_VALUE);
        // 设置线程活跃时间（秒）
        executor.setKeepAliveSeconds(60);
        // 设置默认线程名称
        executor.setThreadNamePrefix("码神之路博客项目");
        // 等待所有任务结束后再关闭线程池
        executor.setWaitForTasksToCompleteOnShutdown(true);
        //执行初始化
        executor.initialize();
        return executor;
    }
}


```

## 7.3.1 使用

src/main/java/com/mszlu/blog/service/ThreadService.java

```java
package com.mszlu.blog.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.dao.mapper.ArticleMapper;
import com.mszlu.blog.dao.pojo.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class ThreadService {
    //期望此操作在线程池执行不会影响原有主线程
    //这里线程池不了解可以去看JUC并发编程
    @Async("taskExcutor")
    public void updateArticleViewCount(ArticleMapper articleMapper, Article article) {

        Integer viewCounts = article.getViewCounts();
        Article articleupdate = new Article();
        articleupdate.setViewCounts(viewCounts+1);
        LambdaQueryWrapper<Article> updatewrapper = new LambdaQueryWrapper<>();
        //根据id更新
        updatewrapper.eq(Article::getId ,article.getId());
        //设置一个为了在多线程的环境下线程安全
        //改之前再确认这个值有没有被其他线程抢先修改，类似于CAS操作 cas加自旋，加个循环就是cas
        updatewrapper.eq(Article ::getViewCounts,viewCounts );
        // update article set view_count=100 where view_count=99 and id =111
        //实体类加更新条件
        articleMapper.update(articleupdate,updatewrapper);
        try {
            Thread.sleep(5000);
            System.out.println("更新完成了");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
}



```

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java

    @Autowired
    private ThreadService threadService;

    @Override
    public ArticleVo findArticleById(Long id) {
        Article article = articleMapper.selectById(id);
        //线程池
        threadService.updateViewCount(articleMapper,article);
        return copy(article,true,true,true,true);
    }


```

## 7.3.3 测试

睡眠 ThredService中的方法 5秒，不会影响主线程的使用，即文章详情会很快的显示出来，不受影响

# Bug修正

之前Article中的commentCounts，viewCounts，weight 字段为int，会造成更新阅读次数的时候，将其余两个字段设为初始值0 mybatisplus在更新文章阅读次数的时候虽然只设立了articleUpdate.setviewsCounts(viewCounts+1), 但是int默认基本数据类型为0， mybatisplus但凡不是null就会生成到sql语句中进行更新。会出现 <img src="https://img-blog.csdnimg.cn/0c58f5d19f3b47aa845fe69d50472be1.png" alt="在这里插入图片描述">理想中应该是只有views_counts改变但是因为mybatisplus规则所以会出现这个现象 所以将int改为Integer就不会出现这个问题。 src/main/java/com/mszlu/blog/dao/pojo/Article.java

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class Article {

    public static final int Article_TOP = 1;

    public static final int Article_Common = 0;

    private Long id;

    private String title;

    private String summary;

    private Integer commentCounts;

    private Integer viewCounts;

    /**
     * 作者id
     */
    private Long authorId;
    /**
     * 内容id
     */
    private Long bodyId;
    /**
     *类别id
     */
    private Long categoryId;

    /**
     * 置顶
     */
    private Integer weight;


    /**
     * 创建时间
     */
    private Long createDate;
}


```

# 8.1. 评论列表

评论表 id评论id content评论内容 create_date评论时间 article_id评论文章 author_id谁评论的 parent_id盖楼功能对评论的评论进行回复 to_uid给谁评论 level评论的是第几层（1级表示最上层的评论，2表示对评论的评论）

```sql
CREATE TABLE `blog`.`ms_comment`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_date` bigint(0) NOT NULL,
  `article_id` int(0) NOT NULL,
  `author_id` bigint(0) NOT NULL,
  `parent_id` bigint(0) NOT NULL,
  `to_uid` bigint(0) NOT NULL,
  `level` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

```

src/main/java/com/mszlu/blog/dao/pojo/Comment.java

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class Comment {

    private Long id;

    private String content;

    private Long createDate;

    private Long articleId;

    private Long authorId;

    private Long parentId;

    private Long toUid;

    private Integer level;
}


```

## 8.1.1 接口说明

接口url：/comments/article/{id}

请求方式：GET

请求参数：

|参数名称|参数类型|说明|
|------ |------ |------ |
|id|long|文章id（路径参数）|

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id": 53,
            "author": {
                "nickname": "李四",
                "avatar": "http://localhost:8080/static/img/logo.b3a48c0.png",
                "id": 1
            },
            "content": "写的好",
            "childrens": [
                {
                    "id": 54,
                    "author": {
                        "nickname": "李四",
                        "avatar": "http://localhost:8080/static/img/logo.b3a48c0.png",
                        "id": 1
                    },
                    "content": "111",
                    "childrens": [],
                    "createDate": "1973-11-26 08:52",
                    "level": 2,
                    "toUser": {
                        "nickname": "李四",
                        "avatar": "http://localhost:8080/static/img/logo.b3a48c0.png",
                        "id": 1
                    }
                }
            ],
            "createDate": "1973-11-27 09:53",
            "level": 1,
            "toUser": null
        }
    ]
}

```

代码结构 时序图<img src="https://img-blog.csdnimg.cn/142c81c40e324f758830ae540cb2bd53.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center" alt="在这里插入图片描述">

## 8.1.2 Controller

src/main/java/com/mszlu/blog/controller/CommentsController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.service.CommentsService;
import com.mszlu.blog.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("comments")
public class CommentsController {

    @Autowired
    private CommentsService commentsService;

    @GetMapping("article/{id}")
    public Result comments(@PathVariable("id") Long articleId){

        return commentsService.commentsByArticleId(articleId);

    }
}


```

## 8.1.3 Service

src/main/java/com/mszlu/blog/service/CommentsService.java

```java
package com.mszlu.blog.service;

import com.mszlu.blog.vo.Result;

public interface CommentsService {

    /**
     * 根据文章id查询所有的评论列表
     * @param id
     * @return
     */
    Result commentsByArticleId(Long id);
}


```

src/main/java/com/mszlu/blog/service/impl/CommentsServiceImpl.java

```java
package com.mszlu.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.dao.mapper.CommentMapper;
import com.mszlu.blog.dao.pojo.Comment;
import com.mszlu.blog.service.CommentsService;
import com.mszlu.blog.service.SysUserService;
import com.mszlu.blog.vo.CommentVo;
import com.mszlu.blog.vo.Result;
import com.mszlu.blog.vo.UserVo;
import org.joda.time.DateTime;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentsServiceImpl implements CommentsService {

    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private SysUserService sysUserService;
    @Override
    public Result commentsByArticleId(Long articleId) {
            /**
         * 1. 根据文章id 查询 评论列表 从 comment 表中查询
         * 2. 根据作者的id 查询作者的信息
         * 3. 判断 如果 level = 1 要去查询它有没有子评论
         * 4. 如果有 根据评论id 进行查询 （parent_id）
         */
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        //根据文章id进行查询
        queryWrapper.eq(Comment::getArticleId,id );
        //根据层级关系进行查询
        queryWrapper.eq(Comment::getLevel,1 );
        List<Comment> comments = commentMapper.selectList(queryWrapper);
        
        List<CommentVo> commentVoList = copyList(comments);
        return Result.success(commentVoList);
    }
    //对list表中的comment进行判断
    public List<CommentVo> copyList(List<Comment> commentList){
        List<CommentVo> commentVoList = new ArrayList<>();
        for (Comment comment : commentList) {
            commentVoList.add(copy(comment));
        }
        return commentVoList;
    }

    private CommentVo copy(Comment comment) {
        CommentVo commentVo = new CommentVo();
        // 相同属性copy
        BeanUtils.copyProperties(comment,commentVo);
        commentVo.setId(String.valueOf(comment.getId()));
        //作者信息
        Long authorId = comment.getAuthorId();
        UserVo userVo = this.sysUserService.findUserVoById(authorId);
        commentVo.setAuthor(userVo);
        //子评论
        Integer level = comment.getLevel();
        if (1 == level){
            Long id = comment.getId();
            List<CommentVo> commentVoList = findCommentsByParentId(id);
            commentVo.setChildrens(commentVoList);
        }
        //to User 给谁评论
        if (level > 1){
            Long toUid = comment.getToUid();
            UserVo toUserVo = this.sysUserService.findUserVoById(toUid);
            commentVo.setToUser(toUserVo);
        }
        return commentVo;
    }

    private List<CommentVo> findCommentsByParentId(Long id) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getParentId,id);
        queryWrapper.eq(Comment::getLevel,2);
        List<Comment> comments = this.commentMapper.selectList(queryWrapper);
        return copyList(comments);
    }




}


```

返回的数据： src/main/java/com/mszlu/blog/vo/CommentVo.java

```java
package com.mszlu.blog.vo;

import com.mszlu.blog.dao.pojo.SysUser;
import lombok.Data;

import java.util.List;

@Data
public class CommentVo  {

    private Long id;

    private UserVo author;

    private String content;

    private List<CommentVo> childrens;

    private String createDate;

    private Integer level;

    private UserVo toUser;
}


```

src/main/java/com/mszlu/blog/vo/UserVo.java

```java
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class UserVo {

    private String nickname;

    private String avatar;

    private Long id;
}


```

在SysUserService中提供 查询用户信息的服务： src/main/java/com/mszlu/blog/service/SysUserService.java

```java
  UserVo findUserVoById(Long id);

```

src/main/java/com/mszlu/blog/service/impl/SysUserServiceImpl.java

```java

    @Override
    public UserVo findUserVoById(Long id) {
        SysUser sysUser = sysUserMapper.selectById(id);
        if (sysUser == null){
            sysUser = new SysUser();
            sysUser.setId(1L);
            sysUser.setAvatar("/static/img/logo.b3a48c0.png");
            sysUser.setNickname("码神之路");
        }
        UserVo userVo = new UserVo();
        userVo.setAvatar(sysUser.getAvatar());
        userVo.setNickname(sysUser.getNickname());
        userVo.setId(sysUser.getId());
        return userVo;
    }

```

# 8.2. 评论

## 8.2.1 接口说明

接口url：/comments/create/change

请求方式：POST

请求参数：

|参数名称|参数类型|说明|
|------|--------|-------|
|articleId|long|文章id|
|content|string|评论内容|
|parent|long|父评论id|
|toUserId|long|被评论的用户id|

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": null
}

```

## 8.2.2 加入到登录拦截器中

src/main/java/com/mszlu/blog/config/WebMVCConfig.java

```java
@Override
    public void addInterceptors(InterceptorRegistry registry) {
        //拦截test接口，后续实际遇到需要拦截的接口时，在配置为真正的拦截接口
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/test").addPathPatterns("/comments/create/change");
    }

```

## 8.2.3 Controller

代码结构 <img src="https://img-blog.csdnimg.cn/f5cd32c2a4cb44cd89059e0e29a97e9d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center" alt="在这里插入图片描述">

构建评论参数对象： src/main/java/com/mszlu/blog/vo/params/CommentParam.java

```java
package com.mszlu.blog.vo.params;

import lombok.Data;

@Data
public class CommentParam {

    private Long articleId;

    private String content;

    private Long parent;

    private Long toUserId;
}


```

src/main/java/com/mszlu/blog/controller/CommentsController.java

```java


    @PostMapping("create/change")
    public Result comment(@RequestBody CommentParam commentParam){
        return commentsService.comment(commentParam);
    }

```

## 8.2.4 Service

src/main/java/com/mszlu/blog/service/CommentsService.java

```java
    Result comment(CommentParam commentParam);

```

src/main/java/com/mszlu/blog/service/impl/CommentsServiceImpl.java

```java
 @Override
    public Result comment(CommentParam commentParam) {
    //拿到当前用户
        SysUser sysUser = UserThreadLocal.get();
        Comment comment = new Comment();
        comment.setArticleId(commentParam.getArticleId());
        comment.setAuthorId(sysUser.getId());
        comment.setContent(commentParam.getContent());
        comment.setCreateDate(System.currentTimeMillis());
        Long parent = commentParam.getParent();
        if (parent == null || parent == 0) {
            comment.setLevel(1);
        }else{
            comment.setLevel(2);
        }
        //如果是空，parent就是0
        comment.setParentId(parent == null ? 0 : parent);
        Long toUserId = commentParam.getToUserId();
        comment.setToUid(toUserId == null ? 0 : toUserId);
        this.commentMapper.insert(comment);
        return Result.success(null);
    }

```

```java
  //防止前端 精度损失 把id转为string
// 分布式id 比较长，传到前端 会有精度损失，必须转为string类型 进行传输，就不会有问题了
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

```

# 写文章

写文章需要 三个接口：
1.  获取所有文章类别 
1.   获取所有标签  
1.  发布文章 

# 9.1. 所有文章分类

## 9.1.1 接口说明

接口url：/categorys

请求方式：GET

请求参数：

|参数名称|参数类型|说明|
|------ |------ |------ |


返回数据：

```json
{
    "success":true,
 	"code":200,
    "msg":"success",
    "data":
    [
        {"id":1,"avatar":"/category/front.png","categoryName":"前端"},	
        {"id":2,"avatar":"/category/back.png","categoryName":"后端"},
        {"id":3,"avatar":"/category/lift.jpg","categoryName":"生活"},
        {"id":4,"avatar":"/category/database.png","categoryName":"数据库"},
        {"id":5,"avatar":"/category/language.png","categoryName":"编程语言"}
    ]
}

```

## 9.1.2 Controller

src/main/java/com/mszlu/blog/controller/CategoryController.java

```
package com.mszlu.blog.controller;

import com.mszlu.blog.service.CategoryService;
import com.mszlu.blog.vo.CategoryVo;
import com.mszlu.blog.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("categorys")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public Result listCategory() {
        return categoryService.findAll();
    }
}


```

## 9.1.3 Service

src/main/java/com/mszlu/blog/service/impl/CategoryServiceImpl.java

```java

//id不一致要重新设立
    public CategoryVo copy(Category category){
        CategoryVo categoryVo = new CategoryVo();
        BeanUtils.copyProperties(category,categoryVo);
        //id不一致要重新设立
        categoryVo.setId(String.valueOf(category.getId()));
        return categoryVo;
    }
    public List<CategoryVo> copyList(List<Category> categoryList){
        List<CategoryVo> categoryVoList = new ArrayList<>();
        for (Category category : categoryList) {
            categoryVoList.add(copy(category));
        }
        return categoryVoList;
    }

    @Override
    public Result findAll() {
    // 没有任何参数，所有一个空的LambdaQueryWrapper即可
        List<Category> categories = this.categoryMapper.selectList(new LambdaQueryWrapper<>());
         //页面交互的对象
        return Result.success(copyList(categories));
    }

```

<img src="https://img-blog.csdnimg.cn/460ad8a5fbae409fb8ebe9c7716d1ff9.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_19,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 9.2. 所有文章标签

## 9.2.1 接口说明

接口url：/tags

请求方式：GET

请求参数：



返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": [
        {
            "id": 5,
            "tagName": "springboot"
        },
        {
            "id": 6,
            "tagName": "spring"
        },
        {
            "id": 7,
            "tagName": "springmvc"
        },
        {
            "id": 8,
            "tagName": "11"
        }
    ]
}

```

## 9.2.2 Controller

src/main/java/com/mszlu/blog/controller/TagsController.java

```java
    @Autowired
    private TagService tagService;
 	@GetMapping
    public Result findAll(){
        /**
     * 查询所有的文章标签
     * @return
     */
        return tagService.findAll();
    }

```

## 9.2.3 Service

src/main/java/com/mszlu/blog/service/TagService.java

```java
    /**
     * 查询所有文章标签
     * @return
     */
    Result findAll();

```

src/main/java/com/mszlu/blog/service/impl/TagServiceImpl.java

```java
	@Override
    public Result findAll() {
        List<Tag> tags = this.tagMapper.selectList(new LambdaQueryWrapper<>());
        return Result.success(copyList(tags));
    }

```

<img src="https://img-blog.csdnimg.cn/88c1876ff47448fcbf00210b109f0a8b.png" alt="在这里插入图片描述">

# 9.3. 发布文章

## 9.3.1 接口说明

```
请求内容是object（{content: “ww”, contentHtml: “ww↵”}）是因为本身为makedown的编辑器
id指的是文章id
```

<img src="https://img-blog.csdnimg.cn/f74eca57127640fba1ce2dcfa038a545.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

接口url：/articles/publish

请求方式：POST

请求参数：

|参数名称|参数类型|说明|
|------ |------ |------ |
|title|string|文章标题|
|id|long|文章id（编辑有值）|
|body|object（{content: “ww”, contentHtml: “ww↵”}）|文章内容|
|category|{id: 2, avatar: “/category/back.png”, categoryName: “后端”}|文章类别|
|summary|string|文章概述|
|tags|[{id: 5}, {id: 6}]|文章标签|

返回数据：

```json
{
    "success": true,
    "code": 200,
    "msg": "success",
    "data": {"id":12232323}
}

```

代码结构 <img src="https://img-blog.csdnimg.cn/f1f481e5790145008dd510ace8c05cad.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center" alt="在这里插入图片描述">

## 9.3.2 Controller

src/main/java/com/mszlu/blog/controller/ArticleController.java

```java
    //  @RequestBody主要用来接收前端传递给后端的json字符串中的数据的(请求体中的数据的)；
    //  而最常用的使用请求体传参的无疑是POST请求了，所以使用@RequestBody接收数据时，一般都用POST方式进行提交。
	@PostMapping("publish")
    public Result publish(@RequestBody ArticleParam articleParam){
        return articleService.publish(articleParam);
    }

```

我们需要建立参数对象需要用于接收前端传过来的数据 src/main/java/com/mszlu/blog/vo/params/ArticleParam.java

```java
package com.mszlu.blog.vo.params;

import com.mszlu.blog.vo.CategoryVo;
import com.mszlu.blog.vo.TagVo;
import lombok.Data;

import java.util.List;

@Data
public class ArticleParam {

    private Long id;

    private ArticleBodyParam body;

    private CategoryVo category;

    private String summary;

    private List<TagVo> tags;

    private String title;
}


```

src/main/java/com/mszlu/blog/vo/params/ArticleBodyParam.java

```java
package com.mszlu.blog.vo.params;

import lombok.Data;

@Data
public class ArticleBodyParam {

    private String content;

    private String contentHtml;

}


```

## 9.3.3 Service

src/main/java/com/mszlu/blog/service/ArticleService.java

```java
    /**
     * 文章发布服务
     * @param articleParam
     * @return
     */
    Result publish(ArticleParam articleParam);

```

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java
@Override
    @Transactional
    public Result publish(ArticleParam articleParam) {
    //注意想要拿到数据必须将接口加入拦截器
        SysUser sysUser = UserThreadLocal.get();

        /**
         * 1. 发布文章 目的 构建Article对象
         * 2. 作者id  当前的登录用户
         * 3. 标签  要将标签加入到 关联列表当中
         * 4. body 内容存储 article bodyId
         */
        Article article = new Article();
        article.setAuthorId(sysUser.getId());
        article.setCategoryId(articleParam.getCategory().getId());
        article.setCreateDate(System.currentTimeMillis());
        article.setCommentCounts(0);
        article.setSummary(articleParam.getSummary());
        article.setTitle(articleParam.getTitle());
        article.setViewCounts(0);
        article.setWeight(Article.Article_Common);
        article.setBodyId(-1L);
        //插入之后 会生成一个文章id（因为新建的文章没有文章id所以要insert一下
        //官网解释："insart后主键会自动'set到实体的ID字段。所以你只需要"getid()就好
//        利用主键自增，mp的insert操作后id值会回到参数对象中
        //https://blog.csdn.net/HSJ0170/article/details/107982866
        this.articleMapper.insert(article);

        //tags
        List<TagVo> tags = articleParam.getTags();
        if (tags != null) {
            for (TagVo tag : tags) {
                ArticleTag articleTag = new ArticleTag();
                articleTag.setArticleId(article.getId());
                articleTag.setTagId(tag.getId());
                this.articleTagMapper.insert(articleTag);
            }
        }
         //body
        ArticleBody articleBody = new ArticleBody();
        articleBody.setContent(articleParam.getBody().getContent());
        articleBody.setContentHtml(articleParam.getBody().getContentHtml());
        articleBody.setArticleId(article.getId());
        articleBodyMapper.insert(articleBody);
//插入完之后再给一个id
        article.setBodyId(articleBody.getId());
         //MybatisPlus中的save方法什么时候执行insert，什么时候执行update
        // https://www.cxyzjd.com/article/Horse7/103868144
       //只有当更改数据库时才插入或者更新，一般查询就可以了
        articleMapper.updateById(article);
        
        ArticleVo articleVo = new ArticleVo();
        articleVo.setId(article.getId());
        return Result.success(articleVo);
    }

```

src/main/java/com/mszlu/blog/config/WebMVCConfig.java

当然登录拦截器中，需要加入发布文章的配置：

```java
 @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //拦截test接口，后续实际遇到需要拦截的接口时，在配置为真正的拦截接口
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/test")
                .addPathPatterns("/comments/create/change")
                .addPathPatterns("/articles/publish");
    }

```

src/main/java/com/mszlu/blog/dao/mapper/ArticleTagMapper.java

```java
package com.mszlu.blog.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.ArticleTag;

public interface ArticleTagMapper  extends BaseMapper<ArticleTag> {
}


```

src/main/java/com/mszlu/blog/dao/mapper/ArticleBodyMapper.java

```java
package com.mszlu.blog.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.dao.pojo.ArticleBody;

public interface ArticleBodyMapper extends BaseMapper<ArticleBody> {
}


```

src/main/java/com/mszlu/blog/vo/ArticleVo.java

```java

package com.mszlu.blog.vo;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.util.List;

@Data
public class ArticleVo {
	//一定要记得加 要不然 会出现精度损失
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    private String title;

    private String summary;

    private Integer commentCounts;

    private Integer viewCounts;

    private Integer weight;
    /**
     * 创建时间
     */
    private String createDate;

    private String author;

    private ArticleBodyVo body;

    private List<TagVo> tags;

    private CategoryVo category;

}


```

src/main/java/com/mszlu/blog/dao/pojo/ArticleTag.java

```java
package com.mszlu.blog.dao.pojo;

import lombok.Data;

@Data
public class ArticleTag {

    private Long id;

    private Long articleId;

    private Long tagId;
}


```

## 9.3.4 测试

# 9.4. AOP日志

IOC是spring的两大核心概念之一，IOC给我们提供了一个IOCbean容器，这个容器会帮我们自动去创建对象，不需要我们手动创建，IOC实现创建的通过DI（Dependency Injection 依赖注入），我们可以通过写Java注解代码或者是XML配置方式，把我们想要注入对象所依赖的一些其他的bean，自动的注入进去，他是通过byName或byType类型的方式来帮助我们注入。正是因为有了依赖注入，使得IOC有这非常强大的好处，解耦。

可以举个例子，JdbcTemplate 或者 SqlSessionFactory 这种bean，如果我们要把他注入到容器里面，他是需要依赖一个数据源的，如果我们把JdbcTemplate 或者 Druid 的数据源强耦合在一起，会导致一个问题，当我们想要使用jdbctemplate必须要使用Druid数据源，那么依赖注入能够帮助我们在Jdbc注入的时候，只需要让他依赖一个DataSource接口，不需要去依赖具体的实现，这样的好处就是，将来我们给容器里面注入一个Druid数据源，他就会自动注入到JdbcTemplate如果我们注入一个其他的也是一样的。比如说c3p0也是一样的，这样的话，JdbcTemplate和数据源完全的解耦了，不强依赖与任何一个数据源，在spring启动的时候，就会把所有的bean全部创建好，这样的话，程序在运行的时候就不需要创建bean了，运行速度会更快，还有IOC管理bean的时候默认是单例的，可以节省时间，提高性能，





在不改变原有方法基础上对原有方法进行增强 src/main/java/com/mszlu/blog/common/aop/LogAnnotation.java

```java
package com.mszlu.blog.common.aop;

import java.lang.annotation.*;

/**
 * 日志注解
 */
 //ElementType.TYPE代表可以放在类上面  method代表可以放在方法上
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogAnnotation {

    String module() default "";

    String operation() default "";
}


```

加上此注解代表着我们需要对此接口进行日志输出 src/main/java/com/mszlu/blog/controller/ArticleController.java

```java
    @PostMapping
    //加上此注解，代表要对此接口记录日志
    @LogAnnotation(module = "文章",operation = "获取文章列表")
    public Result listArticle(@RequestBody PageParams pageParams){

        return articleService.listArticle(pageParams);

    }

```

src/main/java/com/mszlu/blog/common/aop/LogAspect.java

```java
package com.mszlu.blog.common.aop;

import com.alibaba.fastjson.JSON;
import com.mszlu.blog.utils.HttpContextUtils;
import com.mszlu.blog.utils.IpUtils;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

/**
 * @Author ljm
 * @Date 2021/10/18 21:01
 * @Version 1.0
 */
@Component
@Aspect //切面 定义了通知和切点的关系
@Slf4j
public class LogAspect {

    @Pointcut("@annotation(com.mszlu.blog.common.aop.LogAnnotation)")
    public void pt(){
    }

    //环绕通知
    @Around("pt()")
    public Object log(ProceedingJoinPoint point) throws Throwable {
        long beginTime = System.currentTimeMillis();
        //执行方法
        Object result = point.proceed();
        //执行时长(毫秒)
        long time = System.currentTimeMillis() - beginTime;
        //保存日志
        recordLog(point, time);
        return result;

    }

    private void recordLog(ProceedingJoinPoint joinPoint, long time) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        LogAnnotation logAnnotation = method.getAnnotation(LogAnnotation.class);
        log.info("=====================log start================================");
        log.info("module:{}",logAnnotation.module());
        log.info("operation:{}",logAnnotation.operation());

        //请求的方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = signature.getName();
        log.info("request method:{}",className + "." + methodName + "()");

//        //请求的参数
        Object[] args = joinPoint.getArgs();
        String params = JSON.toJSONString(args[0]);
        log.info("params:{}",params);

        //获取request 设置IP地址
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        log.info("ip:{}", IpUtils.getIpAddr(request));


        log.info("excute time : {} ms",time);
        log.info("=====================log end================================");
    }




}


```

用到的方法类 src/main/java/com/mszlu/blog/utils/HttpContextUtils.java

```java
package com.mszlu.blog.utils;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * HttpServletRequest
 *
 */
public class HttpContextUtils {

    public static HttpServletRequest getHttpServletRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    }

}


```

src/main/java/com/mszlu/blog/utils/IpUtils.java

```java
package com.mszlu.blog.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * 获取Ip
 *
 */
@Slf4j
public class IpUtils {

    /**
     * 获取IP地址
     * <p>
     * 使用Nginx等反向代理软件， 则不能通过request.getRemoteAddr()获取IP地址
     * 如果使用了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP地址，X-Forwarded-For中第一个非unknown的有效IP字符串，则为真实IP地址
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = null, unknown = "unknown", seperator = ",";
        int maxLength = 15;
        try {
            ip = request.getHeader("x-forwarded-for");
            if (StringUtils.isEmpty(ip) || unknown.equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(ip) || ip.length() == 0 || unknown.equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
            }
            if (StringUtils.isEmpty(ip) || unknown.equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_CLIENT_IP");
            }
            if (StringUtils.isEmpty(ip) || unknown.equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (StringUtils.isEmpty(ip) || unknown.equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
            }
        } catch (Exception e) {
            log.error("IpUtils ERROR ", e);
        }

        // 使用代理，则获取第一个IP地址
        if (StringUtils.isEmpty(ip) &amp;&amp; ip.length() > maxLength) {
            int idx = ip.indexOf(seperator);
            if (idx > 0) {
                ip = ip.substring(0, idx);
            }
        }

        return ip;
    }

    /**
     * 获取ip地址
     *
     * @return
     */
    public static String getIpAddr() {
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        return getIpAddr(request);
    }
}


```

结果是 <img src="https://img-blog.csdnimg.cn/0bfd2dceffe4440fb16f43e62351e6cd.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

ip地址查询的是

<img src="https://img-blog.csdnimg.cn/6184e67a3fee4a199cc56bbe69c913e4.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# bug修正

防止拿到的值是null值，因为拿到的是毫秒值，需要对其进行转化，Y表示年，m表示月，对时间进行重写。 <img src="https://img-blog.csdnimg.cn/9faa30c7a13c402c9afad4cc30a55753.png" alt="在这里插入图片描述">

文章归档：



```
select FROM_UNIXTIME(create_date/1000,'%Y') as year, FROM_UNIXTIME(create_date/1000,'%m') as month,count(*) as count from ms_article group by year,month

```

# 10.1. 文章图片上传

## 10.1.1 接口说明

接口url：/upload

请求方式：POST

请求参数：

|参数名称|参数类型|说明 |
|------ |------ |------ |
|image|file|上传的文件名称|

返回数据：

```json
{
    "success":true,
 	"code":200,
    "msg":"success",
    "data":"https://static.mszlu.com/aa.png"
}

```

修改pom文件引入七牛云的sdk pom.xml

```java
<dependency>
  <groupId>com.qiniu</groupId>
  <artifactId>qiniu-java-sdk</artifactId>
  <version>[7.7.0, 7.7.99]</version>
</dependency>

```

## 10.1.2 Controller

src/main/java/com/mszlu/blog/controller/UploadController.java

```java
package com.mszlu.blog.controller;

import com.mszlu.blog.utils.QiniuUtils;
import com.mszlu.blog.vo.Result;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("upload")
public class UploadController {
    @Autowired
    private QiniuUtils qiniuUtils;

    //https://blog.csdn.net/justry_deng/article/details/80855235 MultipartFile介绍
    @PostMapping
    public Result upload(@RequestParam("image")MultipartFile file){
        //原始文件名称 比如说aa.png
        String originalFilename = file.getOriginalFilename();
        //唯一的文件名称
        String fileName =  UUID.randomUUID().toString()+"."+StringUtils.substringAfterLast(originalFilename, ".");
        //上传文件上传到那里呢？　七牛云　云服务器
        //降低我们自身应用服务器的带宽消耗
        boolean upload = qiniuUtils.upload(file, fileName);
        if (upload) {
            return Result.success(QiniuUtils.url+fileName);
        }
        return Result.fail(20001,"上传失败");

}


```

## 10.1.3 使用七牛云

注意七牛云测试域名 https://static.mszlu.com/ 一个月一回收，记得去修改。 springboot默认只上传1M的图片大小所以修改文件配置 src/main/resources/application.properties

```properties
# 上传文件总的最大值
spring.servlet.multipart.max-request-size=20MB
# 单个文件的最大值
spring.servlet.multipart.max-file-size=2MB
```



src/main/java/com/mszlu/blog/utils/QiniuUtils.java

```java
package com.mszlu.blog.utils;

import com.alibaba.fastjson.JSON;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class QiniuUtils {

    public static  final String url = "https://static.mszlu.com/";

//修改以下两个值放到proprietarties中，在密钥管理中获取
    @Value("${qiniu.accessKey}")
    private  String accessKey;
    @Value("${qiniu.accessSecretKey}")
    private  String accessSecretKey;

    public  boolean upload(MultipartFile file,String fileName){

        //构造一个带指定 Region 对象的配置类
        Configuration cfg = new Configuration(Region.huabei());
        //...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);
        //...生成上传凭证，然后准备上传，修改上传名称为自己创立空间的空间名称（是你自己的）
        String bucket = "mszlu";
        //默认不指定key的情况下，以文件内容的hash值作为文件名
        try {
            byte[] uploadBytes = file.getBytes();
            Auth auth = Auth.create(accessKey, accessSecretKey);
            String upToken = auth.uploadToken(bucket);
                Response response = uploadManager.put(uploadBytes, fileName, upToken);
                //解析上传成功的结果
                DefaultPutRet putRet = JSON.parseObject(response.bodyString(), DefaultPutRet.class);
                return true;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        return false;
    }
}


```

## 10.1.4 测试

# 10.2. 导航-文章分类

## 10.2.1 查询所有的文章分类

### 10.2.1.1 接口说明

接口url：/categorys/detail

请求方式：GET

请求参数：

|参数名称|参数类型|说明
|------
|||
|||
|||

返回数据：

```
{
    "success": true, 
    "code": 200, 
    "msg": "success", 
    "data": [
        {
            "id": 1, 
            "avatar": "/static/category/front.png", 
            "categoryName": "前端", 
            "description": "前端是什么，大前端"
        }, 
        {
            "id": 2, 
            "avatar": "/static/category/back.png", 
            "categoryName": "后端", 
            "description": "后端最牛叉"
        }, 
        {
            "id": 3, 
            "avatar": "/static/category/lift.jpg", 
            "categoryName": "生活", 
            "description": "生活趣事"
        }, 
        {
            "id": 4, 
            "avatar": "/static/category/database.png", 
            "categoryName": "数据库", 
            "description": "没数据库，啥也不管用"
        }, 
        {
            "id": 5, 
            "avatar": "/static/category/language.png", 
            "categoryName": "编程语言", 
            "description": "好多语言，该学哪个？"
        }
    ]
}


```

src/main/java/com/mszlu/blog/vo/CategoryVo.java

```
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class CategoryVo {

    private Long id;

    private String avatar;

    private String categoryName;

    private String description;
}


```

### 10.2.1.2 Controller

src/main/java/com/mszlu/blog/controller/CategoryController.java

```
@GetMapping("detail")
    public Result categoriesDetail(){
        return categoryService.findAllDetail();
    }

```

### 10.2.1.3 Service

src/main/java/com/mszlu/blog/service/CategoryService.java

```
    Result findAllDetail();

```

src/main/java/com/mszlu/blog/service/impl/CategoryServiceImpl.java

```
 @Override
    public Result findAllDetail() {
        List<Category> categories = categoryMapper.selectList(new LambdaQueryWrapper<>());
        //页面交互的对象
        return Result.success(copyList(categories));
    }

```

文章分类显示 <img src="https://img-blog.csdnimg.cn/a6140f3851da469f95b0ad3d1946760a.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

## 10.2.2 查询所有的标签

### 10.2.2.1 接口说明

接口url：/tags/detail

请求方式：GET

请求参数：

|参数名称|参数类型|说明
|------
|||
|||
|||

返回数据：

```
{
    "success": true, 
    "code": 200, 
    "msg": "success", 
    "data": [
        {
            "id": 5, 
            "tagName": "springboot", 
            "avatar": "/static/tag/java.png"
        }, 
        {
            "id": 6, 
            "tagName": "spring", 
            "avatar": "/static/tag/java.png"
        }, 
        {
            "id": 7, 
            "tagName": "springmvc", 
            "avatar": "/static/tag/java.png"
        }, 
        {
            "id": 8, 
            "tagName": "11", 
            "avatar": "/static/tag/css.png"
        }
    ]
}

```

### 10.2.2.3 Controller

src/main/java/com/mszlu/blog/vo/TagVo.java

```
package com.mszlu.blog.vo;

import lombok.Data;

@Data
public class TagVo {

    private Long id;

    private String tagName;

    private String avatar;
}


```

src/main/java/com/mszlu/blog/controller/TagsController.java

```
 @GetMapping("detail")
    public Result findAllDetail(){
        return tagService.findAllDetail();
    }

```

### 10.2.2.4 Service

src/main/java/com/mszlu/blog/service/TagService.java

```
    Result findAllDetail();

```

src/main/java/com/mszlu/blog/service/impl/TagServiceImpl.java

```
 @Override
    public Result findAllDetail() {
        LambdaQueryWrapper<Tag> queryWrapper = new LambdaQueryWrapper<>();
        List<Tag> tags = this.tagMapper.selectList(queryWrapper);
        return Result.success(copyList(tags));
    }


```

标签显示 <img src="https://img-blog.csdnimg.cn/5f25cff9383d4f9ea7e735381802d98f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 10.3. 分类文章列表

## 10.3.1 接口说明

接口url：/category/detail/{id}

请求方式：GET

请求参数：

|参数名称|参数类型|说明
|------
|id|分类id|路径参数
|||
|||

返回数据：

```
{
    "success": true, 
    "code": 200, 
    "msg": "success", 
    "data": 
        {
            "id": 1, 
            "avatar": "/static/category/front.png", 
            "categoryName": "前端", 
            "description": "前端是什么，大前端"
        }
}


```

## 10.3.2 Controller

src/main/java/com/mszlu/blog/controller/CategoryController.java

```
  @GetMapping("detail/{id}")
    public Result categoriesDetailById(@PathVariable("id") Long id){
        return categoryService.categoriesDetailById(id);
    }


```

## 10.3.3 Service

src/main/java/com/mszlu/blog/service/CategoryService.java

```
Result categoryDetailById(Long id);

```

src/main/java/com/mszlu/blog/service/impl/CategoryServiceImpl.java

```
@Override
    public Result categoriesDetailById(Long id) {
        Category category = categoryMapper.selectById(id);
        //转换为CategoryVo
        CategoryVo categoryVo = copy(category);
        return Result.success(categoryVo);
    }

```

完成上面这些只能说是可以显示文章分类的图标了 <img src="https://img-blog.csdnimg.cn/8171a442d3544001adc7b1075dc41e3c.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

但是如果想显示后端所有的归属内容得在文章查询列表出进行queryWrapper查找，当文章分类标签不是null时，加入文章分类标签这个查询元素进行分类修改。 src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```
	
    @Override
    public Result listArticle(PageParams pageParams) {
        /**
         * 1、分页查询article数据库表
         */
        Page<Article> page = new Page<>(pageParams.getPage(), pageParams.getPageSize());
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        //查询文章的参数 加上分类id，判断不为空 加上分类条件  
        if (pageParams.getCategoryId()!=null) {
            //and category_id=#{categoryId}
            queryWrapper.eq(Article::getCategoryId,pageParams.getCategoryId());
        }
        //是否置顶进行排序,        //时间倒序进行排列相当于order by create_data desc
        queryWrapper.orderByDesc(Article::getWeight,Article::getCreateDate);
        Page<Article> articlePage = articleMapper.selectPage(page, queryWrapper);
        //分页查询用法 https://blog.csdn.net/weixin_41010294/article/details/105726879
        List<Article> records = articlePage.getRecords();
        // 要返回我们定义的vo数据，就是对应的前端数据，不应该只返回现在的数据需要进一步进行处理
        List<ArticleVo> articleVoList =copyList(records,true,true);
        return Result.success(articleVoList);
    }

```

src/main/java/com/mszlu/blog/vo/params/PageParams.java

```
package com.mszlu.blog.vo.params;

import lombok.Data;

@Data
public class PageParams {

    private int page = 1;

    private int pageSize = 10;

    private Long categoryId;

    private Long tagId;
}


```

最后就可以显示所有文章分类的每个标签下的内容了 <img src="https://img-blog.csdnimg.cn/6032d1fdc57e4b47a4e988c3b497909d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 10.4. 标签文章列表

## 10.4.1 接口说明

接口url：/tags/detail/{id}

请求方式：GET

请求参数：

|参数名称|参数类型|说明|
|------ |------ |------ |
|id|标签id|路径参数|

返回数据：

```json
{
    "success": true, 
    "code": 200, 
    "msg": "success", 
    "data": 
        {
            "id": 5, 
            "tagName": "springboot", 
            "avatar": "/static/tag/java.png"
        }
}


```

## 10.4.2 Controller

src/main/java/com/mszlu/blog/controller/TagsController.java

```java
    @GetMapping("detail/{id}")
    public Result findADetailById(@PathVariable("id") Long id){
        /**
         * 查询所有文章标签下所有的文章
         * @return
         */
        return tagService.findADetailById(id);
    }

```

## 10.4.3 Service

src/main/java/com/mszlu/blog/service/TagService.java

```java
Result findADetailById(Long id);

```

src/main/java/com/mszlu/blog/service/impl/TagServiceImpl.java

```java
 @Override
    public Result findDetailById(Long id) {
        Tag tag = tagMapper.selectById(id);
        TagVo copy = copy(tag);
        return Result.success(copy);
    }

```

完成上面这些这保证了文章标签显示出来了我们需要重写文章查询接口，保证当遇到标签查询时我们可以做到正确查询文章标签所对应的内容，要不每一个标签查出来的内容都是一样的。 <img src="https://img-blog.csdnimg.cn/dafc073d46054793ab60ce8592e87745.png" alt="在这里插入图片描述">

## 10.4.4 修改原有的查询文章接口

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java
        //加入标签条件查询
        //article表中并没有tag字段 一篇文章有多个标签
        //articie_tog article_id 1：n tag_id
        //我们需要利用一个全新的属于文章标签的queryWrapper将这篇文章的article_Tag查出来，保存到一个list当中。
        // 然后再根据queryWrapper的in方法选择我们需要的标签即可。

```

```java

    @Override
    public Result listArticle(PageParams pageParams) {
        /**
         * 1、分页查询article数据库表
         */
        Page<Article> page = new Page<>(pageParams.getPage(), pageParams.getPageSize());
        LambdaQueryWrapper<Article> queryWrapper = new LambdaQueryWrapper<>();
        if (pageParams.getCategoryId()!=null) {
            //and category_id=#{categoryId}
            queryWrapper.eq(Article::getCategoryId,pageParams.getCategoryId());
        }
        List<Long> articleIdList = new ArrayList<>();
        if(pageParams.getTagId()!=null){
            //加入标签条件查询
            //article表中并没有tag字段 一篇文章有多个标签
            //articie_tog article_id 1：n tag_id
            //我们需要利用一个全新的属于文章标签的queryWrapper将这篇文章的article_Tag查出来，保存到一个list当中。
            // 然后再根据queryWrapper的in方法选择我们需要的标签即可。

            LambdaQueryWrapper<ArticleTag> articleTagLambdaQueryWrapper = new LambdaQueryWrapper<>();
            articleTagLambdaQueryWrapper.eq(ArticleTag::getTagId,pageParams.getTagId());
            List<ArticleTag> articleTags = articleTagMapper.selectList(articleTagLambdaQueryWrapper);
            for (ArticleTag articleTag : articleTags) {
                articleIdList.add(articleTag.getArticleId());
            }
            if (articleTags.size() > 0) {
                // and id in(1,2,3)
                queryWrapper.in(Article::getId,articleIdList);
            }

        }
        //是否置顶进行排序,        //时间倒序进行排列相当于order by create_data desc
        queryWrapper.orderByDesc(Article::getWeight,Article::getCreateDate);
        Page<Article> articlePage = articleMapper.selectPage(page, queryWrapper);
        //分页查询用法 https://blog.csdn.net/weixin_41010294/article/details/105726879
        List<Article> records = articlePage.getRecords();
        // 要返回我们定义的vo数据，就是对应的前端数据，不应该只返回现在的数据需要进一步进行处理
        List<ArticleVo> articleVoList =copyList(records,true,true);
        return Result.success(articleVoList);
    }


```

## 10.4.5 测试

最终的结果如下，每一个标签下都对应着该标签所对应的文章 <img src="https://img-blog.csdnimg.cn/b9d6c7684563474bb1b624313f60ad04.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 11.1. 归档文章列表

## 11.1.1 接口说明

接口url：/articles

请求方式：POST

请求参数：

|参数名称|参数类型|说明|
|------ |------ |------ |
|year|string|年|
|month|string|月|

返回数据：

```json
{
    "success": true, 
    "code": 200, 
    "msg": "success", 
    "data": [文章列表，数据同之前的文章列表接口]
        
}
```



## 11.1.2 文章列表参数

src/main/java/com/mszlu/blog/vo/params/PageParams.java

```java
package com.mszlu.blog.vo.params;

import lombok.Data;

@Data
public class PageParams {

    private int page = 1;

    private int pageSize = 10;

    private Long categoryId;

    private Long tagId;

    private String year;

    private String month;

    //传递6的话变成06
    public String getMonth(){
        if (this.month != null &amp;&amp; this.month.length() == 1){
            return "0"+this.month;
        }
        return this.month;
    }
}


```

## 11.1.3 使用自定义sql 实现文章列表

src/main/java/com/mszlu/blog/service/impl/ArticleServiceImpl.java

```java
  @Override
    public Result listArticle(PageParams pageParams) {
        Page<Article> page = new Page<>(pageParams.getPage(),pageParams.getPageSize());
        IPage<Article> articleIPage = this.articleMapper.listArticle(page,pageParams.getCategoryId(),pageParams.getTagId(),pageParams.getYear(),pageParams.getMonth());
        return Result.success(copyList(articleIPage.getRecords(),true,true));
    }

```

```java

    <resultMap id="articleMap" type="com.mszlu.blog.dao.pojo.Article">
        <id column="id" property="id" />
        <result column="author_id" property="authorId"/>
        <result column="comment_counts" property="commentCounts"/>
        <result column="create_date" property="createDate"/>
        <result column="summary" property="summary"/>
        <result column="title" property="title"/>
        <result column="view_counts" property="viewCounts"/>
        <result column="weight" property="weight"/>
        <result column="body_id" property="bodyId"/>
        <result column="category_id" property="categoryId"/>
    </resultMap>

 
<!-- resultMap和resultType区别   https://blog.csdn.net/xushiyu1996818/article/details/89075069?spm=1001.2101.3001.6650.4&amp;utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-4.no_search_link&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-4.no_search_link-->
<!--驼峰命名法   https://blog.csdn.net/A_Java_Dog/article/details/107006391?spm=1001.2101.3001.6650.6&amp;utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-6.no_search_link&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-6.no_search_link-->
<!--    Long categoryId,-->
<!--    Long tagId,-->
<!--    String year,-->
<!--    String month-->
<!--mybatis中xml文件用法    https://blog.csdn.net/weixin_43882997/article/details/85625805-->
<!--动态sql    https://www.jianshu.com/p/e309ae5e4a77-->
<!--驼峰命名    https://zoutao.blog.csdn.net/article/details/82685918?spm=1001.2101.3001.6650.18&amp;utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-18.no_search_link&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-18.no_search_link-->
    <select id="listArticle" resultMap="articleMap">
        select * from ms_article
        <where>
            1 = 1
            <if test="categoryId != null">
                and category_id=#{categoryId}
            </if>
            <if test="tagId != null">
                and id in (select article_id from ms_article_tag where tag_id=#{tagId})
            </if>
            <if test="year != null and year.length>0 and month != null and month.length>0">
                and (FROM_UNIXTIME(create_date/1000,'%Y') =#{year} and FROM_UNIXTIME(create_date/1000,'%m')=#{month})
            </if>
        </where>
        order by weight,create_date desc
    </select>

```

## 11.1.4 测试

结果如下 <img src="https://img-blog.csdnimg.cn/5d87bddb2e8545bf955e6dcdeb3f3e5e.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">

# 11.2. 统一缓存处理（优化）

内存的访问速度 远远大于 磁盘的访问速度 （1000倍起）  src/main/java/com/mszlu/blog/common/cache/Cache.java

```java
package com.mszlu.blog.common.cache;


import java.lang.annotation.*;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Cache {

    long expire() default 1 * 60 * 1000;

    String name() default "";

}


```

src/main/java/com/mszlu/blog/common/cache/CacheAspect.java

```java
package com.mszlu.blog.common.cache;

import com.alibaba.fastjson.JSON;
import com.mszlu.blog.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AliasFor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.time.Duration;

@Aspect
@Component
@Slf4j
public class CacheAspect {

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Pointcut("@annotation(com.mszlu.blog.common.cache.Cache)")
    public void pt(){}

    @Around("pt()")
    public Object around(ProceedingJoinPoint pjp){
        try {
            Signature signature = pjp.getSignature();
            //类名
            String className = pjp.getTarget().getClass().getSimpleName();
            //调用的方法名
            String methodName = signature.getName();


            Class[] parameterTypes = new Class[pjp.getArgs().length];
            Object[] args = pjp.getArgs();
            //参数
            String params = "";
            for(int i=0; i<args.length; i++) {
                if(args[i] != null) {
                    params += JSON.toJSONString(args[i]);
                    parameterTypes[i] = args[i].getClass();
                }else {
                    parameterTypes[i] = null;
                }
            }
            if (StringUtils.isNotEmpty(params)) {
                //加密 以防出现key过长以及字符转义获取不到的情况
                params = DigestUtils.md5Hex(params);
            }
            Method method = pjp.getSignature().getDeclaringType().getMethod(methodName, parameterTypes);
            //获取Cache注解
            Cache annotation = method.getAnnotation(Cache.class);
            //缓存过期时间
            long expire = annotation.expire();
            //缓存名称
            String name = annotation.name();
            //先从redis获取
            String redisKey = name + "::" + className+"::"+methodName+"::"+params;
            String redisValue = redisTemplate.opsForValue().get(redisKey);
            if (StringUtils.isNotEmpty(redisValue)){
                log.info("走了缓存~~~,{},{}",className,methodName);
                return JSON.parseObject(redisValue, Result.class);
            }
            Object proceed = pjp.proceed();
            redisTemplate.opsForValue().set(redisKey,JSON.toJSONString(proceed), Duration.ofMillis(expire));
            log.info("存入缓存~~~ {},{}",className,methodName);
            return proceed;
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return Result.fail(-999,"系统错误");
    }

}


```

使用：

```java
   @PostMapping("hot")
    @Cache(expire = 5 * 60 * 1000,name = "hot_article")
    public Result hotArticle(){
        int limit = 5;
        return articleService.hotArticle(limit);
    }

```

# 11.3. 思考别的优化


1. <font  color='blueviolet'>文章可以放入es当中</font>，便于后续中文分词搜索。springboot教程有和es的整合
2. <font  color='red'> 评论数据，可以考虑放入mongodb当中 </font>电商系统当中 评论数据放入mongo中1.
3.  阅读数和评论数 ，<font  color='cornflowerblue'>考虑把阅读数和评论数 增加的时候 放入redis incr自增，使用定时任务 定时把数据固话到数据库当中</font>
4. 为了加快访问速度，部署的时候，可以把图片，js，css等放入<font  color='orange'>七牛云存储中</font>，加快网站访问速度
5. 做一个后台 <font  color='green'>用springsecurity 做一个权限系统</font>，==对工作帮助比较大==

将域名注册，备案，部署相关

# 管理后台

# 12.1. 搭建项目

## 12.1.1 新建maven工程 blog-admin

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>blog-parent2</artifactId>
        <groupId>com.mszlu</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>blog-admin</artifactId>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
            <!-- 排除 默认使用的logback  -->
            <exclusions>
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- log4j2 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-log4j2</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
            <version>1.2.76</version>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
        </dependency>

        <dependency>
            <groupId>commons-collections</groupId>
            <artifactId>commons-collections</artifactId>
            <version>3.2.2</version>
        </dependency>
        <dependency>
            <groupId>commons-codec</groupId>
            <artifactId>commons-codec</artifactId>
        </dependency>

        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
            <version>3.4.3</version>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
        <dependency>
            <groupId>joda-time</groupId>
            <artifactId>joda-time</artifactId>
            <version>2.10.10</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
    </dependencies>
</project>

```

## 12.1.2 配置

application.properties:

```properties
server.port=8889
spring.application.name=mszlu_admin_blog

#数据库的配置
# datasource
spring.datasource.url=jdbc:mysql://localhost:3306/blog?useUnicode=true&amp;characterEncoding=UTF-8&amp;serverTimeZone=UTC
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

#mybatis-plus
mybatis-plus.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
mybatis-plus.global-config.db-config.table-prefix=ms_

# 上传文件总的最大值
spring.servlet.multipart.max-request-size=20MB
# 单个文件的最大值
spring.servlet.multipart.max-file-size=2MB





```

mybatis-plus配置：

```java
package com.mszlu.blog.admin.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("com.mszlu.blog.admin.mapper")
public class MybatisPlusConfig {

    //分页插件
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor(){
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());
        return interceptor;
    }
}


```

## 12.1.3 启动类

```java
package com.mszlu.blog.admin;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AdminApp {

    public static void main(String[] args) {
        SpringApplication.run(AdminApp.class,args);
    }
}


```

## 12.1.4 导入前端工程

放入resources下的static目录中，前端工程在资料中有

## 12.1.5 新建表

后台管理用户表

```sql
CREATE TABLE `blog`.`ms_admin`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

```

权限表

```sql
CREATE TABLE `blog`.`ms_permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

```

用户和权限的关联表

```sql
CREATE TABLE `blog`.`ms_admin_permission`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(0) NOT NULL,
  `permission_id` bigint(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

```

# 12.2. 权限管理

## 12.2.1 Controller

```
package com.mszlu.blog.admin.controller;

import com.mszlu.blog.admin.model.params.PageParam;
import com.mszlu.blog.admin.pojo.Permission;
import com.mszlu.blog.admin.service.PermissionService;
import com.mszlu.blog.admin.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private PermissionService permissionService;

    @PostMapping("permission/permissionList")
    public Result permissionList(@RequestBody PageParam pageParam){
        return permissionService.listPermission(pageParam);
    }

    @PostMapping("permission/add")
    public Result add(@RequestBody Permission permission){
        return permissionService.add(permission);
    }

    @PostMapping("permission/update")
    public Result update(@RequestBody Permission permission){
        return permissionService.update(permission);
    }

    @GetMapping("permission/delete/{id}")
    public Result delete(@PathVariable("id") Long id){
        return permissionService.delete(id);
    }
}


```

```
package com.mszlu.blog.admin.model.params;

import lombok.Data;

@Data
public class PageParam {

    private Integer currentPage;

    private Integer pageSize;

    private String queryString;
}


```

```
package com.mszlu.blog.admin.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Permission {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    private String path;

    private String description;
}


```

## 12.2.2 Service

```
package com.mszlu.blog.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mszlu.blog.admin.mapper.PermissionMapper;
import com.mszlu.blog.admin.model.params.PageParam;
import com.mszlu.blog.admin.pojo.Permission;
import com.mszlu.blog.admin.vo.PageResult;
import com.mszlu.blog.admin.vo.Result;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    public Result listPermission(PageParam pageParam){
        Page<Permission> page = new Page<>(pageParam.getCurrentPage(),pageParam.getPageSize());
        LambdaQueryWrapper<Permission> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(pageParam.getQueryString())) {
            queryWrapper.eq(Permission::getName,pageParam.getQueryString());
        }
        Page<Permission> permissionPage = this.permissionMapper.selectPage(page, queryWrapper);
        PageResult<Permission> pageResult = new PageResult<>();
        pageResult.setList(permissionPage.getRecords());
        pageResult.setTotal(permissionPage.getTotal());
        return Result.success(pageResult);
    }

    public Result add(Permission permission) {
        this.permissionMapper.insert(permission);
        return Result.success(null);
    }

    public Result update(Permission permission) {
        this.permissionMapper.updateById(permission);
        return Result.success(null);
    }

    public Result delete(Long id) {
        this.permissionMapper.deleteById(id);
        return Result.success(null);
    }
}


```

```
package com.mszlu.blog.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.admin.pojo.Permission;

import java.util.List;

public interface PermissionMapper extends BaseMapper<Permission> {

    
}


```

```
package com.mszlu.blog.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Result {

    private boolean success;

    private int code;

    private String msg;

    private Object data;


    public static Result success(Object data){
        return new Result(true,200,"success",data);
    }

    public static Result fail(int code, String msg){
        return new Result(false,code,msg,null);
    }
}


```

```
package com.mszlu.blog.admin.vo;

import lombok.Data;

import java.util.List;

@Data
public class PageResult<T> {

    private List<T> list;

    private Long total;
}


```

## 12.2.3 测试

# 12.3. Security集成

## 12.3.1 添加依赖

```xml
 <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>

```

## 12.3.2 配置

```java
package com.mszlu.blog.admin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder(){
        return new BCryptPasswordEncoder();
    }

    public static void main(String[] args) {
        //加密策略 MD5 不安全 彩虹表  MD5 加盐
        String mszlu = new BCryptPasswordEncoder().encode("mszlu");
        System.out.println(mszlu);
    }
    @Override
    public void configure(WebSecurity web) throws Exception {
        super.configure(web);
    }
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.authorizeRequests() //开启登录认证
//                .antMatchers("/user/findAll").hasRole("admin") //访问接口需要admin的角色
                .antMatchers("/css/**").permitAll()
                .antMatchers("/img/**").permitAll()
                .antMatchers("/js/**").permitAll()
                .antMatchers("/plugins/**").permitAll()
                .antMatchers("/admin/**").access("@authService.auth(request,authentication)") //自定义service 来去实现实时的权限认证
                .antMatchers("/pages/**").authenticated()
                .and().formLogin()
                .loginPage("/login.html") //自定义的登录页面
                .loginProcessingUrl("/login") //登录处理接口
                .usernameParameter("username") //定义登录时的用户名的key 默认为username
                .passwordParameter("password") //定义登录时的密码key，默认是password
                .defaultSuccessUrl("/pages/main.html")
                .failureUrl("/login.html")
                .permitAll() //通过 不拦截，更加前面配的路径决定，这是指和登录表单相关的接口 都通过
                .and().logout() //退出登录配置
                .logoutUrl("/logout") //退出登录接口
                .logoutSuccessUrl("/login.html")
                .permitAll() //退出登录的接口放行
                .and()
                .httpBasic()
                .and()
                .csrf().disable() //csrf关闭 如果自定义登录 需要关闭
                .headers().frameOptions().sameOrigin();
    }
}


```

## 12.3.3 登录认证

```java
package com.mszlu.blog.admin.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Admin {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String username;

    private String password;
}


```

```java
package com.mszlu.blog.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.admin.mapper.AdminMapper;
import com.mszlu.blog.admin.pojo.Admin;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

@Component
@Slf4j
public class SecurityUserService implements UserDetailsService {
    @Autowired
    private AdminService adminService;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("username:{}",username);
        //当用户登录的时候，springSecurity 就会将请求 转发到此
        //根据用户名 查找用户，不存在 抛出异常，存在 将用户名，密码，授权列表 组装成springSecurity的User对象 并返回
        Admin adminUser = adminService.findAdminByUserName(username);
        if (adminUser == null){
            throw new UsernameNotFoundException("用户名不存在");
        }
        ArrayList<GrantedAuthority> authorities = new ArrayList<>();
        UserDetails userDetails = new User(username,adminUser.getPassword(), authorities);
        //剩下的认证 就由框架帮我们完成
        return userDetails;
    }

    public static void main(String[] args) {
        System.out.println(new BCryptPasswordEncoder().encode("123456"));
    }
}


```

```java
package com.mszlu.blog.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mszlu.blog.admin.mapper.AdminMapper;
import com.mszlu.blog.admin.mapper.PermissionMapper;
import com.mszlu.blog.admin.pojo.Admin;
import com.mszlu.blog.admin.pojo.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private PermissionMapper permissionMapper;

    public Admin findAdminByUserName(String username){
        LambdaQueryWrapper<Admin> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Admin::getUsername,username).last("limit 1");
        Admin adminUser = adminMapper.selectOne(queryWrapper);
        return adminUser;
    }

    public List<Permission> findPermissionsByAdminId(Long adminId){
        return permissionMapper.findPermissionsByAdminId(adminId);
    }

}


```

```java
package com.mszlu.blog.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.admin.pojo.Admin;

public interface AdminMapper extends BaseMapper<Admin> {
}


```

```java
package com.mszlu.blog.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mszlu.blog.admin.pojo.Permission;

import java.util.List;

public interface PermissionMapper extends BaseMapper<Permission> {

    List<Permission> findPermissionsByAdminId(Long adminId);
}


```

## 12.3.4 权限认证

```
package com.mszlu.blog.admin.service;

import com.mszlu.blog.admin.mapper.AdminMapper;
import com.mszlu.blog.admin.pojo.Admin;
import com.mszlu.blog.admin.pojo.Permission;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.List;

@Service
@Slf4j
public class AuthService {

    @Autowired
    private AdminService adminService;

    public boolean auth(HttpServletRequest request, Authentication authentication){
  //权限认证，请求路径
        String requestURI = request.getRequestURI();
        log.info("request url:{}", requestURI);
        //true代表放行 false 代表拦截
        Object principal = authentication.getPrincipal();
        if (principal == null || "anonymousUser".equals(principal)){
            //未登录
            return false;
        }
        UserDetails userDetails = (UserDetails) principal;
        String username = userDetails.getUsername();
        Admin admin = adminService.findAdminByUserName(username);
        if (admin == null){
            return false;
        }
        if (admin.getId() == 1){
            //认为是超级管理员
            return true;
        }
        List<Permission> permissions = adminService.findPermissionsByAdminId(admin.getId());
        requestURI = StringUtils.split(requestURI,'?')[0];
        for (Permission permission : permissions) {
            if (requestURI.equals(permission.getPath())){
                log.info("权限通过");
                return true;
            }
        }
        return false;
    }
}


```

```
package com.mszlu.blog.admin.service;

import org.springframework.security.core.GrantedAuthority;

public class MySimpleGrantedAuthority implements GrantedAuthority {
    private String authority;
    private String path;

    public MySimpleGrantedAuthority(){}

    public MySimpleGrantedAuthority(String authority){
        this.authority = authority;
    }

    public MySimpleGrantedAuthority(String authority,String path){
        this.authority = authority;
        this.path = path;
    }

    @Override
    public String getAuthority() {
        return authority;
    }

    public String getPath() {
        return path;
    }
}


```

```
<?xml version="1.0" encoding="UTF-8" ?>
<!--MyBatis配置文件-->
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.mszlu.blog.admin.mapper.PermissionMapper">

    <select id="findPermissionsByAdminId" parameterType="long" resultType="com.mszlu.blog.admin.pojo.Permission">
        select * from ms_permission where id in (select permission_id from ms_admin_permission where admin_id=#{adminId})
    </select>
</mapper>

```

# 12.4. 作业

添加角色，用户拥有多个角色，一个角色拥有多个权限

# 13.总结技术亮点

1、jwt(==json web token==) + redis

<font  color='red'>token令牌的登录方式，</font>访问认证速度快，session共享，安全性

<font  color='blueviolet'>redis做了令牌和用户信息的对应管理</font>，

> 1. 进一步增加了安全性  
>
> 2. 登录用户做了缓存  
> 3. .灵活控制用户的过期（续期，踢掉线等）

2、threadLocal使用了保存用户信息，请求的线程之内，可以随时获取登录的用户，做了线程隔离

3、在使用完ThreadLocal之后，做了value的删除，防止了内存泄漏（这面试说强引用。弱引用。不是明摆着让面试官间JVM嘛）

4·、线程安全-update table set value = newValue where id=1 and value=oldValue

5、线程池应用非常广，面试<font  color='cornflowerblue'>7个核心参数</font>（对当前的主业务流程无影响的操作，放入线程池执行）

1.登录，记录日志

6·权限系统重点内容

7·统一日志记录，统一缓存处理

# 14.前端

先找到Home.vue,一般这里放主页 views文件夹一般存放页面 components文件夹一般存放vue自定义的组件 一般views用到各个组件

router文件夹存放路由，通过不同的路径跳转到不同的页面 store一般做存储用的 utils文件夹一般是工具类 request一般是请求 api就是跟后端的一些接口的定义 dist文件夹打包之后产生的静态页面 <img src="https://img-blog.csdnimg.cn/044af807c2074a03ab5400e802d98830.png" alt="在这里插入图片描述">

 首先看 config目录中的dev.env.js配置后端访问路径 <img src="https://img-blog.csdnimg.cn/9d7bd434bd9c4832a95a6ce15423289f.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">部署生产环境 <img src="https://img-blog.csdnimg.cn/88a6c9cb65a84532bcd16fd4f9fcd640.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"> 再看static目录，category是图片路径 <img src="https://img-blog.csdnimg.cn/e74469e082de45bb84247f69a4befd3d.png" alt="在这里插入图片描述"> 在数据库中这样配置 <img src="https://img-blog.csdnimg.cn/60969ea981e6468aac29a7dd878e8044.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"> 再看src目录 <img src="https://img-blog.csdnimg.cn/036a9496a1ef4451aab1671660a2678b.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_11,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"> api表示后端接口访问的定义，囊括了所有后端的访问接口

以api文件夹下的article.js为例子

```
import request from '@/request'


export function getArticles(query, page) {
  return request({
    url: '/articles',//访问路径
    method: 'post',//访问方式post
    //传递参数
    data: {
      page: page.pageNumber,
      pageSize: page.pageSize,
      name: page.name,
      sort: page.sort,
      year: query.year,
      month: query.month,
      tagId: query.tagId,
      categoryId: query.categoryId
    }
  })
}

export function getHotArtices() {
  return request({
    url: '/articles/hot',//接口路径的名称也可以随意更改
    method: 'post'//访问方式，想改成get直接修改即可
  })
}

export function getNewArtices() {
  return request({
    url: '/articles/new',
    method: 'post'
  })
}

export function viewArticle(id) {
  return request({
    url: `/articles/view/${id}`,
    method: 'post'
  })
}

export function getArticlesByCategory(id) {
  return request({
    url: `/articles/category/${id}`,
    method: 'post'
  })
}

export function getArticlesByTag(id) {
  return request({
    url: `/articles/tag/${id}`,
    method: 'post'
  })
}


export function publishArticle(article,token) {
  return request({
    headers: {'Authorization': token},
    url: '/articles/publish',
    method: 'post',
    data: article
  })
}

export function listArchives() {
  return request({
    url: '/articles/listArchives',
    method: 'post'
  })
}

export function getArticleById(id) {
  return request({
    url: `/articles/${id}`,
    method: 'post'
  })
}


```

在login.js文件中

```
import request from '@/request'

export function login(account, password) {
  const data = {
    account,
    password
  }
  return request({
    url: '/login',
    method: 'post',
    data
  })
}

export function logout(token) {
  return request({
    headers: {'Authorization': token},//在后端通过headers获取token
    url: '/logout',
    method: 'get'
  })
}

export function getUserInfo(token) {
  return request({
    headers: {'Authorization': token},
    url: '/users/currentUser',
    method: 'get'
  })
}

export function register(account, nickname, password) {
  const data = {
    account,
    nickname,
    password
  }
  return request({
    url: '/register',
    method: 'post',
    data
  })
}


```

在home.vue文件夹中

```
<template>
  <div id="home">
    <el-container>
    	
    	<base-header :activeIndex="activeIndex"></base-header>//头
		  
		  <router-view class="me-container"/>//容器
		  
			<base-footer v-show="footerShow"></base-footer>//尾
		  
		</el-container>
		
  </div>
  
</template>

<script>
//components对应components目录，views对应views目录
import BaseFooter from '@/components/BaseFooter'
import BaseHeader from '@/views/BaseHeader'

export default {
  name: 'Home',
  data (){
  	return {
  			activeIndex: '/',
  			footerShow:true
  	}
  },
  components:{
  	'base-header':BaseHeader,
  	'base-footer':BaseFooter
  },
  beforeRouteEnter (to, from, next){
  	 next(vm => {
    	vm.activeIndex = to.path
  	})
  },
  beforeRouteUpdate (to, from, next) {
	  if(to.path == '/'){
	  	this.footerShow = true
	  }else{
	  	this.footerShow = false
	  }
	  this.activeIndex = to.path
	  next()
	}
}
</script>

<style>

.me-container{
  margin: 100px auto 140px;
}
</style>


```

components文件夹下的src\components\BaseFooter.vue文件夹

```
<template>
  <el-footer class="me-area">
    <div class="me-footer">
      <p>Designed by
        <strong>
          <router-link to="/" class="me-login-design-color">码神之路</router-link>
        </strong>
      </p>
    </div>
  </el-footer>

</template>

<script>

  export default {
    name: 'BaseFooter',
    data() {
      return {}
    },
    methods: {},
    mounted() {
    }
  }
</script>

<style>

  .el-footer {
    min-width: 100%;
    box-shadow: 0 -2px 3px hsla(0, 0%, 7%, .1), 0 0 0 1px hsla(0, 0%, 7%, .1);
    position: absolute;
    bottom: 0;
    left: 0;
    z-index: 1024;
  }

  .me-footer {
    text-align: center;
    line-height: 60px;
    font-family: 'Open Sans', sans-serif;
    font-size: 18px;

  }

  .me-login-design-color {
    color: #5FB878 !important;
  }

</style>


```

对应图片最下方 <img src="https://img-blog.csdnimg.cn/b4d8b9ca10c445fa892a4185498ab4f5.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">src\views\BaseHeader.vue文件头

```
<template>
  <el-header class="me-area">
    <el-row class="me-header">

      <el-col :span="4" class="me-header-left">
        <router-link to="/" class="me-title">
          <img src="../assets/img/logo.png" />
        </router-link>
      </el-col>

      <el-col v-if="!simple" :span="16">
        <el-menu :router=true menu-trigger="click" active-text-color="#5FB878" :default-active="activeIndex"
                 mode="horizontal">
          <el-menu-item index="/">首页</el-menu-item>
          <el-menu-item index="/category/all">文章分类</el-menu-item>
          <el-menu-item index="/tag/all">标签</el-menu-item>
          <el-menu-item index="/archives">文章归档</el-menu-item>

          <el-col :span="4" :offset="4">
            <el-menu-item index="/write"><i class="el-icon-edit"></i>写文章</el-menu-item>
          </el-col>

        </el-menu>
      </el-col>

      <template v-else>
        <slot></slot>
      </template>

      <el-col :span="4">
        <el-menu :router=true menu-trigger="click" mode="horizontal" active-text-color="#5FB878">

          <template v-if="!user.login">
            <el-menu-item index="/login">
              <el-button type="text">登录</el-button>
            </el-menu-item>
            <el-menu-item index="/register">
              <el-button type="text">注册</el-button>
            </el-menu-item>
          </template>

          <template v-else>
            <el-submenu index>
              <template slot="title">
                <img class="me-header-picture" :src="user.avatar"/>//头像获取
              </template>
              <el-menu-item index @click="logout"><i class="el-icon-back"></i>退出</el-menu-item>
            </el-submenu>
          </template>
        </el-menu>
      </el-col>

    </el-row>
  </el-header>
</template>

<script>
  export default {
    name: 'BaseHeader',
    props: {
      activeIndex: String,
      simple: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {}
    },
    computed: {
      user() {
        let login = this.$store.state.account.length != 0
        let avatar = this.$store.state.avatar
        return {
          login, avatar
        }
      }
    },
    methods: {
      logout() {
        let that = this
        this.$store.dispatch('logout').then(() => {
          this.$router.push({path: '/'})
        }).catch((error) => {
          if (error !== 'error') {
            that.$message({message: error, type: 'error', showClose: true});
          }
        })
      }
    }
  }
</script>

<style>

  .el-header {
    position: fixed;
    z-index: 1024;
    min-width: 100%;
    box-shadow: 0 2px 3px hsla(0, 0%, 7%, .1), 0 0 0 1px hsla(0, 0%, 7%, .1);
  }

  .me-title {
    margin-top: 10px;
    font-size: 24px;
  }

  .me-header-left {
    margin-top: 10px;
  }

  .me-title img {
    max-height: 2.4rem;
    max-width: 100%;
  }

  .me-header-picture {
    width: 36px;
    height: 36px;
    border: 1px solid #ddd;
    border-radius: 50%;
    vertical-align: middle;
    background-color: #5fb878;
  }
</style>


```

对应图片最上方 <img src="https://img-blog.csdnimg.cn/096a5883f6fa4c76b033b07edf2ee97a.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"> BaseHeader.vue中的logout本质上调用store文件夹下的index.js文件 <img src="https://img-blog.csdnimg.cn/551ffd8306064756b3aea8629c615481.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBAbGptXzk5,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述">
