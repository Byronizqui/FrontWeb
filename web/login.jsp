<%-- 
    Document   : login
    Created on : Mar 14, 2017, 8:29:25 AM
    Author     : Byron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="css/styleLogin.css">
    </head>
    <body>
    <body>
        <div class="container">
            <section id="content">
                <form action="loginServlet" method="post">
                    <h1>Inicio de Sesión</h1>
                    <div>
                        <input type="text" placeholder="Nombre de usuario" name="usuario" required="" id="usuario" />
                    </div>
                    <div>
                        <input type="password" placeholder="Contraseña" name="contrasena" required="" id="contrasena" />
                        <input type='hidden' name='data' value='login'/>
                    </div>
                    <div>
                        <input type="submit" value="Iniciar Sesión" />
                    </div>
                </form><!-- form -->
            </section><!-- content -->
        </div><!-- container -->
    </body>

    <script src="js/index.js"></script>

</body>
</html>

