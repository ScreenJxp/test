<%@page contentType="text/html;charset=gb2312" language="java"%>
<%@page session="true" import="com.gnete.paymentgateway.PayUtils"
	import="java.util.Date" import="java.util.StringTokenizer"%>

<%
	//����ҳ�����
	String strPKey, SignMsg,SourceMsg;
	String OrderNo,PayNo,PayAmount,CurrCode,SystemSSN,RespCode,SettDate,Reserved01,Reserved02;
	boolean ret;
	
	strPKey	= "12hi60ohgmp16nbev0gr8au69bodzguz";

	//�����������߷�������
	//----------------------------------------------------------------------------------------
	OrderNo 	= request.getParameter("OrderNo");		//�̻�������
	PayNo 	    = request.getParameter("PayNo");		//֧������
	PayAmount 	= request.getParameter("PayAmount");		//֧������ʽ��Ԫ.�Ƿ�
	CurrCode 	= request.getParameter("CurrCode");		//���Ҵ���
	SystemSSN 	= request.getParameter("SystemSSN");		//ϵͳ�ο���
	RespCode 	= request.getParameter("RespCode");		//��Ӧ��
	SettDate 	= request.getParameter("SettDate");		//�������ڣ���ʽ����������
	Reserved01 	= request.getParameter("Reserved01");		//������1
	Reserved02 	= request.getParameter("Reserved02");		//������2
	SignMsg     = request.getParameter("SignMsg");                    //ʱ���ǩ��

	SourceMsg = OrderNo + PayNo + PayAmount + CurrCode + SystemSSN + RespCode + SettDate + Reserved01 + Reserved02;

	out.println(SourceMsg);
	//��������
	PayUtils payUtils = new PayUtils();
	
	ret = payUtils.checkSign(SourceMsg,SignMsg,strPKey);
	
	if (ret == false) {
		//����ʧ��
		out.println("��ǩʧ��");
	} else {
		//���������ص�֧��������µ��̻��������ݿ�
		//----------------------------------------------------------------------------------------
		//�˲��ֲ������̻����п��������齫�������ص�ԭ�ġ�SignMsgͬʱд�����ݿ�

		//���֧��������˿�
		
		//��Ӧ��Ϊ"00"��ʾ���׳ɹ����������Ӧ����ձ�����ġ������̻�֧���ӿ�V34.doc��
		if (RespCode.equals("00")){
			//֧���ɹ�
			out.println("֧���ɹ�����Ӧ��: " + RespCode + "<br>");
		}
		else{
			//֧�����ɹ�
			out.println("֧��ʧ�ܣ���Ӧ��: " + RespCode + "<br>");
		}

	}
%>
