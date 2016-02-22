<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Booking</title>
<script language="javascript" type="text/javascript">
     function validate(){
        var fld = document.stu.s1;
        if(fld.value=="")
            {
            alert("Field empty.\nEnter value for focused field. "+fld.value);
            fld.focus();
            return false;
            }
         else
             return true;
     }
</script>
</head>

<body>
    <%@page import="java.io.*" %>
    <%!String status = "";%>
    <%
        String project = request.getParameter("p");
    	String env = request.getParameter("e");
    	String machine = request.getParameter("m");
        String instance = request.getParameter("i");
        String insPath = "//"+machine+".leni2.com/d$/jda/"+instance+"/properties";

        String statusFilePath = insPath+"/status.txt";
        String booking = null;
        int n = 0;

        if(request.getParameter("sr")!=null && request.getParameter("add").equals("Add"))
        {


            String envline = request.getParameter("tel");
            String title = request.getParameter("title");
            String owner = request.getParameter("owner");
            String sd = request.getParameter("sd");
            String sm = request.getParameter("sm");
            String sy = request.getParameter("sy");
            String sDate = sd+"/"+sm+"/"+sy;
            String ed = request.getParameter("ed");
            String em = request.getParameter("em");
            String ey = request.getParameter("ey");
            String eDate = ed+"/"+em+"/"+ey;
            String sysrqu = request.getParameter("sr");

            booking = envline+":"+title+":"+owner+":"+sDate+":"+eDate+":"+sysrqu;


        try{

    	File ft = new File(statusFilePath);

        if(ft.exists()){
                Writer outputt;
                outputt = new BufferedWriter(new FileWriter(ft));
                outputt.append(booking);
                status = "You Have Booked Slot!";
                n = 1;
                outputt.close();
            }
        else
            {
                ft.createNewFile();
                Writer outputc;
                outputc = new BufferedWriter(new FileWriter(ft));
                outputc.append(booking);
                status = "You Have Booked Slot!";
                n = 1;
                outputc.close();
            }
        }

        catch(FileNotFoundException fe)
         {
            %><%="New File Creation Error !"%><%
          }
        }


    %>
<div id="container">
		<div id="header">
        	<h1>Book<span class="off">Env</span></h1>
            <h2>Book Your Instance Here For Release.</h2>
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

  		<div id="content">
            <div id="content_top"></div>
            <div id="content_main">
             <%if(n == 0){%>
            <form name="stu" action="status.jsp" method="post">
            <br><h4>Book Your Slot Here...</h4><hr><br>
                <table>
                    <tr>
                        <td>Test environment Line </td>
                        <td> <select name="tel">
                             <option>Release</option>
                             <option>Olympus</option>
                             <option>Service pack</option>
                             </select>
                        </td>
                   </tr>
                   <tr>
                        <td>Title</td>
                        <td><input type="text" name="title" value="" size="20" /></td>
                   </tr>
                   <tr>
                        <td>Owner</td>
                        <td><input type="text" name="owner" value="" size="20" /></td>
                   </tr>
                   <tr>
                        <td>Start Date</td>
                        <td>
                            <select name="sm">
                            <%for(int sm=1;sm<=12;sm++){ %>
                            <option><%=sm%></option>
                            <%}%>
                            </select>
                            <select name="sd">
                            <%for(int sd=1;sd<=31;sd++){ %>
                            <option><%=sd%></option>
                            <%}%>
                            </select>
                            <select name="sy">
                            <%for(int sy=2010;sy<=2050;sy++){ %>
                            <option><%=sy%></option>
                            <%}%>
                            </select></td>
                    </tr>
                    <tr>
                        <td>End Date</td>
                        <td>
                            <select name="em">
                            <%for(int em=1;em<=12;em++){ %>
                            <option><%=em%></option>
                            <%}%>
                            </select>
                            <select name="ed">
                            <%for(int ed=1;ed<=31;ed++){ %>
                            <option><%=ed%></option>
                            <%}%>
                            </select>
                            <select name="ey">
                            <%for(int ey=2010;ey<=2050;ey++){ %>
                            <option><%=ey%></option>
                            <%}%>
                            </select></td>
                     </tr>
                     <tr>
                            <td>System Requirements</td>
                            <td><input type="text" name="sr" value="" size="20" /></td>
                     </tr>
            <input type="hidden" name="p" value="<%=project %>" />
            <input type="hidden" name="e" value="<%=env %>" />
            <input type="hidden" name="m" value="<%=machine %>" />
            <input type="hidden" name="i" value="<%=instance %>" />
            <tr>
                <td colspan="2"><input type="submit" value="Add" name="add"/></td>
            </tr>
            </table>
            <hr><br>
            </form>
            <%}if(n == 1){%>
	        <%=status %> Go <a href="detail.jsp?p=<%=project%>&e=<%=env%>&m=<%=machine%>&i=<%=instance%>">Back</a> To Check.
            <%}%>
            </div>
            <div id="content_bottom"></div>
       </div>

</div>
</body>
</html>
