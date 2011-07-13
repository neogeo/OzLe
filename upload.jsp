<%@ page import= "com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.zip.*" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.io.IOUtils" %>

<%
System.out.println("");
System.out.println("");
System.out.println("");

//try to set session
session = request.getSession();
if(session == null){
	System.out.println("NO SESSION");
}else{
	System.out.println("sessionID: "+session.getId());
}

System.out.println(request.getParameter("JSESSIONID"));

//check file system 
ServletContext context = session.getServletContext();
String realContextPath = context.getRealPath(request.getContextPath());

	//remove request-context-path from realContextPath
	String[] sArr = realContextPath.split("\\\\");
	StringBuffer newContextPath = new StringBuffer();
		for(int i=0; i<sArr.length-1; i++){
			newContextPath.append(sArr[i]);
			newContextPath.append(File.separator);
		}
	
	realContextPath = newContextPath.toString();
	
	String folderName = (String)session.getAttribute("folderName");
	System.out.println("    foldername "+folderName);
	//load each file
	String workingSet  = realContextPath  + "pics\\" + folderName;
	String modFilePath = workingSet + "\\mod.txt";
	System.out.println("    saving to "+workingSet);
	
	if(folderName!=null){
		try{
			//300MB
			com.oreilly.servlet.MultipartRequest multipartRequest = new com.oreilly.servlet.MultipartRequest(request, workingSet, 314572800); 
			//open mod.txt and write true
			setIsModified(modFilePath);
			System.out.println("uploaded");
		}catch(java.io.IOException e){
			e.printStackTrace();
		}
	}
%>

<%!
//set mod.txt to modified (true)
public void setIsModified(String modFilePath){
	try{
		 FileInputStream in = new FileInputStream( new File(modFilePath) );
		 byte[] b = IOUtils.toByteArray(in);
		 String contents = new String(b);

		 contents = "true";
		 
		 in.close();
		 
		//write contents to file
		 FileUtils.writeStringToFile(new File(modFilePath), contents);
	 }catch(IOException e){
		 e.printStackTrace();
	 }
}
%>