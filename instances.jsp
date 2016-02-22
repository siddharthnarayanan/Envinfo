<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Instances</title>
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
        	<h1>Instance<span class="off">Info</span></h1>
            <h2>Get All The Instances For <%=envr%>.</h2>
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
        <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException" %>
        <%
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

            int currentInstances = 0;

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            Document doc = docBuilder.parse (new File(configFilePath));

            // normalize text representation
            doc.getDocumentElement ().normalize ();

            NodeList listOfServers = doc.getElementsByTagName("server");
            
            String machineName = "";
            String insPath = "";
            String issInstallPath  = "";

            for(int s=0; s<listOfServers.getLength() ; s++){


                Node firstServerNode = listOfServers.item(s);
                if(firstServerNode.getNodeType() == Node.ELEMENT_NODE){


                    Element firstServerElement = (Element)firstServerNode;
                    NodeList pathList = firstServerElement.getElementsByTagName("custom-identity-key-store-file-name");
                    if(pathList.getLength() != 0){

                    //-------- Code to get Machine Name------------------

                    NodeList MachineList = firstServerElement.getElementsByTagName("machine");
                    Element MachineElement = (Element)MachineList.item(0);

                    NodeList textMNList = MachineElement.getChildNodes();
                    machineName = textMNList.item(0).getNodeValue().trim();
                                       
                    //------


                    Element pathElement = (Element)pathList.item(0);

                    NodeList textPath = pathElement.getChildNodes();
                    String path1 = textPath.item(0).getNodeValue().replace('\\','/');
                    String[] insName = path1.split("/");

                    //------
                    insPath = "//"+machineName+".leni2.com/d$/jda/"+insName[2];
                    issInstallPath = insPath+"/i2_iss_install.properties";
                    currentInstances++ ;

                %>
                <%@page import="logic.GetResult" %>
                <%GetResult gr = new GetResult(); %>
                <div id="leftmenu">
                <div id="leftmenu_top"></div>
				<div id="leftmenu_main">

                <h3><%=machineName %>.leni2.com</h3>
		
                <ul>
                    
                    <li><a href="detail.jsp?p=<%=project %>&e=<%=env%>&m=<%=machineName %>&i=<%=insName[2]%>"><%=insName[2]%></a></li>
                    
                </ul>
                </div>
                <div id="leftmenu_bottom"></div>
                </div><%
                }// end of inner if clause

                }//end of outer if clause


           }//end of for loop with s var

           //System.out.println("Total no of Instances : " + currentInstances);
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

        %>
</div>
</body>
</html>
