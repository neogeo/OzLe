<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<%
	session = request.getSession(true);
	//if we are at this page the user is not logged in, so...
	//set loggedIn status
	session.setAttribute("loggedIn", false);

%>

<html>

	<head>
			<meta http-equiv="Content-type" name="desktop" content="text/html;charset=UTF-8">
    	<title></title>
		<!-- jquery must load first -->
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../swfcore/jquery.swfupload.js"></script>	
		<script type="text/javascript" src="../swfcore/swfupload.js"></script>
		
		<link rel="stylesheet" type="text/css" href="../css/pics.css" />
		<link rel="stylesheet" type="text/css" href="../css/layoutSmall.css" />
		
	
	
	<style type="text/css">
		html,body { height:100%; width:100%; }

		.floatLeft{float:left}
		.preload{display:none;}
		
	</style>
					
    <script type="text/javascript">
    
	</script>
    </head>
    <body id='body'>
    	<div id="framePics">
    		<form class='loginForm' name='frm' method='post' action='login_check.jsp'>
    		<div class='label'>Password:</div>
			<input class='loginIinputBox' type='password' name='password' value=''>
			<input class='loginSubmit' type='submit' name='submit' value='Login'>
			</form>
    	</div>
	</body>
</html>