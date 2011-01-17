<%-- 
    Document   : index
    Created on : Jul 20, 2010, 9:42:53 PM
    Author     : Nomad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/layout.css" />
        <link rel="stylesheet" type="text/css" href="css/jtools.css" />
		<link rel="stylesheet" type="text/css" href="css/overlay.css" />
        
        <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="http://cdn.jquerytools.org/1.2.4/full/jquery.tools.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.5.custom.min.js"></script>
		
		<script type="text/javascript" src="scripts/setUp.js"></script>



        <script type="text/javascript">
           
            $(document).ready(function(){
				if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) { //test for MSIE x.x;
					var ieversion = new Number(RegExp.$1) // capture x.x portion and store as a number
					if (ieversion < 8) {
						$("#frame").html("This web site is not compatible with your browser (Internet Explorer " + ieversion + ").<br> Try using Firefox or Chrome instead<br>" +
						"<a href='http://www.getfirefox.net'><img border='0' alt='Firefox' title='Firefox' src='http://sfx-images.mozilla.org/affiliates/Buttons/110x32/get.gif' /></a>" +
						"<a href='http://www.google.com/chrome/index.html?hl=en&brand=CHNG&utm_source=en-hpp&utm_medium=hpp&utm_campaign=en'> <img border=0 alt='Chrome' title='Chrome' src='images/chrome.jpg'></a>");
					}
				}
				
				
				//register buttons
			   	navButtonHandler("welcome");
			   	navButtonHandler("where");
			   	navButtonHandler("rsvp");
			   	navButtonHandler("pics");
				
				
				createScrollable();

				//make pics overlay
				setUpOverlay();
				
              	setUpRSVPForm();
            });

        </script>
    </head>
    <body>
			

	
         <div id="frame">
            <div class="topBar"></div>
			<div class="banner"></div>
            <div id="main" class="header">
			


       

<!-- root element for scrollable -->
<div class="navi"></div>
			
		
            <div class="scrollable">
               <!-- root element for the items -->
               <div class="items">
                  <div id="welcomeContent" class="content">
                     <div class="contentHeader"> <div class="bigText">Welcome</div> </div>
                  </div>
				  
                  <div id="placeContent" class="content">
                    <div class="contentHeader"><div class="bigText">The Place</div> </div>
                  </div>
				  
                  <div id="rsvpContent" class="content">
                     <div class="contentHeader"> <div class="bigText">RSVP</div> </div>
                      <br><br><br><br><br>
                      <div class="text">Be sure to let us know you're coming</div>
                      <br>
                      <div id="myForm">
                            <form id="RSVP_form" name="input" action="" method="POST">
                                <div id="dynamicGuests"> 
									
    									Guest<hr class="line" > 
										<br/>
	                                    	<div class="formLabel">First Name</div><input type="text" name="guests[]" /><br/>
											<div class="formLabel">Last Name</div><input type="text" name="guests[]" />
										<br/>
										<div class="formLabel">Number of Guests</div>
										<select id="numOfGuests">
										  <option>1</option>
										  <option>2</option>
										  <option>3</option>
										  <option>4</option>
										  <option>5</option>
										</select>
										<br/>
										<br/>
										<input class="checkbox" type="checkbox" name="reception" value="reception" /> Attending Reception <br/>
										<input class="checkbox" type="checkbox" name="wedding" value="wedding" />  Attending Wedding <br/>
									
                                </div>
								<br/>
                                <!--input type="button" value="Add Guest" /-->
                                <input id="submitRSVP" type="submit" value="Submit"/>
                            </form> 
                      </div>
                  </div>
				  
				  <div id="picsContent" class="content">
                    <div class="contentHeader"> <div class="bigText">Pictures</div> </div>
					<div id="pictureFrame">
						<div class="thumbnail"><img id="img1"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay" /></div>
						<div class="thumbnail"><img id="img2"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img3"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img4"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img5"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img6"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						
						<div class="thumbnail"><img id="img7"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img8"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img9"  src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img10" src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img11" src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
						<div class="thumbnail"><img id="img12" src="images/gallery/thumbDefault.png"  rel="#pictureOverlay"/></div>
					</div>
					<div id="credits">Our engagment pictures were taken by our good friend <a href="http://sharpshooter.smugmug.com/" target="_blank">Jared Gab</a></div>
                  </div>
               </div><!-- items -->
            </div><!-- scrollable -->

      </div><!-- main -->
			
            <div class="navBar">
                <div id="welcome" class="navBox">Welcome</div>
                <div id="where" class="navBox">The Place</div>
                <div id="rsvp" class="navBox">RSVP</div>
				<div id="pics" class="navBox">Pictures</div>
            </div>
			
            <div class="bottomBar"></div>
        </div>
        
	
	<div class="apple_overlay" id="pictureOverlay"> 
		Come on feet!
	</div> 
    </body>
</html>
