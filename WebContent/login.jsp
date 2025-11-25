<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Login</title>
    <link rel="stylesheet" href="css/styles.css" />
</head>
<body>
<header>
    <nav>
        <a href="<c:url value='/index.jsp'/>">Home</a>
        <a href="<c:url value='/recipes'/>">Recipes</a>
        <a href="<c:url value='/register.jsp'/>">Register</a>
    </nav>
</header>
<div class="container">
    <h2>Log In</h2>
    <c:if test="${param.registered eq 'true'}">
        <p class="success">Registration successful. Please log in.</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <form method="post" action="<c:url value='/login'/>">
        <label>Email</label>
        <input type="email" name="email" required />

        <label>Password</label>
        <input type="password" name="password" required />

        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
