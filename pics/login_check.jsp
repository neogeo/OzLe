<%
	session = request.getSession(true);
	
	String password = request.getParameter("password");
	if(password == null) { password = new String(""); }
	
	if( (password != null) && (password.equals("stjamesclub")) ){
		//success
		session.setAttribute("loggedIn",true);
		response.sendRedirect("index.jsp");

	}else{
		//fail
		session.setAttribute("loggedIn",false);
		response.sendRedirect("login.jsp");

	}
%>
