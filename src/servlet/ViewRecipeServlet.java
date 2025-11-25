package servlet;

import dao.CommentDAO;
import dao.RecipeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Comment;
import model.Recipe;

import java.io.IOException;
import java.util.List;

public class ViewRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final RecipeDAO recipeDAO = new RecipeDAO();
    private final CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(withContext(req, "/recipes"));
            return;
        }

        try {
            int recipeId = Integer.parseInt(idParam);
            Recipe recipe = recipeDAO.getRecipeById(recipeId);
            if (recipe == null) {
                resp.sendRedirect(withContext(req, "/recipes?notfound=true"));
                return;
            }
            List<Comment> comments = commentDAO.getCommentsByRecipeId(recipeId);
            req.setAttribute("recipe", recipe);
            req.setAttribute("comments", comments);
            req.getRequestDispatcher("/viewRecipe.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(withContext(req, "/recipes"));
        }
    }

    private String withContext(HttpServletRequest req, String path) {
        return req.getContextPath() + path;
    }
}
