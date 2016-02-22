<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Project</title>
</head>

<body>
<div id="container">
		<div id="header">
        	<h1>Server<span class="off">Info</span></h1>
            <h2>Get All The Server Detail Here...</h2>
        </div>
        
        <div id="menu">
        	<ul>
		            	<li class="menuitem"><a href="index.jsp">Project</a></li>
		                <li class="menuitem"><a href="#">About</a></li>
		                <li class="menuitem"><a href="#">Products</a></li>
		                <li class="menuitem"><a href="servers.jsp">Servers</a></li>
		                <li class="menuitem"><a href="database.jsp">Database</a></li>
		                <li class="menuitem"><a href="#">Contact</a></li>
            	</ul>
        </div>

        <div id="leftmenu">

        <div id="leftmenu_top"></div>

		<div id="leftmenu_main">
		<h3>Projects</h3>
                <ul>
                    <li><a href="index.jsp?project=FMX">FMX</a></li>
                    <li><a href="index.jsp?project=Lenovo">Lenovo</a></li>
                    <li><a href="index.jsp?project=Sony">Sony</a></li>
                </ul>
               </div>


              <div id="leftmenu_bottom"></div>
        </div>




		<div id="content">


        <div id="content_top"></div>
        <div id="content_main">
            <%
	                    String project = null;
	                    if(request.getParameter("project") == null)
	                        {
	                            project = "Lenovo";
	                        }
	                    else
	                        {
	                            project = request.getParameter("project");
	                        }
            %>
            <h2>There Are Different Envirnoment in <%=project %> Server</h2>
            <br>
            Select Any One
            <br>
                 <ul>
		                     <li><a href="instances.jsp?env=pro">Production</a></li>
		                     <li><a href="instances.jsp?env=qa">QA</a></li>
		                     <li><a href="instances.jsp?env=dev">Development</a></li>
                </ul>
          </div>
        <div id="content_bottom"></div>

       </div>
   </div>
</body>
</html>
