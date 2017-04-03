<%-- 
    Document   : cursos
    Created on : Mar 14, 2017, 9:27:04 PM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Carrera"%>
<%@page import="LogicaNegocio.Ciclo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : ciclos
    Created on : Mar 14, 2017, 10:27:55 AM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Curso"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Cursos</title>
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
        <script src="js/cursos.js"></script>
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
                            <form action="cursoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el nombre a buscar" name="nombre" required="" id="nombre" />
                                    <input type='hidden' name='data' value='bNombre' />
                                </div>
                                <div class="modal-footer ">
                                    <input class="btn btn-primary" type="submit" value="Enviar" />
                                    <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modalCarrera" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por Carrera</h3>
                        </div>
                        <div class="modal-body">
                            <form action="cursoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo de la carrera" name="carrera" required="" id="carrera" />
                                    <input type='hidden' name='data' value='bCarrera' />
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
                            <form action="cursoServlet" method="post">
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
            <div class="modal fade" id="addCurso" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo curso</h3>
                        </div>
                        <div class="modal-body">
                            <form action="cursoServlet" method="post">
                                <ul>
                                    <input  type="text" placeholder="Codigo del curso" name="codigo" required="" id="codigo" />
                                    <input  type="text" placeholder="Nombre del curso" name="nombre" required="" id="nombre" />
                                    <input  type="number" min="2" max="5" placeholder="Creditos" name="creditos" required="" id="creditos" />
                                    <input  type="number" min="4" max="8" placeholder="Horas Semanales" name="horas" required="" id="horas" />
                                    <input  type="text" placeholder="Codigo de carrera" name="carrera" required="" id="carrera" />
                                    <input  type="number" min="2017" max="2020" placeholder="Año del ciclo" name="aCiclo" required="" id="aCiclo" />
                                    <input  type="number" min="1" max="2" placeholder="Numero del ciclo" name="nCiclo" required="" id="nCiclo" />
                                    <input  type='hidden' name='data' value='addCurso' />
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
                            <h3>Editar un curso</h3>
                        </div>
                        <div class="modal-body">
                            <form action="cursoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo del curso" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eCurso' />
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

            <%                Curso c = (Curso) request.getAttribute("curso");
                if (c != null) {
                    Ciclo ci = (Ciclo)request.getAttribute("ciclo");
                    Carrera ca = (Carrera)request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='editCurso' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar curso</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='cursoServlet' method='post'>"
                            + "<ul>"
                            +"<input type='text' name='codigo' readonly id='codigo' value='"+c.getCodigo()+"' />"
                            +"<input type='text' placeholder='Nombre del curso' name='nombre' required='' id='nombre' value='"+c.getNombre()+"' />"
                            +"<input type='number' min='2' max='5' name='creditos' required='' id='creditos' value="+c.getCreditos()+" />"
                            +"<input type='number' min='4' max='8' name='horas' required='' id='horas' value="+c.getHorasSemanles()+" />"
                            +"<input type='text' name='carrera' required='' id='carrera' value="+ca.getCodigo()+" />" 
                            +"<input type='number' min='2017' max='2020' name='aCiclo' required='' id='aCiclo' value='"+ci.getAnyo()+"'/>"
                            +"<input type='number' min='1' max='2' name='nCiclo' required='' id='nCiclo' value='"+ci.getNumero()+"'/>"
                            +"<input  type='hidden' name='data' value='mCurso' />"
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
                            + "$('#editCurso').modal('show'); </script>");
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
                    <h2>Mantenimiento de Cursos</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <li><a href="#" id="busquedaNombre" class="button special">Busqueda por nombre</a></li>
                                <li><a href="#" id="busquedaCodigo" class="button special">Busqueda por código</a></li>
                                <li><a href="#" id='busquedaCarrera' class="button special">Busqueda por carrera</a></li>
                                <li><a href="#" id='editarCurso' class="button special">Editar un curso</a></li>
                                <li><a href="#" id='agregarCurso' class="button special">Agregar un curso</a></li>
                            </ul>
                        </section>
                        <section>
                            <%                        ArrayList<Curso> list = (ArrayList<Curso>) request.getAttribute("lCurso");
                                if (list != null) {
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Codigo</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Creditos</th>");
                                    out.println("<th>Horas Semanales</th>");
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