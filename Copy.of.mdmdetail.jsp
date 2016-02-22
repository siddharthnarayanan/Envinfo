<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Instances Detail</title>
</head>

<body>
 <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException,java.util.*" %><%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException,java.util.*" %>
 <%
    String configPath = null;
    String xserverPath = null;
    String machine = null;
    String mname = null;

    String installationDir = null;
    String dbServer = null;
    String database = null;
    String schema = null;
    String abppPort = null;

    String project = request.getParameter("p");
    String env = request.getParameter("e");
    String instance = request.getParameter("i");

    if(env.equals("pro")){machine = "//lenprdmdm11.leni2.com/d$"; configPath = machine+"/bea/doms/"+instance+"/config/config.xml"; mname = "Lenprdmdm11";}
    if(env.equals("test")){machine = "//lendevmdm01.leni2.com/d$"; configPath = machine+"/doms/"+instance+"/config/config.xml"; mname = "Lendevmdm01";}

    DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
    DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
    Document doc = docBuilder.parse (new File(configPath));

    doc.getDocumentElement ().normalize ();
    NodeList mainNodes = doc.getElementsByTagName("app-deployment");

    for(int mn=0; mn<mainNodes.getLength() ; mn++){

                Node firstMainNode = mainNodes.item(mn);
                if(firstMainNode.getNodeType() == Node.ELEMENT_NODE){

                    Element firstMainElement = (Element)firstMainNode;
                    NodeList installationPath = firstMainElement.getElementsByTagName("source-path");
                    Element pathElement = (Element)installationPath.item(0);

                    NodeList textPath = pathElement.getChildNodes();

                    String aa = textPath.item(0).getNodeValue().replace('\\','/');
                    String[] insName = aa.split("/");

                    installationDir = insName[0]+"\\"+insName[1]+"\\"+insName[2];

                    xserverPath= machine+"/"+insName[1]+"/"+insName[2]+"/cfg/properties/xserver.xml";

                }
    }

    Document doc1 = docBuilder.parse (new File(xserverPath));

    doc1.getDocumentElement ().normalize ();
    NodeList dbDetails = doc1.getElementsByTagName("database-config");

    for(int db=0; db<dbDetails.getLength() ; db++){

                Node dbConfigNode = dbDetails.item(db);
                if(dbConfigNode.getNodeType() == Node.ELEMENT_NODE){

                    Element dbConfigElement = (Element)dbConfigNode;

                    NodeList dbURLList = dbConfigElement.getElementsByTagName("db-url");
                    Element dbURLElement = (Element)dbURLList.item(0);
                    String[] dbURL = dbURLElement.getAttribute("Value").split(":");
                    dbServer = dbURL[3];
                    database = dbURL[5];

                    NodeList schemaList = dbConfigElement.getElementsByTagName("userid");
                    Element schemaElement = (Element)schemaList.item(0);
                    schema = schemaElement.getAttribute("Value");
                }

    }

    NodeList portDetails = doc1.getElementsByTagName("server-config");

    for(int pd=0; pd<portDetails.getLength() ; pd++){

                Node serverConfigNode = portDetails.item(pd);
                if(serverConfigNode.getNodeType() == Node.ELEMENT_NODE){

                    Element serverConfigElement = (Element)serverConfigNode;

                    NodeList abppPortList = serverConfigElement.getElementsByTagName("listenerPort");
                    Element abppPortElement = (Element)abppPortList.item(0);
                    abppPort = abppPortElement.getAttribute("Value");

                }
        }
 %>
<div id="container">
		<div id="header">
        	<h1>Instance<span class="off">Info</span></h1>
            <h2>Get The Instance Detail Here.</h2>
        </div>

        <div id="menu">
        	<ul>
		            	<li class="menuitem"><a href="index.jsp">Project</a></li>
		                <li class="menuitem"><a href="mdmenv.jsp?p=<%=project %>">Environment</a></li>
		                <li class="menuitem"><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Instances</a></li>
		                <li class="menuitem"><a href="mdmservers.jsp?p=<%=project %>&e=<%=env %>">Servers</a></li>
		                
           </ul>
        </div>

        <div id="leftmenu">
        <div id="leftmenu_top"></div>
				<div id="leftmenu_main">
                <h3><%=mname %>.leni2.com</h3>
                <ul>
                    <li><a href="#"><%=instance %></a></li>
                </ul>
                </div>
        <div id="leftmenu_bottom"></div>
        </div>

		<div id="content">
        <div id="content_top"></div>
        <div id="content_main">
                <h2>Few Basic Detail for Instance Are..</h2><br>
                <h4>Installation Directory :: <%=installationDir %></h4><br>
                <h4>ABPP Port No :: <%=abppPort %></h4><br>
                <h4>Database Server :: <%=dbServer %></h4><br>
                <h4>Database :: <%=database %></h4><br>
                <h4>Schema :: <%=schema %></h4><br>
        </div>
        <div id="content_bottom"></div>

        <div id="footer"><h3><a href="#">florida web design</a> | <a href="#">web tutorials</a> | <a href="#">html codes</a> | <a href="#">free templates</a></h3></div>

      </div>
   </div>
</body>
</html>
