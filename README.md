# LLP-ExpressPay-Java

欢迎来到连连快捷收款的Java仓库， 本仓库包含Java接入快捷收款网页版的示例代码及必要的说明。

其中， ```Web```目录下为快捷收款PC端页面的示例工程；```H5```目录下为快捷收款移动端页面的示例工程。

## 主要内容

[前置要求](#前置要求)

[快捷收款测试商户号信息](#快捷收款测试商户号信息)

[使用说明](#使用说明)

[文档说明](#文档说明)

## 前置要求

Java JDK版本为1.6及1.6以上

## 快捷收款测试商户号信息

测试商户号: 201408071000001539

PKCS8格式私钥(供```Java```使用): 

```text
MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKZGXpmfgya2gGh6UdFPqPqi6e2z/HX4aIlMH394FOXTVwErnSGY5S0YFw5WskJrQLU2RHwFiA5P9Yt8VPxwgLDpdIm1/a7NlyjvWNvBd8V7wyITH8teJA1Ae5yWmRRrWFcVRSjpBq3xfwv76lVl+Nq/jR08p/ugVYJgtYEIM53JAgMBAAECgYA17SarPj+j45a7y8gTUXmlaAbkb/ZWMG1+8fBZQBHPA/74wzNf/R1+xYxcuyNvRSekXehSLN0WfzpMtdM+WCJ0ODqHRFsbAxmi784hzBZHOAxoJV49P8PVy6HIPthXxiSNUcacSt/HKJrUI6zACpymJLiVxMb9GqQAyx3BJl7rjQJBANG+RDszZYl3J1z1AtD0WggycrH2YOB7v5o3qKOz2AQ6CHWApSN6cuvqFwaUtHK9gMpDhvWR6zbYVRP+f4AxoQ8CQQDK8fTkpHNrHc011E8jjk3Uq5PWTJ0jAvcqk4rqZa4eV9953YSJYtJ2Fk2JnL3Ba7AU+qStnyD6MvSIpwIPSaOnAkEAptbFaZ4Jn55jdmMC2Xn1f925NGx6RTbKg37Qq18sbrhG8Ejjk2QctCIiLL7vBvJM1xd97CslQhw1GNFxVGSl6wJAQzwFtfoFgudMpRjBXzY18s8lG0omhQLmf+SBkUY+eS8Diowo7Jsgvp6E8aJL+1iB7XFcPWkKs9lNyjgKJqZu4QJAM22ULfWKrNIqaBJaYDmQSupUkHR/WL5rQJtAuVo8Zg3+rBrtMTXfIHJpR0MNpMgRSsPK6pZ3n4i+VvC5WxKUzA==
```

其公钥已上传至商户站。有关您真实商户号的公私钥配置， 请参考[连连开放平台 - 公私钥配置](https://zealous-kare-7abde4.netlify.com/docs/development/signature-key-generation)。

> 测试商户号是连连正式环境的商户号， 需要使用真实信息进行测试， 测试时建议将订单金额设置到```0.01```元(CNY)。使用测试商户号时， 建议使用独特的用户唯一标识```user_id```及独特的商户订单号```no_order```以免与其他商户的测试信息冲突。

## 使用说明

根据需要， 将```Web```或```H5```版的示例工程部署到您的Web应用服务器(可以使用[Tomcat](http://tomcat.apache.org/), 或[JBoss](https://www.jboss.org/)等)运行即可。

示例工程目录说明:

```text
webdemo
  │
  ├src┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈类文件夹
  │  │
  │  ├com.llpay.client.config
  │  │  │
  │  │  ├PartnerConfig.java┈┈┈┈┈┈商户基础配置类文件
  │  │  │
  │  │  └ServerURLConfig.java┈┈┈┈┈请求服务地址配置类文件
  │  │
  │  ├com.llpay.client.conn
  │  │  │
  │  │  ├CustomHttpClient.java┈┈┈┈┈┈HttpClient类文件
  │  │  │
  │  │  ├HttpRequestSimple.java┈┈┈┈┈HttpClient类文件
  │  │  │
  │  │  └MySSLSocketFactory.java┈┈┈┈┈┈┈HttpClient类文件
  │  │
  │  ├com.llpay.client.enum
  │  │  │
  │  │  ├PayResultEnum.java ┈┈┈┈┈┈┈┈┈支付结果枚举类文件
  │  │  │
  │  │  └SignTypeEnum.java ┈┈┈┈┈┈┈┈┈签名类型枚举类文件
  │  │
  │  ├com.llpay.client.pay
  │  │  │
  │  │  ├InfoQueryServlet.java ┈卡bin信息查询和已绑定信息查询类文件
  │  │  │
  │  │  ├ReceiveNotifyServlet.java ┈┈┈┈┈异步通知接收类文件
  │  │  │
  │  │  └ToPayServlet.java┈┈┈┈构造支付信息类文件
  │  │
  │  ├com.llpay.client.security
  │  │  │
  │  │  ├Base64.java ┈Base64类文件
  │  │  │
  │  │  ├Md5Algorithm.java ┈┈┈┈┈Md5Algorithm类文件
  │  │  │
  │  │  └TraderRSAUtil.java┈┈┈┈TraderRSAUtil类文件
  │  │
  │  ├com.llpay.client.utils
  │  │  │
  │  │  └LLPayUtil.java┈┈┈连连支付工具类文件
  │  │
  │  └com.llpay.client.vo
  │      │
  │      ├OrderInfo.java ┈订单bean
  │      │
  │      ├PayDataBean.java ┈┈┈┈┈异步通知数据bean
  │      │
  │      ├PaymentInfo.java ┈┈┈┈┈支付信息bean
  │      │
  │      └RetBean.java┈┈┈┈异步通知响应bean
  │
  │
  └WebRoot┈┈┈┈┈┈┈┈┈┈┈┈┈┈页面文件夹
     │
     ├images┈┈┈┈┈┈┈┈┈图片资源
     │
     ├about.jsp┈┈┈┈┈┈┈┈┈┈┈连连支付介绍页面
     │
     ├gotoPlainPay.jsp ┈┈┈┈┈┈┈┈普通接入方式调转连连支付页面文件
     │
     ├gotoPrepositPay.jsp ┈┈┈┈┈┈卡前置接入方式调转连连支付页面文件
     │
     ├index.jsp ┈┈┈┈┈┈┈┈demo入口页面
     │
     ├plainPay.jsp ┈┈┈┈┈┈┈┈普通接入方式页面文件
     │
     ├prepositPay.jsp ┈┈┈┈┈┈┈┈卡前置接入方式页面文件
     │
     ├urlReturn.jsp ┈┈┈┈┈┈┈┈页面跳转同步通知文件
     │
     └WEB-INF
          │
          └lib（如果JAVA项目中包含这些架包，则不需要导入）
             │
             ├commons-codec-1.4.jar
             │
             ├fastjson-1.1.31.jar
             │
             ├httpclient-4.2.5.jar
             │
             ├httpclient-cache-4.2.5.jar
             │
             ├httpcore-4.2.4.jar
             │
             └httpmime-4.2.5.jar
```

## 文档说明

有关快捷收款的详细介绍及请求参数说明， 请参考[连连开放平台 - 快捷收款](https://zealous-kare-7abde4.netlify.com/docs/receive-money/express/overview)。