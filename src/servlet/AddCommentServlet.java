package servlet;

import dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Comment;
import model.User;

import java.io.IOException;

public class AddCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = null;
        if (session != null) {
            Object userObject = session.getAttribute("currentUser");
            if (userObject instanceof User) {
                currentUser = (User) userObject;
            }
        }
        String recipeIdParam = req.getParameter("recipeId");
        String commentText = req.getParameter("comment");

        if (recipeIdParam == null) {
            resp.sendRedirect(withContext(req, "/recipes"));
            return;
        }

        int recipeId;
        try {
            recipeId = Integer.parseInt(recipeIdParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(withContext(req, "/recipes"));
            return;
        }

        if (currentUser == null) {
            resp.sendRedirect(withContext(req, "/login.jsp"));
            return;
        }

        if (commentText == null || commentText.trim().isEmpty()) {
            resp.sendRedirect(withContext(req, "/viewRecipe?id=" + recipeId + "&error=emptyComment"));
            return;
        }

        Comment comment = new Comment();
        comment.setRecipeId(recipeId);
        comment.setUserId(currentUser.getId());
        comment.setCommentText(commentText.trim());
        boolean saved = commentDAO.addComment(comment);
        if (saved) {
            resp.sendRedirect(withContext(req, "/viewRecipe?id=" + recipeId));
        } else {
            resp.sendRedirect(withContext(req, "/viewRecipe?id=" + recipeId + "&error=commentFailed"));
        }
    }

    private String withContext(HttpServletRequest req, String path) {
        return req.getContextPath() + path;
    }
}
