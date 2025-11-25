<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Home</title>
    <link rel="stylesheet" href="css/styles.css" />
</head>
<body>
<header>
    <nav>
        <a href="<c:url value='/index.jsp'/>">Home</a>
        <a href="<c:url value='/recipes'/>">Recipes</a>
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <a href="<c:url value='/addRecipe'/>">Add Recipe</a>
                <a href="<c:url value='/logout'/>">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login.jsp'/>">Login</a>
                <a href="<c:url value='/register.jsp'/>">Register</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
<div class="container">
    <h1>Welcome to RecipeShare</h1>
    <p>Share your favorite dishes, discover new flavors, and connect with food lovers everywhere.</p>
    <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
            <p>Ready to post something new?</p>
            <a class="btn" href="<c:url value='/addRecipe'/>">Share a Recipe</a>
        </c:when>
        <c:otherwise>
            <p>Create a free account to start sharing your recipes with the community.</p>
            <a class="btn" href="<c:url value='/register.jsp'/>">Join Now</a>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
