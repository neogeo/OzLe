<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" 
    "http://www.w3.org/TR/html4/strict.dtd">

<%
	session = request.getSession();
	session.setAttribute("folderName","oz");
%>



<!--  extracted cos.jsr -->
<!--Edit /etc/httpd/conf/js_modsecurity/useragents.conf. SecRule HTTP_User-Agent  "^Shockwave Flash"-->			


<html>

	<head>
		<meta http-equiv="Content-type" name="desktop" content="text/html;charset=UTF-8">
    	<title></title>
		<!-- jquery must load first -->
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="swfcore/jquery.swfupload.js"></script>	
		<script type="text/javascript" src="swfcore/swfupload.js"></script>
		
		
	<style type="text/css">
		html,body { height:100%; width:100%; }
		
		
		.floatLeft{float:left}
		.preload{display:none;}
	</style>
					
    <script type="text/javascript">
			
			
    $(function(){
    	$('#swfupload-control').swfupload({
    		upload_url: "upload.jsp"+";jsessionid=<%= session.getId() %>",
    		flash_url : "swfcore/Flash/swfupload.swf",
    		post_params: {"JSESSIONID" : "<%= session.getId() %>"},
    		file_size_limit : "10240",
    		file_types : "*.jpg;*.gif;*.bmp;*.jpeg;",
    		file_types_description : "All Files",
    		file_upload_limit : "0",
    		button_image_url : 'swfcore/XPButtonUploadText_61x22.png',
    		button_width : 61,
    		button_height : 22,
    		button_placeholder : $('#button')[0],
    		debug: true,
    		custom_settings : {something : "here"}
    	})
    		.bind('swfuploadLoaded', function(event){
    			$('#log').append('<li>Loaded</li>');
    		})
    		.bind('fileQueued', function(event, file){
    			$('#log').append('<li>File queued - '+file.name+'</li>');
    			// start the upload since it's queued
    			$(this).swfupload('startUpload');
    		})
    		.bind('fileQueueError', function(event, file, errorCode, message){
    			$('#log').append('<li>File queue error - '+message+'</li>');
    		})
    		.bind('fileDialogStart', function(event){
    			$('#log').append('<li>File dialog start</li>');
    		})
    		.bind('fileDialogComplete', function(event, numFilesSelected, numFilesQueued){
    			$('#log').append('<li>File dialog complete</li>');
    		})
    		.bind('uploadStart', function(event, file){
    			$('#log').append('<li>Upload start - '+file.name+'</li>');
    		})
    		.bind('uploadProgress', function(event, file, bytesLoaded){
    			$('#log').append('<li>Upload progress - '+bytesLoaded+'</li>');
    		})
    		.bind('uploadSuccess', function(event, file, serverData){
    			$('#log').append('<li>Upload success - '+file.name+'</li>');
    		})
    		.bind('uploadComplete', function(event, file){
    			$('#log').append('<li>Upload complete - '+file.name+'</li>');
    			// upload has completed, lets try the next one in the queue
    			$(this).swfupload('startUpload');
    		})
    		.bind('uploadError', function(event, file, errorCode, message){
    			$('#log').append('<li>Upload error - '+message+'</li>');
    		});
    });	
     
    </script> 
    </head> 
    <body> 
     
    <div id="swfupload-control"> 
    	<ol id="log"></ol> 
    	<input type="button" id="button" /> 
    </div> 
     
    </body> 
    </html> 