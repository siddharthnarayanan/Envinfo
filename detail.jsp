<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Instances Detail</title>
</head>

<body>
 <%
    String project = request.getParameter("p");
    String env = request.getParameter("e");
 %>
<div id="container">
		<div id="header">
        	<h1>Instance<span class="off">Info</span></h1>
            <h2>Get The Instance Detail Here.</h2>
        </div>

        <div id="menu">
        	<ul>
		            	<li class="menuitem"><a href="index.jsp">Project</a></li>
		                <li class="menuitem"><a href="env.jsp?p=<%=project %>">Environment</a></li>
		                <li class="menuitem"><a href="instances.jsp?p=<%=project %>&e=<%=env %>">Instances</a></li>
		                <li class="menuitem"><a href="servers.jsp?p=<%=project %>&e=<%=env %>">Servers</a></li>
		                <li class="menuitem"><a href="database.jsp?p=<%=project %>&e=<%=env %>">Database</a></li>
                </ul>
        </div>

        <div id="leftmenu">

        <div id="leftmenu_top"></div>

				<div id="leftmenu_main">

<h3><%=request.getParameter("m") %>.leni2.com</h3>
                <ul>
                    <li><a href="#"><%=request.getParameter("i") %></a></li>
                </ul>
</div>


              <div id="leftmenu_bottom"></div>
        </div>




		<div id="content">


        <div id="content_top"></div>
        <div id="content_main">
        	
        	<%@page import="logic.GetResult,java.io.*;" %>
		            <%
		            String machine = request.getParameter("m");
		            String instance = request.getParameter("i");
		            String insPath = "//"+machine+".leni2.com/d$/jda/"+instance;
		
		            String buildNoPath = insPath+"/buildnumber.txt";
		            String issInstallPath = insPath+"/i2_iss_install.properties";
		            String lenovoPath = insPath+"/i2_lenovo_install.properties";
		            String verPath =  insPath+"/version";
		            
		
		            GetResult gr = new GetResult();
		         
		 
                %>
                <h2>Few Basic Detail for Instance Are..</h2><br>
                <h4>Instance Name :: <%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_1") %></h4><br>
		<h4>Build Number :: <%=gr.getBuildNumber(buildNoPath) %></h4><br>
		<h4>Listen Port :: <%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_2") %></h4><br>
                <h4>Install Directory :: <%=gr.getValueForKey(issInstallPath, "USER_INSTALL_DIR")%></h4><br>
                <h4>Database Server :: <%=gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_4") %></h4><br>
		<h4>Related Database :: <%=gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_1") %></h4><br>
                <h4>Related Schema  :: <%=gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_2") %></h4><br>
                <h4>Max Socket :: <%=gr.getValueForKey(lenovoPath,"I2_HTTP_PROPERTIES_1") %></h4><br>
                <h4>Service Pack Version ::</h4><br>
		            <%try{
		                       String files ;
		                       File folder = new File(verPath);
		                       File[] listOfFiles = folder.listFiles();
		                       
		                       for (int i = 0; i < listOfFiles.length; i++)
		                           {
		                            if (listOfFiles[i].isFile())
		                               {
		                                files = listOfFiles[i].getName();
		                                %><ul>
		                                    <li><%=files %></li>
		                                  </ul>
		                                <%
		                               }
		                            }
		                            
		                       }catch(NullPointerException ne){
		                        %><%="There is No Version for this Instance" %><%
                                 }%>
               <br>
               <h4>Booked Slot ::</h4><br>
                <%
	           String statusFilePath = insPath+"/properties/status.txt";
	           
	           try{
	           //---------------Read Status From Status File In Properties Folder----------
	       
	           File f = new File(statusFilePath);
	           
	           FileInputStream fstream = new FileInputStream(f);
	           DataInputStream in = new DataInputStream(fstream);
	           BufferedReader br = new BufferedReader(new InputStreamReader(in));
	           String strLine = br.readLine() ;
	           String[] sta = strLine.split(":");
	           %>
		                  <table border="1">
		                      <thead>
		                          <tr>
		                              <th>Test Env Line</th>
		                              <th>Title</th>
		                              <th>Owner</th>
		                              <th>Start Date</th>
		                              <th>End Date</th>
		                              <th>Sys Requirement</th>
		                          </tr>
		                      </thead>
		                      <tbody>
		                          <tr>
		                              <td><%=sta[0] %></td>
		                              <td><%=sta[1] %></td>
		                              <td><%=sta[2] %></td>
		                              <td><%=sta[3] %></td>
		                              <td><%=sta[4] %></td>
		                              <td><%=sta[5] %></td>
		                          </tr>
		                      </tbody>
		                  </table>
               	                  <a href="status.jsp?p=<%=project %>&e=<%=env %>&m=<%=machine %>&i=<%=instance %>">Book New Slot</a>
		                  <%
		                          
		  
		      		}
		      catch(FileNotFoundException fe)
		      {
		                  %><%="This Instance Is Free To Book!"%>   <a href="status.jsp?p=<%=project %>&e=<%=env %>&m=<%=machine %>&i=<%=instance %>">Book Now</a><%
		         
            	      }
	       
    	        %>
        <br><br><h4>Weblogic URL ::</h4><br>
        <a href="http://<%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_1") %>:<%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_2") %>/SEUILibrary/controller/Lenovo:Admin?ConfigContext=LenovoAdminPortal">http://<%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_1") %>:<%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_2") %>/SEUILibrary/controller/Lenovo:Admin?ConfigContext=LenovoAdminPortal</a>
        </div>
        <div id="content_bottom"></div>

            <div id="footer"><h3><a href="#">florida web design</a> | <a href="#">web tutorials</a> | <a href="#">html codes</a> | <a href="#">free templates</a></h3></div>
      </div>
   </div>
</body>
</html>
