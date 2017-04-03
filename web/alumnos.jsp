<%-- 
    Document   : alumnos
    Created on : Mar 16, 2017, 12:58:20 PM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Curso"%>
<%@page import="LogicaNegocio.Nota"%>
<%@page import="LogicaNegocio.Carrera"%>
<%@page import="LogicaNegocio.Alumno"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LogicaNegocio.Profesor"%>
<%@page import="LogicaNegocio.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alumnos</title>
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dropotron.min.js"></script>
        <script src="js/jquery.scrollgress.min.js"></script>
        <script src="js/jquery.scrolly.min.js"></script>
        <script src="js/jquery.slidertron.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        <script src="js/alumnos.js"></script>
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
                            <form action="alumnoServlet" method="post">
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

            <div class="modal fade" id="modalMatricula" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Matricular un alumno</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Cedula del alumno" name="cedula" required="" id="cedula" />
                                    <input class='special' type="text" placeholder="Codigo del curso" name="codigoCurso" required="" id="codigoCurso" />
                                    <input class='special' type="number" min="1" max="8" placeholder="Numero de grupo" name="numeroGrupo" required="" id="numeroGrupo" />
                                    <input type='hidden' name='data' value='matricula' />
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

            <div class="modal fade" id="modalCedula" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por Cédula</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el numero de cedula" name="cedula" required="" id="cedula" />
                                    <input type='hidden' name='data' value='bCedula' />
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

            <div class="modal fade" id="modalCedulaHistorial" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda por Cédula</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el numero de cedula del alumno" name="cedula" required="" id="cedula" />
                                    <input type='hidden' name='data' value='bCedulaHistorial' />
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
                            <h3>Busqueda por Carrera</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo de la carrera" name="codigo" required="" id="codigo" />
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
            <div class="modal fade" id="addAlumno" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo alumno</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <ul>
                                    <input type='text' name='codigo' placeholder="Cedula"  id='codigo' />
                                    <input type='text' name='nombre' placeholder="Nombre" required='' id='nombre'/>
                                    <input type='text' name='clave' placeholder="Clave" required='' id='clave'/>
                                    <input type='text' name='email' placeholder="Email" required='' id='email'/>
                                    <input type='date' name='fecha' placeholder="Fecha de Nacimiento" required='' id='fecha'/>
                                    <input type='number' min='0' max='10' name='beca' placeholder='beca' required='' id='beca' />
                                    <input type='text' name='carrera' required='' placeholder='Codigo de la carrera' id='carrera' />
                                    <input  type='hidden' name='data' value='aAlumno' />
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
            <div class="modal fade" id="alumnoEdit" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Editar un Alumno</h3>
                        </div>
                        <div class="modal-body">
                            <form action="alumnoServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese la cedula del alumno" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eAlumno' />
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

            <%                Usuarios c = (Usuarios) request.getAttribute("eUser");
                if (c != null) {
                    Alumno p = (Alumno) request.getAttribute("eAlumno");
                    Carrera ca = (Carrera) request.getAttribute("eCarrera");
                    //Carrera ca = (Carrera)request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='editCurso' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar Alumno</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='alumnoServlet' method='post'>"
                            + "<ul>"
                            + "<input type='text' name='codigo' readonly id='codigo' value='" + c.getCedula() + "' />"
                            + "<input type='text' name='nombre' required='' placeholder='Nombre' id='nombre' value='" + c.getNombre() + "' />"
                            + "<input type='text' name='email' required=''placeholder='email' id='email' value=" + c.getEmail() + " />"
                            + "<input type='date' name='fecha' required='' placeholder='Fecha de nacimiento' id='fecha' value=" + c.getFechaNac() + " />"
                            + "<input type='number' min='0' max='10' name='beca' placeholder='beca' required='' id='beca' value='" + p.getBeca() + "' />"
                            + "<input type='text' name='carrera' required='' placeholder='Codigo de la carrera' id='carrera' value='" + ca.getCodigo() + "' />"
                            + "<input  type='hidden' name='idU' value='" + c.getId() + "' />"
                            + "<input  type='hidden' name='data' value='mAlumno' />"
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
                    <h2>Mantenimiento de Alumnos</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <% String ti = (String) session.getAttribute("tipo");
                                    if (ti == "1") {
                                        out.println("<li><a href='#' id='busquedaNombre' class='button special'>Busqueda por nombre</a></li>");
                                        out.println("<li><a href='#' id='busquedaCedula' class='button special'>Busqueda por cedula</a></li>");
                                        out.println("<li><a href='#' id='busquedaCarrera' class='button special'>Busqueda por carrera</a></li>");
                                        out.println("<li><a href='#' id='editarAlumno' class='button special'>Editar un Alumno</a></li>");
                                        out.println("<li><a href='#' id='agregarAlumno' class='button special'>Agregar un Alumno</a></li>");
                                        out.println("<li><a href='#' id='matricularAlumno' class='button special'>Matricular Alumno</a></li>");
                                        out.println("<li><a href='#' id='consultaHistorial' class='button special'>Consultar Historial</a></li>");
                                    }
                                    if (ti == "4") {
                                        out.println("<li><a href='#' id='matricularAlumno' class='button special'>Matricular Alumno</a></li>");
                                    }
                                    if (ti == "3") {
                                        out.println("<li><a href='/alumnoServlet?data=bCedulaHistorial&cedula=" + session.getAttribute("id") + "' class='button special'>Consultar Historial</a></li>");
                                    }
                                %>

                            </ul>
                        </section>
                        <section>
                            <%                        ArrayList<Usuarios> list = (ArrayList<Usuarios>) request.getAttribute("lUsers");
                                if (list != null) {
                                    ArrayList<Alumno> lP = (ArrayList<Alumno>) request.getAttribute("lAlumnos");
                                    ArrayList<Carrera> lC = (ArrayList<Carrera>) request.getAttribute("lCarrera");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Cedula</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Email</th>");
                                    out.println("<th>Nacimiento</th>");
                                    out.println("<th>Beca</th>");
                                    out.println("<th>Carrera</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");
                                    int i = 0;
                                    for (Usuarios category : list) {
                                        out.println("<tr>");
                                        out.println("<td>" + category.getCedula() + "</td>");
                                        out.println("<td>" + category.getNombre() + "</td>");
                                        out.println("<td>" + category.getEmail() + "</td>");
                                        out.println("<td>" + category.getFechaNac() + "</td>");
                                        out.println("<td>" + lP.get(i).getBeca() + "</td>");
                                        out.println("<td>" + lC.get(i).getNombre() + "</td>");
                                        out.println("</tr>");
                                        i++;
                                    }

                                    out.println("</tbody>");
                                    out.println("</table>");
                                    out.println("</div>");
                                }
                            %>
                        </section>

                        <section>
                            <%                        ArrayList<Nota> lN = (ArrayList<Nota>) request.getAttribute("hNotas");
                                if (lN != null) {
                                    ArrayList<Curso> lC = (ArrayList<Curso>) request.getAttribute("hCursos");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Curso</th>");
                                    out.println("<th>Nota</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");
                                    int i = 0;
                                    for (Nota category : lN) {
                                        out.println("<tr>");
                                        out.println("<td>" + lC.get(i).getNombre() + "</td>");
                                        out.println("<td>" + category.getNota() + "</td>");
                                        out.println("</tr>");
                                        i++;
                                    }

                                    out.println("</tbody>");
                                    out.println("</table>");
                                    out.println("</div>");
                                }
                            %>
                        </section>

                        <section>
                            <%                        Usuarios u = (Usuarios) request.getAttribute("usuarios");
                                if (u != null) {
                                    Alumno p = (Alumno) request.getAttribute("alumno");
                                    Carrera ca = (Carrera) request.getAttribute("carrera");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Cedula</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Email</th>");
                                    out.println("<th>Nacimiento</th>");
                                    out.println("<th>Beca</th>");
                                    out.println("<th>Carrera</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");
                                    out.println("<tr>");
                                    out.println("<td>" + u.getCedula() + "</td>");
                                    out.println("<td>" + u.getNombre() + "</td>");
                                    out.println("<td>" + u.getEmail() + "</td>");
                                    out.println("<td>" + u.getFechaNac() + "</td>");
                                    out.println("<td>" + p.getBeca() + "</td>");
                                    out.println("<td>" + ca.getNombre() + "</td>");
                                    out.println("</tr>");
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

