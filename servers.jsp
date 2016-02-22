<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Servers</title>
</head>

<body>


     <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException,java.util.*" %>
            <%
            String env = null;
            String envr = null;
            String project = request.getParameter("p");
            Set serverSet = new HashSet();
        try {

            String configFilePath = null;
	    env = request.getParameter("e");

            if(env.equals("pro")){configFilePath ="C:/Users/j1012484/Desktop/Configs/ProdDom/config.xml";envr = "Production";}

            if(env.equals("qa")){configFilePath ="C:/Users/j1012484/Desktop/Configs/PrepDom/config.xml";envr = "QA";}

            if(env.equals("dev")){configFilePath ="C:/Users/j1012484/Desktop/Configs/DevDom/config.xml";envr = "Development";}

            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
            Document doc = docBuilder.parse (new File(configFilePath));

            // normalize text representation
            doc.getDocumentElement ().normalize ();

            NodeList listOfServers = doc.getElementsByTagName("server");

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
                    String machineName = textMNList.item(0).getNodeValue().trim();
                    serverSet.add(machineName);

                      }// end of inner if clause
                }//end of outer if clause
           }//end of for loop with s var
       }catch (SAXParseException err) {
        System.out.println ("** Parsing error" + ", line "
             + err.getLineNumber () + ", uri " + err.getSystemId ());
        System.out.println(" " + err.getMessage ());

        }catch (SAXException e) {
        Exception x = e.getException ();
        ((x == null) ? e : x).printStackTrace ();

        }catch (Throwable t) {
        t.printStackTrace ();
        }
        //System.exit (0);
                %>
                
<div id="container">
		<div id="header">
        	<h1>Server<span class="off">Info</span></h1>
            <h2>Get All The Server For <%=envr%>.</h2>
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


        
        
        
        
            <% Iterator itr = serverSet.iterator();
               while(itr.hasNext()){ String machine = (String)itr.next();%>
               	       	                         
	       	       	                <div id="leftmenu">
	       	       	                <div id="leftmenu_top"></div>
	       	       					<div id="leftmenu_main">
	       	       	                                <h3><%=env %>..</h3>
	       	       	                                <ul>
	       	       	                                    <li><a href="sinstances.jsp?p=<%=project %>&e=<%=env %>&mac=<%=machine %>"><%=machine %></a></li>
	       	       	                                </ul>
	       	        		                </div>
	       	       	                <div id="leftmenu_bottom"></div>
	       		                </div>
                             
              <%}%>
                  
          
          
     

</div>
</body>
</html>
