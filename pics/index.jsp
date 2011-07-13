<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" 
    "http://www.w3.org/TR/html4/strict.dtd">
<%
    		session = request.getSession(true);
			Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
			if (loggedIn == null){ loggedIn = false;}
			//is user logged in
			if( loggedIn == false)
			{
			%>
				<jsp:forward page= "login.jsp"/>
			<%
			} 
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

	
		
    
    $(function(){
		$('#ozle').click(function(){
			window.location.href = "viewpics.jsp?folderName=ozle&dn=LeAndOz";
		});
		$('#mandy').click(function(){
			window.location.href = "viewpics.jsp?folderName=mandy&dn=Mandy";
		});
		$('#catlin').click(function(){
			window.location.href = "viewpics.jsp?folderName=catlin&dn=Catlin";
		});
		$('#ross').click(function(){
			window.location.href = "viewpics.jsp?folderName=ross&dn=Ross";
		});
		$('#jared').click(function(){
			window.location.href = "viewpics.jsp?folderName=jared&dn=Jared";
		});
		$('#gregashley').click(function(){
			window.location.href = "viewpics.jsp?folderName=gregashley&dn=GregAndAshley";
		});
		$('#matthew').click(function(){
			window.location.href = "viewpics.jsp?folderName=matthew&dn=Matthew";
		});
		$('#ozparents').click(function(){
			window.location.href = "viewpics.jsp?folderName=ozparents&dn=Oz's_Parent";
		});
		$('#zack').click(function(){
			window.location.href = "viewpics.jsp?folderName=zack&dn=Zack";
		});
		$('#jason').click(function(){
			window.location.href = "viewpics.jsp?folderName=jason&dn=Jason";
		});
		$('#weeks').click(function(){
			window.location.href = "viewpics.jsp?folderName=weeks&dn=Week";
		});
		$('#travis').click(function(){
			window.location.href = "viewpics.jsp?folderName=travis&dn=Travis";
		});
		$('#keithvalerie').click(function(){
			window.location.href = "viewpics.jsp?folderName=keithvalerie&dn=KeithAndValerie";
		});
		$('#jeffemma').click(function(){
			window.location.href = "viewpics.jsp?folderName=jeffemma&dn=JeffAndEmma";
		});
		$('#shonhaylle').click(function(){
			window.location.href = "viewpics.jsp?folderName=shonhaylle&dn=ShonAndHaylle";
		});
		$('#leparents').click(function(){
			window.location.href = "viewpics.jsp?folderName=leparents&dn=Le'sParents";
		});
		$('#fanny').click(function(){
			window.location.href = "viewpics.jsp?folderName=fanny&dn=Fanny";
		});
		$('#duongfamily').click(function(){
			window.location.href = "viewpics.jsp?folderName=duongfamily&dn=DuongFamily";
		});
				
    });
    
	</script> 
    </head> 
    <body> 
     	<div id="framePics">
			<div class="topBar"></div>
			<div class="banner"><div class='chocoBox' style='position:absolute;margin:15px 0 0 10px'>Share Your Pics</div></div>
	    	
				<div class="folderContainer">
					<div id='catlin' class='folder'><div>Catlin</div></div>
					<div id='duongfamily' class='folder'><div>Duong Family</div></div>
					<div id='fanny' class='folder'><div>Fanny</div></div>
					<div id='gregashley' class='folder'><div>Greg & Ashley</div></div>
					<div id='jared' class='folder'><div>Jared</div></div>
					<div id='jason' class='folder'><div>Jason</div></div>
					<div id='jeffemma' class='folder'><div>Jeff and Emma</div></div>
					<div id='keithvalerie' class='folder'><div>Keith and Valerie</div></div>
					<div id='leparents' class='folder'><div>Le's Parents</div></div>
			    	<div id='mandy' class='folder'><div>Mandy</div></div>
					<div id='matthew' class='folder'><div>Matthew</div></div>
			    	<div id='ozle' class='folder'><div>LeAndOz</div></div>
			    	<div id='ozparents' class='folder'><div>Oz's Parents</div></div>
					<div id='ross' class='folder'><div>Ross</div></div>
			     	<div id='shonhaylle' class='folder'><div>Shon and Haylle</div></div>
					<div id='travis' class='folder'><div>Travis</div></div>
					<div id='weeks' class='folder'><div>Weeks</div></div>
					<div id='zack' class='folder'><div>Zack</div></div>
				</div>
			<div class="bottomBar"></div>
		</div>
    </body> 
    </html> 