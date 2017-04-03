<%-- 
    Document   : profesores
    Created on : Mar 16, 2017, 12:50:11 PM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Alumno"%>
<%@page import="java.util.List"%>
<%@page import="LogicaNegocio.Curso"%>
<%@page import="LogicaNegocio.Grupo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LogicaNegocio.Profesor"%>
<%@page import="LogicaNegocio.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profesores</title>
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dropotron.min.js"></script>
        <script src="js/jquery.scrollgress.min.js"></script>
        <script src="js/jquery.scrolly.min.js"></script>
        <script src="js/jquery.slidertron.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        <script src="js/profesores.js"></script>
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
                            <form action="profesorServlet" method="post">
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
                            <form action="profesorServlet" method="post">
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
            
            <div class="modal fade" id="modalNota" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Registro de nota</h3>
                        </div>
                        <div class="modal-body">
                            <form action="registroServlet" method="post">
                                <div>
                                    <input class='special' type="number" min="1" max="100" placeholder="Ingrese el codigo a buscar" name="nota" required="" id="codigo" />
                                    <input type='hidden' id="notaAlumno" name='alumno' />
                                    <input type='hidden' id="notaGrupo" name='grupo' />
                                    <input type='hidden' name='data' value='nota' />
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
            
            <div class="modal fade" id="addProfesor" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo profesor</h3>
                        </div>
                        <div class="modal-body">
                            <form action="profesorServlet" method="post">
                                <ul>
                                    <input type='text' name='codigo' placeholder="Cedula"  id='codigo' />
                                    <input type='text' name='nombre' placeholder="Nombre" required='' id='nombre'/>
                                    <input type='text' name='clave' placeholder="Clave" required='' id='clave'/>
                                    <input type='text' name='email' placeholder="Email" required='' id='email'/>
                                    <input type='date' name='fecha' placeholder="Fecha de Nacimiento" required='' id='fecha'/>
                                    <input type='text' name='categoria' placeholder="Categoria" required='' id='categoria'/>
                                    <input type='number' min="0" name='salario' placeholder="Salario" required='' id='salario'/>
                                    <input  type='hidden' name='data' value='aProfe' />
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
            <div class="modal fade" id="profesorEdit" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Editar un profesor</h3>
                        </div>
                        <div class="modal-body">
                            <form action="profesorServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese la cedula del profesor" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eProfe' />
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
                    Profesor p = (Profesor) request.getAttribute("eProfe");
                    //Carrera ca = (Carrera)request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='editCurso' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar profesor</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='profesorServlet' method='post'>"
                            + "<ul>"
                            + "<input type='text' name='codigo' readonly id='codigo' value='" + c.getCedula() + "' />"
                            + "<input type='text' name='nombre' required='' id='nombre' value='" + c.getNombre() + "' />"
                            + "<input type='text' name='email' required='' id='email' value=" + c.getEmail() + " />"
                            + "<input type='date' name='fecha' required='' id='fecha' value=" + c.getFechaNac() + " />"
                            + "<input type='text' name='categoria' required='' id='categoria' value='" + p.getCategoria() + "' />"
                            + "<input type='number' min='0' name='salario' required='' id='salario' value='" + p.getSalario() + "' />"
                            + "<input  type='hidden' name='idU' value='" + c.getId() + "' />"
                            + "<input  type='hidden' name='data' value='mProfe' />"
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
                    <h2>Mantenimiento de Profesores</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <% String ti = (String) session.getAttribute("tipo");
                                    if (ti == "1") {
                                        out.println("<li><a href='#' id='busquedaNombre' class='button special'>Busqueda por nombre</a></li>"
                                                + "<li><a href='#' id='busquedaCedula' class='button special'>Busqueda por cedula</a></li>"
                                                + "<li><a href='#' id='editarProfesor' class='button special'>Editar un profesor</a></li>"
                                                + "<li><a href='#' id='agregarProfesor' class='button special'>Agregar un profesor</a></li>");
                                    } else if (ti == "2") {
                                        out.println("<li><a href='/registroServlet?data=request&id=" + session.getAttribute("id") + "' id='registroNotas' class='button special'>Registrar Notas</a></li>");
                                    }
                                %>
                            </ul>
                        </section>
                        <section>
                            <%                        ArrayList<Usuarios> list = (ArrayList<Usuarios>) request.getAttribute("lUsers");
                                if (list != null) {
                                    ArrayList<Profesor> lP = (ArrayList<Profesor>) request.getAttribute("lProfes");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Cedula</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Email</th>");
                                    out.println("<th>Nacimiento</th>");
                                    out.println("<th>Categoría</th>");
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
                                        out.println("<td>" + lP.get(i).getCategoria() + "</td>");
                                        out.println("</tr>");
                                        i++;
                                    }

                                    out.println("</tbody>");
                                    out.println("</table>");
                                    out.println("</div>");
                                }
                            %>

                            <%                ArrayList<Usuarios> lG = (ArrayList<Usuarios>) request.getAttribute("lUsuarioGrupo");
                                if (lG != null) {
                                    ArrayList<Alumno> ci = (ArrayList<Alumno>) request.getAttribute("lAlumnoGrupo");
                                    Grupo gr = (Grupo) request.getAttribute("grupo");
                                    out.println("<div class='modal fade' id='lGrupoP' style='margin-top: 30px'>"
                                            + "<div class='modal-dialog' role='document'>"
                                            + "<div class='modal-content'>"
                                            + "<div class='modal-header'>"
                                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                                            + "<span aria-hidden='true'>&times;</span>"
                                            + "</button>"
                                            + "<h3>Lista de estudiantes</h3>"
                                            + "</div>"
                                            + "<div class='modal-body'>"
                                            + "<div class='table-wrapper'>"
                                            + "<table>"
                                            + "<thead>"
                                            + "<tr>"
                                            + "<th>Cedula</th>"
                                            + "<th>Nombre</th>"
                                            + "<th>Email</th>"
                                            + "<th>FechaNacimiento</th>"
                                            + "<th>Agregar Nota</th>"
                                            + "</tr>"
                                            + "</thead>"
                                            + "<tbody>");
                                    int i = 0;
                                    for (Usuarios category : lG) {

                                        out.println("<tr>");

                                        out.println("<td>" + category.getCedula() + "</td>");
                                        out.println("<td>" + category.getNombre() + "</td>");
                                        out.println("<td>" + category.getEmail() + "</td>");
                                        out.println("<td>" + category.getFechaNac() + "</td>");
                                        out.println("<td><a href='#' id='registrarNota' onClick='nota(" + ci.get(i).getId() + "," + gr.getId() + ")' class='btn btn-sm'><i class='fa fa-bars' aria-hidden='true'></i></a></td>");
                                        i++;
                                        out.println("</tr>");
                                    }

                                    out.println("</table>"
                                            + "</div>"
                                            + "</div>"
                                            + "</div>"
                                            + "</div>"
                                            + "</div>");
                                    out.println(" </tbody><script> "
                                            + "$('#lGrupoP').modal('show'); </script>");
                                }
                            %>

                        </section><section>
                            <%                        Usuarios u = (Usuarios) request.getAttribute("usuarios");
                                if (u != null) {
                                    Profesor p = (Profesor) request.getAttribute("profesor");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Cedula</th>");
                                    out.println("<th>Nombre</th>");
                                    out.println("<th>Email</th>");
                                    out.println("<th>Nacimiento</th>");
                                    out.println("<th>Categoría</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");
                                    out.println("<tr>");
                                    out.println("<td>" + u.getCedula() + "</td>");
                                    out.println("<td>" + u.getNombre() + "</td>");
                                    out.println("<td>" + u.getEmail() + "</td>");
                                    out.println("<td>" + u.getFechaNac() + "</td>");
                                    out.println("<td>" + p.getCategoria() + "</td>");
                                    out.println("</tr>");
                                    out.println("</tbody>");
                                    out.println("</table>");
                                    out.println("</div>");
                                }
                            %>
                        </section>
                        <section>
                            <%                        ArrayList<Grupo> lGP = (ArrayList<Grupo>) request.getAttribute("lGP");
                                if (lGP != null) {
                                    ArrayList<Curso> lCP = (ArrayList<Curso>) request.getAttribute("lCP");
                                    out.println("<div class='table-wrapper'>");
                                    out.println("<table>");
                                    out.println("<thead>");
                                    out.println("<tr>");
                                    out.println("<th>Numero de grupo</th>");
                                    out.println("<th>Horario</th>");
                                    out.println("<th>Curso</th>");
                                    out.println("<th>Lista de alumnos</th>");
                                    out.println("</tr>");
                                    out.println("</thead>");
                                    out.println("<tbody>");
                                    int i = 0;
                                    for (Grupo category : lGP) {
                                        out.println("<tr>");
                                        out.println("<td>" + category.getNumeroGrupo() + "</td>");
                                        out.println("<td>" + category.getHorario() + "</td>");
                                        out.println("<td>" + lCP.get(i).getNombre() + "</td>");
                                        out.println("<td><a href='/registroServlet?data=grupos&id=" + category.getId() + "' id='bus' class='btn btn-sm'><i class='fa fa-bars' aria-hidden='true'></i></a></td>");
                                        out.println("</tr>");
                                        i++;
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

