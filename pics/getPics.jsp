<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%
	//get a list of pictures in a given folder

	session = request.getSession();
	String folderName = (String)request.getParameter("folderName");
	

	//get pictures in folder
	//check file system 
	ServletContext context = session.getServletContext();
	String realContextPath = context.getRealPath(request.getContextPath());

	boolean isWindows = (System.getProperty("os.name").startsWith("Windows"))? true : false;
	
	//Set working set, depending on OS
	String workingSet = null;
	if (isWindows) {
		//remove request-context-path from realContextPath
		String[] sArr = realContextPath.split("\\\\");
		StringBuffer newContextPath = new StringBuffer();
			for(int i=0; i<sArr.length-1; i++){
				newContextPath.append(sArr[i]);
				newContextPath.append(File.separator);
			}
		
		realContextPath = newContextPath.toString();
		workingSet  = realContextPath + "pics\\" + folderName;
	} else {
	    // Linux
		workingSet  = realContextPath + "/pics/" + folderName;
	} 

	// get a list of files from current directory
	String jsonString = "{";

    File f = new File( workingSet );
	File[] files = f.listFiles();
	//for each file
	int index = 0;
	for (int i=0; i<files.length; i++) {
    	  //if it is a file and not mod.txt
    	  if(files[i].isFile() && !(files[i].getName().equals("mod.txt")) ){
    	  //get file name, but clense ticks
		  	jsonString += "'file"+index+"':'" + files[i].getName().replace("'","")+"'";
			index++;
		  }
	}
	jsonString += "}";
	//replace ticks with quotes for strict json parsing
	jsonString = jsonString.replace("''","','");
	//separate items
	jsonString = jsonString.replace("'","\"");
	
	out.println(jsonString);

%>