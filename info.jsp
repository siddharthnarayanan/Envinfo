<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Information</title>
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
        	<h1>Get<span class="off">Info</span></h1>
            <h2>Get All The Information For <%=envr%> </h2>
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

        <div style="padding-top:120px">
        <font size="20" color="white" style="padding-left:130px;"><b>Select Information Type Here</b></font>
        </div>

        <table border="0" style="padding-top:120px;">
            <tbody>
                <tr>
                    <td> <div id="leftmenu">
        <div id="leftmenu_top"></div>
				<div id="leftmenu_main">
                <h3>Info..</h3>
                <ul>
                    <li><a href="instances.jsp?p=<%=project %>&e=<%=env %>">INSTANCES</a></li>
                </ul>
                </div>
        <div id="leftmenu_bottom"></div>
        </div></td>
                    <td> <div id="leftmenu">
        <div id="leftmenu_top"></div>
				<div id="leftmenu_main">
                <h3>Info..</h3>
                <ul>
                    <li><a href="servers.jsp?p=<%=project %>&e=<%=env %>">SERVERS</a></li>
                </ul>
                </div>
        <div id="leftmenu_bottom"></div>
        </div></td>
                    <td> <div id="leftmenu">
        <div id="leftmenu_top"></div>
				<div id="leftmenu_main">
                <h3>Info..</h3>
                <ul>
                    <li><a href="database.jsp?p=<%=project %>&e=<%=env %>">DATABASE</a></li>
                </ul>
                </div>
        <div id="leftmenu_bottom"></div>
        </div></td>
                </tr>
            </tbody>
        </table>

   </div>
</body>
</html>
