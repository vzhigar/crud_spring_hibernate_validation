<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href=""></a>
<h1>Book list</h1>
<c:if test="${not empty listBooks}">
    <table>
        <tr>
            <th>ID</th>
            <th>TITLE</th>
            <th>AUTHOR</th>
            <th>PRICE</th>
            <th>EDIT</th>
            <th>DELETE</th>
        </tr>
        <c:forEach items="${listBooks}" var="book">
            <tr>
                <td>${book.id}</td>
                <td><a href="/bookdata/${book.id}" target="_blank">${book.bookTitle}</a></td>
                <td>${book.bookAuthor}</td>
                <td>${book.price/100}</td>
                <td><a href="<c:url value="/edit/${book.id}"/>">Edit</a></td>
                <td><a href="<c:url value="/remove/${book.id}"/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<h1>Add book</h1>
<c:url value="/books/add" var="addAction"/>
<form:form action="${addAction}" modelAttribute="book">
    <table>
        <c:if test="${not empty book.bookTitle}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="bookTitle">
                    <spring:message text="Title"/>
                </form:label>
            </td>
            <td><form:input path="bookTitle"/></td>
            <td><form:errors path="bookTitle"/></td>
        </tr>
        <tr>
            <td>
                <form:label path="bookAuthor">
                    <spring:message text="Author"/>
                </form:label>
            </td>
            <td><form:input path="bookAuthor"/></td>
            <td><form:errors path="bookAuthor"/></td>
        </tr>
        <tr>
            <td>
                <form:label path="price">
                    <spring:message text="Price (cents)"/>
                </form:label>
            </td>
            <td><form:input path="price"/></td>
            <td><form:errors path="price"/></td>
        </tr>
        <tr>
            <td colspan="2">
                <c:if test="${not empty book.bookTitle}">
                    <input type="submit" value="<spring:message text="Edit book"/>">
                </c:if>
                <c:if test="${empty book.bookTitle}">
                    <input type="submit" value="<spring:message text="Add book"/>">
                </c:if>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
