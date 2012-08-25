<%@ page import="java.io.*" %>
<%@ page import="java.util.zip.*" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%
String folderName = (String)request.getParameter("folderName");
System.out.println("    foldername "+folderName);
//check file system 
ServletContext context = session.getServletContext();
String realContextPath = context.getRealPath(request.getContextPath());

boolean isWindows = (System.getProperty("os.name").startsWith("Windows"))? true : false;

//Set working set, depending on OS
String workingSet = null;
String OS_PATH_SEPERATOR = null;
if (isWindows) {
	OS_PATH_SEPERATOR = "\\";
	//remove request-context-path from realContextPath
	String[] sArr = realContextPath.split("\\\\");
	StringBuffer newContextPath = new StringBuffer();
		for(int i=0; i<sArr.length-1; i++){
			newContextPath.append(sArr[i]);
			newContextPath.append(File.separator);
		}

	realContextPath = newContextPath.toString();

	workingSet  = realContextPath + "pics\\" + folderName;
}else{
	//Linux
	OS_PATH_SEPERATOR = "/";
	workingSet  = realContextPath + "/pics/" + folderName;
}

String zipWorkingSet = workingSet + OS_PATH_SEPERATOR + "zip";
String zipFileName = "pictures.zip";
String modFilePath = workingSet + OS_PATH_SEPERATOR + "mod.txt";
System.out.println("looking at pictures in "+workingSet);

File modFile = new File(modFilePath);

if(folderName != null && modFile.exists()){

//check if files have been added
	if( isModified(modFilePath) ){
		 System.out.println("modified, start zipping");
		//create new zip
		boolean zipSuccess = zipPics(workingSet, zipWorkingSet, zipFileName);
		if(zipSuccess){
		     out.println("{\"status\" : {\"status\":\"success\", \"description\":\"successfully zipped, start downloading\"} }");
		}else{
			 out.println("{\"status\" : {\"status\":\"failure\", \"description\":\"failed to zip pictures\"} }");
		}
		//set mod.txt to not modified
		setNotModified(modFilePath);
	}else{
		 System.out.println("not modified, start downloading");
		//download zip at folder/zip
		out.println("{\"status\" : {\"status\":\"success\", \"description\":\"start downloading\"} }");
		System.out.println("finished downloading");
	}
	
}else{
	out.println("{\"status\" : {\"status\":\"failure\", \"description\":\"picture folder not defined\"} }");
}
      
    
   
   


%>

<%!
//have more pics been added
 public boolean isModified(String modFilePath){
	boolean modified = false;
		try{
		 FileInputStream in = new FileInputStream( new File(modFilePath) );
		 byte[] b = IOUtils.toByteArray(in);
		 String contents = new String(b);

		 if(contents.contains("true")){
			 modified = true;
		 }
		 in.close();
	 }catch(IOException e){
		 e.printStackTrace();
	 }
	 return modified;
}
//set mod.txt to not modified (false)
public void setNotModified(String modFilePath){
	try{
		 FileInputStream in = new FileInputStream( new File(modFilePath) );
		 byte[] b = IOUtils.toByteArray(in);
		 String contents = new String(b);

		 contents = "false";
		 
		 in.close();
		 
		//write contents to file
		 FileUtils.writeStringToFile(new File(modFilePath), contents);
	 }catch(IOException e){
		 e.printStackTrace();
	 }
}

public boolean zipPics(String workingSet, String zipWorkingSet, String zipFileName){
	String OS_PATH_SEPERATOR = (System.getProperty("os.name").startsWith("Windows"))? "\\" : "/";
	final int BUFFER = 2048;
   try {
      BufferedInputStream origin = null;
      FileOutputStream dest = new FileOutputStream( zipWorkingSet + OS_PATH_SEPERATOR + zipFileName );
      System.out.println( "Save to: "+ zipWorkingSet + OS_PATH_SEPERATOR + zipFileName);
      ZipOutputStream zOut = new ZipOutputStream(new BufferedOutputStream(dest));
      //set to compress
      zOut.setMethod(ZipOutputStream.DEFLATED);
      
      byte data[] = new byte[BUFFER];
      // get a list of files from current directory
      File f = new File( workingSet );
      //String files[] = f.list();
      File[] files = f.listFiles();
      for (int i=0; i<files.length; i++) {
    	  //zip it if it is a file and not mod.txt
    	  if(files[i].isFile() && !(files[i].getName().equals("mod.txt")) ){
 	         //System.out.println( "Adding: "+files[i].getAbsolutePath() );
 	         System.out.println( "Adding: "+files[i] );
 	         FileInputStream fi = new FileInputStream( files[i] );
 	         origin = new BufferedInputStream(fi, BUFFER);
 	         //ZipEntry entry = new ZipEntry(files[i].getAbsolutePath());
 	         ZipEntry entry = new ZipEntry(files[i].getName());
 	         zOut.putNextEntry(entry);
 	         int count;
 	         while((count = origin.read(data, 0, 
 	           BUFFER)) != -1) {
 	        	 zOut.write(data, 0, count);
 	         }
 	         origin.close();
	    	 }
      }
      zOut.close();
      System.out.println("done zipping, saved to "+zipWorkingSet);
      return true;

   } catch(Exception e) {
      System.out.println(e.getMessage());
      return false;
   }
   
}

%>