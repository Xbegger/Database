## MyBatis3

### MyBatis介绍

https://mybatis.org/mybatis-3/zh/getting-started.html

1. JDBC(java data base connection)java数据库连接

> 优点:
>
> 运行期快捷 , 高效
>
> 缺点:
>
> 编辑器代码量大 , 繁琐异常操作 , 不支持数据库跨平台



jdbc核心API:

* DriverManager   连接数据库
* Connection         连接数据可的抽象
* Statment             执行SQL
* ResultsSet           数据结果集

![image-20211109181845206](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111091818348.png)



2. DBUtils

![image-20211109181929076](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111091819196.png)



<img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111091820327.png" alt="image-20211109182041120" style="zoom:200%;" />



4. JDBC Template

* 优点:运行期高效 , 内嵌spring框架中 , 支持基于AOP的声明式事务

* 缺点:必须与Spring框架结合在一起 , 不支持数据库跨平台,默认没有缓存.

  

### ORM

object relational mapping对象关系映射

>  对象关系映射（Object Relational Mapping，简称ORM）模式<font  color='cblue'>是一种为了解决面向对象与关系数据库存在的互不匹配的现象的技术</font>。简单的说，==ORM是通过使用描述对象和数据库之间映射的元数据，将程序中的对象自动持久化到关系数据库中==。



### Mybatis

优秀的持久层框架(**ORM**) , 支持自定义SQL ,,存储过程 , 以及高级映射.

可以通过==简单的xml==或==注解==来配置和映射**原始类型,接口,和java POJO**(plain old java objects 普通老式java对象)为数据库中的记录

![image-20211109184150578](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111091841677.png)



### 数据源和连接池的区别

数据源:

> 所谓数据源也就是==数据的来源==。它存储了所有建立数据库连接需要的信息。是提供某种所需要数据的器件或原始媒体。在数据源中存储了所有建立数据库连接的信息。就像通过指定文件名称可以在文件系统中找到文件一样，通过提供正确的数据源名称，你可以找到相应的数据库连接算是对数据库的一个抽象映射，==即一个数据源对应一个数据库==。==一个数据库也可以创建多个数据源==

有以下属性:

* **databaseName** String数据库名称，即数据库的SID。
* **dataSourceName** String数据源接口实现类的名称。
* **description** String 对数据源的描述。
* **networkProtocol** String 和服务器通讯使用的网络协议名。
* **password** String 用户登录密码。
* **portNumber**数据库服务器使用的端口。
* **serverName** String数据库服务器名称。
* **user** String 用户登录名。

==如果数据是水，数据库就是水库，数据源就是连接水库的管道，终端用户看到的数据集是管道里流出来的水。==



连接池:

> ==连接池是创建和管理一个连接的缓冲池的技术==，这些连接准备好被任何需要它们的线程使用。当一个线程需要用JDBC对一个数据库操作时，将从池中请求一个连接。当这个连接使用完毕后，将返回到连接池中，等待为其他的线程服务。

比如java**利用**数据源创建某个数据库的多个连接，将连接保存不关闭（这就叫缓存），这个缓冲区就叫连接池，每次需要于数据库连接时，直接从连接池中取得连接就行。用完还回连接池，但是连接并没关闭。



**==maven编译之后会将java和resources文件合并成一级生成到classpath中去==**所以为了保证xxxMapper接口和xxxMapper.xml保持相同位置需要在resources中配置与java相同的路径,最后结果是:

![image-20211111095947634](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111110959719.png)





### 快速搭建MyBatis项目并实现CRUD

确保Emp类对应的是Mysql数据库中的table

* id:主键,自增
* username:用户名

1. 创建maven项目
2. 导入依赖

文件目录结构:

![image-20211111110227161](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111111102258.png)

基本配置

#### pom.xml

```xml
<dependencies>
    <!--mybatis核心依赖-->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.5.7</version>
    </dependency>
    <!--数据库连接器驱动-->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.27</version>
    </dependency>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13</version>
        <scope>test</scope>
    </dependency>

</dependencies>
```

#### mybatis.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<configuration>
    <!--环境配置，连接的数据库，这里使用的是MySQL-->
    <environments default="development">
        <environment id="development">
            <!--指定事务管理的类型，这里简单使用Java的JDBC的提交和回滚设置-->
            <transactionManager type="JDBC"/>
            <!--dataSource 指连接源配置，POOLED是JDBC连接对象的数据源连接池的实现-->
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/mybatis"/>
                <property name="username" value="root"/>
                <property name="password" value="123123"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <!--这是告诉Mybatis去哪找持久化类的映射文件，对于在src下的文件直接写文件名，
     如果在某包下，则要写明路径,如：com/mybatistest/config/User.xml-->
        <!--<mapper resource="EmpMapper.xml"/>-->

        <!--接口绑定需要使用class-->
        <mapper class="com.jt.mapper.EmpMapper"/>
    </mappers>
</configuration>
```

`  <property name="driver" value="com.mysql.cj.jdbc.Driver"/>`==value值来自于这里==

![image-20211111141127214](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111111411296.png)



#### EmpMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.jt.mapper.EmpMapper">

    <!--// 根据id来查询Emp实体-->
    <!--resultType接收类型-->
    <select id="selectEmp" resultType="com.jt.pojo.Emp">
        select *
        from Emp
        where id = #{id}
    </select>

    <insert id="insertEmp">
        INSERT INTO `mybatis`.`emp` (`username`)
        VALUES (#{username});
    </insert>

    <update id="updateEmp">
        UPDATE EMP
        SET username=#{username}
        where id = #{id}
    </update>

    <delete id="deleteEmp">
        delete
        from emp
        where id = #{id}
    </delete>
</mapper>

```

#### Emp实体类

```java
package com.jt.pojo;
public class Emp {
    private Integer id;
    private String username;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    @Override
    public String toString() {
        return "Emp{" +
                "id=" + id +
                ", username='" + username + '\'' +
                '}';
    }
}
```

#### EmpMapper接口

```java
public interface EmpMapper {
    // 根据id来查询Emp实体
    // 注意需要更改EmpMapper.xml中的namespace为类的完全限定名
    Emp selectEmp(Integer id);

    //插入
    Integer insertEmp(Emp emp);

    //更新
    Integer updateEmp(Emp emp);

    //删除
    Integer deleteEmp(Integer id);
    
    // 基于注解的方式:@Select("select * from emp where id = #{id}")
    //  Emp selectEmp(Integer id);
}
```

#### 测试类MyBatisTest

```java
package com.jt.tests;
/**
 * MyBatis搭建步骤:
 * 0.提前拥有数据库和表
 * 1.添加pom依赖: mybatis的核心依赖 和 数据库对应版本的驱动jar包
 * 2.添加mybatis全局配置文件(直接复制)
 * 3.修改全局配置文件中的 数据源配置信息
 * 4.添加数据库表对应的POJO对象(相当于实体类)
 * 5.添加对应的XxxMapper.xml （里面维护了所有的sql）
 *   修改namespace：
 *      如果是statementID的方式没有特殊的要求
 *      如果是基于接口绑定的方式，必须要等于接口的完整限定名
 *   修改对应的id(唯一)， resultType对应返回的类型（如果是pojo就需要指定完整限定名）
 * 6.修改mybatis的全局配置文件：修改Mapper
 */

public class MyBatisTest {
    SqlSessionFactory sqlSessionFactory;

    @Before
    public void before() {
        // 从xml中构建SqlSessionFactory
        String resource = "mybatis.xml";
        InputStream inputStream = null;
        try {
            inputStream = Resources.getResourceAsStream(resource);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

    }


    /**
     * 基于statementID的方式去执行(老版本,不推荐)
     */
    @Test
    public void test01() throws IOException {

        try (SqlSession session = sqlSessionFactory.openSession()) {
            // 参数之一是statementID,通过EmpMapper.xml中来获得
            Emp emp = (Emp) session.selectOne("com.jt.pojo.EmpMapper.selectEmp", 1);
            System.out.println(emp);
        }
    }

    /**
     * 基于接口绑定的方式(利用xml的方式最为推荐!)
     * 1.新建数据访问层的接口：POJOMapper
     * 2.添加mapper中对应操作的方法
     *      -方法名要和mapper中对应的操作的节点的id要一致
     *      -返回类型要和mapper中对应的resultType要一致
     *      -mapper中对应的操作的节点的参数必须要在方法的参数中声明
     * 3.mapper.xml中的namespace必须要和接口的完整限定名要一致
     * 4.修改mybatis全局配置文件中的mappers，采用接口绑定的方式：
     *      <mappers>
     *          <mapper class="com.jt.mapper.EmpMapper"/>
     *      </mappers>
     * 5.一定要将mapper.xml和接口放在同一级目录中,只需要在resources中新建和接口
     * 同样结构的文件夹就可以了,最后会将java和resources合并到一起
     */
    @Test
    public void test02() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            EmpMapper mapper = session.getMapper(EmpMapper.class);
            Emp emp = mapper.selectEmp(1);
            System.out.println(emp);
        }
    }

    /**
     * 基于注解的方式(看起来简单,但是不推荐,因为复杂的SQL语句不好写!)
     * 在对应的方法上协商对应的注解
     * eg:@Select("select * from emp where id = #{id}")
     * 注意:
     *      注解可以和xml共用,但是不能同时存在方法对应的xml的id
     */
    @Test
    public void test03() {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            EmpMapper mapper = session.getMapper(EmpMapper.class);
            Emp emp = mapper.selectEmp(1);
            System.out.println(emp);
        }
    }
}
```

#### 测试类MyBatisCRUD

```java
package com.jt.tests;
public class MyBatisCRUD {
    SqlSessionFactory sqlSessionFactory;
    @Before
    public void before() {
        // 从xml中构建SqlSessionFactory
        String resource = "mybatis.xml";
        InputStream inputStream = null;
        try {
            inputStream = Resources.getResourceAsStream(resource);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

    }
    /**
     * 查询
     */
    @Test
    public void select() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        Emp emp = mapper.selectEmp(1);
        System.out.println(emp);
    }
    /**
     * 添加
     */
    @Test
    public void insert() {
        // openSession()方法中可以添加一个boolean值用于开启自动提交!
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        Emp emp = new Emp();
        emp.setUsername("叙述");
        try {
            Integer result = mapper.insertEmp(emp);
            System.out.println(result);
            //手动提交
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
        }finally{
            sqlSession.close();
        }
    }
    /**
     * 更新
     */
    @Test
    public void update() {
        // openSession()方法中可以添加一个boolean值用于开启自动提交!
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        Emp emp = new Emp();
        emp.setId(4);
        emp.setUsername("更改后");
        try {
            Integer result = mapper.updateEmp(emp);
            System.out.println(result);
            //手动提交
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
        }finally{
            sqlSession.close();
        }
    }
    /**
     * 删除
     */
    @Test
    public void delete() {
        // openSession()方法中可以添加一个boolean值用于开启自动提交!
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        try {
            Integer result = mapper.deleteEmp(1);
            System.out.println(result);
            //手动提交
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
        }finally{
            sqlSession.close();
        }
    }
}
```



### 日志框架

![image-20211111143714833](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111111437930.png)



日志门面:==SLF4j==(集成日志框架的一个抽象层)

日志实现:==Log4j2== 或 ==Logback==



如何在mybatis中实现(采用**==SLF4j+Logback==**)?

```xml
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>1.7.32</version>
</dependency>

<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.2.3</version>
</dependency>
```



### 全局配置文件详解

![image-20211111212504363](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111112125467.png)

#### mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">

<!--注意：classpath（resources）下需要文件db.properties来设置数据库信息
        mysql.driver=com.mysql.cj.jdbc.Driver
        mysql.url=jdbc:mysql://localhost:3306/mybatis
        mysql.username=root
        mysql.password=123123
-->
<!--就是DOCTYPE后面对应的根节点-->
<configuration>
    <!--配置外部属性资源文件，通过${xxx}引用-->
    <properties resource="db.properties"/>


    <!--环境配置，连接的数据库，这里使用的是MySQL
        可以多个环境 default可以用id设置选则那个environment
    -->
    <environments default="development">
        <!--配置数据库环境 id指定当前数据库环境的唯一标识,会被父节点所设置-->
        <environment id="development">
            <!--指定事务管理的类型，这里简单使用Java的JDBC的提交和回滚设置
                type= JDBC      :使用JDBC的事务管理
                    =MANAGED    :不使用事务
            -->
            <transactionManager type="JDBC"/>
            <!--dataSource 指连接数据源配置，POOLED是JDBC连接对象的数据源连接池的实现
                type=POOLED     :使用连接池
                    UNPOOLED    :不适用连接池
                    JNDI        :在Tomcat中使用
            -->
            <dataSource type="POOLED">
                <property name="driver" value="${mysql.driver}"/>
                <property name="url" value="${mysql.url}"/>
                <property name="username" value="${mysql.username}"/>
                <property name="password" value="${mysql.password}"/>
            </dataSource>
        </environment>

    </environments>

    <!--设置映射器 4种方式
        1.<mapper resource  :设置Mapper.xml,适用于根据statementId进行操作
        2.<mapper class     :设置Mapper接口,适用接口绑定方式
        3.<mapper url       :设置磁盘的绝对路径
        4.<package          :根据包设置Mapper接口 （常用）
    -->
    <mappers>
        <!--这是告诉Mybatis去哪找持久化类的映射文件，对于在src下的文件直接写文件名，
     如果在某包下，则要写明路径,如：com/mybatistest/config/User.xml-->
        <!--<mapper resource="EmpMapper.xml"/>-->

        <!--接口绑定需要使用class-->
        <mapper class="com.jt.mapper.EmpMapper"/>

        <!--根据包设置包下面的所有Mapper接口-->
        <!--<package name=""/>-->
    </mappers>
</configuration>
```

![image-20211111220238457](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111112202609.png)

https://mybatis.org/mybatis-3/zh/configuration.html#settings

#### logback.xml

```xml
<!--注意 如果使用logback作为日志实现层
    则需要在resources目录下新建文件
    logback.xml文件,内容大概如下
    这是约定大于配置的原则!!!!!!!!!!!!

    文件名:logback.xml
-->
<configuration>
    <!--appender 追加器 指示日志以哪种方式进行输出!
        name    取个名字
        class   不同的实现类会输出到不同的地方
                -ch.qos.logback.core.FileAppender   :输出到文件
                -ch.qos.logback.core.ConsoleAppender:输出到控制台
    -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{100} - %msg%n</pattern>
        </encoder>
    </appender>

    <!--控制更细粒度的日志级别,根据包or类-->
    <!--<logger name="" level="debug"/>-->

    <!--控制所有的日志级别
        trace
        debug
        info
        warn
        error
    -->
    <root level="debug">
        <!--将当前日志级别输出到那个追加器上面-->
        <appender-ref ref="STDOUT" />
    </root>
</configuration>
<!--
    在java文件中这样使用:
    Logger LOGGER = LoggerFactory.getLogger(this.getClass());
-->
```

#### EmpMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--命名空间是 数据库访问层 接口 的 完全限定名-->
<mapper namespace="com.jt.mapper.EmpMapper">
    <select id="selectEmp" resultType="com.jt.pojo.Emp">
        SELECT * FROM EMP WHERE id=#{id}
    </select>
</mapper>


```

#### db.properties

```properties
mysql.driver=com.mysql.cj.jdbc.Driver
mysql.url=jdbc:mysql://localhost:3306/mybatis
mysql.username=root
mysql.password=123123
```



#### Mapper中的Select元素的属性

| 属性            | 描述                                                         |
| --------------- | ------------------------------------------------------------ |
| `id`            | 在命名空间中唯一的标识符，可以被用来引用这条语句。           |
| `parameterType` | 将会传入这条语句的参数的类全限定名或别名。这个属性是可选的，因为 MyBatis 可以通过类型处理器（TypeHandler）推断出具体传入语句的参数，默认值为未设置（unset）。 |
| `resultType`    | 期望从这条语句中返回结果的类全限定名或别名。 注意，如果返回的是集合，那应该设置为集合包含的类型，而不是集合本身的类型。 resultType 和 resultMap 之间只能同时使用一个。 |
| `resultMap`     | 对外部 resultMap 的命名引用。结果映射是 MyBatis 最强大的特性，如果你对其理解透彻，许多复杂的映射问题都能迎刃而解。 resultType 和 resultMap 之间只能同时使用一个。 |
| `flushCache`    | 将其设置为 true 后，只要语句被调用，都会导致本地缓存和二级缓存被清空，默认值：false。 |
| `useCache`      | 将其设置为 true 后，将会导致本条语句的结果被二级缓存缓存起来，默认值：对 select 元素为 true。 |
| `statementType` | 可选 STATEMENT，PREPARED 或 CALLABLE。这会让 MyBatis 分别使用 Statement，PreparedStatement 或 CallableStatement，默认值：PREPARED。 |
| `resultSetType` | FORWARD_ONLY，SCROLL_SENSITIVE, SCROLL_INSENSITIVE 或 DEFAULT（等价于 unset） 中的一个，默认值为 unset （依赖数据库驱动）。 |
| `resultSets`    | 这个设置仅适用于多结果集的情况。它将列出语句执行后返回的结果集并赋予每个结果集一个名称，多个名称之间以逗号分隔。 |

#### Mapper中Insert, Update, Delete 元素的属性

| 属性               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| `id`               | 在命名空间中唯一的标识符，可以被用来引用这条语句。           |
| `parameterType`    | 将会传入这条语句的参数的类全限定名或别名。这个属性是可选的，因为 MyBatis 可以通过类型处理器（TypeHandler）推断出具体传入语句的参数，默认值为未设置（unset）。 |
| `parameterMap`     | 用于引用外部 parameterMap 的属性，目前已被废弃。请使用行内参数映射和 parameterType 属性。 |
| `flushCache`       | 将其设置为 true 后，只要语句被调用，都会导致本地缓存和二级缓存被清空，默认值：（对 insert、update 和 delete 语句）true。 |
| `timeout`          | 这个设置是在抛出异常之前，驱动程序等待数据库返回请求结果的秒数。默认值为未设置（unset）（依赖数据库驱动）。 |
| `statementType`    | 可选 STATEMENT，PREPARED 或 CALLABLE。这会让 MyBatis 分别使用 Statement，PreparedStatement 或 CallableStatement，默认值：PREPARED。 |
| `useGeneratedKeys` | （仅适用于 insert 和 update）这会令 MyBatis 使用 JDBC 的 getGeneratedKeys 方法来取出由数据库内部生成的主键（比如：像 MySQL 和 SQL Server 这样的关系型数据库管理系统的自动递增字段），默认值：false。 |
| `keyProperty`      | （仅适用于 insert 和 update）指定能够唯一识别对象的属性，MyBatis 会使用 getGeneratedKeys 的返回值或 insert 语句的 selectKey 子元素设置它的值，默认值：未设置（`unset`）。如果生成列不止一个，可以用逗号分隔多个属性名称。 |
| `keyColumn`        | （仅适用于 insert 和 update）设置生成键值在表中的列名，在某些数据库（像 PostgreSQL）中，当主键列不是表中的第一列的时候，是必须设置的。如果生成列不止一个，可以用逗号分隔多个属性名称。 |
| `databaseId`       | 如果配置了数据库厂商标识（databaseIdProvider），MyBatis 会加载所有不带 databaseId 或匹配当前 databaseId 的语句；如果带和不带的语句都有，则不带的会被忽略。 |



![image-20211112221409579](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111122214713.png)



### 参数-返回结果处理

默认情况下，使用 `#{}` 参数语法时，MyBatis 会创建 `PreparedStatement` 参数占位符，==并通过占位符安全地设置参数（就像使用 ? 一样）。 这样做更安全，更迅速，通常也是首选做法==，不过有时你就是想直接在 SQL 语句中直接插入一个不转义的字符串。 比如 ORDER BY 子句，这时候你可以：



#### 解决数据库中字段名字与JavaBean字段不匹配的问题

mybatis-config文件!

```xml
<!--可以将下划线命名的数据库列映射到java对象的驼峰式命名属性-->
<settings>
    <setting name="mapUnderscoreToCamelCase" value="true"/>
</settings>
```

![image-20211113100026811](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111131000922.png)

#### 参数如何配置

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--命名空间是 数据库访问层 接口 的 完全限定名
    默认情况下时随意填写，但是采用接口绑定的方式就必须要输入对应的接口的完整限定名
    <select id="xxx" resultType="Emp">resultType后面需要是POJO的完整限定名
    如果在config文件中加入了<typeAliases> 可以使用简短的别名
-->
<mapper namespace="com.jt.mapper.EmpMapper">

    <!--获取参数的方式:
        1.#{}(推荐) :会将参数编译成`?`
            -会经过JDBC当中的PreparedStatement的预编译,根据不同的数据类型来编译成
             对应的数据库所对应的数据
            -能够有效的防止SQL注入
            -特殊方式（自带很多内置属性,但通常不会去使用!）

        2.${} :参数编译成字符串拼接的方式 "id="+1
            -不会进行预编译,直接将输入进来的数据拼接在SQL中
            -存在SQL注入的风险
            -特殊用法:
                1.调试的时候可以临时使用,因为控制台的输出是完整的SQL语句!
                2.可以实现:动态表 动态列 动态SQL(前提是一定保证数据安全性)
    -->



    <!--参数传递的处理：
        1.单个参数: SelectEmp(Integer id);
            mybatis不会有什么强制的要求#{输入任何字符获取参数}

        2.多个参数: Emp SelectEmp(Integer id, String username);
            mybatis会进行封装,会将传进来的参数封装成Map;
            一个值对应两个map项:
                -id        ==> {key:arg0 , value:id的值} {key:param1 , value:id的值}
                -username  ==> {key:arg1 , value:un的值} {key:param2 , value:un的值}
            所以可以使用#{arg0} #{param1} #{arg1} #{param2}
            除了使用这种没有意义的参数名还可以使用注解!!!
            设置参数的别名@Param("xxx"),当使用了@Param只能使用#{xxx}或者#{paramX}

         3.JavaBean参数:
            单个参数:Emp selectEmp(Emp emp);
                -可以直接使用属性名
                emp.id == #{id}
                emp.username == #{username}
            多个参数:Emp selectEmp(Integer num , Emp emp);
                num ==> @Param 或者 #{param1}(只记住param就最好忘记arg)
                emp ==> 必须加上对象名 #{param2.id} 或者 @Param("emp") #{emp.id}

         4.集合或者数组
            Emp selectEmp(List<String> usernames);

            如果是list,MyBatis会自动封装为map:
            {key:"list" , value :usernames}
                要获得usernames.get(0) ==> #{list[0]}

            如果是数组,MyBatis会自动封装成map:
            {key:"array" , value :usernames}

         5.map参数
            和javabean的参数传递一样
            一般情况下:
                请求进来的参数和POJO对应,就用POJO
                请求进来的参数没有和POJO对应 , 就用map
                请求进来的参数 没有和POJO对应,但使用频率很高,就用TO DTO(就是单独为这些参数创建的javaBean)
    -->

    <select id="selectEmp" resultType="Emp">
        SELECT `emp`.`id`,
        `emp`.`user_name`
        FROM `mybatis`.`emp` WHERE user_name=#{list[0]} or user_name=#{list[1]};
    </select>

</mapper>
```

#### 返回结果如何配置

```xml
    <!--根据id查询
          返回类型设置:
            如果返回一行数据,就用POJO接收,或者map
            如果返回多行数据,就可以使用List<pojo> List<map>
                resultType指定List中泛型类型就可以(pojo map ....)
            基础类型或者包装类型直接指定别名就行
    -->
    <!--1.声明resultMap自定义结果集 resultType 和 resultMap 只能使用一个
        id 唯一标识,需要和resultMap进行对应
        type 需要映射的pojo对象,可以设置别名
        autoMapping 自动映射,默认为true ,只要字段名和属性名遵循映射规则就可以自动映射,但是不建议
            哪怕属性名,和字段名一一对应也要显示的配置映射
        extends 如果多个resultMap有重复的映射,可以声明父resultMap,将公共的映射提取出来,可以减少
            子resultMap的映射冗余
    -->
    <resultMap id="emp_map" type="emp">
        <!--主键必须使用id节点,对底层的存储有性能作用,可读性也高
            column 需要映射的数据库字段名
            property 需要映射的pojo属性名
        -->
        <id column="id" property="id"/>
        <result column="user_name" property="username"/>
        <result column="create_date" property="cjsj"/>
    </resultMap>
    <!--2.使用resultMap关联 自定义结果集的id-->
    <select id="selectEmp"  resultMap="emp_map">
        SELECT `emp`.`id`,
        `emp`.`user_name`,
        `emp`.`create_date`
        FROM `mybatis`.`emp` WHERE id=#{id};
    </select>
```



### 高级结果映射

**懒加载**(全局模式)

```xml
<settings>
    <!--开启延迟加载,之后的所有分步查询都是懒加载,默认是立即加载,-->
    <setting name="lazyLoadingEnabled" value="true"/>
    <!--开启后,使用pojo中任意属性都会启用立即加载延迟查询(贪心),默认是false-->
    <setting name="aggressiveLazyLoading" value="true"/>
    <!--设置对象的那些方法调用会立即加载延迟查询 默认equals,clone,hashCode,toStrin-->
    <setting name="lazyLoadTriggerMethods" value="hashCode"/>
</settings>
```

**懒加载**(单独配置)

xxxxxxx

==懒加载没啥用!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!==

 ![image-20211113205810068](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111132058179.png)

```xml
<!--嵌套结果:一对多 查询部门及所有员工-->
<resultMap id="selectDeptAndEmpsMap" type="dept">
    <id column="d_id" property="id"/>
    <id column="dept_name" property="deptName"/>
    <collection property="emps" ofType="emp">
        <id column="e_id" property="id"/>
        <result column="user_name" property="userName"/>
        <result column="create_date" property="createDate"/>
    </collection>
</resultMap>
```



### 动态SQL

 最有用 最实用的MyBatis特性!

<img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111140945832.png" alt="image-20211114094545726" style="zoom:150%;" />



html特殊转义表:

![image-20211114095633608](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111140956680.png)



#### if choose foreach set bind SQL片段 OGNL

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.jt.mapper.EmpMapper">
    <!--查询Emp 根据id username , 创建的开始时间 , 结束时间 , 部门id
        如果在编写SQL过程中出现特殊字符报错:1.进行转义 2.使用cdata <![CDATA[<=]]>
    -->
    <!--
        使用动态SQL:
        1.实现动态条件SQL
        <if>标签
            test 支持OGNL表达式
          问题: and需要动态拼接的问题(只有一个条件的情况就不需要and,如果多个条件就必须用and/or来拼接)
                解决:1.(加一个dummy节点) 'where 1= 1' 后面的条件都加上and/or就行
                    2.使用<where>标签
                    3.使用<trim>标签

         <where>标签
            一般会在加载动态条件中配合使用,在有条件情况下会自动在所有条件的前面加上where关键字,
            还会去掉所有条件前面的AND.OR


         <trim>标签
            功能比较灵活,广泛,他可以用来实现where节点的功能
            prefix在所有包含的SQL前面加上指定的字符串
            prefixOverrides 在所有包含的SQL前面去除指定的字符串
            suffix.............
            suffixOverrides.........


    -->
    <select id="queryEmp" resultType="emp">
        select *
        from emp
        <where>
            <if test="id!=null and id!=''">
                id = #{id}
            </if>

            <if test="userName!=null and userName!=''">
                and user_name = #{userName}
            </if>

            <if test="beginDate!=null and beginDate!=''">
                and create_date >= #{beginDate}
            </if>

            <if test="endDate!=null and endDate!=''">
                and create_date <![CDATA[<=]]> #{endDate}
            </if>

            <if test="deptId!=null and deptId!=''">
                and dept_id = #{deptId}
            </if>
        </where>

    </select>
    <!--&#45;&#45;and create_date &lt;= #{endDate}-->

    <!--根据部门名称查询所有员工
        choose where otherwise 组合
    -->
    <select id="queryEmp2" resultType="emp">
        select * from emp
        <where>
            <choose>
                <when test="deptName=='经理'">
                    dept_id=1
                </when>
                <when test="deptName=='普通员工'">
                    dept_id=2
                </when>
                <otherwise>
                    dept_id=#{id}
                </otherwise>
            </choose>
        </where>
    </select>

    <!--foreach 循环
        实现in范围查询 使用${}可以实现但有SQL注入风险

        collection 需要循环的集合的参数名字
        item 每次循环使用的接受变量
        separator 分隔符设置(每次循环在结尾添加什么分隔符,会自动去除最后一个结尾的分隔符)
        open 循环开始添加的字符串
        index 循环下标的变量

    -->
    <select id="queryEmp3" resultType="emp">
        select * from emp

        <where>
            <foreach collection="usernames" item="username" separator="," open="user_name in (" close=")" index="i">
                #{username}
            </foreach>
        </where>

    </select>


    <!--
        <set 用在update语句上面
        会自动加上set关键字
        会自动去除最后一个更新字段的','
    -->
    <update id="update">
        update emp
        <set>
            <if test="userName!=null and userName!=''">
                user_name=#{userName},
            </if>
            <if test="createDate!=null and createDate!=''">
                create_date = #{createDate},
            </if>
            <if test="deptId!=null and deptId!=''">
                dept_id = #{deptId}
            </if>
        </set>
        where id = #{id}
    </update>

    <!--实现模糊查询 like '%xx%'
        * 可以使用mysql的字符串拼接:
            1.空格拼接
            2.CONCAT函数
        * 可以拼接好在传进来
        * 使用bind在Mapper映射文件上下文声明一个变量<bind>
    -->
    <!--<bind> 在mapper映射文件上下文声明一个变量
            name 变量名称
            value 值(支持OGNL表达式)
    -->
    <select id="queryEmp4" resultType="emp">
        <bind name="_username" value="'%' + username + '%'"/>
        <include refid="selectEmp2">
            <property name="columns" value="*"/>
        </include>
        where user_name like #{_username}
    </select>

    <!--循环逐条插入!性能不高-->
    <insert id="insert">
        insert into emp (user_name, create_date, dept_id)
        values (#{userName}, #{createDate}, #{deptId})
    </insert>

    <!--批量插入!-->
    <insert id="insertBatch">
        insert into emp (user_name , create_date , dept_id)
        values
        <foreach collection="emps" item="emp" separator=",">
            (#{emp.userName},#{emp.createDate},#{emp.deptId})
        </foreach>

    </insert>
    
    <!--
        sql片段:
        解决SQL中重复的代码冗余 ,可以提取出来放在sql片段中
        用<include refid="selectEmp"/>来获取

        1.定义SQL片段 id:唯一标识
        2.在SQL中引用SQL片段
            <refid 需要引用的SQL片段的id
            <property 声明变量,就可以在SQL片段中动态调用!让不同的SQL调用同一个片段达到不同目的
                name:变量名
                value:变量值
                一般情况下使用${}在SQL片段中引用,一旦引用,必需保证每个include都声明了该变量
    -->
    <sql id="selectEmp">
        select *
        from emp
    </sql>

    <sql id="selectEmp2">
        select ${columns}
        from emp
    </sql>
</mapper>
```

#### foreach

```xml
<foreach item="item" index="index" collection="list|array|map key" open="(" separator="," close=")">
    参数值
</foreach>
```

foreach 标签主要有以下属性，说明如下。

- item：表示集合中每一个元素进行迭代时的别名。
- index：指定一个名字，表示在迭代过程中每次迭代到的位置。
- open：表示该语句以什么开始（既然是 in 条件语句，所以必然以`(`开始）。
- separator：表示在每次进行迭代之间以什么符号作为分隔符（既然是 in 条件语句，所以必然以`,`作为分隔符）。
- close：表示该语句以什么结束（既然是 in 条件语句，所以必然以`)`开始）。

- 如果传入的是单参数且参数类型是一个 List，==collection 属性值为 list==。
- 如果传入的是单参数且参数类型是一个 array 数组，==collection 的属性值为 array==。
- 如果传入的参数是多个，需要把它们封装成一个 Map，当然单参数也可以封装成 Map。Map 的 key 是参数名，==collection 属性值是传入的 List 或 array 对象在自己封装的 Map 中的 key==。







### 缓存

MyBatis 内置了一个强大的事务性查询缓存机制，它可以非常方便地配置和定制。 为了使它更加强大而且易于配置



#### 一级缓存

```java
    /**
     *  一级缓存
     *  特性:
     *      1.默认开启,也可以在配置文件中通过设置localCacheScope=STATEMENT来关闭
     *      2.作用域是基于sqlSession(默认),一次数据库操会话
     *      3.缓存默认实现类PerpetualCache,使用map进行存储的
     *          key ==> hashcode + sqlId + sql + environmentsID
     *      4.查询完进行存储
     *
     *  失效情况:
     *      1.不同的sqlSession会使以及缓存失效
     *      2.同一个sqlSession,但是查询语句不同
     *      3.同一个sqlSession,查询语句一样,期间执行增删改操作!
     *      4.同一个sqlSession,查询语句一样,期间手动清除缓存
     */
    @Test
    public void test01() throws IOException {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()){

            DeptMapper mapper = sqlSession.getMapper(DeptMapper.class);

            Dept dept = new Dept();
            dept.setId(1);
            List<Dept> depts = mapper.selectDept(dept);

            // 执行增删改,缓存也失效
            EmpMapper empMapper = sqlSession.getMapper(EmpMapper.class);
            empMapper.insert(new Emp("啦啦啦!"));
            sqlSession.commit();

            // sqlSession.clearCache();

            Dept dept1 = new Dept();
            dept1.setId(2);
            List<Dept> depts2 = mapper.selectDept(dept1);


            System.out.println(depts);
        }catch (Exception e){
            LOGGER.error(e.getMessage());
        }
    }
```





#### 二级缓存

```java
/**
     *  二级缓存:
     *  特性:
     *      1.默认开启,但没有实现!
     *      2.作用域:基于全局范围,应用级别
     *      3.缓存默认实现类PerpetualCache,使用map进行存储的
     *          (二级缓存上面还有一层map[命名空间:二级map])
     *         key ==> hashcode + sqlId + sql + environmentsID
     *      4.事务提交的时候(sqlSession关闭)存储
     *      5.先从二级缓存获取 在向一级缓存获取
     *
     *   实现(乱用会OOM!):
     *      1.开启默认缓存(setting中设置cacheEnabled)
     *      2.在需要用到二级缓存的映射文件(xxxMapper.xml)中加入<cache></cache>
     *          基于Mapper映射文件来实现缓存的,基于Mapper映射文件的命名空间来存储的
     *      3.在需要用到二级缓存的javaBean实现序列化!
     *          配置成功就会出现缓存命中率,同一个sqlID,从缓存中拿出的次数 / 查询总次数
     *
     *    失效:
     *      1.同一个命名空间进行了增删改,会导致二级缓存失效
     *          (不推荐)如果不想失效:可以将SQL(xxxMapper.xml中的sql)的flushCache 设置为false
     *          但是要慎重,涉及数据脏读问题,除非保证查询的数据永远不会执行增删改
     *      2.让查询不缓存数据到二级缓存中useCache=false
     *         xxxMapper.xml
     *         <select id="selectDept" resultType="Dept" useCache="false">
     *      3.如果希望其他mapper映射文件的命名空间执行了增删改 清空另外的命名空间就可以设置:
     *         xxxMapper.xml
     *         <cache-ref namespace="com.jt.mapper.DeptMapper"/>
     */
    @Test
    public void test03() {
        try (SqlSession sqlSession = sqlSessionFactory.openSession()){

            DeptMapper mapper = sqlSession.getMapper(DeptMapper.class);

            Dept dept = new Dept();
            dept.setId(1);
            List<Dept> depts = mapper.selectDept(dept);

            // 执行增删改,缓存也失效
            EmpMapper empMapper = sqlSession.getMapper(EmpMapper.class);
            empMapper.insert(new Emp("啦啦啦!"));
            sqlSession.commit();

            // sqlSession.clearCache();

            Dept dept1 = new Dept();
            dept1.setId(2);
            List<Dept> depts2 = mapper.selectDept(dept1);


            System.out.println(depts);
        }catch (Exception e){
            LOGGER.error(e.getMessage());
        }
    }
```



#### 整合第三方缓存-redis

DeptMapper.xml

```xml
<mapper namespace="com.jt.mapper.DeptMapper">
    <!--type:配置第三方缓存redis-->
    <cache type="org.mybatis.caches.redis.RedisCache"/>	//引入maven后的cache实现类
    ............................
</mapper>    
```

pom.xml

```xml
<dependency>
    <groupId>org.mybatis.caches</groupId>
    <artifactId>mybatis-redis</artifactId>
    <version>1.0.0-beta2</version>
</dependency>
```





### 逆向工程&分页插件

#### 分页查询

https://github.com/pagehelper/Mybatis-PageHelper/blob/master/wikis/zh/HowToUse.md

pom.xml

```xml
<!--分页插件-->
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper</artifactId>
    <version>5.3.0</version>
</dependency>
```

mybatis-config.xml

```xml
<plugins>
    <!--注册分页插件-->
    <plugin interceptor="com.github.pagehelper.PageInterceptor">
        <!--helperDialect(可省略),设置当前数据库的方言,默认检查当前使用的数据库-->
        <property name="helperDialect" value="mysql"/>
    </plugin>
</plugins>
```

使用

```java
@Test
public void test01() throws IOException {
    try {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        //在需要执行分页查询的上面调用PageHelper.startPage设置 当前页和 数据量
        PageHelper.startPage(1, 10);
        List<Emp> list = mapper.queryEmp();
        //在查询完成后封装成PageInfo 因为pageinfo中的属性非常实用
        PageInfo<Emp> pageInfo = new PageInfo<>(list);
        //page 传到request域中 来使用
        System.out.println(pageInfo);
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

#### mybatis插件原理(未学习)

* 动态代理
* 责任链设计模式



MyBatis 允许你在映射语句执行过程中的某一点进行拦截调用。默认情况下，MyBatis 允许使用插件来拦截的方法调用包括：

> - ==Executor== (update, query, flushStatements, commit, rollback, getTransaction, close, isClosed)
> - ==ParameterHandler== (getParameterObject, setParameters)
> - ==ResultSetHandler== (handleResultSets, handleOutputParameters)
> - ==StatementHandler== (prepare, parameterize, batch, update, query)

![image-20211116165039395](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111161650545.png)



#### 逆向工程(代码生成器)

http://mybatis.org/generator/

generatorConfig.xml

```xml
<!DOCTYPE generatorConfiguration PUBLIC
        "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
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
    <context id="simple" targetRuntime="MyBatis3">


        <commentGenerator>
            <!--设置是否生成注释 true不生成 注意:如果不生成注释,代码将不会进行合并-->
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>

        <!--配置数据源-->
        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
                        connectionURL="xxx"
                        userId="xxx"
                        password="xxxx"/>

        <!--pojo
            javaModelGenerator:java实体生成规则(POJO)
            targetPackage:生成到那个包下
            targetProject:生成到当前文件的那个相对路径下
        -->
        <javaModelGenerator targetPackage="com.jt.pojo" targetProject="src/main/java"/>
        <!--mapper xml映射文件
            sqlMapGenerator:Mapper.xml映射文件生成规则
            targetPackage:生成到那个包下
            targetProject:生成到当前文件的那个相对路径下
        -->
        <sqlMapGenerator targetPackage="com.jt.mapper" targetProject="src/main/resources"/>
        <!--mapper接口
            type:指定生成方式
                ANNOTATEDMAPPER:注解方式
                XMLMAPPER:接口绑定方式 要配置<sqlMapGenerator
        -->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.jt.mapper" targetProject="src/main/java"/>

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

生成所有mybaits相关文件的java代码!!!!


```java
@Test
public void test() throws Exception{
    List<String> warnings = new ArrayList<String>();
    boolean overwrite = true;
    File configFile = new File("generatorConfig.xml");
    ConfigurationParser cp = new ConfigurationParser(warnings);
    Configuration config = cp.parseConfiguration(configFile);
    DefaultShellCallback callback = new DefaultShellCallback(overwrite);
    MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
    myBatisGenerator.generate(null);
}
```











































































































