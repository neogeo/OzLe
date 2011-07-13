 //define colors
var colors = { yellow:"#FFFF33", lightGreen:"#99FF33", green:"33FF66", 
    lightBlue:"#33FFFF", blue:"#3366FF", darkBlue:"#6633FF", brown:"#C9B385"};

var counter = 0;
var fNameEntered = false;
var lNameEntered = false;
var weddingRecptionEntered = false;
//ser up nav buttons 
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
				//for layout.css
				//$("#extender").css("height","15px").css("width","100%").css("margin-top","115px").css("border","1px solid");
				//for layoutSmall.css
				$("#extender").css("height","30px").css("width","100%").css("margin-top","20px");
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

//set up the overlay for the picture gallery
function setUpOverlay(){
	//initialize overlay
	$(".thumbnail img[rel]").overlay({
		mask: '#000',
		effect: 'apple',
		speed: 800//,
		//closeOnClick: true,
		//speed: 'fast',
		/*onClose: function(){
			$("#overlayImage").remove();
		}*/
	});
	
	$(".thumbnail img[rel]").click(function(){
		//set overlay to load image
		/*var numReg = /\d+/;
		var imageNum = numReg.exec($(this).attr("id"));
		var pictureToLoad = "";
		
		imageNum = imageNum - 0;
		switch(imageNum){
			case 1:  pictureToLoad = "01.jpg";  break;
			case 2:  pictureToLoad = "02.jpg";  break;
			case 3:  pictureToLoad = "03.jpg";  break;
			case 4:  pictureToLoad = "04.jpg";  break;
			case 5:  pictureToLoad = "05.jpg";  break;
			case 6:  pictureToLoad = "06.jpg";  break;
			case 7:  pictureToLoad = "07";  break;
			case 8:  pictureToLoad = "08";  break;
			case 9:  pictureToLoad = "09";  break;
			case 10: pictureToLoad = "10";  break;
			case 11: pictureToLoad = "11";  break;
			case 12: pictureToLoad = "12.jpg";  break;
			default: alert("image not found");
		}
		var oImg = document.createElement("img");
		oImg.id = "overlayImage";
		oImg.setAttribute('src', 'images/gallery/'+pictureToLoad);
		
		$("#pictureOverlay").append(oImg);*/
	});
}

function preloadPics(){
	var hide = document.createElement('div');
	hide.innerHTML = ""
	+"<img class='preload' src='images/gallery/01.jpg'\/>"
	+"<img class='preload' src='images/gallery/02.jpg'\/>"
	+"<img class='preload' src='images/gallery/03.jpg'\/>"
	+"<img class='preload' src='images/gallery/04.jpg'\/>"
	+"<img class='preload' src='images/gallery/05.jpg'\/>"
	+"<img class='preload' src='images/gallery/06.jpg'\/>"
	+"<img class='preload' src='images/gallery/12.jpg'\/>";
	
	$("body").append(hide);
}

function receptionMap(){
	var loadMap = true;
	$("#reception").click(function(){
		if (loadMap) {
			//load map after sliding animation has finished
			setTimeout(function(){
			
				var map = document.createElement('div');
				//map.innerHTML = '<iframe width="425" height="325" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=1150+North+Broadway+wichita+ks&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=39.099308,84.375&amp;ie=UTF8&amp;hq=&amp;hnear=1150+N+Broadway+St,+Wichita,+Sedgwick,+Kansas+67214&amp;ll=37.713294,-97.334232&amp;spn=0.022067,0.025835&amp;z=14&amp;output=embed"></iframe><br /><small><a href="http://www.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=1150+North+Broadway+wichita+ks&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=39.099308,84.375&amp;ie=UTF8&amp;hq=&amp;hnear=1150+N+Broadway+St,+Wichita,+Sedgwick,+Kansas+67214&amp;ll=37.713294,-97.334232&amp;spn=0.022067,0.025835&amp;z=14" style="color:#0000FF;text-align:left">View Larger Map</a></small>'
				map.innerHTML ='<iframe width="425" height="325" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=5015+E.+29th+St.+N,+Wichita,+KS&amp;aq=&amp;ie=UTF8&amp;hq=&amp;hnear=5015+E+29th+St+N,+Wichita,+Kansas+67220&amp;ll=37.743164,-97.276211&amp;spn=0.023755,0.036478&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=5015+E.+29th+St.+N,+Wichita,+KS&amp;aq=&amp;ie=UTF8&amp;hq=&amp;hnear=5015+E+29th+St+N,+Wichita,+Kansas+67220&amp;ll=37.743164,-97.276211&amp;spn=0.023755,0.036478&amp;z=14&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>';
				$("#receptionMap").append(map);
				loadMap = false;
			}, 500);
		}
	});
	$("#rsvpLink").click(function(){
		if (loadMap) {
			//load map after sliding animation has finished
			setTimeout(function(){
			
				var map = document.createElement('div');
				//map.innerHTML = '<iframe width="425" height="325" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://www.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=1150+North+Broadway+wichita+ks&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=39.099308,84.375&amp;ie=UTF8&amp;hq=&amp;hnear=1150+N+Broadway+St,+Wichita,+Sedgwick,+Kansas+67214&amp;ll=37.713294,-97.334232&amp;spn=0.022067,0.025835&amp;z=14&amp;output=embed"></iframe><br /><small><a href="http://www.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=1150+North+Broadway+wichita+ks&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=39.099308,84.375&amp;ie=UTF8&amp;hq=&amp;hnear=1150+N+Broadway+St,+Wichita,+Sedgwick,+Kansas+67214&amp;ll=37.713294,-97.334232&amp;spn=0.022067,0.025835&amp;z=14" style="color:#0000FF;text-align:left">View Larger Map</a></small>'
				map.innerHTML ='<iframe width="425" height="325" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=5015+E.+29th+St.+N,+Wichita,+KS&amp;aq=&amp;ie=UTF8&amp;hq=&amp;hnear=5015+E+29th+St+N,+Wichita,+Kansas+67220&amp;ll=37.743164,-97.276211&amp;spn=0.023755,0.036478&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe><br /><small><a href="http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=5015+E.+29th+St.+N,+Wichita,+KS&amp;aq=&amp;ie=UTF8&amp;hq=&amp;hnear=5015+E+29th+St+N,+Wichita,+Kansas+67220&amp;ll=37.743164,-97.276211&amp;spn=0.023755,0.036478&amp;z=14&amp;iwloc=A" style="color:#0000FF;text-align:left">View Larger Map</a></small>';
				$("#receptionMap").append(map);
				loadMap = false;
			}, 500);
		}
	});
	
}
function createScrollable(){
	//create scrollable
	$(".scrollable").scrollable({
	     circular: false
	}).navigator({
	    navi: '.navBar',
	    naviItem: '.navBox'
	});
}

function rsvpLink(){
	var api = $(".scrollable").data("scrollable");
	api.move(3);
}

function setUpRSVPForm(){
	//set astricks as float left
	$("#fName").css("float","right");
	$("#lName").css("float","right");
	
	
	//clear form
	$("#rsvpFirstName").val("");
	$("#rsvpLastName").val("");
	$("input:checkbox").removeAttr('checked');
	
	//on input field change
	$("#rsvpFirstName").keyup(function(){
		//get input
		var txt = $(this).val();
		//check for correct input 
		if (txt == null || txt.length < 1 || txt.split(" ").join("").length < 1) {
			//show asterick
			$("#fName").css("display","block");
			//make sure field is still highlighted
			if(!$(this).hasClass("requiredField")){
				$(this).addClass("requiredField");
			}
			
			fNameEntered = false;
		}else {//save
			//remove required classes
			$(this).removeClass("requiredField");
			$("#fName").fadeOut("fast");
			
			fNameEntered = true;
		}
		
		shouldUndiherSubmitButton();
	});
	
	$("#rsvpLastName").keyup(function(){
		//get input
		var txt = $(this).val();
		//check for correct input 
		if (txt == null || txt.length < 1 || txt.split(" ").join("").length < 1) {
			//show asterick
			$("#lName").css("display","block");
			//make sure field is still highlighted
			if(!$(this).hasClass("requiredField")){
				$(this).addClass("requiredField");
			}
			
			lNameEntered = false;
		}else {//save
			//remove required classes
			$(this).removeClass("requiredField");
			$("#lName").fadeOut("fast");
			
			lNameEntered = true;
		}
		
		shouldUndiherSubmitButton();
	});
	
	$(".checkbox").change(function(){
		var reception = $("#rsvpReception:checked").val();
		var wedding = $("#rsvpWedding:checked").val();
		
		if ((reception == undefined) && (wedding == undefined)) {
			//show required box
			if (!$("#checkBoxes").hasClass("requiredCheckBoxes")){
				$("#checkBoxes").removeClass("notRequiredCheckBoxes").addClass("requiredCheckBoxes");
			}
			
			weddingRecptionEntered = false;
		}else if ((reception != undefined) || (wedding != undefined)) {
			//remove required box
			if ($("#checkBoxes").hasClass("requiredCheckBoxes")) {
				$("#checkBoxes").removeClass("requiredCheckBoxes").addClass("notRequiredCheckBoxes");
				
			}
			weddingRecptionEntered = true;
		}
		
		
		shouldUndiherSubmitButton();
	});
	//set form submission
	/*$(":button").click(function(){
	 var newdiv = document.createElement('div');
	 newdiv.innerHTML = "Guset " + (counter + 1) + "<input type='text' name='guests[]'><br><br>";
	 $("#dynamicGuests").append(newdiv);
	 counter++;
	 });*/
	$("#submitRSVP").click(function(){
		if(!$(this).hasClass("dither")){
			var firstName = $("#rsvpFirstName").val();
			var lastName = $("#rsvpLastName").val();
			var numOfGuests = $("#rsvpNumOfGuests").val();
			var reception = $("#rsvpReception:checked").val();
			var wedding = $("#rsvpWedding:checked").val();
			
			//check input
			firstName = (firstName == "") ? "blank" : firstName;
			lastName = (lastName == "") ? "blank" : lastName;
			reception = (reception == undefined) ? "blank" : reception;
			wedding = (wedding == undefined) ? "blank" : wedding;
			
			//call sendMail
			sendMail(firstName, lastName, numOfGuests, reception, wedding);
		}else{
			//highlight required fields
			if(!fNameEntered){
				$("#rsvpFirstName").effect("highlight", {queue:false, duration:1000 } );
			}
			if(!lNameEntered){
				$("#rsvpLastName").effect("highlight", {queue:false, duration:1000 } );
			}
			if(!weddingRecptionEntered){
				$("#checkBoxes").effect("highlight", {queue:false, duration:1000 } );
			}
		}
		
	});
	
}

function shouldUndiherSubmitButton(){
	var $submit = $("#submitRSVP");
	if(fNameEntered && lNameEntered && weddingRecptionEntered){
		if($submit.hasClass("dither")){
			$submit.removeClass("dither");
		}
	}else{
		if (!$submit.hasClass("dither")) {
			$submit.addClass("dither");
		}
	}
}

function sendMail(firstName, lastName, numOfGuests, reception, wedding){
	$("#RSVP_form").fadeOut("fast", function(){
		//show loading gif
		setLoading("myForm");
	});
	
	/*setTimeout(function(){
		var info = document.createElement("div");
		info.id = "result";
		info.className = "success";
		info.innerHTML = "Whoops, something unexpected happened. <br\/> Try again in a couple of minutes.";
		$("#myForm").append(info);
		
		$("#loader").fadeOut("fast",function(){
			$(".success").fadeIn("fast");
		});
	},5000);
	*/
	
	//make remote call
	//if(counter Math.mod(counter, 2) == 0)
	sendMailRemotelyOne(function(jsonStatusMsg, jsonString){
				if (jsonStatusMsg.status.status == "success") {
					//show success
					var info = document.createElement("div");
					info.id = "result";
					info.className = "success";
					info.innerHTML = "Thanks, your RSVP has been submitted";
					$("#myForm").append(info);
					
					$("#loader").fadeOut("fast",function(){
						$(".success").fadeIn("fast");
					});
				}else{//fail
					//TODO: sendmailremotely2
					sendMail2(firstName, lastName, numOfGuests, reception, wedding);
				}
			}, 
			firstName, lastName, numOfGuests, reception, wedding
	);
		
	//increase counter
	counter++;
}

function sendMail2(firstName, lastName, numOfGuests, reception, wedding){
	//make remote call
	sendMailRemotelyTwo(function(jsonStatusMsg, jsonString){
				if (jsonStatusMsg.status.status == "success") {
					//show success
					var info = document.createElement("div");
					info.id = "result";
					info.className = "success";
					info.innerHTML = "Thanks, your RSVP has been submitted";
					$("#myForm").append(info);
					
					$("#loader").fadeOut("fast",function(){
						$(".success").fadeIn("fast");
					});
				}else{//fail
					//show error
					var info = document.createElement("div");
					info.id = "result";
					info.className = "success";
					info.innerHTML = "Whoops, something unexpected happened. <br\/> Try again in a couple of minutes.";
					$("#myForm").append(info);
					
					$("#loader").fadeOut("fast",function(){
						$(".success").fadeIn("fast");
					});
				}
			}, 
			firstName, lastName, numOfGuests, reception, wedding
	);
}

function sendMailRemotelyOne(remoteCallback, firstName, lastName, numOfGuests, reception, wedding){
	//try to load remotely
	jQuery.ajax({ 	beforeSend: function(R) { R.setRequestHeader ( "Cache-Control", "no-cache, must-revalidate"); },
			            url: "scripts/sendMail.jsp"+"?id="+new Date().getTime(), //prevent IE from caching response
			            data: {'firstName':firstName, 'lastName':lastName, 'numOfGuests':numOfGuests, 'reception':reception, 'wedding':wedding },
			            type: "POST", //use POST so the jsonString parameter may be very large
			            dataType: "json",
			            timeout: 60000,
			            error: function(e1, e2){
							var statusMsg = "{'status' : {'status':'failure', 'description':'"+ e1.statusText +"'} }";
							//replace ticks with quotes for strict JSON parsing
							statusMsg = statusMsg.replace(new RegExp(/'/g),"\"");
							//output JSON object 
							remoteCallback( JSON.parse(statusMsg) );
			            },
			            success: function(returned_data_json){
						  	//de-seraialize json
						  	var statusMsg = JSON.stringify(returned_data_json);
							//replace ticks with quotes for strict JSON parsing
							statusMsg = statusMsg.replace(new RegExp(/'/g),"\"");
							//output JSON object 
							remoteCallback( JSON.parse(statusMsg) );
			            }
		});
}

function sendMailRemotelyTwo(remoteCallback, firstName, lastName, numOfGuests, reception, wedding){
	//try to load remotely
	jQuery.ajax({ 	beforeSend: function(R) { R.setRequestHeader ( "Cache-Control", "no-cache, must-revalidate"); },
			            url: "scripts/sendMail2.jsp"+"?id="+new Date().getTime(), //prevent IE from caching response
			            data: {'firstName':firstName, 'lastName':lastName, 'numOfGuests':numOfGuests, 'reception':reception, 'wedding':wedding },
			            type: "POST", //use POST so the jsonString parameter may be very large
			            dataType: "json",
			            timeout: 60000,
			            error: function(e1, e2){
							var statusMsg = "{'status' : {'status':'failure', 'description':'"+ e1.statusText +"'} }";
							//replace ticks with quotes for strict JSON parsing
							statusMsg = statusMsg.replace(new RegExp(/'/g),"\"");
							//output JSON object 
							remoteCallback( JSON.parse(statusMsg) );
			            },
			            success: function(returned_data_json){
						  	//de-seraialize json
						  	var statusMsg = JSON.stringify(returned_data_json);
							//replace ticks with quotes for strict JSON parsing
							statusMsg = statusMsg.replace(new RegExp(/'/g),"\"");
							//output JSON object 
							remoteCallback( JSON.parse(statusMsg) );
			            }
		});
}

function setLoading(elementId) {
	document.getElementById(elementId).innerHTML = "<div id='loader' class='loading'><br\/><img src='images/loading.gif' alt='Loading...' \/><\/div>";
};
