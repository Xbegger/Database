## 命名冲突

在 XML 中，元素名称是由开发者定义的，当两个不同的文档使用相同的元素名时，就会发生命名冲突。

```xml
<!--A.xml-->
<table>
   <tr>
   <td>Apples</td>
   <td>Bananas</td>
   </tr>
</table>
```

```xml
<!--B.xml-->
<table>
   <name>African Coffee Table</name>
   <width>80</width>
   <length>120</length>
</table>
```

假如这两个 ==XML 文档被一起使用==，由于两个文档都包含带有不同内容定义的 **<table> 元素**，就会发生**命名冲突**。XML 解析器无法确定如何处理这类冲突。



## 使用前缀来避免命名冲突

```xml
<h:table>
   <h:tr>
   <h:td>Apples</h:td>
   <h:td>Bananas</h:td>
   </h:tr>
</h:table>
```

```xml
<f:table>
   <f:name>African Coffee Table</f:name>
   <f:width>80</f:width>
   <f:length>120</f:length>
</f:table>
```

现在，命名冲突不存在了，**这是由于两个文档都使用了不同的名称来命名它们的 <table> 元素** (<h:table> 和 <f:table>)。通过使用前缀，我们创建了两种不同类型的 <table> 元素。



## 使用命名空间（Namespaces）

```xml
<h:table 
xmlns:h="http://www.w3.org/TR/html4/"
>
   <h:tr>
   <h:td>Apples</h:td>
   <h:td>Bananas</h:td>
   </h:tr>
</h:table>
```

```xml
<f:table 
xmlns:f="http://www.w3school.com.cn/furniture"
>
   <f:name>African Coffee Table</f:name>
   <f:width>80</f:width>
   <f:length>120</f:length>
</f:table>
```

与仅仅使用前缀不同，我们为 <table> 标签添加了一个 xmlns 属性，这样==**就为前缀赋予了一个与某个命名空间相关联的限定名称**。==



## XML Namespace (xmlns) 属性

XML 命名空间属性被放置于元素的开始标签之中，并使用以下的语法：

```
xmlns:namespace-prefix="namespaceURI"
```

当==命名空间被定义在元素的开始标签中时，所有带有相同前缀的子元素都会与同一个命名空间相关联==。

注释：用于标示命名空间的地址不会被解析器用于查找信息。==**其惟一的作用是赋予命名空间一个惟一的名称**==。不过，**很多公司常常会作为指针来使用命名空间指向实际存在的网页**。



## 统一资源标识符（Uniform Resource Identifier (URI)）

*统一资源标识符*是一串==可以标识因特网资源的字符==。**最常用的 URI 是用来标示因特网域名地址的*统一资源定位器(URL)***。另一个不那么常用的 URI 是*统一资源命名(URN)*。在我们的例子中，我们仅使用 URL。



## 默认的命名空间（Default Namespaces）

为元素定义默认的命名空间可以让我们**省去在所有的子元素中使用前缀的工作**。

```xml
<table 
xmlns="http://www.w3.org/TR/html4/"
>
   <tr>
   <td>Apples</td>
   <td>Bananas</td>
   </tr>
</table>
```

```xml
<table 
xmlns="http://www.w3school.com.cn/furniture"
>
   <name>African Coffee Table</name>
   <width>80</width>
   <length>120</length>
</table>
```

























