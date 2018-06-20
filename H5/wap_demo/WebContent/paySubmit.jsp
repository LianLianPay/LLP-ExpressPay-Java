<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.lianpay.share.util.*"%>
<%@ page import="com.lianpay.share.security.RSAUtil"%>
<%@ page import="com.lianpay.share.security.Md5Algorithm"%>
<%@page import="com.yintong.paywap.domain.PaymentInfo"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page import="com.lianpay.share.config.PartnerConfig"%>


<%
	request.setCharacterEncoding("UTF-8");
    String contextPath = request.getContextPath() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>连连支付</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<style>
.info {
	padding: 15px;
	background: #fff url(images/info_bg.png) left bottom repeat-x;
}

.table_ui {
	width: 100%;
	margin: 0 auto;
}

.table_ui td {
	line-height: 1.5em;
	padding-bottom: 10px;
	vertical-align: top;
}

.ft_gray {
	color: #999;
}

.slogan {
	overflow: hidden;
	width: 100%;
	height: 19px;
	position: relative;
	margin: 20px 0 5px 0;
}

.slogan h3 {
	font-size: 18px;
	line-height: 19px;
	padding-left: 1%;
	color: #4d4d4d;
	position: absolute;
	background: #f2f2f2;
	z-index: 100;
	padding: 0 0.215em;
	font-weight: normal;
	font-family: "微软雅黑";
}

.slogan span {
	height: 9px;
	border-bottom: 1px solid #cacaca;
	width: 100%;
	position: absolute
}

.warp {
	width: 95%;
	margin: 0 auto;
}

.footer {
	text-align: center;
	color: #999;
	padding: 2em 0 1em 0;
}

.footer img {
	height: 15px;
	vertical-align: middle;
}

.footer span {
	height: 15px;
	font-size: 0.8em;
	line-height: 0.8em;
}
</style>
<%    

    StringBuffer strBuf = new StringBuffer();
    if (!FuncUtils.isNull(request.getParameter("acct_name")))
    {
        strBuf.append("acct_name=");
        strBuf.append(request.getParameter("acct_name"));
        strBuf.append("&app_request=3");
    } else
    {
        strBuf.append("app_request=3");
    }
    if (!FuncUtils.isNull(request.getParameter("bg_color")))
    {
        strBuf.append("&bg_color=");
        strBuf.append(request.getParameter("bg_color"));
    }
    strBuf.append("&busi_partner=");
    strBuf.append(request.getParameter("busi_partner"));
    if (!FuncUtils.isNull(request.getParameter("card_no")))
    {
        strBuf.append("&card_no=");
        strBuf.append(request.getParameter("card_no"));
    }
    strBuf.append("&dt_order=");
    strBuf.append(request.getParameter("dt_order"));
    if (!FuncUtils.isNull(request.getParameter("id_no")))
    {
        strBuf.append("&id_no=");
        strBuf.append(request.getParameter("id_no"));
    }
    if (!FuncUtils.isNull(request.getParameter("info_order")))
    {
        strBuf.append("&info_order=");
        strBuf.append(request.getParameter("info_order"));
    }
    strBuf.append("&money_order=");
    strBuf.append(request.getParameter("money_order"));
    if (!FuncUtils.isNull(request.getParameter("name_goods")))
    {
        strBuf.append("&name_goods=");
        strBuf.append(request.getParameter("name_goods"));
    }
    if (!FuncUtils.isNull(request.getParameter("no_agree")))
    {
        strBuf.append("&no_agree=");
        strBuf.append(request.getParameter("no_agree"));
    }
    strBuf.append("&no_order=");
    strBuf.append(request.getParameter("no_order"));
    strBuf.append("&notify_url=");
    strBuf.append(request.getParameter("notify_url"));
    strBuf.append("&oid_partner=");
    strBuf.append(request.getParameter("oid_partner"));
    if (!FuncUtils.isNull(request.getParameter("risk_item")))
    {
        strBuf.append("&risk_item=");
        strBuf.append(request.getParameter("risk_item"));
    }
    strBuf.append("&sign_type=");
    strBuf.append(request.getParameter("sign_type"));
    if (!FuncUtils.isNull(request.getParameter("url_return")))
    {
        strBuf.append("&url_return=");
        strBuf.append(request.getParameter("url_return"));
    }
    if (!FuncUtils.isNull(request.getParameter("user_id")))
    {
        strBuf.append("&user_id=");
        strBuf.append(request.getParameter("user_id"));
    }
    if (!FuncUtils.isNull(request.getParameter("valid_order")))
    {
        strBuf.append("&valid_order=");
        strBuf.append(request.getParameter("valid_order"));
    }
    String sign_src = strBuf.toString();
    if (sign_src.startsWith("&"))
    {
        sign_src = sign_src.substring(1);
    }
    String sign = "";
    if ("RSA".equals(request.getParameter("sign_type")))
    {
        sign = RSAUtil.sign(PartnerConfig.TRADER_PRI_KEY, sign_src);
    } else
    {
        sign_src += "&key=" + PartnerConfig.MD5_KEY;
        sign = Md5Algorithm.getInstance().md5Digest(
                sign_src.getBytes("utf-8"));
    }
    PaymentInfo payInfo = new PaymentInfo();
    payInfo.setApp_request(request.getParameter("app_request"));
    payInfo.setBg_color(request.getParameter("bg_color"));
    payInfo.setBusi_partner(request.getParameter("busi_partner"));
    payInfo.setCard_no(request.getParameter("card_no"));
    payInfo.setDt_order(request.getParameter("dt_order"));
    payInfo.setId_no(request.getParameter("id_no"));
    payInfo.setInfo_order(request.getParameter("info_order"));
    payInfo.setMoney_order(request.getParameter("money_order"));
    payInfo.setName_goods(request.getParameter("name_goods"));
    payInfo.setNo_agree(request.getParameter("no_agree"));
    payInfo.setNo_order(request.getParameter("no_order"));
    payInfo.setNotify_url(request.getParameter("notify_url"));
    payInfo.setOid_partner(request.getParameter("oid_partner"));
    payInfo.setAcct_name(request.getParameter("acct_name"));
    payInfo.setRisk_item(request.getParameter("risk_item"));
    payInfo.setSign_type(request.getParameter("sign_type"));
    payInfo.setUrl_return(request.getParameter("url_return"));
    payInfo.setUser_id(request.getParameter("user_id"));
    payInfo.setValid_order(request.getParameter("valid_order"));
    payInfo.setSign(sign);
    String req_data = JSON.toJSONString(payInfo);
%>
</head>
<body>
	<div class="header">
		<a href="javascript:history.go(-1);" class="back">返回</a>
		<h1 class="logo">银行卡支付</h1>
		<a href="#" class="about">关于</a>
	</div>

	<section class="info">
		<table border="0" cellspacing="0" cellpadding="0" class="table_ui">
			<tr>
				<td width="200"><span class="ft_gray">维多利亚丽佳酒店(杭州)</span></td>
				<td style="text-align: right"></td>
			</tr>
			<tr>
				<td><span class="ft_gray">房型：</span></td>
				<td style="text-align: right">高级套房</td>
			</tr>
			<tr>
				<td width="100"><span class="ft_gray">房间面积：</span></td>
				<td style="text-align: right">50</td>
			</tr>
			<tr>
				<td width="100"><span class="ft_gray">楼层：</span></td>
				<td style="text-align: right">2-5</td>
			</tr>
			<tr>
				<td width="100"><span class="ft_gray">早餐：</span></td>
				<td style="text-align: right">含双早</td>
			</tr>
			<tr>
				<td width="100"><span class="ft_gray">宽带：</span></td>
				<td style="text-align: right">免费</td>
			</tr>
			<tr>
				<td width="100"><span class="ft_gray">到店时间：</span></td>
				<td style="text-align: right">2013-07-25</td>
			</tr>
		</table>
	</section>

	<section class="slogan">
		<h3>
			请仔细阅读<a href="javascript:void(0)">《网上订购须知》</a>
		</h3>
		<span class="line"></span>
	</section>
	<section>
		<div class="form_warp">
			<form action="https://wap.lianlianpay.com/payment.htm"
				method="post">
				<ul>
					<li><input type="hidden" name="req_data" value='<%=req_data%>' />
						<button name="next_btn" class="btn" type="submit" id="next_btn">连连支付</button></li>
				</ul>
			</form>
		</div>

	</section>
	<footer class="warp footer">
		<img src="images/logo.png" /> <span>连连支付版权所有 2004-2017
			浙B2-20080148</span>
	</footer>
</body>
</html>

