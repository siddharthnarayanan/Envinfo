<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Servers</title>
</head>

<body>
            <%
            String env = null;
            String envr = null;
            String project = request.getParameter("p");
            env = request.getParameter("e");
            if(env.equals("pro")){envr = "Production";}
            if(env.equals("test")){envr = "Testing";}
            %>
<div id="container">

        <div id="header">
        	<h1>Instance<span class="off">Info</span></h1>
            <h2>Get All The Instance For <%=project %> <%=envr %>.</h2>
        </div>

        <div id="menu">
        	<ul>
		            	<li class="menuitem"><a href="index.jsp">Project</a></li>
		                <li class="menuitem"><a href="mdmenv.jsp?p=<%=project %>">Environment</a></li>
		                <li class="menuitem"><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Instances</a></li>
		                <li class="menuitem"><a href="mdmservers.jsp?p=<%=project %>&e=<%=env %>">Servers</a></li>
		                
            </ul>
        </div>

         <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException" %>
         <%! String path = "";%>
         <%
         String files;
         if(env.equals("pro")){path = "//lenprdmdm11.leni2.com/d$/bea/doms";}
         if(env.equals("test")){path = "//lendevmdm01.leni2.com/d$/doms";}

                try{
                    File folder = new File(path);
                    //  File[] listOfFiles = folder.listFiles();
                    FilenameFilter select = new FilenameFilter() {
                    public boolean accept(File dir, String name) {
                    return name.startsWith("ABPP");
                       }
                      };
                    File[] listOfFiles = folder.listFiles(select);

                                for (int i = 0; i < listOfFiles.length; i++)
                                    {
                                        if (listOfFiles[i].isDirectory())
                                           {
                                                files = listOfFiles[i].getName();
                                            %>
                                            <div id="leftmenu">
                                            <div id="leftmenu_top"></div>
                                            <div id="leftmenu_main">
                                            <h3>Ins</h3>
                                            <ul>
                                            <li><a href="mdmdetail.jsp?p=<%=project %>&e=<%=env %>&i=<%=files%>"><%=files%></a></li>
                                            </ul>
                                            </div>
                                            <div id="leftmenu_bottom"></div>
                                            </div>
                                            <%
                                           }
                                    }
                            }catch(NullPointerException ne){
                                  %><%="No Instance Available"%><%
                                }
                          %>

</div>
</body>
</html>
