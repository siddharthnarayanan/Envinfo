<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Environment</title>
</head>

<body>
<%@page import="logic.CreateExcelFile,logic.GetResult;" %>
<%
    String project = request.getParameter("p");
    String pod = request.getParameter("pod");
    String env = request.getParameter("e");
    

   if((pod != null) && (env != null))
        {
            CreateExcelFile report = new CreateExcelFile();
            report.getReport(project, pod, env);
        }
%>

<div id="container">
	<div id="header">
            <h1>Env<span class="off">Info</span></h1>
            <h2>Get All The Environment For <%=project %> </h2>
        </div>

        <div id="menu">
        	<ul>
            	<li class="menuitem"><a href="index.jsp">Project</a></li>
            </ul>
        </div>

        <div style="padding-top:120px">
        <font size="20" color="white" style="padding-left:130px;"><b>Select Your Environment Here</b></font>
        </div>

        <%
        if(project.equals("Lenovo")){
        %>
        <table border="0" style="padding-top:120px;">
            <tbody>
                <tr>
                    <td> <div id="leftmenu">
                    <div id="leftmenu_top"></div>
                    <div id="leftmenu_main">
                    <h3><a href="env.jsp?p=<%=project%>&e=pro&pod=iss"><img src="images/excel.gif" width="30" height="30" alt="excel"/></a></h3>
                    <ul>
                    <li><a href="info.jsp?p=<%=project%>&e=pro">PRODUCTION</a></li>
                    </ul>
                    </div>
                    <div id="leftmenu_bottom"></div>
                    </div></td>
                    <td> <div id="leftmenu">
                    <div id="leftmenu_top"></div>
                    <div id="leftmenu_main">
                    <h3><a href="env.jsp?p=<%=project%>&e=qa&pod=iss"><img src="images/excel.gif" width="30" height="30" alt="excel"/></a></h3>
                    <ul>
                    <li><a href="info.jsp?p=<%=project%>&e=qa">QA</a></li>
                    </ul>
                    </div>
                    <div id="leftmenu_bottom"></div>
                    </div></td>
                    <td> <div id="leftmenu">
                    <div id="leftmenu_top"></div>
                    <div id="leftmenu_main">
                    <h3><a href="env.jsp?p=<%=project%>&e=dev&pod=iss"><img src="images/excel.gif" width="30" height="30" alt="excel"/></a></h3>
                    <ul>
                    <li><a href="info.jsp?p=<%=project%>&e=dev">DEVELOPMENT</a></li>
                    </ul>
                    </div>
                    <div id="leftmenu_bottom"></div>
                    </div></td>
                 </tr>
            </tbody>
        </table>
        <%}else{%>
        <%="Our Apologies"%>
        <%}%>
        <% if((pod != null) && (env != null)){
	
	        String filename = null;
	        String url =null;
	
	        if(pod.equals("iss") && env.equals("pro"))
	        {filename = "wecProdReport.xls";}
	
	        if(pod.equals("iss") && env.equals("qa"))
	        {filename = "wecQaReport.xls";}
	
	        if(pod.equals("iss") && env.equals("dev"))
	        {filename = "wecDevReport.xls";}
	
	        url = "http://lendev44.leni2.com:8080/Info/reports/"+filename;
	            %>
	            <font size="3" color="white" style="padding-left:380px;">
	            <b>File Have Been Generated</b></font><br>
	            <a href=<%=url%>><font size="3" color="blue" style="padding-left:390px;">Click Here to Download</font></a>
	            
	            <%
        }%>
   </div>
</body>
</html>
