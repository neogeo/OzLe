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



        <script type="text/javascript">
            //define colors
            var colors = { yellow:"#FFFF33", lightGreen:"#99FF33", green:"33FF66", 
                lightBlue:"#33FFFF", blue:"#3366FF", darkBlue:"#6633FF", brown:"#C9B385"};

            var counter = 1;
			
			function navButtonHandler(element){
				$('#'+element).click(function(){
					//color brown
					$(this).animate({ backgroundColor: colors.brown	}, 300, function(){
						//aniimation complete
						//change to white
						$(this).animate({ backgroundColor: 'white'}, 300)
					});
			   	});
				
				$('#'+element).hover(function(){
				   		$(this).css("cursor","pointer");
					
				   		//does not exist add an extended bottom so that the mouse out event does not fire
				   		if ($("#extender").length == 0) {
							var newMenuItem = document.createElement("div");
							newMenuItem.id = "extender";
							$(this).append(newMenuItem);
							$("#extender").css("height","15px").css("width","100%").css("margin-top","115px");
						}
						//bump up					
				   		$(this).animate({ 
	        				top: "-=15px",
	      				}, 200, 'easeInBack' );
			   		},function(){
				   		$(this).css("cursor","default");
				   		$("#extender").remove();
						
						$(this).animate({ 
		        			top: "+=15px",
		      			}, 200, 'easeOutQuad' );
			   });
			}
			
			function setUpOverlay(){
				//initialize overlay
				$(".thumbnail img[rel]").overlay({
					effect: 'apple',
					closeOnClick: true,
					speed: 'fast',
					onClose: function(){
						$("#overlayImage").remove();
					}
				});
				
				$(".thumbnail img[rel]").click(function(){
					//set overlay to load image
					var numReg = /\d+/;
					var imageNum = numReg.exec($(this).attr("id"));
					var pictureToLoad = "";
					
					imageNum = imageNum - 0;
					switch(imageNum){
						case 1:  pictureToLoad = "1";  break;
						case 2:  pictureToLoad = "2";  break;
						case 3:  pictureToLoad = "3";  break;
						case 4:  pictureToLoad = "4";  break;
						case 5:  pictureToLoad = "5";  break;
						case 6:  pictureToLoad = "6";  break;
						case 7:  pictureToLoad = "7";  break;
						case 8:  pictureToLoad = "8";  break;
						case 9:  pictureToLoad = "9";  break;
						case 10: pictureToLoad = "10"; break;
						case 11: pictureToLoad = "11"; break;
						case 12: pictureToLoad = "12"; break;
						default: alert("image not found");
					}
					var oImg = document.createElement("img");
					oImg.id = "overlayImage";
					oImg.setAttribute('src', 'images/gallery/full'+pictureToLoad+'.jpeg');
					
					$("#pictureOverlay").append(oImg);
				});
			}
			
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
				
				//create scrollable
                $(".scrollable").scrollable({
                     circular: true
                }).navigator({
                    navi: '.navBar',
                    naviItem: '.navBox'
                });

				//make pics overlay
				setUpOverlay();
				
                //set form submission
                $(":button").click(function(){
                     var newdiv = document.createElement('div');
                     newdiv.innerHTML = "Guset " + (counter + 1) + "<input type='text' name='guests[]'><br><br>";
                     $("#dynamicGuests").append(newdiv);
                      //$("#dynamicGuests").html("");

                       counter++;
                });
            });

        </script>
    </head>
    <body>



         <div id="frame">
            <div class="topBar"></div>
            <div id="main" class="header">
			<div class="banner"></div>


       

<!-- root element for scrollable -->
<div class="navi"></div>
			
		
            <div class="scrollable">
               <!-- root element for the items -->
               <div class="items">
                  <div id="welcomeContent" class="content">
                     <div class="contentHeader"> <div class="bigText">Welcome</div> </div>
					 
                  </div>
				  
                  <div id="placeContent" class="content">
                    <div class="bigText">The Place</div>
                  </div>
				  
                  <div id="rsvpContent" class="content">
                     <div class="contentHeader"> <div class="bigText">RSVP</div> </div>
                      <br><br><br><br><br>
                      <span>"Be sure to let us know you're coming"</span>
                      <br>
                      <div id="myForm">
                            <form name="input" action="" method="POST">
                                <div id="dynamicGuests">
                                    Guest 1 <input type="text" name="guests[]" /><br>
                                </div>
                                <input type="button" value="Add Guest" />
                                <input type="submit" value="Submit"/>
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
