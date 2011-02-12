 //define colors
var colors = { yellow:"#FFFF33", lightGreen:"#99FF33", green:"33FF66", 
    lightBlue:"#33FFFF", blue:"#3366FF", darkBlue:"#6633FF", brown:"#C9B385"};

var counter = 0;

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

//set up the overlay for the picture gallery
function setUpOverlay(){
	//initialize overlay
	$(".thumbnail img[rel]").overlay({
		mask: '#000',
		effect: 'apple'//,
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

function createScrollable(){
	//create scrollable
	$(".scrollable").scrollable({
	     circular: true
	}).navigator({
	    navi: '.navBar',
	    naviItem: '.navBox'
	});
}

function setUpRSVPForm(){
	//set form submission
	/*$(":button").click(function(){
	 var newdiv = document.createElement('div');
	 newdiv.innerHTML = "Guset " + (counter + 1) + "<input type='text' name='guests[]'><br><br>";
	 $("#dynamicGuests").append(newdiv);
	 counter++;
	 });*/
	$("#submitRSVP").click(function(){
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
	});
	
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
