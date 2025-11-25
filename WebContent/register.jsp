<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Register</title>
    <link rel="stylesheet" href="css/styles.css" />
</head>
<body>
<header>
    <nav>
        <a href="<c:url value='/index.jsp'/>">Home</a>
        <a href="<c:url value='/recipes'/>">Recipes</a>
        <a href="<c:url value='/login.jsp'/>">Login</a>
    </nav>
</header>
<div class="container">
    <h2>Create Account</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <form method="post" action="<c:url value='/register'/>">
        <label>Name</label>
        <input type="text" name="name" required />

        <label>Email</label>
        <input type="email" name="email" required />

        <label>Password</label>
        <input type="password" name="password" required />

        <button type="submit">Register</button>
    </form>
</div>
</body>
</html>
