<script language="javascript">
	function DoAction() {
		document.SendOrderForm.submit();
	}
</script>

<%@page contentType="text/html;charset=gb2312" language="java"%>
<!-- import="java.net.URLEncoder" --> 
<%@page session="true"
	import="com.gnete.paymentgateway.PayUtils,java.text.SimpleDateFormat,java.util.Date"
	%>
 
<html>

<table border=1 bordercolor="ccccff" bgcolor="ccddee" align="center">
	<%
		//�������
		String MerId, OrderNo, OrderAmount, CurrCode, BankCode,OrderType, nOrderType, CallBackUrl, ResultMode, Reserved01, Reserved02, SourceText, PKey, SignedMsg, EntryMode;
		boolean ret;

		PKey = "12hi60ohgmp16nbev0gr8au69bodzguz";
		SignedMsg = "";

		MerId = "198"; //�̻�ID����		
		out.println("�̻�ID: " + MerId + "<br>");
		Date myDate = new Date();
		OrderNo = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); //�̻�������
		
		out.println("�̻������Ų�����20λ: " + OrderNo + "<br>");
		OrderAmount = "1.01"; //��������ʽ��Ԫ.�Ƿ�
		out.println("�������: " + OrderAmount.toString() + "<br>");
		CurrCode = "CNY"; //���Ҵ��룬ֵΪ��CNY
		out.println("���Ҵ���: " + CurrCode + "<br>");
		CallBackUrl = "http://localhost:8080/demo1/OvRcv.jsp"; //֧���������URL
		
		EntryMode = request.getParameter("EntryMode") == null ? "": request.getParameter("EntryMode"); //֧����ʽ

		BankCode = request.getParameter("nBankCode") == null ? "" : request.getParameter("nBankCode");

		out.println("֧���������URL: " + CallBackUrl + "<br>");
		ResultMode = "0"; //֧��������ط�ʽ(0-�ɹ���ʧ��֧����������أ�1-�����سɹ�֧�����)
		Reserved01 = "just"; //������1
		Reserved02 = "atest"; //������2

		OrderType = "B2C";

		//��ϳɶ���ԭʼ����
		SourceText = MerId + OrderNo + OrderAmount + CurrCode + OrderType + CallBackUrl+ ResultMode + BankCode + EntryMode + Reserved01+ Reserved02;
		out.println("<br>SourceText=" +SourceText);
		
		PayUtils payUtils = new PayUtils();

		SignedMsg = payUtils.md5(SourceText + payUtils.md5(PKey));

		out.println("<br>" + "���ܺ����Ϣ: " + SignedMsg + "<br>");
		
		ret = payUtils.checkSign(SourceText,SignedMsg,PKey);
		if(ret){
			out.println("<br>"+"��֤ǩ���ɹ���");
		}else{
			out.println("<br>"+"��֤ǩ��ʧ��! ");
		}
		//out.println("<br>"+"��֤ǩ��: "+"883ef8a28d9602f8705cafb4d01ca754".equals(SignedMsg)  +"<br>");
	%>
	<form method="post" name="SendOrderForm" action="http://test.gnete.com:8888/Bin/Scripts/OpenVendor/Gnete/V36/GetOvOrder.asp">
		<input type='hidden' name='MerId' value='<%=MerId%>'> 
		<input type='hidden' name='OrderNo' value='<%=OrderNo%>'> 
		<input type='hidden' name='OrderAmount' value='<%=OrderAmount%>'> 
		<input type='hidden' name='CurrCode' value='<%=CurrCode%>'> 
		<input type='hidden' name='CallBackUrl' value='<%=CallBackUrl%>'> 
		<input type='hidden' name='ResultMode' value='<%=ResultMode%>'>
		<input type='hidden' name='OrderType' value='<%=OrderType%>'>
		<input type='hidden' name='BankCode' value='<%=BankCode%>'> 
		<input type='hidden' name='EntryMode' value='<%=EntryMode%>'> 0
		<input type='hidden' name='Reserved01' value='<%=Reserved01%>'> 
		<input type='hidden' name='Reserved02' value='<%=Reserved02%>'> 
		<input type='hidden' name='SignMsg' value='<%=SignedMsg%>'>

	<div align="center"><input type="submit" name="Submit" value="�ύ">
	</div>

	</form>
	<tr>
	</tr>
</table>

</html>




