package com.llpay.client.pay;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.llpay.client.config.PartnerConfig;
import com.llpay.client.config.ServerURLConfig;
import com.llpay.client.utils.LLPayUtil;
import com.llpay.client.vo.OrderInfo;
import com.llpay.client.vo.PaymentInfo;

/**
* 调用连连支付WEB支付服务
* @author guoyx e-mail:guoyx@lianlian.com
* @date:2013-6-25 下午01:41:15
* @version :1.0
*
*/
public class ToPayServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        // 创建订单
        OrderInfo order = createOrder(req);
        RequestDispatcher dispatcher = null;
        String paymod = req.getParameter("paymod");
        if ("plain".equals(paymod))
        {
            plainPay(req, order);
            dispatcher = req.getRequestDispatcher("/gotoPlainPay.jsp");
        } else
        {
            prepositPay(req, order);
            dispatcher = req.getRequestDispatcher("/gotoPrepositPay.jsp");
        }
        dispatcher.forward(req, resp);
    }

    /**
     * 卡前置支付处理
     * @param req
     * @param order
     */
    private void prepositPay(HttpServletRequest req, OrderInfo order)
    {
        // 构造支付请求对象
        PaymentInfo paymentInfo = new PaymentInfo();
        paymentInfo.setVersion(PartnerConfig.VERSION);
        paymentInfo.setOid_partner(PartnerConfig.OID_PARTNER);
        paymentInfo.setUser_id(req.getParameter("user_id"));
        paymentInfo.setSign_type(PartnerConfig.SIGN_TYPE);
        paymentInfo.setBusi_partner(PartnerConfig.BUSI_PARTNER);
        paymentInfo.setNo_order(order.getNo_order());
        paymentInfo.setDt_order(order.getDt_order());
        paymentInfo.setName_goods(order.getName_goods());
        paymentInfo.setInfo_order(order.getInfo_order());
        paymentInfo.setMoney_order(order.getMoney_order());
        paymentInfo.setNotify_url(PartnerConfig.NOTIFY_URL);
        paymentInfo.setUrl_return(PartnerConfig.URL_RETURN);
        paymentInfo.setUserreq_ip(LLPayUtil.getIpAddr(req));
        paymentInfo.setUrl_order("");
        paymentInfo.setValid_order("10080");// 单位分钟，可以为空，默认7天
        paymentInfo.setRisk_item(createRiskItem());
        paymentInfo.setTimestamp(LLPayUtil.getCurrentDateTimeStr());
        if (!LLPayUtil.isnull(req.getParameter("no_agree")))
        {
            paymentInfo.setNo_agree(req.getParameter("no_agree"));
            paymentInfo.setBack_url("http://www.lianlianpay.com/");
        } else
        {
            // 从系统中获取用户身份信息
            paymentInfo.setId_type("0");
            paymentInfo.setId_no("410782198912151334");
            paymentInfo.setAcct_name("连连");
            paymentInfo.setFlag_modify("1");
            paymentInfo.setCard_no(req.getParameter("card_no"));
            paymentInfo.setBack_url("http://www.lianlianpay.com/");
        }
        // 加签名
        String sign = LLPayUtil.addSign(JSON.parseObject(JSON
                .toJSONString(paymentInfo)), PartnerConfig.TRADER_PRI_KEY,
                PartnerConfig.MD5_KEY);
        paymentInfo.setSign(sign);

        req.setAttribute("version", paymentInfo.getVersion());
        req.setAttribute("oid_partner", paymentInfo.getOid_partner());
        req.setAttribute("user_id", paymentInfo.getUser_id());
        req.setAttribute("sign_type", paymentInfo.getSign_type());
        req.setAttribute("busi_partner", paymentInfo.getBusi_partner());
        req.setAttribute("no_order", paymentInfo.getNo_order());
        req.setAttribute("dt_order", paymentInfo.getDt_order());
        req.setAttribute("name_goods", paymentInfo.getName_goods());
        req.setAttribute("info_order", paymentInfo.getInfo_order());
        req.setAttribute("money_order", paymentInfo.getMoney_order());
        req.setAttribute("notify_url", paymentInfo.getNotify_url());
        req.setAttribute("url_return", paymentInfo.getUrl_return());
        req.setAttribute("userreq_ip", paymentInfo.getUserreq_ip());
        req.setAttribute("url_order", paymentInfo.getUrl_order());
        req.setAttribute("valid_order", paymentInfo.getValid_order());
        req.setAttribute("timestamp", paymentInfo.getTimestamp());
        req.setAttribute("sign", paymentInfo.getSign());
        req.setAttribute("risk_item", paymentInfo.getRisk_item());
        req.setAttribute("no_agree", paymentInfo.getNo_agree());
        req.setAttribute("id_type", paymentInfo.getId_type());
        req.setAttribute("id_no", paymentInfo.getId_no());
        req.setAttribute("acct_name", paymentInfo.getAcct_name());
        req.setAttribute("flag_modify", paymentInfo.getFlag_modify());
        req.setAttribute("card_no", paymentInfo.getCard_no());
        req.setAttribute("back_url", paymentInfo.getBack_url());
        req.setAttribute("req_url", ServerURLConfig.PAY_URL);

    }

    /**
     * 根据连连支付风控部门要求的参数进行构造风控参数
     * @return
     */
    private String createRiskItem()
    {
        JSONObject riskItemObj = new JSONObject();
        riskItemObj.put("user_info_full_name", "你好");
        riskItemObj.put("frms_ware_category", "1999");
        return riskItemObj.toString();
    }

    /**
     * 普通支付处理
     * @param req
     * @param order
     */
    private void plainPay(HttpServletRequest req, OrderInfo order)
    {
        // 构造支付请求对象
        PaymentInfo paymentInfo = new PaymentInfo();
        paymentInfo.setVersion(PartnerConfig.VERSION);
        paymentInfo.setOid_partner(PartnerConfig.OID_PARTNER);
        paymentInfo.setUser_id(req.getParameter("user_id"));
        paymentInfo.setSign_type(PartnerConfig.SIGN_TYPE);
        paymentInfo.setBusi_partner(PartnerConfig.BUSI_PARTNER);
        paymentInfo.setNo_order(order.getNo_order());
        paymentInfo.setDt_order(order.getDt_order());
        paymentInfo.setName_goods(order.getName_goods());
        paymentInfo.setInfo_order(order.getInfo_order());
        paymentInfo.setMoney_order(order.getMoney_order());
        paymentInfo.setNotify_url(PartnerConfig.NOTIFY_URL);
        paymentInfo.setUrl_return(PartnerConfig.URL_RETURN);
        paymentInfo.setUserreq_ip(LLPayUtil.getIpAddr(req));
        paymentInfo.setUrl_order("");
        paymentInfo.setValid_order("10080");// 单位分钟，可以为空，默认7天
        paymentInfo.setTimestamp(LLPayUtil.getCurrentDateTimeStr());
        paymentInfo.setRisk_item(createRiskItem());
        // 加签名
        String sign = LLPayUtil.addSign(JSON.parseObject(JSON
                .toJSONString(paymentInfo)), PartnerConfig.TRADER_PRI_KEY,
                PartnerConfig.MD5_KEY);
        paymentInfo.setSign(sign);

        req.setAttribute("version", paymentInfo.getVersion());
        req.setAttribute("oid_partner", paymentInfo.getOid_partner());
        req.setAttribute("user_id", paymentInfo.getUser_id());
        req.setAttribute("sign_type", paymentInfo.getSign_type());
        req.setAttribute("busi_partner", paymentInfo.getBusi_partner());
        req.setAttribute("no_order", paymentInfo.getNo_order());
        req.setAttribute("dt_order", paymentInfo.getDt_order());
        req.setAttribute("name_goods", paymentInfo.getName_goods());
        req.setAttribute("info_order", paymentInfo.getInfo_order());
        req.setAttribute("money_order", paymentInfo.getMoney_order());
        req.setAttribute("notify_url", paymentInfo.getNotify_url());
        req.setAttribute("url_return", paymentInfo.getUrl_return());
        req.setAttribute("userreq_ip", paymentInfo.getUserreq_ip());
        req.setAttribute("url_order", paymentInfo.getUrl_order());
        req.setAttribute("valid_order", paymentInfo.getValid_order());
        req.setAttribute("timestamp", paymentInfo.getTimestamp());
        req.setAttribute("sign", paymentInfo.getSign());
        req.setAttribute("risk_item", paymentInfo.getRisk_item());
        req.setAttribute("req_url", ServerURLConfig.PAY_URL);

    }

    /**
     * 模拟商户创建订单
     * @param req
     * @return
     */
    private OrderInfo createOrder(HttpServletRequest req)
    {
        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setNo_order(LLPayUtil.getCurrentDateTimeStr());
        orderInfo.setDt_order(LLPayUtil.getCurrentDateTimeStr());
        orderInfo.setMoney_order(req.getParameter("money_order"));
        orderInfo.setName_goods(req.getParameter("name_goods"));
        orderInfo.setInfo_order("用户购买" + req.getParameter("name_goods"));
        return orderInfo;
    }

}
