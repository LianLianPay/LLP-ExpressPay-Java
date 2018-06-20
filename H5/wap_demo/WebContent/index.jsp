<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="com.lianpay.share.util.*"%>
<%@ page import="com.lianpay.share.config.PartnerConfig"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style type="text/css">
body {
	text-align: center;
	font-family: "微软雅黑";
}

td {
	font-size: 14px;
}
</style>
<title>连连支付WAP收银台测试</title>
</head>
<body>

	<form name="inputForm"
		action='<%=request.getContextPath()%>/paySubmit.jsp' method=post>
		<table cellpadding="2" cellspacing="2">
			<tr>
				<td colspan="2" align="center"
					style="font-weight: bold; font-size: 25px;" height="85">连连支付WAP收银台测试</td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>请求应用标识</td>
				<td><input type="text" name="app_request" value="3"
					readonly="readonly">1-Android 2-ios 3-WAP</td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>商户业务类型</td>
				<td><input type="text" name="busi_partner" value="<%=PartnerConfig.BUSI_PARTNER%>"
					readonly="readonly">（101001：虚拟商品销售、109001：实物商品销售、108001：外部账户充值）</td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>商户订单时间</td>
				<td><input type="text" name="dt_order"
					value="<%=DateUtil.getCurrentDateTimeStr1()%>">（格式：YYYYMMDDH24MISS）</td>
			</tr>

			<tr>
				<td>订单描述</td>
				<td><input type="text" name="info_order" value="购买高级套房一间"></td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>交易金额</td>
				<td><input type="text" name="money_order" value="0.01">（单位为RMB-元）</td>
			</tr>
			<tr>
				<td>商品名称</td>
				<td><input type="text" name="name_goods" value="高级套房一间"></td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>商户唯一订单号</td>
				<td><input type="text" name="no_order"
					value="<%=DateUtil.getCurrentDateTimeStr1()%>">（不重复的单号）</td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>服务器异步通知地址</td>
				<td><input type="text" style="width: 300px;" name="notify_url"
					value="<%=PartnerConfig.NOTIFY_URL%>"></td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>商户号</td>
				<td><input type="text" name="oid_partner"
					value="<%=PartnerConfig.OID_PARTNER%>" readonly="readonly">测试：201310102000003524
					线上测试：201306031000001013</td>
			</tr>
			<tr>
				<td><span></span>卡号</td>
				<td><input type="text" name="card_no" value=""></td>
			</tr>
			<tr>
				<td><span></span>姓名</td>
				<td><input type="text" name="acct_name" value=""></td>
			</tr>

			<tr>
				<td><span></span>身份证号</td>
				<td><input type="text" name="id_no" value=""></td>
			</tr>
			<tr>
				<td>协议号</td>
				<td><input type="text" name="no_agree"></td>
			</tr>

			<tr>
				<td>风险控制参数</td>
				<td><textarea rows="5" cols="60" name="risk_item">{"user_info_bind_phone":"13958069593","user_info_dt_register":"20131030122130","risk_state":"1","frms_ware_category ":"1009"}</textarea></td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>签名方式</td>
				<td><input type="text" name="sign_type" value="<%=PartnerConfig.SIGN_TYPE%>">（RSA或MD5）</td>
			</tr>
			<tr>
				<td>支付结束回显url</td>
				<td><input type="text" style="width: 300px;" name="url_return"
					value="<%=PartnerConfig.URL_RETURN%>"></td>
			</tr>
			<tr>
				<td><span style="color: red">*</span>商户用户唯一编号</td>
				<td><input type="text" name="user_id" value="22222222"></td>
			</tr>
			<tr>
				<td>订单有效时间</td>
				<td><input type="text" name="valid_order" value="30">分钟为单位，默认为10080分钟（7天）</td>
			</tr>
			<tr>
				<td><input type="submit" value="提交"><input type="reset"
					value="重置"></td>
			</tr>
		</table>
	</form>
</body>
</html>
