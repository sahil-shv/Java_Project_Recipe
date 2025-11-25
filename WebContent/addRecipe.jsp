<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecipeShare | Add Recipe</title>
    <link rel="stylesheet" href="css/styles.css" />
</head>
<body>
<header>
    <nav>
        <a href="<c:url value='/index.jsp'/>">Home</a>
        <a href="<c:url value='/recipes'/>">Recipes</a>
        <a href="<c:url value='/logout'/>">Logout</a>
    </nav>
</header>
<div class="container">
    <h2>Share a New Recipe</h2>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <form method="post" action="<c:url value='/addRecipe'/>">
        <label>Title</label>
        <input type="text" name="title" required />

        <label>Ingredients</label>
        <textarea name="ingredients" rows="4" required></textarea>

        <label>Steps</label>
        <textarea name="steps" rows="6" required></textarea>

        <label>Image URL (optional)</label>
        <input type="text" name="image" />

        <button type="submit">Post Recipe</button>
    </form>
</div>
</body>
</html>
