<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.OutputStream"%>
<%@page import="com.ignou.vcs.chartGenerators.JFreeBarChartGenerator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ignou.vcs.exams.beans.StudentExamBean"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ignou.vcs.commons.beans.UserBean"%>
<%@page
	import="com.ignou.vcs.commons.database.CommonsDatabaseActivities"%>

<%@page import="java.io.PrintWriter"%><html:html>
<head>
<script type="text/javascript" language="javascript">  function loadCss() { 	
	var browser = navigator.appName.toLowerCase(); 	
	// document.write(browser); 	
	var stylesheet = document.getElementById("pagestyle"); 	
	var menusheet = document.getElementById("menustyle"); 	
	if(browser.indexOf("microsoft internet explorer") != -1) 
	{ 		
		stylesheet.href="${pageContext.request.contextPath}/theme/css/style_ie.css"; 		
		menusheet.href="${pageContext.request.contextPath}/theme/css/menu_ie.css"; 	
		} 	
	else 
	{ 		
		stylesheet.href="${pageContext.request.contextPath}/theme/css/style1.css"; 		
		menusheet.href="${pageContext.request.contextPath}/theme/css/menu.css";		 	
		} 
	} 
	</script>
<link id="pagestyle" type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/theme/css/style1.css" />
<link id="menustyle" type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/theme/css/menu.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/theme/js/transmenu_Packed.js"></script>
<!-- LightBox css and scripts -->
<%
	String usid = (String) request.getSession().getAttribute(
				"userId");
		if (usid != null) {
%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/theme/css/lightbox_vid.css"
	media="screen,projection" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/theme/js/prototype.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/theme/js/lightbox.js"></script>
<%
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="GENERATOR" content="Rational Application Developer">
<title>Virtual Classroom System</title>
</head>
<body onLoad="javascript:window.history.forward(1);javascript:loadCss()">
	<%@include file="../../header.jsp"%>
	<div class="left">
		<div class="left_articles">
			<div class="buttons"></div>
			<%@include file="../../DisplayCalendar.jsp"%>
			<h2>
				<a href="#"><u>Virtual Classroom System</u></a>
			</h2>
			<p class="description">Studying the e-way.</p>
			<%
				String secured = (String) session.getAttribute("MarksSecured");
				String total = (String) session.getAttribute("TotalMarks");
				String per = (String) session.getAttribute("Percentage");
				StudentExamBean seb = (StudentExamBean) session.getAttribute("StudentExam");
				
				int marksSecured = Integer.parseInt(secured);
				int totalMarks = Integer.parseInt(total);
				int percentage = Integer.parseInt(per);
				
				String result = "";
				
				if(seb!=null)
				{
					int passMarks = seb.getPassMarks();
					if(marksSecured>=passMarks)
					{
						result= "PASS";
					}
					else
					{
						result="FAIL";
					}
					%>
					<table>
						<tr><td>Exam Id</td><td></td><td><%=seb.getExamId() %></td></tr>
						<tr><td>Exam Name</td><td></td><td><%=seb.getExamName() %></td></tr>		
						<tr><td>Course Name</td><td></td><td><%=seb.getCourseName() %></td></tr>
						<tr><td>Subject Name</td><td></td><td><%=seb.getSubjectName() %></td></tr>
						<tr><td>Exam Duration</td><td></td><td><%=seb.getDuration() %> Minute(s).</td></tr>
					</table>
					<br>
					<hr>
					<br>
					<table>
						<tr><td>Maximum Marks</td><td></td><td><%=seb.getMaxMarks() %></td></tr>
						<tr><td>Passing Marks</td><td></td><td><%=seb.getPassMarks() %></td></tr>
						<tr><td>Your Marks</td><td></td><td><%=marksSecured %> and <%=percentage %>%</td></tr>
						<tr><td>Result</td><td></td>
						<td><%
							if(result.equalsIgnoreCase("fail"))
							{
								out.println("<b><font color='red'>Fail</font></b>");
							}else
							{
								out.println("<b><font color='green'>Pass</font></b>");
							}
						%></td></tr>
						<tr><td colspan="3">
						</td></tr>
						<tr><td colspan="3" align="center">
						<%
							String comment = "";
						
							if (percentage >= 35 && percentage <= 59) 
							{ 		
								comment = "Congratulations"; 	
							} 
							else if (percentage >= 60 && percentage <= 69) 
							{ 		
								comment = "Congratulations. Your marks are GOOD"; 	
							} else if (percentage >= 70 && percentage <= 79) 
							{ 		
								comment = "Congratulations. Your marks are VERY GOOD"; 		
							} 
							else if (percentage >= 80) 
							{ 		
								comment = "Congratulations. Your marks are EXCELLENT"; 	
							}
							else
							{
								comment = "Better luck next time."; 	
							}
							
							if(percentage>=35)
							{
								out.println("<b><font color='green'>"+comment+"</font></b>");	
							}else
							{
								out.println("<b><font color='red'>"+comment+"</font></b>");
							}
							
							String chartPath = "ResultsChart.jsp?e="+seb.getExamId()+"&t="+totalMarks+"&p="+passMarks+"&m="+marksSecured;
						%>
						</td></tr>
						<tr><td colspan="3">
						<img src="<%=chartPath %>" alt="<%=seb.getExamName() %>'s Result">
						</td></tr>
					</table>
					<%
				}
			%>
		</div>
		
		<%@include file="../../footer.jsp"%>
	</div>
</body>
</html:html>
