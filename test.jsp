<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>ServerInfo | Instances</title>
</head>

<body>

<div id="container">
		<div id="header">
        	<h1>Instance<span class="off">Info</span></h1>
            <h2>Get All The Instances For Production.</h2>
        </div>

        <%@page import="java.io.*,org.w3c.dom.*,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.xml.sax.SAXException,org.xml.sax.SAXParseException" %>
        <%
        try {

            String configFilePath = "C:/Users/j1012484/Desktop/Configs/ProdDom/config.xml";

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
        %><table border="1"><%
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
                <tr>
                    <td><%=machineName %>.leni2.com</td>
		                        <td><%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_1") %></td>
		                        <td><%=gr.getValueForKey(issInstallPath, "I2_WEBLOGIC_ADMIN_2") %></td>
		                        <td><%=gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_4") %></td>>
                    <td><%=gr.getValueForKey(issInstallPath,"I2_BPE_JDBC_1") %></td>
                </tr>
                <%
                }// end of inner if clause

                }//end of outer if clause


           }//end of for loop with s var
            %></table><%

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
