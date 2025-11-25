<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Recipe Details</title>
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
    <c:if test="${empty recipe}">
        <p>Recipe not found.</p>
    </c:if>
    <c:if test="${not empty recipe}">
        <h2>${recipe.title}</h2>
        <p>By ${recipe.author.name}</p>
        <c:if test="${not empty recipe.image}">
            <img src="${recipe.image}" alt="${recipe.title}" style="max-width: 100%; height: auto;" />
        </c:if>
        <h3>Ingredients</h3>
        <p class="multiline">${recipe.ingredients}</p>
        <h3>Steps</h3>
        <p class="multiline">${recipe.steps}</p>

        <section>
            <h3>Comments</h3>
            <c:choose>
                <c:when test="${param.error == 'emptyComment'}">
                    <p class="error">Comment cannot be empty.</p>
                </c:when>
                <c:when test="${param.error == 'commentFailed'}">
                    <p class="error">Unable to save your comment. Please try again.</p>
                </c:when>
            </c:choose>
            <c:if test="${empty comments}">
                <p>No comments yet.</p>
            </c:if>
            <c:forEach var="comment" items="${comments}">
                <div class="comment">
                    <p>${comment.commentText}</p>
                    <small>By ${comment.commenter.name}</small>
                </div>
            </c:forEach>
        </section>

        <c:if test="${not empty sessionScope.currentUser}">
            <section>
                <h4>Add a Comment</h4>
                <form method="post" action="<c:url value='/addComment'/>">
                    <input type="hidden" name="recipeId" value="${recipe.id}" />
                    <textarea name="comment" rows="3" required></textarea>
                    <button type="submit">Comment</button>
                </form>
            </section>
        </c:if>
        <c:if test="${empty sessionScope.currentUser}">
            <p><a href="<c:url value='/login.jsp'/>">Log in</a> to comment.</p>
        </c:if>
    </c:if>
</div>
</body>
</html>
