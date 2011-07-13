<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" 
    "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%
	session = request.getSession();

	
			Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
			if (loggedIn == null){ loggedIn = false;}
			//is user logged in
			if( loggedIn == false)
			{
			%>
				<jsp:forward page= "login.jsp"/>
			<%
			} 

	String folderName = (String)request.getParameter("folderName");
	String displayName = (String)request.getParameter("dn");
	
	//set folderName
	session.setAttribute("folderName",folderName);
	System.out.println("set folderName as "+folderName);
	
%>
    		
<html>

	<head>
			<meta http-equiv="Content-type" name="desktop" content="text/html;charset=UTF-8">
    	<title></title>
		<!-- jquery must load first -->
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery-ui-1.8.5.custom.min.js"></script>
		<script type="text/javascript" src="../swfcore/jquery.swfupload.js"></script>	
		<script type="text/javascript" src="../swfcore/swfupload.js"></script>
		<script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
		 <link rel="stylesheet" type="text/css" href="../css/pics.css" />
		 <link rel="stylesheet" type="text/css" href="../css/layoutSmall.css" />
		 
		
	
	
	<style type="text/css">
		html,body { height:100%; width:100%; }

		.floatLeft{float:left}
		.preload{display:none;}
		
	</style>
					
    <script type="text/javascript">

	//show loading bar
    	function setProgressLoading(elementId) {
		$("#"+elementId).progressBar(0, { showText: true,
														width: 208,
														height: 13,
														showText: false,
														speed:10,
														boxImage: '../images/blue_progress_box_new.gif',
														barImage: '../images/blue_loader_new.gif'} );
		};
		//update loading bar
		//queries: a key-value pair object. a value of -1 means the query has not completed
		function updateProgressLoading(elementId, queries) {
			//count the number of finished queries
			var finishedQueryCount = 0;
			var totalQueries = 0;
			for (var q in queries) {
				if (queries[q] != -1) {
					finishedQueryCount += 1;
				}
				totalQueries += 1;
			}
			
			var progress = (finishedQueryCount/totalQueries)*10;
			progress = Math.floor(progress);
			
			if(progress <= 0) {
				 $("#"+elementId).progressBar(5);
			}else if (progress <= 1) {
				$("#"+elementId).progressBar(10);
			}else if (progress <= 1.5) {
				$("#"+elementId).progressBar(15);
			}else if (progress <= 2) {
				$("#"+elementId).progressBar(20);
			}else if (progress <= 2.5) {
				$("#"+elementId).progressBar(25);
			}else if (progress <= 3) {
				$("#"+elementId).progressBar(30);
			}else if (progress <= 3.5) {
				$("#"+elementId).progressBar(35);
			}else if (progress <= 4) {
				$("#"+elementId).progressBar(40);
			}else if (progress <= 4.5) {
				$("#"+elementId).progressBar(45);
			}else if (progress <= 5) {
				$("#"+elementId).progressBar(50);
			}else if (progress <= 5.5) {
				$("#"+elementId).progressBar(55);
			}else if (progress <= 6) {
				$("#"+elementId).progressBar(60);
			}else if (progress <= 6.5) {
				$("#"+elementId).progressBar(65);
			}else if (progress <= 7) {
				$("#"+elementId).progressBar(70);
			}else if (progress <= 7.5) {
				$("#"+elementId).progressBar(75);
			}else if (progress <= 8) {
				$("#"+elementId).progressBar(80);
			}else if (progress <= 8.5) {
				$("#"+elementId).progressBar(85);
			}else if (progress <= 9) {
				$("#" + elementId).progressBar(90);
			}else if (progress <= 9.5) {
				$("#" + elementId).progressBar(95);
			}else{
				$("#" + elementId).progressBar(100);
			}
		};
		
	function hideDownloadButton(){
		//hide download button. we don't want to upload and download at the same time
		$("#dlButtonContainer").hide("slow");
		$("#prepareDL").hide("slow");
	};
	
		
	function setUpdlButton(){
		
		
		var folderName = "<%=folderName%>";
		$("#dlButton").click(function(){
			//show loading
			$("#prepareDL").html("Preparing download<br>This may take a while...<br><img src='../images/ajaxLoader.gif' alt='Loading...'/>" ).show("fast");
			//download file
			jQuery.ajax({ 	beforeSend: function(R) { R.setRequestHeader ( "Cache-Control", "no-cache, must-revalidate"); },
					            url: "../download.jsp"+"?id="+new Date().getTime(), //prevent IE from caching response
					            type: "POST", //use POST so the jsonString parameter may be very large
					            data: {'folderName':folderName},
					            dataType: "json",
					            timeout: 60000,
					            error: function(e1, e2){
									$("#prepareDL").html("Whoops, an error occured: "+e2);
					            },
					            success: function(returned_data_json){
									if(returned_data_json.status.status == "success"){
										//create dl link
										var dlLink = '<a href="'+folderName+'/zip/pictures.zip?id='+new Date().getTime()+'">Click Here to Download Pictures</a>';
										$("#prepareDL").html(dlLink).effect("highlight", {}, 2000);
									}else{
										$("#prepareDL").html("Whoops, an error occured: "+returned_data_json.status.description);
									}
					            }
				});
		});
	}
	
	function createPictureList(){
		//call getPics
		var folderName = "<%=folderName%>";
		//set loader
		$("#fileListContents").html("<img src='../images/ajaxLoader.gif' alt='Loading...'/>" );
		
		hideDownloadButton();
		
		//get a list of pics
		jQuery.ajax({ 	beforeSend: function(R) { R.setRequestHeader ( "Cache-Control", "no-cache, must-revalidate"); },
				            url: "getPics.jsp"+"?id="+new Date().getTime(), //prevent IE from caching response
				            type: "POST", //use POST so the jsonString parameter may be very large
				            data: {'folderName':folderName},
				            dataType: "json",
				            timeout: 60000,
				            error: function(e1, e2){
								$("#fileListContents").html("Can't find folder: "+folderName);
				            },
				            success: function(returned_data_json){
								
								if(returned_data_json.file0 == undefined){
									picListHTML = "This folder is empty. Upload some pictures! ";
								}else{
									//make list
									picListHTML = "<ul id='picList'>";//start list
									var key;
									for(key in returned_data_json){
										picListHTML += "<li>"+returned_data_json[key]+"</li>";
									}
									picListHTML += "</ul>";//end list
									
									//show download button
									$("#dlButtonContainer").show("slow");
;
								}
								
								//insert into fileListContents
								$("#fileListContents").html(picListHTML);	
				            }
			});
			
		
		
		
	}	
    var queued = 0;
	var completed = 0;
	var total = 0;
	var completedUploads = {}
	 
    $(function(){
		createPictureList();
		setUpdlButton();
				
		$('#swfupload-control').swfupload({
    		upload_url: "../upload.jsp"+";jsessionid=<%= session.getId() %>",
    		flash_url : "../swfcore/Flash/swfupload.swf",
    		post_params: {"JSESSIONID" : "<%= session.getId() %>"},
    		file_size_limit : "10 MB",
    		file_types : "*.jpg;*.gif;*.bmp;*.jpeg;",
    		file_types_description : "All Files",
    		file_upload_limit : "0",
    		//button_image_url : '../swfcore/XPButtonUploadText_61x22.png',
    		//button_width : 61,
    		//button_height : 22,
    		//button_placeholder : $('#button')[0],
			button_image_url : '../images/ozle_upload_button.png',
			button_width : 120,
    		button_height : 60,
			button_placeholder_id : "uploadButton",
			button_text: '<span class="theFont">Upload</span>',
			button_text_style: ".theFont { width:100%; font-weight:bold; text-align:center; font-size: 24px; font-family: sans-serif; }",
			button_cursor: SWFUpload.CURSOR.HAND,
			//button_text: '<div class="theFont">Upload</span>',
			//button_text_style: ".theFont { width:100%; text-align:center; font-size: 16px; }",
    		debug: false,
    		custom_settings : {something : "here"}
    	})
    		.bind('swfuploadLoaded', function(event){
    			//$('#log').append('<li>Loaded</li>');
    		})
    		.bind('fileQueued', function(event, file){
				queued++;
				completedUploads[queued] = -1;
    			//$('#log').append('<li>File queued - '+file.name+'</li>');
    			// start the upload since it's queued
				//alert(queued);
    			$(this).swfupload('startUpload');
    		})
    		.bind('fileQueueError', function(event, file, errorCode, message){
    			$('#log').append('<li>File queue error - '+file.name+' '+message+'<br>only pictures under 10MB please</li>');
    		})
    		.bind('fileDialogStart', function(event){
    			//$('#log').append('<li>File dialog start</li>');
    		})
    		.bind('fileDialogComplete', function(event, numFilesSelected, numFilesQueued){
				if(queued != 0){
					total = queued;
					$("#uploadProgress").fadeIn("slow");
					$("#fileStatus").fadeIn("slow");
					//clear log
					$('#log').html("");
					//show loading
					setProgressLoading("uploadProgress");
					hideDownloadButton();
				}
    			//$('#log').append('<li>File dialog complete</li>');
    		})
    		.bind('uploadStart', function(event, file){
				updateProgressLoading("uploadProgress",completedUploads);
				
				$("#fileStatus").html("Uploading File "+completed+" of "+total+":"+file.name);
				//check queued and update object
    			//$('#log').append('<li>Upload start - '+file.name+'</li>');
    		})
    		.bind('uploadProgress', function(event, file, bytesLoaded){
    			//$('#log').append('<li>Upload progress - '+bytesLoaded+'</li>');
    		})
    		.bind('uploadSuccess', function(event, file, serverData){
    			//$('#log').append('<li>Upload success - '+file.name+'</li>');
    		})
    		.bind('uploadComplete', function(event, file){
				completedUploads[queued] = 1;
				completed++;
				queued--;
				
				updateProgressLoading("uploadProgress",completedUploads);
				
				if(queued == 0){
					//clear 
					total = 0;
					completed = 0;
					completedUploads = {};
					
					$("#fileStatus").html("Upload Complete");
					//timer to display success
					setTimeout(function(){
						$("#uploadProgress").fadeOut("slow");
						$("#fileStatus").fadeOut("slow");
						//update picture list
						createPictureList();
					}, 2000);
				}
    			//$('#log').append('<li>Upload complete - '+file.name+'</li>');
    			// upload has completed, lets try the next one in the queue
    			$(this).swfupload('startUpload');
    		})
    		.bind('uploadError', function(event, file, errorCode, message){
    			$('#log').append('<li>Upload error - '+file.name+' '+message+'</li>');
    		});
			
			//IEfix
			if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) {
				$("#dlButton").css('margin-left','84.5px');
			}
    });
    
	</script> 
    </head> 
    <body> 
     	
		<div id="framePics">
			<div class="topBar"></div>
			<div class="banner"><div class='chocoBox' style='position:absolute;margin:15px 0 0 10px'><%=displayName%>'s Pictures</div></div>
	    	
			
			<div class="uploader">
				
				<div id="swfupload-control"> 
					<div class="uploadButtonContainer">
						<div id="uploadButton"></div>
					</div>
					<div class="uploadStatus">
						<div id="uploadProgress" class="uploadProgressBar"></div>
			    		<div id="fileStatus"></div>	
					</div>
					<ol id="log"></ol> 
			    </div> 
				
				<div id="dlButtonContainer" style="display:none;">
					<div id="dlButton" class="navBox" >Download All</div>
					
				</div>
				<div id="prepareDL" style="display:none;"></div>
			</div>
			
			<div class="smallDivider"></div>
			
			<div class="fileList">
				<h4>Pictures</h4>
				<div id="fileListContents"></div>
			</div>
			
			<div class="bottomBar"></div>
		</div>
		
		
    	 
     	
    </body> 
    </html> 