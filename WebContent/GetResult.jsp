<%@page contentType="text/html;charset=gb2312" language="java"%>
<%@page session="true" import="com.gnete.paymentgateway.PayUtils,java.util.Date"
                       import="java.net.URLEncoder" %>
<html>
<table border="0">

<%	
	String strUrl,MerId,UserId,Pwd,PaySuc,ShoppingTime,BeginTime,EndTime,OrderNo,strBody;
	boolean ret;
	String resultMsg;
	strUrl = "http://test.gnete.com:8888/bin/scripts/Openvendor/gnete/V36/GetPayResult.asp";
	MerId			= "198";
	UserId			= "198";
	Pwd				= "a123456";
	PaySuc			= "1" ;
	ShoppingTime	= "";
	BeginTime		= "2012-10-11 00:00:00";
	EndTime			= "2012-10-12 00:00:00"	;
	OrderNo			= "";
	
	BeginTime = URLEncoder.encode(BeginTime,"gb2312");
	EndTime = URLEncoder.encode(EndTime,"gb2312");
	
	strBody = "Merid=" + MerId + "&userid=" + UserId + "&pwd=" + Pwd + "&paysuc=" + PaySuc + "&shoppingtime=" + ShoppingTime + "&BeginTime=" + BeginTime + "&endtime=" + EndTime +	"&orderno=" + OrderNo;
	
	PayUtils payUtils = new PayUtils();
	//�Ӻ�����֧���������ط��������Ľ��׽������
	try{
		resultMsg = payUtils.doPostQueryCmd(strUrl,strBody);
		System.out.println(resultMsg);
		if(resultMsg!=null){
			//���سɹ���ȡ���׽�����ݣ������ʽ���������̻�֧���ӿ�V34.doc���С����ʽ�����ݡ�һ��
			out.println(resultMsg);
	  	}else{
			//����ʧ�ܣ���ʾ������Ϣ
		}
	}catch(Exception e ){
		e.printStackTrace();
		out.println("<br>" + "��ѯ��������ʧ��: " + e.getMessage() + "<br>");
	}
%>
</table>
</html>




