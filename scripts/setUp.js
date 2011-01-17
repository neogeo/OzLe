 //define colors
var colors = { yellow:"#FFFF33", lightGreen:"#99FF33", green:"33FF66", 
    lightBlue:"#33FFFF", blue:"#3366FF", darkBlue:"#6633FF", brown:"#C9B385"};

var counter = 1;

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
$(":button").click(function(){
     var newdiv = document.createElement('div');
     newdiv.innerHTML = "Guset " + (counter + 1) + "<input type='text' name='guests[]'><br><br>";
     $("#dynamicGuests").append(newdiv);

       counter++;
});


}
