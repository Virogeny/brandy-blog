+++
title = "Stream流使用"
date = 2020-12-23T14:59:36+08:00
tags = ["JAVA"]
categories = ["JAVA"]
draft = false
description = "java新特新之stream流"

+++

## 将List\<T>转Map\<String,List\<T>>

```java
List<AreaOfOrg> areaOfOrgs = areaOfOrgMapper.countyListAll();
Map<String, List<AreaOfOrg>> map = areaOfOrgs.stream().collect(Collectors.groupingBy(AreaOfOrg::getPOrgNo));
```

## filter

- filter 方法用于通过设置的条件过滤出元素  

```txt
```java
List<String>strings = Arrays.asList("abc", "", "bc", "efg", "abcd","", "jkl");
// 获取空字符串的数量
long count = strings.stream().filter(string -> string.isEmpty()).count();
```
