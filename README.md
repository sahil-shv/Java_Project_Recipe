# RecipeShare

RecipeShare is a JSP/Servlet-based recipe sharing platform that lets users create accounts, post recipes, and comment on others. The application follows a classic MVC structure using DAOs for data access and JDBC for persistence.

## Features
- User registration with SHA-256 password hashing, login, and logout
- Session-based access control so only authenticated users can add recipes or comment
- Recipe CRUD (create + read) with ingredient lists, steps, and optional image references
- Comment threads per recipe displayed chronologically
- JDBC + MySQL persistence with prepared statements and proper resource cleanup

## Project Structure
```
RecipeShare/
 src/
    model/        # POJOs for User, Recipe, Comment
    dao/          # DAO classes for database operations
    servlet/      # Servlets handling HTTP requests
    util/         # Helper utilities (DB connection, password hashing)
 WebContent/       # JSP views, static assets
    css/
    images/
 WEB-INF/
    web.xml       # Servlet mappings
 database.sql      # Schema and seed data
 README.md
```

## Prerequisites
- JDK 11+
- Apache Tomcat 10+ (Jakarta namespace)
- MySQL 8+
- JSTL 1.2 JAR in `WEB-INF/lib`

## Setup
1. **Database**
   ```sql
   SOURCE database.sql;
   ```
   Update DB credentials in `src/util/DBConnection.java` if needed.

2. **Dependencies**
   - Place `jakarta.servlet-api.jar` (provided by container) and `jakarta.servlet.jsp.jstl-2.0.0.jar` into `WEB-INF/lib` if your server does not supply them.

3. **Deploy**
   - Import the project into your IDE as a Dynamic Web Project.
   - Configure Tomcat, ensuring the project web root points to `WebContent`.
   - Start the server and navigate to `http://localhost:8080/RecipeShare`.

## Usage Flow
1. Register a new account.
2. Log in; session stores `currentUser`.
3. Add recipes via `/addRecipe`.
4. Browse `/recipes`, open individual recipes, read details and comments.
5. Authenticated users can post comments through `/addComment`.
6. Logout clears the session.

## Security Notes
- Passwords are hashed using SHA-256 before storage.
- Prepared statements prevent SQL injection.
- Session validation is performed on sensitive servlet actions.

## Testing Checklist
- Register/login/logout flow
- Add recipe and ensure it appears on `recipes.jsp`
- View recipe details and submit comments
- Try posting without authentication to verify redirects

Enjoy sharing recipes!
