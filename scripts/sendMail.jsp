<%@ page import="java.util.Properties,javax.mail.Message,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeMessage,javax.mail.PasswordAuthentication,javax.mail.MessagingException" %>
	
 <%
    	
    	String json = "";
    	//set properties
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "smtp.gmail.com");
		props.setProperty("mail.user", "neogeo.ku@gmail.com");
		props.setProperty("mail.password", "******.");
		props.setProperty("mail.smtp.auth", "true");
    	props.setProperty("mail.smtp.port", "465");
    	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
    	
		try{
			//mail session
			javax.mail.Session mailSession = javax.mail.Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication(){ 
					return new PasswordAuthentication("neogeo.ku@gmail.com","*******.");	
				}
			});		
			
			Transport transport = mailSession.getTransport();
	
			//set message
			MimeMessage message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress("neogeo.ku@gmail.com"));
			message.setRecipients(Message.RecipientType.TO, 
                    InternetAddress.parse("neogeo.ku@gmail.com"));
			message.setSubject("Testing javamail html");
			message.setContent
				("This is a test <b>HOWTO<b>", "text/html; charset=ISO-8859-1");
	
			//try to send
			transport.connect();
			transport.sendMessage(message,
			    message.getRecipients(Message.RecipientType.TO));
			transport.close();
			
			json = "{ 'status': {'status':'success','description':'success'} }";
		}catch(MessagingException e){
			json = "{ 'status': {'status':'failure','description':'failure'} }";
		}finally{
			out.println(json);
		}
   
%>