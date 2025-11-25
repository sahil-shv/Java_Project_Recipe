package servlet;

import dao.RecipeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Recipe;
import model.User;

import java.io.IOException;

public class AddRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final RecipeDAO recipeDAO = new RecipeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = getAuthenticatedUser(req.getSession(false));
        if (currentUser == null) {
            resp.sendRedirect(withContext(req, "/login.jsp?redirect=addRecipe"));
            return;
        }
        req.getRequestDispatcher("/addRecipe.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = getAuthenticatedUser(session);
        if (currentUser == null) {
            resp.sendRedirect(withContext(req, "/login.jsp"));
            return;
        }

        String title = req.getParameter("title");
        String ingredients = req.getParameter("ingredients");
        String steps = req.getParameter("steps");
        String image = req.getParameter("image");

        if (isBlank(title) || isBlank(ingredients) || isBlank(steps)) {
            req.setAttribute("error", "Title, ingredients, and steps are required.");
            req.getRequestDispatcher("/addRecipe.jsp").forward(req, resp);
            return;
        }

        Recipe recipe = new Recipe();
        recipe.setTitle(title.trim());
        recipe.setIngredients(ingredients.trim());
        recipe.setSteps(steps.trim());
        recipe.setImage(isBlank(image) ? null : image.trim());
        recipe.setUserId(currentUser.getId());

        boolean success = recipeDAO.addRecipe(recipe);
        if (success) {
            resp.sendRedirect(withContext(req, "/recipes"));
        } else {
            req.setAttribute("error", "Unable to save recipe. Please try again.");
            req.getRequestDispatcher("/addRecipe.jsp").forward(req, resp);
        }
    }

    private User getAuthenticatedUser(HttpSession session) {
        if (session == null) {
            return null;
        }
        Object userObj = session.getAttribute("currentUser");
        if (userObj instanceof User) {
            return (User) userObj;
        }
        return null;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String withContext(HttpServletRequest req, String path) {
        return req.getContextPath() + path;
    }
}
