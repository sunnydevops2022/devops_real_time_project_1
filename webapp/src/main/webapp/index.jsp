<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <h1>Welcome to my page!</h1>
    <p>Here are some random numbers:</p>
    <ul>
      <c:forEach var="i" begin="1" end="10">
        <li><c:out value="${i}" /></li>
      </c:forEach>
    </ul>
  </body>
</html>
