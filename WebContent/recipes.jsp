<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Recipes</title>
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
    <h2>Community Recipes</h2>
    <c:if test="${empty recipes}">
        <p>No recipes posted yet. Be the first to share!</p>
    </c:if>
    <c:forEach var="recipe" items="${recipes}">
        <div class="recipe-card">
            <h3>${recipe.title}</h3>
            <p>By ${recipe.author.name}</p>
            <c:if test="${not empty recipe.image}">
                <img src="${recipe.image}" alt="${recipe.title}" style="max-width: 100%; height: auto;" />
            </c:if>
            <p><strong>Ingredients:</strong></p>
            <p class="multiline">${recipe.ingredients}</p>
            <p><strong>Steps:</strong></p>
            <p class="multiline">${recipe.steps}</p>
            <c:url var="viewUrl" value="/viewRecipe">
                <c:param name="id" value="${recipe.id}" />
            </c:url>
            <a class="btn" href="${viewUrl}">View Details</a>
        </div>
    </c:forEach>
</div>
</body>
</html>
