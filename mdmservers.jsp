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
        	<h1>Server<span class="off">Info</span></h1>
            <h2>Get All The Server For <%=project %> <%=envr %>.</h2>
        </div>

        <div id="menu">
        	<ul>
		            	<li class="menuitem"><a href="index.jsp">Project</a></li>
		                <li class="menuitem"><a href="mdmenv.jsp?p=<%=project %>">Environment</a></li>
		                <li class="menuitem"><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Instances</a></li>
		                <li class="menuitem"><a href="mdmservers.jsp?p=<%=project %>&e=<%=env %>">Servers</a></li>
		                
            </ul>
        </div>
        <%if(env.equals("pro")){ %>
        <div id="leftmenu">
               <div id="leftmenu_top"></div>
         		<div id="leftmenu_main">
	            <h3><%=env %>..</h3>
	            <ul>
	                <li><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Lenprdmdm11</a></li>
	            </ul>
	            </div>
	           <div id="leftmenu_bottom"></div>
	    </div>
        <div id="leftmenu">
               <div id="leftmenu_top"></div>
         		<div id="leftmenu_main">
	            <h3><%=env %>..</h3>
	            <ul>
	                <li><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Lenprdmdm12</a></li>
	            </ul>
	            </div>
	           <div id="leftmenu_bottom"></div>
	    </div>
        <%}
        if(env.equals("test")){%>
        <div id="leftmenu">
               <div id="leftmenu_top"></div>
         		<div id="leftmenu_main">
	            <h3><%=env %>..</h3>
	            <ul>
	                <li><a href="mdminstances.jsp?p=<%=project %>&e=<%=env %>">Lendevmdm01</a></li>
	            </ul>
	            </div>
	           <div id="leftmenu_bottom"></div>
	    </div>
        <%}%>

</div>
</body>
</html>
