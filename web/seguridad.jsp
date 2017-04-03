<%-- 
    Document   : seguridad
    Created on : Mar 24, 2017, 10:26:44 AM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Matriculador"%>
<%@page import="LogicaNegocio.Administrador"%>
<%@page import="LogicaNegocio.Usuarios"%>
<%@page import="LogicaNegocio.Curso"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seguridad</title>
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dropotron.min.js"></script>
        <script src="js/jquery.scrollgress.min.js"></script>
        <script src="js/jquery.scrolly.min.js"></script>
        <script src="js/jquery.slidertron.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        <script src="js/seguridad.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
    </head>
    <body>
        <header id="header" class="skel-layers-fixed">
            <%@ include file="jspf/inicio.jspf" %>
        </header>
        <div class="container">
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
                    <h2>Seguridad</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <li><a href="#" id="addBAdmin" class="button special">Agregar administrador</a></li>
                                <li><a href="#" id="edAdmin" class="button special">Editar administrador</a></li>
                                <li><a href="#" id='addBMatri' class="button special">Agregar matriculador</a></li>
                                <li><a href="#" id='edMatri' class="button special">Editar Matriculador</a></li>
                            </ul>
                        </section>
                </div>
            </section>
            <div class="modal fade" id="addAdmin" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo administrador</h3>
                        </div>
                        <div class="modal-body">
                            <form action="seguridadServlet" method="post">
                                <ul>
                                    <input type='text' name='codigo' placeholder="Cedula"  id='codigo' />
                                    <input type='text' name='nombre' placeholder="Nombre" required='' id='nombre'/>
                                    <input type='text' name='clave' placeholder="Clave" required='' id='clave'/>
                                    <input type='text' name='email' placeholder="Email" required='' id='email'/>
                                    <input type='date' name='fecha' placeholder="Fecha de Nacimiento" required='' id='fecha'/>
                                    <input type='number' min="0" name='salario' placeholder="Salario" required='' id='salario'/>
                                    <input  type='hidden' name='data' value='aAdmin' />
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
            <div class="modal fade" id="admnistradorEdit" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Editar un administrador</h3>
                        </div>
                        <div class="modal-body">
                            <form action="seguridadServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese la cedula del administrador" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eAdmin' />
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
                    Administrador p = (Administrador) request.getAttribute("eAd");
                    //Carrera ca = (Carrera)request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='editAdmin' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar profesor</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='seguridadServlet' method='post'>"
                            + "<ul>"
                            + "<input type='text' name='codigo' readonly id='codigo' value='" + c.getCedula() + "' />"
                            + "<input type='text' name='nombre' required='' id='nombre' value='" + c.getNombre() + "' />"
                            + "<input type='text' name='email' required='' id='email' value=" + c.getEmail() + " />"
                            + "<input type='date' name='fecha' required='' id='fecha' value=" + c.getFechaNac() + " />"
                            + "<input type='number' min='0' name='salario' required='' id='salario' value='" + p.getSalario() + "' />"
                            + "<input  type='hidden' name='idU' value='" + c.getId() + "' />"
                            + "<input  type='hidden' name='data' value='mAdmin' />"
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
                            + "$('#editAdmin').modal('show'); </script>");
                }

            %>



            <div class="modal fade" id="addMatri" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Ingreso de un nuevo matricular</h3>
                        </div>
                        <div class="modal-body">
                            <form action="seguridadServlet" method="post">
                                <ul>
                                    <input type='text' name='codigo' placeholder="Cedula"  id='codigo' />
                                    <input type='text' name='nombre' placeholder="Nombre" required='' id='nombre'/>
                                    <input type='text' name='clave' placeholder="Clave" required='' id='clave'/>
                                    <input type='text' name='email' placeholder="Email" required='' id='email'/>
                                    <input type='date' name='fecha' placeholder="Fecha de Nacimiento" required='' id='fecha'/>
                                    <input type='date' name='fechaIni' placeholder="Fecha de Inicio" required='' id='fechaIni'/>
                                    <input type='date' name='fechaFin' placeholder="Fecha de Fin" required='' id='fechaFin'/>
                                    <input  type='hidden' name='data' value='aMatri' />
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
            <div class="modal fade" id="matriculadorEdit" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Editar un matriculador</h3>
                        </div>
                        <div class="modal-body">
                            <form action="seguridadServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese la cedula del administrador" name="codigo" required="" id="codigo" />
                                    <input type='hidden' name='data' value='eMatri' />
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
            <%                Usuarios uu = (Usuarios) request.getAttribute("eUserM");
                if (uu != null) {
                    Matriculador p = (Matriculador) request.getAttribute("eMatri");
                    //Carrera ca = (Carrera)request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='editMatri' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar profesor</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='seguridadServlet' method='post'>"
                            + "<ul>"
                            + "<input type='text' name='codigo' readonly id='codigo' value='" + uu.getCedula() + "' />"
                            + "<input type='text' name='nombre' required='' id='nombre' value='" + uu.getNombre() + "' />"
                            + "<input type='text' name='email' required='' id='email' value=" + uu.getEmail() + " />"
                            + "<input type='date' name='fecha' required='' id='fecha' value=" + uu.getFechaNac() + " />"
                            + "<input type='date' name='fechaIni' required='' id='fecha' value=" + p.getFechaIni() + " />"
                            + "<input type='date' name='fechaFin' required='' id='fecha' value=" + p.getFechaFin() + " />"
                            + "<input  type='hidden' name='idU' value='" + uu.getId() + "' />"
                            + "<input  type='hidden' name='data' value='mMatri' />"
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
                            + "$('#editMatri').modal('show'); </script>");
                }

            %>
        </div>
    </body>
</html>
