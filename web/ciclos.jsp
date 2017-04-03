<%-- 
    Document   : ciclos
    Created on : Mar 14, 2017, 10:27:55 AM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Curso"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Ciclos</title>
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
        <script src="js/ciclos.js"></script>
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
            <div class="modal fade" id="modalCiclos" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por año</h3>

                        </div>
                        <div class="modal-body">
                            <form action="cicloServlet" method="post">

                                <div>
                                    <input class='special' type="number" placeholder="Ingrese el año a buscar" name="anyo" required="" id="anyo" />
                                    <input type='hidden' name='data' value='bAnyo' />
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


            <div class="modal fade" id="addCiclo" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo ciclo</h3>
                        </div>
                        <div class="modal-body">
                            <form action="cicloServlet" method="post">
                                <ul>
                                    <div>
                                        <input  type="number" placeholder="Año del ciclo" name="anyo" required="" id="anyo" />
                                        <input  type="number" placeholder="Numero de ciclo" min='01' max ='02' name="numero" required="" id="numero" />
                                    </div>

                                    <div>
                                        <input  type="date" placeholder="Fecha de inicio" name="fIni" required="" id="fIni" />
                                        <input  type="date" placeholder="Fecha de fin" name="fFin" required="" id="fFin" />
                                    </div>
                                    <div>
                                        <input  type="checkbox" name="active" id="active" value="activo"> <label for="active">Activo</label> 
                                        <input  type='hidden' name='data' value='aAnyo' />
                                    </div>
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
        </div>

    </div>
    <!-- Main -->
    <section id="main" class="wrapper style1">
        <header class="major">
            <h2>Mantenimiento de Ciclos</h2>
        </header>
        <div class="container">

            <!-- Content -->
            <section id="content" class="">                    
                <!-- Lists -->
                <section>
                    <ul class="actions">
                        <li><a href="#" id="busqueda" class="button special">Busqueda por año</a></li>
                        <li><a href="#" id='nuevoCiclo' class="button special">Ingresar un nuevo ciclo</a></li>
                    </ul>

                </section>
                <section>
                    <%                        String m = (String) request.getAttribute("message");
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
                                    + "}, 3000);"
                                    + "</script>");
                        }
                        ArrayList<Curso> list = (ArrayList<Curso>) request.getAttribute("lCiclos");
                        if (list != null) {
                            out.println("<div class='table-wrapper'>");
                            out.println("<table>");
                            out.println("<thead>");
                            out.println("<tr>");
                            out.println("<th>Codigo</th>");
                            out.println("<th>Nombre</th>");
                            out.println("<th>Creditos</th>");
                            out.println("<th>HorasSemanales</th>");
                            out.println("</tr>");
                            out.println("</thead>");
                            out.println("<tbody>");
                            
                            for (Curso category : list) {
                                out.println("<tr>");
                                out.println("<td>" + category.getCodigo() + "</td>");
                                out.println("<td>" + category.getNombre() + "</td>");
                                out.println("<td>" + category.getCreditos() + "</td>");
                                out.println("<td>" + category.getHorasSemanles() + "</td>");
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
            <a>&copy; Copyright. Lab 1 - 2 Móviles</a>	
        </span>
    </footer>

</body>
</html>
