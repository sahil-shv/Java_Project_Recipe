package servlet;

import dao.RecipeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Recipe;

import java.io.IOException;
import java.util.List;

public class RecipeListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final RecipeDAO recipeDAO = new RecipeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Recipe> recipes = recipeDAO.getAllRecipes();
        req.setAttribute("recipes", recipes);
        req.getRequestDispatcher("/recipes.jsp").forward(req, resp);
    }
}
