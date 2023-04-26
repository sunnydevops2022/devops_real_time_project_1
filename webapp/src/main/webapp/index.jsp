<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
  <head>
    <title>My Page</title>
    <style>
      body {
        background-color: #f2f2f2;
        font-family: Arial, sans-serif;
      }
      
      h1 {
        color: #333;
        text-align: center;
        margin-top: 50px;
      }
      
      p {
        font-size: 18px;
        color: #666;
        text-align: center;
        margin-top: 20px;
      }
      
      ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        text-align: center;
      }
      
      li {
        display: inline-block;
        margin: 10px;
        padding: 10px 20px;
        border-radius: 5px;
        background-color: #0077b3;
        color: #fff;
        text-transform: uppercase;
        font-weight: bold;
        font-size: 14px;
        text-decoration: none;
        transition: all 0.3s ease;
      }
      
      li:hover {
        background-color: #004c7f;
      }
    </style>
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
