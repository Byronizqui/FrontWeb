<%-- 
    Document   : carreras
    Created on : Mar 14, 2017, 11:00:07 PM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Carrera"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Carreras</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dropotron.min.js"></script>
        <script src="js/jquery.scrollgress.min.js"></script>
        <script src="js/jquery.scrolly.min.js"></script>
        <script src="js/jquery.slidertron.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        <script src="js/carreras.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
        <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
        <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    </head>
    <body>

        <!-- Header -->
        <header id="header" class="skel-layers-fixed">
            <%@ include file="jspf/inicio.jspf" %>
        </header>
        <div class="container">
            <!-- Modal -->
            <div class="modal fade" id="modalNombre" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por nombre</h3>
                        </div>
                        <div class="modal-body">
                            <form action="carreraServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el nombre a buscar" name="nombre" required="" id="nombre" />
                                    <input type='hidden' name='data' value='bNombre' />
                                </div>
                                <div class="modal-footer">
                                    <input class="btn btn-primary" type="submit" value="Enviar" />
                                    <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalCodigo" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por codigo</h3>
                        </div>
                        <div class="modal-body">
                            <form action="carreraServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo a buscar" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='bCodigo' />
                                </div>
                                <div class="modal-footer">
                                    <input class="btn btn-primary" type="submit" value="Enviar" />
                                    <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="addCarrera" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de una nueva carrera</h3>
                        </div>
                        <div class="modal-body">
                            <form action="carreraServlet" method="post">
                                <ul>
                                    <input  type="text" placeholder="Codigo de la carrera" name="codigo" required="" id="codigo" />
                                    <input  type="text" placeholder="Nombre de la carrera" name="nombre" required="" id="nombre" />
                                    <input  type="text" placeholder="Titulo de la carrerao" name="titulo" required="" id="titulo" />
                                    <input  type='hidden' name='data' value='nCarrera' />
                                </ul>
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-primary" type="submit" value="Enviar" />
                            <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                        </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modalEdit" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Editar una carrera</h3>
                        </div>
                        <div class="modal-body">
                            <form action="carreraServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo de la carrera" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eCarrera' />
                                </div>
                                <div class="modal-footer">
                                    <input class="btn btn-primary" type="submit" value="Enviar" />
                                    <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <%                Carrera c = (Carrera) request.getAttribute("carrera");
                if (c != null) {
                    out.println("<div class='modal fade' id='editCarrera' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar carrera</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='carreraServlet' method='post'>"
                            + "<ul>"
                            + "<input  type='text' name='id' required='' id='id' value='" + c.getId() + "' readonly/>"
                            + "<input  type='text' name='codigo' required='' id='codigo' value='" + c.getCodigo() + "' readonly/>"
                            + "<input  type='text' name='nombre' required='' id='nombre' value='" + c.getNombre() + "'/>"
                            + "<input  type='text' name='titulo' required='' id='titulo' value='" + c.getTitulo() + "'/>"
                            + "<input  type='hidden' name='data' value='mCarrera' />"
                            + "</ul>"
                            + "</div>"
                            + "<div class='modal-footer'>"
                            + "<input class='btn btn-primary' type='submit' value='Enviar' />"
                            + "<input class='btn btn-secondary' data-dismiss='modal' type='button' value='Close' />"
                            + "</div>"
                            + "</form>"
                            + "</div>"
                            + "</div>"
                            + "</div>"
                            + "</div>");
                    out.println("<script> "
                            + "$('#editCarrera').modal('show'); </script>");
                }

            %>
            <!-- Main -->
            <section id="main" class="wrapper style1">
                <% String m = (String) request.getAttribute("message");
                    if (m != null) {
                        out.println("<div class='modal fade' id='modalMessage' style='margin-top: 30px'>"
                                + "<div class='modal-dialog' role='document'>"
                                + "<div class='modal-content'>"
                                + "<div class='modal-header'>"
                                + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                                + "<span aria-hidden='true'>&times;</span>"
                                + "</button>"
                                + "<h3>" + m + "</h3>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "</div>"
                                + "<script>"
                                + "$('#modalMessage').modal('show');"
                                + "setTimeout(function () {"
                                + "$('#modalMessage').modal('hide');"
                                + "}, 2000);"
                                + "</script>");
                    }
                %>
                <header class="major">
                    <h2>Mantenimiento de Carreras</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <li><a href="#" id="busquedaNombre" class="button special">Busqueda por nombre</a></li>
                                <li><a href="#" id="busquedaCodigo" class="button special">Busqueda por código</a></li>
                                <li><a href="#" id='nuevaCarrera' class="button special">Ingresar una nueva carrera</a></li>
                                <li><a href="#" id='editarCarrera' class="button special">Editar una carrera</a></li>
                            </ul>

                        </section>
                        <section>
                            <%                        ArrayList<Carrera> list = (ArrayList<Carrera>) request.getAttribute("lCarrera");
                                if (list != null) {
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Codigo</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Título</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");

                                    for (Carrera category : list) {
                                        out.println("<tr>");
                                        out.println("<td>" + category.getCodigo() + "</td>");
                                        out.println("<td>" + category.getNombre() + "</td>");
                                        out.println("<td>" + category.getTitulo() + "</td>");
                                        out.println("</tr>");
                                    }

                                    out.println("</tbody>");
                                    out.println("</table>");
                                    out.println("</div>");
                                }
                            %>
                        </section>
                </div>
            </section>

            <!-- Footer -->
            <footer id="footer">
                <span class="copyright">
                    <a>&copy; Copyright. Lab 1 - 2 Móviles</a>	                </span>
            </footer>

    </body>
</html>


