---
layout: post
title: Java code to get URL from a string
description: Java code to get URL from a string
tags: [java, url, regex]
---

This little code snippet / function will effectively extract URL strings from a string in Java. I found the basic regex for doing it here, and used it in a java function.

```java
//Pull all links from the body for easy retrieval
private ArrayList pullLinks(String text) {
ArrayList links = new ArrayList();

String regex = "\\(?\\b(http://|www[.])[-A-Za-z0-9+&@#/%?=~_()|!:,.;]*[-A-Za-z0-9+&@#/%=~_()|]";
Pattern p = Pattern.compile(regex);
Matcher m = p.matcher(text);
while(m.find()) {
String urlStr = m.group();
if (urlStr.startsWith("(") && urlStr.endsWith(")"))
{
  urlStr = urlStr.substring(1, urlStr.length() - 1);
}
links.add(urlStr);
}
return links;
}
```

## Book Recommendation: Java in a Nutshell
Interested in learning more and better Java? Then I recommend the Java book I most recently read: ["Java in a Nutshell: A Desktop Quick Reference"](https://amzn.to/3pjbekB) published by O’Reilly.

[![Java in a Nutshell: A Desktop Quick Reference](/assets/books/oreilly_java_in_a_nutshell.jpg)](https://amzn.to/3pjbekB)
