<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Database</title>
</head>

<body>

<%
    String envr = "";
    String project = request.getParameter("p");
    String env = request.getParameter("e");
    if(env.equals("pro")) {envr = "Production";}
    if(env.equals("qa")) {envr = "QA";}
    if(env.equals("dev")) {envr = "Development";}
%>
    
<div id="container">
		<div id="header">
        	<h1>DB<span class="off">Info</span></h1>
            <h2>Get All The Database For <%=envr%>.</h2>
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

	 <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException,java.util.*" %>
	         <%
	         int currentInstances = 0;
	         Set dbSet = new HashSet();
	         Set msSet = new HashSet();
	         HashMap msdbs = new HashMap();
	         String[][] info = null;
	         int p = 0;
	         logic.GetResult gr = new logic.GetResult();
	         int l = 0 ;
	         try {
	 		
	 		String configFilePath = null;
			                        
			            if(env == null)
				      {%>
				          <div id="content_top"></div>
				          <div id="content_main">
				          <%="Our Apologies !"%></div>
			                  <div id="content_bottom"></div>
			              <%}
			
			            if(env.equals("pro")){configFilePath ="C:/Users/j1012484/Desktop/Configs/ProdDom/config.xml";}
			
			            if(env.equals("qa")){configFilePath ="C:/Users/j1012484/Desktop/Configs/PrepDom/config.xml";}
			
            		            if(env.equals("dev")){configFilePath ="C:/Users/j1012484/Desktop/Configs/DevDom/config.xml";}
            
	             DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
	             DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
	             Document doc = docBuilder.parse (new File(configFilePath));
	 
	             // normalize text representation
	             doc.getDocumentElement ().normalize ();
	 
	             NodeList listOfServers = doc.getElementsByTagName("server");
	            
	             l = listOfServers.getLength();
	             info = new String[l][4];
	 
	             for(int s=0; s<l; s++){
	 
	 
	                 Node firstServerNode = listOfServers.item(s);
	                 Element firstServerElement = (Element)firstServerNode;
	                 NodeList pathList = firstServerElement.getElementsByTagName("custom-identity-key-store-file-name");
	 
	                 if((firstServerNode.getNodeType() == Node.ELEMENT_NODE) && (pathList.getLength() != 0)){
	 
	                     //-------- Code to get Machine Name------------------
	 
	                     NodeList MachineList = firstServerElement.getElementsByTagName("machine");
	                     Element MachineElement = (Element)MachineList.item(0);
	 
	                     NodeList textMNList = MachineElement.getChildNodes();
	                     String machineName = textMNList.item(0).getNodeValue().trim();
	                     
	                     //--------Code to get Instance name------------------
	 
	                     Element pathElement = (Element)pathList.item(0);
	 
	                     NodeList textPath = pathElement.getChildNodes();
	                     String path1 = textPath.item(0).getNodeValue().replace('\\','/');
	                     String[] insName = path1.split("/");
	 
	                     //--------Code to create the root path----------------
	 
	                     String insPath = "//"+machineName+".leni2.com/d$/jda/"+insName[2];
				   String buildNoPath = insPath+"/buildnumber.txt";	                     
                           String issInstallPath = insPath+"/i2_iss_install.properties";
	                     
	 
	                     //-------- Filling information in the Array object----
	 
	                     if((machineName != null)&&(insName[2] != null))
	                     {   info[p][0] = machineName;
	                         info[p][1] = insName[2];
	                         info[p][2] = gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_1");
	                         info[p][3] = gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_4");
	                         String key = info[p][0]+"/"+info[p][1];
	                         String value = info[p][2]+"/"+info[p][3];
	                         msSet.add(key);
	                         dbSet.add(value);
	                         msdbs.put(key,value);
	                         p++;
	                     }
	 
	                     //------------- Instance counter----------------
	 
	                     currentInstances++ ;
	                 }//end of outer if clause
	            }//end of for loop with s var
	 
	        // out.println("Total no of Instances : " + currentInstances);
	        }catch (SAXParseException err) {
	 
	         System.out.println ("** Parsing error" + ", line "
	              + err.getLineNumber () + ", uri " + err.getSystemId ());
	         System.out.println(" " + err.getMessage ());
	         err.printStackTrace(new PrintWriter(out));
	 
	         }catch (SAXException e) {
	         Exception x = e.getException ();
	         ((x == null) ? e : x).printStackTrace (new PrintWriter(out));
	 
	         }catch (Throwable t) {
	         t.printStackTrace ();
	         t.printStackTrace(new PrintWriter(out));
	         }
	         //System.exit (0);
	         // Display information on the page
	         
	         String action = request.getParameter("dbs");
                 if(action == null){
	         	          
	       	Iterator itr = dbSet.iterator();
	                while(itr.hasNext()){
	                         String sidbs = (String)itr.next();
	                         String[] val = sidbs.split("/"); %>
	       	                <div id="leftmenu">
	       	                <div id="leftmenu_top"></div>
	       					<div id="leftmenu_main">
	       	                                <h3><%=val[1] %></h3>
	       	                                <ul>
	       	                                    <li><a href="database.jsp?p=<%=project %>&e=<%=env %>&dbs=<%=sidbs%>"><%=val[0] %></a></li>
	       	                                </ul>
	        		                </div>
	       	                <div id="leftmenu_bottom"></div>
	       	                </div>
              <%}}else{
              	
              	Set set = msdbs.entrySet();
              	Iterator im = set.iterator();
              	
              	while(im.hasNext())
				{
				Map.Entry me=(Map.Entry)im.next();
				if(me.getValue().equals(action)){
				String ms = (String)me.getKey();
				String[] msp = ms.split("/");%>
				<div id="leftmenu">
		                <div id="leftmenu_top"></div>
					  	<div id="leftmenu_main">
	  	                                <h3><%=msp[0] %></h3>
	    	                                <ul>
                               			<li><a href="detail.jsp?p=<%=project %>&e=<%=env %>&m=<%=msp[0]%>&i=<%=msp[1]%>"><%=msp[1] %></a></li>
			                        </ul>
		  		                </div>
	 	                <div id="leftmenu_bottom"></div>
	       	                </div>
			<% }
			}
		    }
              %>
              
              

   </div>
</body>
</html>
