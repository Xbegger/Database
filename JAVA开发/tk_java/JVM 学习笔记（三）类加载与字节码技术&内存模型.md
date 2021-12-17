# JVM 学习笔记（三）类加载与字节码技术&内存模型



# 四、类加载与字节码技术

<img src="https://img-blog.csdnimg.cn/20210210200506952.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述">



## 1、类文件结构

![image-20211214103606934](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202112141036027.png)

通过` javac 类名.java` 编译 java 文件后，会生成一个` xxx.class `的文件！ 以下是字节码文件：

```bash
0000000 ca fe ba be 00 00 00 34 00 23 0a 00 06 00 15 09 
0000020 00 16 00 17 08 00 18 0a 00 19 00 1a 07 00 1b 07 
0000040 00 1c 01 00 06 3c 69 6e 69 74 3e 01 00 03 28 29 
0000060 56 01 00 04 43 6f 64 65 01 00 0f 4c 69 6e 65 4e 
0000100 75 6d 62 65 72 54 61 62 6c 65 01 00 12 4c 6f 63 
0000120 61 6c 56 61 72 69 61 62 6c 65 54 61 62 6c 65 01 
0000140 00 04 74 68 69 73 01 00 1d 4c 63 6e 2f 69 74 63 
0000160 61 73 74 2f 6a 76 6d 2f 74 35 2f 48 65 6c 6c 6f 
0000200 57 6f 72 6c 64 3b 01 00 04 6d 61 69 6e 01 00 16 
0000220 28 5b 4c 6a 61 76 61 2f 6c 61 6e 67 2f 53 74 72 
0000240 69 6e 67 3b 29 56 01 00 04 61 72 67 73 01 00 13 
0000260 5b 4c 6a 61 76 61 2f 6c 61 6e 67 2f 53 74 72 69 
0000300 6e 67 3b 01 00 10 4d 65 74 68 6f 64 50 61 72 61 
0000320 6d 65 74 65 72 73 01 00 0a 53 6f 75 72 63 65 46 
0000340 69 6c 65 01 00 0f 48 65 6c 6c 6f 57 6f 72 6c 64
0000360 2e 6a 61 76 61 0c 00 07 00 08 07 00 1d 0c 00 1e 
0000400 00 1f 01 00 0b 68 65 6c 6c 6f 20 77 6f 72 6c 64 
0000420 07 00 20 0c 00 21 00 22 01 00 1b 63 6e 2f 69 74 
0000440 63 61 73 74 2f 6a 76 6d 2f 74 35 2f 48 65 6c 6c 
0000460 6f 57 6f 72 6c 64 01 00 10 6a 61 76 61 2f 6c 61 
0000500 6e 67 2f 4f 62 6a 65 63 74 01 00 10 6a 61 76 61 
0000520 2f 6c 61 6e 67 2f 53 79 73 74 65 6d 01 00 03 6f 
0000540 75 74 01 00 15 4c 6a 61 76 61 2f 69 6f 2f 50 72 
0000560 69 6e 74 53 74 72 65 61 6d 3b 01 00 13 6a 61 76 
0000600 61 2f 69 6f 2f 50 72 69 6e 74 53 74 72 65 61 6d 
0000620 01 00 07 70 72 69 6e 74 6c 6e 01 00 15 28 4c 6a 
0000640 61 76 61 2f 6c 61 6e 67 2f 53 74 72 69 6e 67 3b 
0000660 29 56 00 21 00 05 00 06 00 00 00 00 00 02 00 01 
0000700 00 07 00 08 00 01 00 09 00 00 00 2f 00 01 00 01 
0000720 00 00 00 05 2a b7 00 01 b1 00 00 00 02 00 0a 00 
0000740 00 00 06 00 01 00 00 00 04 00 0b 00 00 00 0c 00 
0000760 01 00 00 00 05 00 0c 00 0d 00 00 00 09 00 0e 00 
0001000 0f 00 02 00 09 00 00 00 37 00 02 00 01 00 00 00 
0001020 09 b2 00 02 12 03 b6 00 04 b1 00 00 00 02 00 0a 
0001040 00 00 00 0a 00 02 00 00 00 06 00 08 00 07 00 0b 
0001060 00 00 00 0c 00 01 00 00 00 09 00 10 00 11 00 00 
0001100 00 12 00 00 00 05 01 00 10 00 00 00 01 00 13 00 
0001120 00 00 02 00 14
```

==根据 JVM 规范，类文件结构如下：==

```java
classFile{
    u4 			   magic									//魔数
    u2             minor_version;    						//小版本号
    u2             major_version;    						//主版本号
    u2             constant_pool_count;    					//常量池信息
    cp_info        constant_pool[constant_pool_count-1];    //~
    u2             access_flags;    						// 返回修饰
    u2             this_class;    							//类
    u2             super_class;   							//父类
    u2             interfaces_count;    					//接口信息
    u2             interfaces[interfaces_count];   			
    u2             fields_count;    						//变量信息
    field_info     fields[fields_count];   
    u2             methods_count;    						//方法信息
    method_info    methods[methods_count];    
    u2             attributes_count;    					//类附加属性信息
    attribute_info attributes[attributes_count];
}
```

### 1）魔数

`u4 magic `对应字节码文件的 0~3 个字节 0000000 <font  color='red'>ca fe ba be</font> 00 00 00 34 00 23 0a 00 06 00 15 09 

`ca fe ba be` ：意思是 `.class 文件`，不同的东西有不同的魔数，比如 jpg、png 图片等！

### 2）版本

`u2 minor_version`; `u2 major_version`; 0000000 ca fe ba be<font  color='red'> 00 00 00 34</font> 00 23 0a 00 06 00 15 09 00 00 <font  color='cblue'>00 34：34H（16进制） = 52（10进制），代表JDK8</font>

### 3）常量池

> 常量池长度

0000000 ca fe ba be 00 00 00 34<font  color='red'> 00 23</font> 0a 00 06 00 15 09

> ![image-20211214104257555](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202112141042631.png)

0000000 ca fe ba be 00 00 00 34 00 23<font  color='red'> 0a 00 06 00 15</font> 09

> ![image-20211214104329168](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202112141043236.png)

0000000 ca fe ba be 00 00 00 34 00 23 0a 00 06 00 15 <font  color='red'>09</font>

**… 参考文档** 

## 2、字节码指令

可参考： 

### 1）javap 工具

Java 中提供了 javap 工具来<font  color='cblue'>反编译 class 文件</font>

```shell
javap -v D:Demo.class
```

### 2）图解方法执行流程

**代码**

```java
public class Demo3_1 {    
	public static void main(String[] args) {        
		int a = 10;        
		int b = Short.MAX_VALUE + 1;        
		int c = a + b;        
		System.out.println(c);   
    } 
}
```

**==常量池载入运行时常量池==** 常量池也属于方法区，只不过这里单独提出来了

> `short`范围内的值<font  color='red'>与字节码指令存储在一起</font>,但超出`short`范围内的值<font  color='cblue'>存储在常量池中</font>

<img src="https://img-blog.csdnimg.cn/20210210230332114.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> ==**方法字节码载入方法区**== 

（stack=2，locals=4） 

对应操作数栈(<font  color='blue'>栈帧中的蓝色水槽</font>)有 `2 `个空间（每个空间 `4 个字节`），局部变量表(<font  color='blue'>栈帧中的绿色水槽</font>)中有 `4 个槽位`。 <img src="https://img-blog.csdnimg.cn/20210210230419340.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 



**执行引擎开始执行字节码** 

**`bipush 10`**

* 将一个 byte 压入操作数栈（其长度<font  color='cblue'>会补齐 4 个字节</font>），类似的指令还有 

* ` sipush` 将一个 short 压入操作数栈（其长度会补齐 4 个字节）

* `ldc` 将一个 int 压入操作数栈

* ` ldc2_w` 将一个 long 压入操作数栈（**分两次压入**，因为<font  color='cblue'> long 是 8 个字节</font>）

* 这里==小的数字都是和字节码指令存在一起，**超过 short 范围的数字存入了常量池**==

  

  <img src="https://img-blog.csdnimg.cn/20210210230611776.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  **`istore 1`** 

  将操作数栈栈顶元素弹出，放入局部变量表的 `slot 1` 中 对应代码中的 `a = 10 `<img src="https://img-blog.csdnimg.cn/20210210230717611.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  **`ldc #3`** 

  读取运行时常量池中` #3` ，即 32768 (超过 short 最大值范围的数会被放到<font  color='blue'>运行时常量池中</font>)，将其加载到操作数栈中 注意 Short.MAX_VALUE 是 32767，所以 32768 = Short.MAX_VALUE + 1 实际是在编译期间计算好的。 <img src="https://img-blog.csdnimg.cn/20210210230918171.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`istore 2`** 将操作数栈中的元素弹出，放到局部变量表的` 2 `号位置 

  <img src="https://img-blog.csdnimg.cn/20210210231005919.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> **`iload1` ` iload2`** 将局部变量表中 `1 号`位置和 `2 号`位置的元素放入<font  color='orange'>操作数栈</font>中。因为只能在操作数栈中执行运算操作 <img src="https://img-blog.csdnimg.cn/20210210231211695.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  **`iadd`** 

  将操作数栈中的两个元素弹出栈并相加，结果在压入操作数栈中。 <img src="https://img-blog.csdnimg.cn/20210210231236404.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`istore 3`** 将操作数栈中的元素弹出，放入局部变量表的`3号`位置。 <img src="https://img-blog.csdnimg.cn/20210210231319967.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`getstatic #4`** 在运行时常量池中找到 `#4` ，发现是一个对象，在堆内存中找到该对象，并将其<font  color='red'>引用</font>放入操作数栈中 <img src="https://img-blog.csdnimg.cn/20210210231759663.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> <img src="https://img-blog.csdnimg.cn/20210210231827339.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`iload 3`** 将局部变量表中 `3 号`位置的元素压入操作数栈中。 <img src="https://img-blog.csdnimg.cn/20210210232008706.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`invokevirtual #5`** 找到常量池 `#5` 项，定位到方法区 `java/io/PrintStream.println:(I)V `方法 生成新的栈帧（分配 `locals`、`stack`等） 传递参数，执行新栈帧中的字节码 <img src="https://img-blog.csdnimg.cn/20210210232148931.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  执行完毕，弹出栈帧 清除 main 操作数栈内容 <img src="https://img-blog.csdnimg.cn/20210210232228908.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 

  

  **`return`** 完成 main 方法调用，弹出 main 栈帧，程序结束


### 3）通过字节码指令分析问题

代码

```java
public class Code_11_ByteCodeTest {
    public static void main(String[] args) {
        int i = 0;
        int x = 0;
        while (i < 10) {
            x = x++;
            i++;
        }
        System.out.println(x); // 0
    }
}
```

为什么最终的 x 结果为 0 呢？ 通过分析字节码指令即可知晓

```
Code:
     stack=2, locals=3, args_size=1	// 操作数栈分配2个空间，局部变量表分配 3 个空间
        0: iconst_0	// 准备一个常数 0
        1: istore_1	// 将常数 0 放入局部变量表的 1 号槽位 i = 0
        2: iconst_0	// 准备一个常数 0
        3: istore_2	// 将常数 0 放入局部变量的 2 号槽位 x = 0	
        4: iload_1		// 将局部变量表 1 号槽位的数放入操作数栈中
        5: bipush        10	// 将数字 10 放入操作数栈中，此时操作数栈中有 2 个数
        7: if_icmpge     21	// 比较操作数栈中的两个数，如果下面的数大于上面的数，就跳转到 21 。这里的比较是将两个数做减法。因为涉及运算操作，所以会将两个数弹出操作数栈来进行运算。运算结束后操作数栈为空
       10: iload_2		// 将局部变量 2 号槽位的数放入操作数栈中，放入的值是 0 
       11: iinc          2, 1	// 将局部变量 2 号槽位的数加 1 ，自增后，槽位中的值为 1 
       14: istore_2	//将操作数栈中的数放入到局部变量表的 2 号槽位，2 号槽位的值又变为了0
       15: iinc          1, 1 // 1 号槽位的值自增 1 
       18: goto          4 // 跳转到第4条指令
       21: getstatic     #2                  // Field java/lang/System.out:Ljava/io/PrintStream;
       24: iload_2
       25: invokevirtual #3                  // Method java/io/PrintStream.println:(I)V
       28: return

```

### 4）构造方法

> :factory:两种
>
> * `clinit()v`
> * `init()V`

==**clinit()V**==

```java
public class Code_12_clinitTest {
	static int i = 10;

	static {
		i = 20;
	}

	static {
		i = 30;
	}

	public static void main(String[] args) {
		System.out.println(i); // 30
	}
}
```

编译器会按==从上至下的顺序==，<font  color='red'>收集所有 static 静态代码块和静态成员赋值的代码，合并为一个特殊的方法 </font> `clinit()V`：

```
stack=1, locals=0, args_size=0
         0: bipush        10
         2: putstatic     #3                  // Field i:I
         5: bipush        20
         7: putstatic     #3                  // Field i:I
        10: bipush        30
        12: putstatic     #3                  // Field i:I
        15: return
```

==**init()V**==

```java
public class Code_13_InitTest {
    private String a = "s1";
    
    {
        b = 20;
    }
    
    private int b = 10;
    
    {
        a = "s2";
    }

    public Code_13_InitTest(String a, int b) {
        this.a = a;
        this.b = b;
    }

    public static void main(String[] args) {
        Code_13_InitTest d = new Code_13_InitTest("s3", 30);
        System.out.println(d.a);	// s3
        System.out.println(d.b);	// 30
    }
}
```

编译器会按==从上至下的顺序==，<font  color='red'>收集所有 {} 代码块和成员变量赋值的代码，形成新的构造方法</font>，<font  color='cblue'>但原始构造方法内的代码总是在后.</font>

```
Code:
     stack=2, locals=3, args_size=3
        0: aload_0
        1: invokespecial #1                  // Method java/lang/Object.<init>":()V
        4: aload_0
        5: ldc           #2                  // String s1
        7: putfield      #3                  // Field a:Ljava/lang/String;
       10: aload_0
       11: bipush        20
       13: putfield      #4                  // Field b:I
       16: aload_0
       17: bipush        10
       19: putfield      #4                  // Field b:I
       22: aload_0
       23: ldc           #5                  // String s2
       25: putfield      #3                  // Field a:Ljava/lang/String;
       // 原始构造方法在最后执行
       28: aload_0
       29: aload_1
       30: putfield      #3                  // Field a:Ljava/lang/String;
       33: aload_0
       34: iload_2
       35: putfield      #4                  // Field b:I
       38: return

```

### 5）方法调用

```java
public class Code_14_MethodTest {

    public Code_14_MethodTest() {}

    private void test1() {}

    private final void test2() {}

    public void test3() {}

    public static void test4() {}

    public static void main(String[] args) {
        Code_14_MethodTest obj = new Code_14_MethodTest();
        obj.test1();
        obj.test2();
        obj.test3();
        Code_14_MethodTest.test4();
    }
}
```

<font  color='cblue'>不同方法在调用时，对应的虚拟机指令有所区别</font>

- ==私有==、==构造==、==被 final 修饰的方法==，在调用时都使用` invokespecial` 指令- 
- ==普通成员方法==在调用时，使用` invokevirtual `指令。因为编译期间无法确定该方法的内容，只有在运行期间才能确定
- ==静态方法==在调用时使用 `invokestatic `指令
```
Code:
      stack=2, locals=2, args_size=1
         0: new           #2                  //
         3: dup 							  // 复制一份对象地址压入操作数栈中
         4: invokespecial #3                  // Method <init>":()V
         7: astore_1
         8: aload_1
         9: invokespecial #4                  // Method test1:()V
        12: aload_1
        13: invokespecial #5                  // Method test2:()V
        16: aload_1
        17: invokevirtual #6                  // Method test3:()V
        20: invokestatic  #7                  // Method test4:()V
        23: return

```
- `new` 是创建【对象】，给对象分配堆内存，执行成功会将【对象引用】压入操作数栈
-  `dup` 是赋值操作数栈栈顶的内容，本例即为【对象引用】，为什么需要两份引用呢，一个是要配合 `invokespecial `调用该对象的构造方法` “init”: ()V `（会消耗掉栈顶一个引用），另一个要 配合 astore_1 赋值给局部变量- 
- ==终方法（ﬁnal），私有方法（private），构造方法==都是由 `invokespecial `指令来调用，属于静态绑定
- ==普通成员==方法是由` invokevirtual `调用，属于动态绑定，即支持多态 成员方法与静态方法调用的另一个区别是，执行方法前是否需要【对象引用】
### 6）多态原理

因为普通成员方法需要在运行时才能确定具体的内容，所以虚拟机需要调用` invokevirtual `指令 在执行 invokevirtual 指令时，经历了以下几个步骤
- 先通过栈帧中<font  color='red'>对象的引用找到对象</font>
- <font  color='cblue'>分析对象头</font>，<font  color='cblue'>找到对象实际的 Class</font>
- Class 结构中有<font  color='blue'> vtable</font>
- 查询 vtable <font  color='orange'>找到方法的具体地址</font>
- <font  color='cyan'>执行方法的字节码</font>
### 7）异常处理

==**try-catch**==

```java
public class Code_15_TryCatchTest {

    public static void main(String[] args) {
        int i = 0;
        try {
            i = 10;
        }catch (Exception e) {
            i = 20;
        }
    }
}
```

对应字节码指令

```solidity
Code:
     stack=1, locals=3, args_size=1
        0: iconst_0
        1: istore_1
        2: bipush        10
        4: istore_1
        5: goto          12
        8: astore_2
        9: bipush        20
       11: istore_1
       12: return
     //多出来一个异常表
     Exception table:
        from    to  target type
            2     5     8   Class java/lang/Exception

```
- 可以看到多出来一个 Exception table 的结构，`[from, to) `是<font  color='red'>前闭后开</font>（也就是检测 2~4 行）的检测范围，一旦这个范围内的字节码执行出现异常，<font  color='cblue'>则通过 type 匹配异常类型</font>，如果一致，进入 target 所指示行号

- ` 8 `行的字节码指令 `astore_2 `是将异常对象引用存入局部变量表的` 2 号`位置（为` e `）

  

  ==**多个 single-catch**==

```java
public class Code_16_MultipleCatchTest {

    public static void main(String[] args) {
        int i = 0;
        try {
            i = 10;
        }catch (ArithmeticException e) {
            i = 20;
        }catch (Exception e) {
            i = 30;
        }
    }
}



```

对应的字节码

```
Code:
     stack=1, locals=3, args_size=1
        0: iconst_0
        1: istore_1
        2: bipush        10
        4: istore_1
        5: goto          19
        8: astore_2
        9: bipush        20
       11: istore_1
       12: goto          19
       15: astore_2
       16: bipush        30
       18: istore_1
       19: return
     Exception table:
        from    to  target type
            2     5     8   Class java/lang/ArithmeticException
            2     5    15   Class java/lang/Exception

```
- 因为异常出现时，只能进入 `Exception table `中一个分支，所以局部变量表<font  color='blue'> slot 2 位置被共用</font>

  

  ==**finally**==

```java
public class Code_17_FinallyTest {
    
    public static void main(String[] args) {
        int i = 0;
        try {
            i = 10;
        } catch (Exception e) {
            i = 20;
        } finally {
            i = 30;
        }
    }
}
```

对应字节码

```java
Code:
     stack=1, locals=4, args_size=1
        0: iconst_0
        1: istore_1
        // try块
        2: bipush        10
        4: istore_1
        // try块执行完后，会执行finally    
        5: bipush        30
        7: istore_1
        8: goto          27
       // catch块     
       11: astore_2 // 异常信息放入局部变量表的2号槽位
       12: bipush        20
       14: istore_1
       // catch块执行完后，会执行finally        
       15: bipush        30
       17: istore_1
       18: goto          27
       // 出现异常，但未被 Exception 捕获，会抛出其他异常，这时也需要执行 finally 块中的代码   
       21: astore_3
       22: bipush        30
       24: istore_1
       25: aload_3
       26: athrow  // 抛出异常
       27: return
     Exception table:
        from    to  target type
            2     5    11   Class java/lang/Exception
            2     5    21   any
           11    15    21   any

```

可以看到 ﬁnally 中的代码被复制了 `3 份`，分别放入<font  color='red'> try 流程</font>，<font  color='cblue'>catch 流程</font>以及<font  color='blue'> catch 剩余的异常类型流程</font> 

注意：虽然从字节码指令看来，每个块中都有 finally 块，<font  color='red'>但是 finally 块中的代码只会被执行一次</font>



**finally 中的 return**

```java
public class Code_18_FinallyReturnTest {

    public static void main(String[] args) {
        int i = Code_18_FinallyReturnTest.test();
        // 结果为 20
        System.out.println(i);
    }
    public static int test() {
        int i;
        try {
            i = 10;
            return i;
        } finally {
            i = 20;
            return i;
        }
    }
}
```

对应字节码

```java
Code:
     stack=1, locals=3, args_size=0
        0: bipush        10
        2: istore_0
        3: iload_0
        4: istore_1  // 暂存返回值
        5: bipush        20
        7: istore_0
        8: iload_0
        9: ireturn	// ireturn 会返回操作数栈顶的整型值 20
       // 如果出现异常，还是会执行finally 块中的内容，没有抛出异常
       10: astore_2
       11: bipush        20
       13: istore_0
       14: iload_0
       15: ireturn	// 这里没有 athrow 了，也就是如果在 finally 块中如果有返回操作的话，且 try 块中出现异常，会吞掉异常！
     Exception table:
        from    to  target type
            0     5    10   any

```
- 由于 ﬁnally 中的 ireturn 被插入了所有可能的流程，因此返回结果肯定以==ﬁnally的为准==- 

- 至于字节码中第` 2 行`，似乎没啥用，且留个伏笔，看下个例子- 

- 跟上例中的 ﬁnally 相比，发现没有 `athrow` 了，这告诉我们：如果在` ﬁnally `中出现了 `return`，<font  color='blue'>会吞掉异常</font>- ==所以不要在finally中进行返回操作== :radioactive::radioactive::radioactive::radioactive::radioactive:

   

  **被吞掉的异常**

```java
public static int test() {
      int i;
      try {
         i = 10;
         //  这里应该会抛出异常
         i = i/0;
         return i;
      } finally {
         i = 20;
         return i;
      }
   }

```

会发现打印结果为 <font  color='red'>20 </font>，并未抛出异常

**finally 不带 return**

```
public static int test() {
		int i = 10;
		try {
			return i;
		} finally {
			i = 20;
		}
	}

```

:watermelon:对应字节码

```
Code:
     stack=1, locals=3, args_size=0
        0: bipush        10
        2: istore_0 // 赋值给i 10
        3: iload_0	// 加载到操作数栈顶
        4: istore_1 // 加载到局部变量表的1号位置
        5: bipush        20
        7: istore_0 // 赋值给i 20
        8: iload_1 // 加载局部变量表1号位置的数10到操作数栈
        9: ireturn // 返回操作数栈顶元素 10
       10: astore_2
       11: bipush        20
       13: istore_0
       14: aload_2 // 加载异常
       15: athrow // 抛出异常
     Exception table:
        from    to  target type
            3     5    10   any

```



### 8）Synchronized

```java 
public class Code_19_SyncTest {

    public static void main(String[] args) {
        Object lock = new Object();
        synchronized (lock) {
            System.out.println("ok");
        }
    }
}
```

对应字节码

```java
Code:
      stack=2, locals=4, args_size=1
         0: new           #2                  // class java/lang/Object
         3: dup // 复制一份栈顶，然后压入栈中。用于函数消耗
         4: invokespecial #1                  // Method java/lang/Object.<init>":()V
         7: astore_1 // 将栈顶的对象地址方法 局部变量表中 1 中
         8: aload_1 // 加载到操作数栈
         9: dup     // 复制一份，放到操作数栈，用于加锁时消耗
        10: astor_2     // 将操作数栈顶元素弹出，暂存到局部变量表的 2 号槽位。这时操作数栈中有一份对象的引用
        11: monitorenter // 加锁
        12: getstatic     #3                  // Field java/lang/System.out:Ljava/io/PrintStream;
        15: ldc           #4                  // String ok
        17: invokevirtual #5                  // Method java/io/PrintStream.println:(Ljava/lang/String;)V
        20: aload_2 // 加载对象到栈顶
        21: monitorexit // 释放锁
        22: goto          30
        // 异常情况的解决方案 释放锁！
        25: astore_3
        26: aload_2
        27: monitorexit
        28: aload_3
        29: athrow
        30: return
        // 异常表！
      Exception table:
         from    to  target type
            12    22    25   any
            25    28    25   any


```

## 3、编译期处理

所谓的 **语法糖:candy:** ，其实就是指 java 编译器把` .java 源码`编译为` .class 字节码`的过程中，<font  color='blue'>自动生成和转换的一些代码</font>，主要是为了减轻程序员的负担，算是 java 编译器给我们的一个额外福利 

**注意**，以下代码的分析，借助了 `javap `工具，`idea 的反编译功能`，idea 插件` jclasslib `等工具。另外， 编译器转换的**结果直接就是 class 字节码**，只是为了便于阅读，给出了 几乎等价 的 java 源码方式，<font  color='red'>并不是编译器还会转换出中间的 java 源码，切记。</font>



:candy:

### 1）默认构造器

```java
public class Candy1 {

}
```

经过编译期优化后

```java
public class Candy1 {
   // 这个无参构造器是java编译器帮我们加上的
   public Candy1() {
      // 即调用父类 Object 的无参构造方法，即调用 java/lang/Object." <init>":()V
      super();
   }
}

```

:candy:

### 2）自动拆装箱

<font  color='cblue'>基本类型和其包装类型的相互转换过程，称为拆装箱</font> 在 JDK 5 以后，它们的转换可以在编译期自动完成

```java
public class Candy2 {
   public static void main(String[] args) {
      Integer x = 1;
      int y = x;
   }
}
```

转换过程如下

```java
public class Candy2 {
   public static void main(String[] args) {
      // 基本类型赋值给包装类型，称为装箱
      Integer x = Integer.valueOf(1);
      // 包装类型赋值给基本类型，称谓拆箱
      int y = x.intValue();
   }
}
```

:candy:

### 3）泛型集合取值

泛型也是在 JDK 5 开始加入的特性，<font  color='cblue'>但 java 在编译泛型代码后会执行泛型擦除的动作</font>，即泛型信息在编译为字节码之后就丢失了，实际的类型都当做了 Object 类型来处理：

```java
public class Candy3 {
   public static void main(String[] args) {
      List<Integer> list = new ArrayList<>();
      list.add(10);		// 
      Integer x = list.get(0);
   }
}
```

对应字节码

```java
Code:
    stack=2, locals=3, args_size=1
       0: new           #2                  // class java/util/ArrayList
       3: dup
       4: invokespecial #3                  // Method java/util/ArrayList.<init>":()V
       7: astore_1
       8: aload_1
       9: bipush        10
      11: invokestatic  #4                  // Method java/lang/Integer.valueOf:(I)Ljava/lang/Integer;
      // 这里进行了泛型擦除，实际调用的是add(Objcet o)
      14: invokeinterface #5,  2            // InterfaceMethod java/util/List.add:(Ljava/lang/Object;)Z

      19: pop
      20: aload_1
      21: iconst_0
      // 这里也进行了泛型擦除，实际调用的是get(Object o)   
      22: invokeinterface #6,  2            // InterfaceMethod java/util/List.get:(I)Ljava/lang/Object;
// 这里进行了类型转换，将 Object 转换成了 Integer
      27: checkcast     #7                  // class java/lang/Integer
      30: astore_2
      31: return

```

<font  color='cblue'>所以调用 get 函数取值时，有一个类型转换的操作。</font>

```java
Integer x = (Integer) list.get(0);
```

<font  color='blue'>如果要将返回结果赋值给一个 int 类型的变量，则还有自动拆箱的操</font>作

```java
int x = (Integer) list.get(0).intValue();
```

使用反射可以得到，参数的类型以及泛型类型。泛型反射代码如下：

```java
public static void main(String[] args) throws NoSuchMethodException {
    // 1. 拿到方法
    Method method = Code_20_ReflectTest.class.getMethod("test", List.class, Map.class);
    // 2. 得到泛型参数的类型信息
    Type[] types = method.getGenericParameterTypes();
    for(Type type : types) {
        // 3. 判断参数类型是否，带泛型的类型。
        if(type instanceof ParameterizedType) {
            ParameterizedType parameterizedType = (ParameterizedType) type;

            // 4. 得到原始类型
            System.out.println("原始类型 - " + parameterizedType.getRawType());
            // 5. 拿到泛型类型
            Type[] arguments = parameterizedType.getActualTypeArguments();
            for(int i = 0; i < arguments.length; i++) {
                System.out.printf("泛型参数[%d] - %s\n", i, arguments[i]);
            }
        }
    }
}

public Set<Integer> test(List<String> list, Map<Integer, Object> map) {
    return null;
}
```

输出：

```
原始类型 - interface java.util.List
泛型参数[0] - class java.lang.String
原始类型 - interface java.util.Map
泛型参数[0] - class java.lang.Integer
泛型参数[1] - class java.lang.Object
```

:candy:

### 4）可变参数

可变参数也是 JDK 5 开始加入的新特性： 例如：

```java
public class Candy4 {
   public static void foo(String... args) {
      // 将 args 赋值给 arr ，可以看出 String... 实际就是 String[]  
      String[] arr = args;
      System.out.println(arr.length);
   }

   public static void main(String[] args) {
      foo("hello", "world");
   }
}
```

可变参数 `String… args` 其实是一个 `String[] args` ，从代码中的赋值语句中就可以看出来。 同 样 java 编译器会在编译期间将上述代码变换为：

```java
public class Candy4 {
   public Candy4 {}
   public static void foo(String[] args) {
      String[] arr = args;
      System.out.println(arr.length);
   }

   public static void main(String[] args) {
      foo(new String[]);
   }
}
```

注意，如果调用的是 `foo()` ，即未传递参数时，等价代码为 foo(new String[]{}) ，<font  color='blue'>创建了一个空数组，而不是直接传递的 null .</font>

:candy:

### 5）foreach 循环

仍是 JDK 5 开始引入的语法糖，数组的循环：

```java
public class Candy5 {
	public static void main(String[] args) {
        // 数组赋初值的简化写法也是一种语法糖。
		int[] arr = {1, 2, 3, 4, 5};
		for(int x : arr) {
			System.out.println(x);
		}
	}
}
```

编译器会帮我们转换为

```java
public class Candy5 {
    public Candy5() {}

	public static void main(String[] args) {
		int[] arr = new int[]{1, 2, 3, 4, 5};
		for(int i = 0; i < arr.length; ++i) {
			int x = arr[i];
			System.out.println(x);
		}
	}
}
```

如果是集合使用 foreach

```java
public class Candy5 {
    public static void main(String[] args) {
        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);
        for (Integer x : list) {
            System.out.println(x);
        }
    }
```

集合要使用 foreach ，<font  color='red'>需要该集合类实现了 Iterable 接口</font>，因为集合的遍历需要用到迭代器` Iterator`.

```java
public class Candy5 {
    public Candy5(){}
    
   public static void main(String[] args) {
      List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);
      // 获得该集合的迭代器
      Iterator<Integer> iterator = list.iterator();
      while(iterator.hasNext()) {
         Integer x = iterator.next();
         System.out.println(x);
      }
   }
}
```

:candy:

### 6）switch 字符串

从 JDK 7 开始，switch 可以作用于字符串和枚举类，这个功能其实也是语法糖，例如：

```java
public class Cnady6 {
   public static void main(String[] args) {
      String str = "hello";
      switch (str) {
         case "hello" :
            System.out.println("h");
            break;
         case "world" :
            System.out.println("w");
            break;
         default:
            break;
      }
   }
}
```

在编译器中执行的操作

```java
public class Candy6 {
   public Candy6() {
      
   }
   public static void main(String[] args) {
      String str = "hello";
      int x = -1;
      // 通过字符串的 hashCode + value 来判断是否匹配
      switch (str.hashCode()) {
         // hello 的 hashCode
         case 99162322 :
            // 再次比较，因为字符串的 hashCode 有可能相等
            if(str.equals("hello")) {
               x = 0;
            }
            break;
         // world 的 hashCode
         case 11331880 :
            if(str.equals("world")) {
               x = 1;
            }
            break;
         default:
            break;
      }

      // 用第二个 switch 在进行输出判断
      switch (x) {
         case 0:
            System.out.println("h");
            break;
         case 1:
            System.out.println("w");
            break;
         default:
            break;
      }
   }
}

```

过程说明：
在编译期间，单个的 ==switch 被分为了两个== 

:ice_cream:第一个用来匹配字符串，并给 x 赋值字符串的匹配用到了字符串的`hashCode` ，还用到了` equals` 方法-

:ice_cream:使用 hashCode 是为了==提高比较效率==，使用 equals 是==防止有 hashCode 冲突==（如 BM 和 C .）



:candy:

### 7）switch 枚举


```java
enum SEX {
   MALE, FEMALE;
}
public class Candy7 {
   public static void main(String[] args) {
      SEX sex = SEX.MALE;
      switch (sex) {
         case MALE:
            System.out.println("man");
            break;
         case FEMALE:
            System.out.println("woman");
            break;
         default:
            break;
      }
   }
}

```

编译器中执行的代码如下

```java
enum SEX {
   MALE, FEMALE;
}

public class Candy7 {
   /**     
    * 定义一个合成类（仅 jvm 使用，对我们不可见）     
    * 用来映射枚举的 ordinal 与数组元素的关系     
    * 枚举的 ordinal 表示枚举对象的序号，从 0 开始     
    * 即 MALE 的 ordinal()=0，FEMALE 的 ordinal()=1     
    */ 
   static class $MAP {
      // 数组大小即为枚举元素个数，里面存放了 case 用于比较的数字
      static int[] map = new int[2];
      static {
         // ordinal 即枚举元素对应所在的位置，MALE 为 0 ，FEMALE 为 1
         map[SEX.MALE.ordinal()] = 1;
         map[SEX.FEMALE.ordinal()] = 2;
      }
   }

   public static void main(String[] args) {
      SEX sex = SEX.MALE;
      // 将对应位置枚举元素的值赋给 x ，用于 case 操作
      int x = $MAP.map[sex.ordinal()];
      switch (x) {
         case 1:
            System.out.println("man");
            break;
         case 2:
            System.out.println("woman");
            break;
         default:
            break;
      }
   }
}

```

:candy:

###  8）枚举类

JDK 7 新增了枚举类，以前面的性别枚举为例：

```java
enum SEX {
   MALE, FEMALE;
}
```

转换后的代码

```java
public final class Sex extends Enum<Sex> {   
   // 对应枚举类中的元素
   public static final Sex MALE;    
   public static final Sex FEMALE;    
   private static final Sex[] $VALUES;
   
    static {       
    	// 调用构造函数，传入枚举元素的值及 ordinal
    	MALE = new Sex("MALE", 0);    
        FEMALE = new Sex("FEMALE", 1);   
        $VALUES = new Sex[]{MALE, FEMALE}; 
   }
 	
   // 调用父类中的方法
    private Sex(String name, int ordinal) {     
        super(name, ordinal);    
    }
   
    public static Sex[] values() {  
        return $VALUES.clone();  
    }
    public static Sex valueOf(String name) { 
        return Enum.valueOf(Sex.class, name);  
    } 
   
}

```

:candy:

### 9）try-with-resources

JDK 7 开始新增了<font  color='cblue'>对需要关闭的资源处理的特殊语法</font>，‘try-with-resources’

```java
try(资源变量 = 创建资源对象) {
	
} catch() {

}
```

其中资源对象<font  color='red'>需要实现</font> `AutoCloseable `接口，例如`` InputStream` 、 `OutputStream` 、` Connection` 、 `Statement` 、` ResultSet` 等接口都实现了 `AutoCloseable` ，使用 `try-with- resources` 可以不用写 `finally `语句块，<font  color='blue'>编译器会帮助生成关闭资源代码</font>，例如：

```java
public class Candy9 { 
	public static void main(String[] args) {
		try(InputStream is = new FileInputStream("d:\\1.txt")){	
			System.out.println(is); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		} 
	} 
}
```

会被转换为：

```java
public class Candy9 { 
    public Candy9() { }
    public static void main(String[] args) { 
        try {
            InputStream is = new FileInputStream("d:\\1.txt");
            Throwable t = null; 
            try {
                System.out.println(is); 
            } catch (Throwable e1) { 
                // t 是我们代码出现的异常 
                t = e1; 
                throw e1; 
            } finally {
                // 判断了资源不为空 
                if (is != null) { 
                    // 如果我们代码有异常
                    if (t != null) { 
                        try {
                            is.close(); 
                        } catch (Throwable e2) { 
                            // 如果 close 出现异常，作为被压制异常添加
                            t.addSuppressed(e2); 
                        } 
                    } else { 
                        // 如果我们代码没有异常，close 出现的异常就是最后 catch 块中的 e 
                        is.close(); 
                    } 
                } 
            } 
        } catch (IOException e) {
            e.printStackTrace(); 
        } 
    }
}
```

为什么要设计一个<font  color='red'> addSuppressed(Throwable e) （添加被压制异常）的方法呢</font>？是==为了防止异常信息的丢失==（想想 try-with-resources 生成的 fianlly 中如果抛出了异常）：

```java
public class Test6 { 
	public static void main(String[] args) { 
		try (MyResource resource = new MyResource()) { 
			int i = 1/0; 
		} catch (Exception e) { 
			e.printStackTrace(); 
		} 
	} 
}
class MyResource implements AutoCloseable { 
	public void close() throws Exception { 
		throw new Exception("close 异常"); 
	} 
}
```

输出：

```java
java.lang.ArithmeticException: / by zero 
	at test.Test6.main(Test6.java:7) 
	Suppressed: java.lang.Exception: close 异常 
		at test.MyResource.close(Test6.java:18) 
		at test.Test6.main(Test6.java:6)
```



:candy:

### 10）方法重写时的桥接方法

我们都知道，方法重写时对返回值分两种情况： 

:first_quarter_moon_with_face:父子类的<font  color='cblue'>返回值完全一致 </font>

:first_quarter_moon_with_face:<font  color='red'>子类返回值可以</font>是<font  color='blue'>父类返回值</font>的<font  color='orange'>子类</font>（比较绕口，见下面的例子）`Integer`是`Number`的子类

```java
class A { 
	public Number m() { 
		return 1; 
	} 
}
class B extends A { 
	@Override 
	// 子类 m 方法的返回值是 Integer 是父类 m 方法返回值 Number 的子类 	
	public Integer m() { 
		return 2; 
	} 
}

```

对于子类，java 编译器会做如下处理：

```java
class B extends A { 
	public Integer m() { 
		return 2; 
	}
	// 此方法才是真正重写了父类 public Number m() 方法 
	public synthetic bridge Number m() { 
		// 调用 public Integer m() 
		return m(); 
	} 
}

```

其中桥接方法比较特殊，仅对 java 虚拟机可见，并且与原来的 public Integer m() 没有命名冲突，可以 用下面反射代码来验证：

```java
public static void main(String[] args) {
    for(Method m : B.class.getDeclaredMethods()) {
        System.out.println(m);
    }
}
```

结果：

```java
public java.lang.Integer cn.ali.jvm.test.B.m()
public java.lang.Number cn.ali.jvm.test.B.m()
```



:candy:

### 11）匿名内部类

```java
public class Candy10 {
   public static void main(String[] args) {
      Runnable runnable = new Runnable() {
         @Override
         public void run() {
            System.out.println("running...");
         }
      };
   }
}
```

转换后的代码

```java
public class Candy10 {
   public static void main(String[] args) {
      // 用额外创建的类来创建匿名内部类对象
      Runnable runnable = new Candy10$1();
   }
}

// 创建了一个额外的类，实现了 Runnable 接口
final class Candy10$1 implements Runnable {
   public Candy10$1() {}

   @Override
   public void run() {
      System.out.println("running...");
   }
}

```

引用<font  color='red'>局部变量的匿名内部类</font>，源代码：

```java
public class Candy11 { 
	public static void test(final int x) { 
		Runnable runnable = new Runnable() { 
			@Override 
			public void run() { 	
				System.out.println("ok:" + x); 
			} 
		}; 
	} 
}

```

转换后代码：

```java
// 额外生成的类 
final class Candy11$1 implements Runnable { 
	int val$x; 
	Candy11$1(int x) { 
		this.val$x = x; 
	}
	public void run() { 
		System.out.println("ok:" + this.val$x); 
	} 
}

public class Candy11 { 
	public static void test(final int x) { 
		Runnable runnable = new Candy11$1(x); 
	} 
}

```

注意：这同时解释了为什么匿名内部类引用局部变量时，==局部变量必须是 final 的==：

因为在创建 Candy11$1 对象时，将 x 的值赋值给了 Candy11$1 对象的 值后，如果不是 final 声明的 x 值发生了改变，<font  color='blue'>匿名内部类则值不一致。</font>

## 4、类加载阶段

### 1）加载
将类的字节码载入<font  color='red'>方法区</font>（<font  color='cblue'>1.8后为元空间，在本地内存中</font>）中，内部采用`C++ 的 instanceKlass 描述 java 类`，它的重要 `ﬁeld `有：



* `_java_mirror` 即 java 的类镜像，例如对 String 来说，它的镜像类就是 String.class，作用是把 klass 暴露给 java 使用-

* `_super` 即父类- 

*  `_ﬁelds` 即成员变量- 

* `_methods` 即方法- 

* `_constants` 即常量池-

* `_class_loader` 即类加载器- 

* `_vtable` 虚方法表-

* `_itable` 接口方法



**注意**

- instanceKlass 这样的【元数据】是存储在方法区（1.8 后的元空间内），但 _java_mirror 是存储在堆中- 可以通过前面介绍的 HSDB 工具查看

### 2）连接


**验证** 验证类是否符合 JVM规范，安全性检查 用 UE 等支持二进制的编辑器修改 HelloWorld.class 的魔数，在控制台运行 **准备** 为 static 变量分配空间，设置默认值
- static 变量在 JDK 7 之前存储于 instanceKlass 末尾，从 JDK 7 开始，存储于 _java_mirror 末尾- static 变量分配空间和赋值是两个步骤，分配空间在准备阶段完成，赋值在初始化阶段完成- 如果 static 变量是 final 的基本类型，以及字符串常量，那么编译阶段值就确定了，赋值在准备阶段完成- 如果 static 变量是 final 的，但属于引用类型，那么赋值也会在初始化阶段完成将常量池中的符号引用解析为直接引用
```
public class Code_22_AnalysisTest {


    public static void main(String[] args) throws ClassNotFoundException, IOException {
        ClassLoader classLoader = Code_22_AnalysisTest.class.getClassLoader();
        Class<?> c = classLoader.loadClass("cn.ali.jvm.test.C");

        // new C();
        System.in.read();
    }

}

class C {
    D d = new D();
}

class D {

}

```

### 3）初始化

#### clinit()v 方法

初始化即调用 clinit()V ，虚拟机会保证这个类的『构造方法』的线程安全

#### 发生的时机

概括得说，类初始化是【懒惰的】
- main 方法所在的类，总会被首先初始化- 首次访问这个类的静态变量或静态方法时- 子类初始化，如果父类还没初始化，会引发- 子类访问父类的静态变量，只会触发父类的初始化- Class.forName- new 会导致初始化
不会导致类初始化的情况
- 访问类的 static final 静态常量（基本类型和字符串）不会触发初始化- 类对象.class 不会触发初始化- 创建该类的数组不会触发初始化



![image-20211214160336478](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202112141603590.png)

```
public class Load1 {
    static {
        System.out.println("main init");
    }
    public static void main(String[] args) throws ClassNotFoundException {
        // 1. 静态常量（基本类型和字符串）不会触发初始化
//         System.out.println(B.b);
        // 2. 类对象.class 不会触发初始化
//         System.out.println(B.class);
        // 3. 创建该类的数组不会触发初始化
//         System.out.println(new B[0]);
        // 4. 不会初始化类 B，但会加载 B、A
//         ClassLoader cl = Thread.currentThread().getContextClassLoader();
//         cl.loadClass("cn.ali.jvm.test.classload.B");
        // 5. 不会初始化类 B，但会加载 B、A
//         ClassLoader c2 = Thread.currentThread().getContextClassLoader();
//         Class.forName("cn.ali.jvm.test.classload.B", false, c2);


        // 1. 首次访问这个类的静态变量或静态方法时
//         System.out.println(A.a);
        // 2. 子类初始化，如果父类还没初始化，会引发
//         System.out.println(B.c);
        // 3. 子类访问父类静态变量，只触发父类初始化
//         System.out.println(B.a);
        // 4. 会初始化类 B，并先初始化类 A
//         Class.forName("cn.ali.jvm.test.classload.B");
    }

}


class A {
    static int a = 0;
    static {
        System.out.println("a init");
    }
}
class B extends A {
    final static double b = 5.0;
    static boolean c = false;
    static {
        System.out.println("b init");
    }
}

```



### 4）练习

从字节码分析，使用 a，b，c 这三个常量是否会导致 E 初始化

```
public class Load2 {

    public static void main(String[] args) {
        System.out.println(E.a);
        System.out.println(E.b);
        // 会导致 E 类初始化，因为 Integer 是包装类
        System.out.println(E.c);
    }
}

class E {
    public static final int a = 10;
    public static final String b = "hello";
    public static final Integer c = 20;

    static {
        System.out.println("E clinit");
    }
}


```

典型应用 - 完成懒惰初始化单例模式

```
public class Singleton {

    private Singleton() { } 
    // 内部类中保存单例
    private static class LazyHolder { 
        static final Singleton INSTANCE = new Singleton(); 
    }
    // 第一次调用 getInstance 方法，才会导致内部类加载和初始化其静态成员 
    public static Singleton getInstance() { 
        return LazyHolder.INSTANCE; 
    }
}


```

以上的实现特点是：
- 懒惰实例化- 初始化时的线程安全是有保障的
## 5、类加载器

类加载器虽然只用于实现类的加载动作，但它在Java程序中起到的作用却远超类加载阶段 对于任意一个类，都必须由加载它的类加载器和这个类本身一起共同确立其在 Java 虚拟机中的唯一性，每一个类加载器，都拥有一个独立的类名称空间。这句话可以表达得更通俗一些：比较两个类是否“相等”，只有在这两个类是由同一个类加载器加载的前提下才有意义，否则，即使这两个类来源于同一个 Class 文件，被同一个 Java 虚拟机加载，只要加载它们的类加载器不同，那这两个类就必定不相等！ 以JDK 8为例

|名称|加载的类|说明
|------
|Bootstrap ClassLoader（启动类加载器）|JAVA_HOME/jre/lib|无法直接访问
|Extension ClassLoader(拓展类加载器)|JAVA_HOME/jre/lib/ext|上级为Bootstrap，显示为null
|Application ClassLoader(应用程序类加载器)|classpath|上级为Extension
|自定义类加载器|自定义|上级为Application

### 1）启动类的加载器

可通过在控制台输入指令，使得类被启动类加器加载

### 2）扩展类的加载器

如果 classpath 和 JAVA_HOME/jre/lib/ext 下有同名类，加载时会使用拓展类加载器加载。当应用程序类加载器发现拓展类加载器已将该同名类加载过了，则不会再次加载。

### 3）双亲委派模式

双亲委派模式，即调用类加载器ClassLoader 的 loadClass 方法时，查找类的规则。 loadClass源码

```
protected Class<?> loadClass(String name, boolean resolve)
    throws ClassNotFoundException
{
    synchronized (getClassLoadingLock(name)) {
        // 首先查找该类是否已经被该类加载器加载过了
        Class<?> c = findLoadedClass(name);
        // 如果没有被加载过
        if (c == null) {
            long t0 = System.nanoTime();
            try {
                // 看是否被它的上级加载器加载过了 Extension 的上级是Bootstarp，但它显示为null
                if (parent != null) {
                    c = parent.loadClass(name, false);
                } else {
                    // 看是否被启动类加载器加载过
                    c = findBootstrapClassOrNull(name);
                }
            } catch (ClassNotFoundException e) {
                // ClassNotFoundException thrown if class not found
                // from the non-null parent class loader
                //捕获异常，但不做任何处理
            }

            if (c == null) {
                // 如果还是没有找到，先让拓展类加载器调用 findClass 方法去找到该类，如果还是没找到，就抛出异常
                // 然后让应用类加载器去找 classpath 下找该类
                long t1 = System.nanoTime();
                c = findClass(name);

                // 记录时间
                sun.misc.PerfCounter.getParentDelegationTime().addTime(t1 - t0);
                sun.misc.PerfCounter.getFindClassTime().addElapsedTimeFrom(t1);
                sun.misc.PerfCounter.getFindClasses().increment();
            }
        }
        if (resolve) {
            resolveClass(c);
        }
        return c;
    }
}

```

### 4）自定义类加载器

**使用场景**
- 想加载非 classpath 随意路径中的类文件- 通过接口来使用实现，希望解耦时，常用在框架设计- 这些类希望予以隔离，不同应用的同名类都可以加载，不冲突，常见于 tomcat 容器
**步骤**
- 继承 ClassLoader 父类- 要遵从双亲委派机制，重写 ﬁndClass 方法 不是重写 loadClass 方法，否则不会走双亲委派机制- 读取类文件的字节码- 调用父类的 deﬁneClass 方法来加载类- 使用者调用该类加载器的 loadClass 方法
  **破坏双亲委派模式**
  <li>双亲委派模型的第一次“被破坏”其实发生在双亲委派模型出现之前——即JDK1.2面世以前的“远古”时代 
  
  <ul>- 建议用户重写findClass()方法，在类加载器中的loadClass()方法中也会调用该方法- 如果有基础类型又要调用回用户的代码，此时也会破坏双亲委派模式- 这里所说的“动态性”指的是一些非常“热”门的名词：代码热替换（Hot Swap）、模块热部署（Hot Deployment）等
## 6、运行期优化

### 1）即时编译

**分层编译** JVM 将执行状态分成了 5 个层次：
- 0层：解释执行，用解释器将字节码翻译为机器码- 1层：使用 C1 即时编译器编译执行（不带 proﬁling）- 2层：使用 C1 即时编译器编译执行（带基本的profiling）- 3层：使用 C1 即时编译器编译执行（带完全的profiling）- 4层：使用 C2 即时编译器编译执行
proﬁling 是指在运行过程中收集一些程序执行状态的数据，例如【方法的调用次数】，【循环的 回边次数】等

即时编译器（JIT）与解释器的区别
<li>解释器 
  <ul>- 将字节码解释为机器码，下次即使遇到相同的字节码，仍会执行重复的解释- 是将字节码解释为针对所有平台都通用的机器码- 将一些字节码编译为机器码，并存入 Code Cache，下次遇到相同的代码，直接执行，无需再编译- 根据平台类型，生成平台特定的机器码
对于大部分的不常用的代码，我们无需耗费时间将其编译成机器码，而是采取解释执行的方式运行；另一方面，对于仅占据小部分的热点代码，我们则可以将其编译成机器码，以达到理想的运行速度。 执行效率上简单比较一下 Interpreter &lt; C1 &lt; C2，总的目标是发现热点代码（hotspot名称的由 来），并优化这些热点代码。 **逃逸分析** 逃逸分析（Escape Analysis）简单来讲就是，Java Hotspot 虚拟机可以分析新创建对象的使用范围，并决定是否在 Java 堆上分配内存的一项技术

逃逸分析的 JVM 参数如下：
- 开启逃逸分析：-XX:+DoEscapeAnalysis- 关闭逃逸分析：-XX:-DoEscapeAnalysis- 显示分析结果：-XX:+PrintEscapeAnalysis
逃逸分析技术在 Java SE 6u23+ 开始支持，并默认设置为启用状态，可以不用额外加这个参数

对象逃逸状态

全局逃逸（GlobalEscape）
<li>即一个对象的作用范围逃出了当前方法或者当前线程，有以下几种场景： 
  <ul>- 对象是一个静态变量- 对象是一个已经发生逃逸的对象- 对象作为当前方法的返回值
参数逃逸（ArgEscape）
- 即一个对象被作为方法参数传递或者被参数引用，但在调用过程中不会发生全局逃逸，这个状态是通过被调方法的字节码确定的
没有逃逸
- 即方法中的对象没有发生逃逸
**逃逸分析优化** 针对上面第三点，当一个对象没有逃逸时，可以得到以下几个虚拟机的优化

**锁消除** 我们知道线程同步锁是非常牺牲性能的，当编译器确定当前对象只有当前线程使用，那么就会移除该对象的同步锁 例如，StringBuffer 和 Vector 都是用 synchronized 修饰线程安全的，但大部分情况下，它们都只是在当前线程中用到，这样编译器就会优化移除掉这些锁操作 锁消除的 JVM 参数如下：
- 开启锁消除：-XX:+EliminateLocks- 关闭锁消除：-XX:-EliminateLocks
锁消除在 JDK8 中都是默认开启的，并且锁消除都要建立在逃逸分析的基础上

**标量替换** 首先要明白标量和聚合量，基础类型和对象的引用可以理解为标量，它们不能被进一步分解。而能被进一步分解的量就是聚合量，比如：对象 对象是聚合量，它又可以被进一步分解成标量，将其成员变量分解为分散的变量，这就叫做标量替换。

这样，如果一个对象没有发生逃逸，那压根就不用创建它，只会在栈或者寄存器上创建它用到的成员标量，节省了内存空间，也提升了应用程序性能 标量替换的 JVM 参数如下：
- 开启标量替换：-XX:+EliminateAllocations- 关闭标量替换：-XX:-EliminateAllocations- 显示标量替换详情：-XX:+PrintEliminateAllocations
标量替换同样在 JDK8 中都是默认开启的，并且都要建立在逃逸分析的基础上

**栈上分配** 当对象没有发生逃逸时，该对象就可以通过标量替换分解成成员标量分配在栈内存中，和方法的生命周期一致，随着栈帧出栈时销毁，减少了 GC 压力，提高了应用程序性能

**方法内联** **内联函数** 内联函数就是在程序编译时，编译器将程序中出现的内联函数的调用表达式用内联函数的函数体来直接进行替换

**JVM内联函数** C++ 是否为内联函数由自己决定，Java 由编译器决定。Java 不支持直接声明为内联函数的，如果想让他内联，你只能够向编译器提出请求: 关键字 final 修饰 用来指明那个函数是希望被 JVM 内联的，如

```
public final void doSomething() {  
        // to do something  
}

```

总的来说，一般的函数都不会被当做内联函数，只有声明了final后，编译器才会考虑是不是要把你的函数变成内联函数

JVM内建有许多运行时优化。首先短方法更利于JVM推断。流程更明显，作用域更短，副作用也更明显。如果是长方法JVM可能直接就跪了。

第二个原因则更重要：方法内联

如果JVM监测到一些小方法被频繁的执行，它会把方法的调用替换成方法体本身，如：

```
private int add4(int x1, int x2, int x3, int x4) { 
		//这里调用了add2方法
        return add2(x1, x2) + add2(x3, x4);  
    }  

    private int add2(int x1, int x2) {  
        return x1 + x2;  
    }

```

方法调用被替换后

```
private int add4(int x1, int x2, int x3, int x4) {  
    	//被替换为了方法本身
        return x1 + x2 + x3 + x4;  
    }

```

### 2）反射优化

```
public class Reflect1 {
   public static void foo() {
      System.out.println("foo...");
   }

   public static void main(String[] args) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
      Method foo = Demo3.class.getMethod("foo");
      for(int i = 0; i<=16; i++) {
         foo.invoke(null);
      }
   }
}

```

foo.invoke 前面 0 ~ 15 次调用使用的是 MethodAccessor 的 NativeMethodAccessorImpl 实现 invoke 方法源码

```
@CallerSensitive
public Object invoke(Object obj, Object... args)
    throws IllegalAccessException, IllegalArgumentException,
       InvocationTargetException
{
    if (!override) {
        if (!Reflection.quickCheckMemberAccess(clazz, modifiers)) {
            Class<?> caller = Reflection.getCallerClass();
            checkAccess(caller, clazz, obj, modifiers);
        }
    }
    //MethodAccessor是一个接口，有3个实现类，其中有一个是抽象类
    MethodAccessor ma = methodAccessor;             // read volatile
    if (ma == null) {
        ma = acquireMethodAccessor();
    }
    return ma.invoke(obj, args);
}

```

<img src="https://img-blog.csdnimg.cn/20210211225135924.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述"> 会由 DelegatingMehodAccessorImpl 去调用 NativeMethodAccessorImpl NativeMethodAccessorImpl 源码

```
class NativeMethodAccessorImpl extends MethodAccessorImpl {
    private final Method method;
    private DelegatingMethodAccessorImpl parent;
    private int numInvocations;

    NativeMethodAccessorImpl(Method var1) {
        this.method = var1;
    }
	
	//每次进行反射调用，会让numInvocation与ReflectionFactory.inflationThreshold的值（15）进行比较，并使使得numInvocation的值加一
	//如果numInvocation>ReflectionFactory.inflationThreshold，则会调用本地方法invoke0方法
    public Object invoke(Object var1, Object[] var2) throws IllegalArgumentException, InvocationTargetException {
        if (++this.numInvocations > ReflectionFactory.inflationThreshold() &amp;&amp; !ReflectUtil.isVMAnonymousClass(this.method.getDeclaringClass())) {
            MethodAccessorImpl var3 = (MethodAccessorImpl)(new MethodAccessorGenerator()).generateMethod(this.method.getDeclaringClass(), this.method.getName(), this.method.getParameterTypes(), this.method.getReturnType(), this.method.getExceptionTypes(), this.method.getModifiers());
            this.parent.setDelegate(var3);
        }

        return invoke0(this.method, var1, var2);
    }

    void setParent(DelegatingMethodAccessorImpl var1) {
        this.parent = var1;
    }

    private static native Object invoke0(Method var0, Object var1, Object[] var2);
}

```

```
//ReflectionFactory.inflationThreshold()方法的返回值
private static int inflationThreshold = 15;

```
- 一开始if条件不满足，就会调用本地方法 invoke0<li>随着 numInvocation 的增大，当它大于 ReflectionFactory.inflationThreshold 的值 16 时，就会本地方法访问器替换为一个运行时动态生成的访问器，来提高效率 
  <ul>- 这时会从反射调用变为正常调用，即直接调用 Reflect1.foo()
  <img src="https://img-blog.csdnimg.cn/20210211225248176.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl81MDI4MDU3Ng==,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述">

阿里开源工具：arthas-boot

# 五、内存模型

