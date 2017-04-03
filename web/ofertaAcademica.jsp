<%-- 
    Document   : ofertaAcademica
    Created on : Mar 15, 2017, 8:15:43 PM
    Author     : Byron
--%>

<%@page import="LogicaNegocio.Usuarios"%>
<%@page import="LogicaNegocio.Grupo"%>
<%@page import="LogicaNegocio.Ciclo"%>
<%@page import="LogicaNegocio.Carrera"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LogicaNegocio.Curso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Oferta</title>
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
        <script src="js/ofertaAcademica.js"></script>
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
                                <div class="modal-footer">
                                    <input class="btn btn-primary" type="submit" value="Enviar" />
                                    <input class="btn btn-secondary" data-dismiss="modal" type="button" value="Close" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalAuto" style="margin-top: 30px">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3>Busqueda de cursos</h3>
                        </div>
                        <div class="modal-body">
                            <form action="ofertaServlet" method="post">
                                <div>
                                    <input class='special' type="text" placeholder="Ingrese el codigo de la carrera" name="carrera" required="" id="carrera" />
                                    <input  type="number" min="2017" max="2020" placeholder="Año del ciclo" name="aCiclo" required="" id="aCiclo" />
                                    <input  type="number" min="1" max="2" placeholder="Numero del ciclo" name="nCiclo" required="" id="nCiclo" />
                                    <input type='hidden' name='data' value='bCursos' />
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

            <%                Grupo c = (Grupo) request.getAttribute("edGrupo");
                if (c != null) {
                    Usuarios ca = (Usuarios) request.getAttribute("profe");
                    out.println("<div class='modal fade' id='edGrupo' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Editar grupo</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='ofertaServlet' method='post'>"
                            + "<ul>"
                            + "<input type='hidden' name='id' id='id' value=" + c.getId() + " />"
                            + "<input type='hidden' name='curso' id='curso' value=" + c.getCurso() + " />"
                            + "<input type='number' min='1' name='numero' required='' id='numero' value='"+c.getNumeroGrupo()+"'/>"
                            + "<input type='text' name='horario' required='' id='horario' value='"+c.getHorario()+"'/>"
                            + "<input type='text' name='profesor' required='' id='profesor' value='"+ca.getCedula()+"'/>"
                            + "<input  type='hidden' name='data' value='mGrupo' />"
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
                            + "$('#edGrupo').modal('show'); </script>");
                }

            %>


            <%                Curso nC = (Curso) request.getAttribute("addGrupo");
                if (nC != null) {
                    Ciclo ci = (Ciclo) request.getAttribute("ciclo");
                    Carrera ca = (Carrera) request.getAttribute("carrera");
                    out.println("<div class='modal fade' id='newGrupo' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Agregar grupo</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<form action='ofertaServlet' method='post'>"
                            + "<ul>"
                            + "<input type='hidden' name='curso' id='curso' value=" + nC.getId() + " />"
                            + "<input type='number' min='1' max='8' placeholder='Numero de grupo' name='numero' required='' id='numero'/>"
                            + "<input type='text' name='horario' placeholder='Horario del grupo' required='' id='horario'/>"
                            + "<input type='text' name='profesor' placeholder='Cedula del profesor' required='' id='profesor'/>"
                            + "<input  type='hidden' name='data' value='newGrupo' />"
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
                            + "$('#newGrupo').modal('show'); </script>");
                }

            %>

            <%                ArrayList<Grupo> lG = (ArrayList<Grupo>) request.getAttribute("lGrupo");
                if (lG != null) {
                    Ciclo ci = (Ciclo) request.getAttribute("ciclo");
                    Carrera ca = (Carrera) request.getAttribute("carrera");
                    ArrayList<Usuarios> lU = (ArrayList<Usuarios>) request.getAttribute("lProfes");
                    out.println("<div class='modal fade' id='lGrupo' style='margin-top: 30px'>"
                            + "<div class='modal-dialog' role='document'>"
                            + "<div class='modal-content'>"
                            + "<div class='modal-header'>"
                            + "<button type='button' class='close' data-dismiss='modal' aria-label='Close'>"
                            + "<span aria-hidden='true'>&times;</span>"
                            + "</button>"
                            + "<h3>Lista de grupos</h3>"
                            + "</div>"
                            + "<div class='modal-body'>"
                            + "<div class='table-wrapper'>"
                            + "<table>"
                            + "<thead>"
                            + "<tr>"
                            + "<th>Numero Grupo</th>"
                            + "<th>Horario</th>"
                            + "<th>Profesor</th>"
                            + "<th>Editar</th>"
                            + "</tr>"
                            + "</thead>"
                            + "<tbody>");
                    int i = 0;
                    for (Grupo category : lG) {
                        
                        out.println("<tr>");
                        if (category.getNumeroGrupo() == -1) {
                            out.println("<td></td>");
                            out.println("<td></td>");
                            out.println("<td></td>");
                            out.println("<td></td>");
                        } else {
                            out.println("<td>" + category.getNumeroGrupo() + "</td>");
                            out.println("<td>" + category.getHorario() + "</td>");
                            out.println("<td>" + lU.get(i).getNombre() + "</td>");
                            out.println("<td><a href='/ofertaServlet?data=eGrupos&id=" + category.getId() + "' id='busquedaNombre' class='btn btn-sm'><i class='fa fa-bars' aria-hidden='true'></i></a></td>");
                            
                        }
                        i++;
                        out.println("</tr>");
                    }

                    out.println("</tbody>"
                            + "<tfoot>"
                            + "<tr>"
                            + "<td colspan='3'></td>"
                            + "<td><a href='/ofertaServlet?data=addGrupo&curso=" + lG.get(0).getCurso() + "' id='busquedaNombre' class='btn btn-sm'><i class='fa fa-plus' aria-hidden='true'></i></a></td>"
                            + "</tr>"
                            + "</tfoot>"
                            + "</table>"
                            + "</div>"
                            + "</div>"
                            + "</div>"
                            + "</div>"
                            + "</div>");
                    out.println("<script> "
                            + "$('#lGrupo').modal('show'); </script>");
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
                    <h2>Oferta Académica</h2>
                </header>
                <div class="container">

                    <!-- Content -->
                    <section id="content" class="">                    
                        <!-- Lists -->
                        <section>
                            <ul class="actions">
                                <li><a href="#" id="buscarCursos" class="button special">Buscar Cursos</a></li>
                            </ul>


                            <section>
                                <%                        ArrayList<Curso> list = (ArrayList<Curso>) request.getAttribute("lCursos");
                                    if (list != null) {
                                        out.println("<div class='table-wrapper'>");
                                        out.println("<table>");
                                        out.println("<thead>");
                                        out.println("<tr>");
                                        out.println("<th>Codigo</th>");
                                        out.println("<th>Nombre</th>");
                                        out.println("<th>Creditos</th>");
                                        out.println("<th>Horas Semanales</th>");
                                        out.println("<th>Grupos</th>");
                                        out.println("</tr>");
                                        out.println("</thead>");
                                        out.println("<tbody>");

                                        for (Curso category : list) {
                                            out.println("<tr>");
                                            out.println("<td>" + category.getCodigo() + "</td>");
                                            out.println("<td>" + category.getNombre() + "</td>");
                                            out.println("<td>" + category.getCreditos() + "</td>");
                                            out.println("<td>" + category.getHorasSemanles() + "</td>");
                                            out.println("<td><a href='/ofertaServlet?data=grupos&id=" + category.getId() + "' id='busquedaNombre' class='btn btn-sm'><i class='fa fa-bars' aria-hidden='true'></i></a></td>");
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