/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import AccesoDatos.alumno_has_GrupoDAO;
import BL.AlumnoBL;
import BL.CarreraBL;
import BL.CicloBL;
import BL.CursoBL;
import BL.GrupoBL;
import BL.NotaBL;
import BL.RolBL;
import BL.UsuariosBL;
import LogicaNegocio.Alumno;
import LogicaNegocio.Carrera;
import LogicaNegocio.Ciclo;
import LogicaNegocio.Curso;
import LogicaNegocio.Grupo;
import LogicaNegocio.Nota;
import LogicaNegocio.Rol;
import LogicaNegocio.Usuarios;
import LogicaNegocio.alumno_has_grupo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Byron
 */
public class alumnoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String data = request.getParameter("data");
            Usuarios u = null;
            UsuariosBL uBL = new UsuariosBL();
            Alumno a = null;
            AlumnoBL aBL = new AlumnoBL();
            Carrera c = null;
            CarreraBL cBL = new CarreraBL();
            alumno_has_GrupoDAO aHGBL = new alumno_has_GrupoDAO();
            CursoBL __cBL = new CursoBL();
            Curso __c = null;
            GrupoBL gBL = new GrupoBL();
            Nota n = null;
            NotaBL nBL = new NotaBL();
            RolBL rBL = new RolBL();
            switch (data) {
                case "bNombre": {
                    String name = request.getParameter("nombre");
                    List<Usuarios> lU = uBL.findAllByOther("name", name);
                    List<Usuarios> def = new ArrayList();
                    List<Alumno> lA = new ArrayList();
                    List<Carrera> lC = new ArrayList();
                    for (Usuarios aux : lU) {
                        Rol r = new Rol();
                        r = rBL.findByOther("idU", aux.getCedula());
                        if (r.getRol() == 3) {
                            a = aBL.findByOther("idU", String.valueOf(aux.getId()));
                            def.add(aux);
                            lA.add(a);
                            c = cBL.findByOther("id", String.valueOf(a.getCarrera()));
                            lC.add(c);
                        }
                    }
                    if (lA.size() <= 0) {
                        request.setAttribute("message", "No se encontraron alumnos que correspondan");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("lCarrera", lC);
                        request.setAttribute("lUsers", def);
                        request.setAttribute("lAlumnos", lA);
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                        //response.sendRedirect("/alumnos.jsp");
                    }
                }
                break;
                case "bCedula": {
                    String id = request.getParameter("cedula");
                    u = uBL.findByOther("id", id);
                    if (u != null) {
                        a = aBL.findByOther("idU", String.valueOf(u.getId()));
                        c = cBL.findByOther("id", String.valueOf(a.getCarrera()));
                        request.setAttribute("carrera", c);
                        request.setAttribute("alumno", a);
                        request.setAttribute("usuarios", u);
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró al alumno.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }

                }
                break;
                case "bCarrera": {
                    String code = request.getParameter("codigo");
                    c = cBL.findByOther("code", code);
                    if (c == null){
                        request.setAttribute("message", "La carrera no existe.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }
                    List<Usuarios> lU = uBL.findAll(Usuarios.class.getName());
                    List<Usuarios> def = new ArrayList();
                    List<Alumno> lA = new ArrayList();
                    List<Carrera> lC = new ArrayList();
                    for (Usuarios aux : lU) {
                        Rol r = new Rol();
                        r = rBL.findByOther("idU", aux.getCedula());
                        if (r.getRol() == 3) {
                            a = aBL.findByOther("idU", String.valueOf(aux.getId()));
                            if (a.getCarrera() == c.getId()) {
                                lA.add(a);
                                def.add(aux);
                                lC.add(c);
                            }
                        }
                    }
                    if (lA.size() <= 0) {
                        request.setAttribute("message", "No se encontraron alumnos que correspondan");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("lCarrera", lC);
                        request.setAttribute("lUsers", def);
                        request.setAttribute("lAlumnos", lA);
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }
                }
                break;
                case "eAlumno": {
                    String code = request.getParameter("codigo");
                    u = uBL.findByOther("id", code);

                    if (u != null) {
                        a = aBL.findByOther("idU", String.valueOf(u.getId()));
                        c = cBL.findByOther("id", String.valueOf(a.getCarrera()));
                        request.setAttribute("eUser", u);
                        request.setAttribute("eCarrera", c);
                        request.setAttribute("eAlumno", a);
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró el alumno.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }
                }
                break;
                case "mAlumno": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String idU = request.getParameter("idU");
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String beca = request.getParameter("beca");
                    String carrera = request.getParameter("carrera");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    Usuarios mU = uBL.findByOther("pK", idU);
                    Alumno mA = aBL.findByOther("idU", String.valueOf(mU.getId()));
                    c = cBL.findByOther("code", String.valueOf(carrera));
                    if (c == null) {
                        request.setAttribute("message", "La carrera no existe.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        mU.setCedula(cedula);
                        mU.setEmail(email);
                        mU.setFechaNac(sqlDate);
                        mU.setNombre(nombre);
                        uBL.merge(mU);
                        mA.setBeca(Integer.valueOf(beca));
                        mA.setCarrera(c.getId());
                        aBL.merge(mA);
                        request.setAttribute("message", "El alumno se editó correctamente.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }

                }
                break;
                case "aAlumno": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String clave = request.getParameter("clave");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String beca = request.getParameter("beca");
                    String carrera = request.getParameter("carrera");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    Usuarios uA = uBL.findByOther("id", cedula);
                    Carrera ca = cBL.findByOther("code", String.valueOf(carrera));
                    if (uA != null) {
                        request.setAttribute("message", "El usario ya se encuentra registrado.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else if (ca == null) {
                        request.setAttribute("message", "La carrera no existe.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        u = new Usuarios();
                        u.setCedula(cedula);
                        u.setClave(clave);
                        u.setEmail(email);
                        u.setFechaNac(sqlDate);
                        u.setNombre(nombre);
                        uBL.save(u);
                        Usuarios uu = uBL.findByOther("id", String.valueOf(u.getCedula()));
                        a = new Alumno();
                        a.setUsuarios(uu.getId());
                        a.setBeca(Integer.valueOf(beca));
                        a.setCarrera(ca.getId());
                        aBL.save(a);
                        Rol r = new Rol(0, u.getCedula(), 3);
                        rBL.save(r);
                        request.setAttribute("message", "El alumno se agregó correctamente.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }

                }
                break;
                case "matricula": {
                    String ced = request.getParameter("cedula");
                    Usuarios __u = uBL.findByOther("id", ced);
                    if (__u == null) {
                        request.setAttribute("message", "El alumno no se encuetra en el sistema.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }
                    Alumno aa = aBL.findByOther("idU", String.valueOf(__u.getId()));
                    if (aa != null) {
                        String code = request.getParameter("codigoCurso");
                        String numeroGrupo = request.getParameter("numeroGrupo");
                        Curso cur = __cBL.findByOther("code", code);
                        if (cur != null) {
                            if (cur.getCarrera() != aa.getCarrera()) {
                                request.setAttribute("message", "El curso no pertenece a la carrera del estudiante.");
                                request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                            } else {
                                List<Grupo> gru = gBL.findAllByOther("curso", String.valueOf(cur.getId()));
                                if (gru.size() >= 1) {
                                    for (Grupo G : gru) {
                                        if (G.getNumeroGrupo() == Integer.valueOf(numeroGrupo)) {
                                            alumno_has_grupo ahg = new alumno_has_grupo(aa.getId(), G.getId());
                                            aHGBL.save(ahg);
                                        }
                                    }
                                    request.setAttribute("message", "Se ha realido la matrícula correctamente");
                                    request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("message", "No existe ningun curso que cumpla con las caracteristicas descritas");
                                    request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                                }
                            }

                        } else {
                            request.setAttribute("message", "El curso no existe");
                            request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                        }

                    } else {
                        request.setAttribute("message", "El alumno no se encuetra en el sistema.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    }
                }
                break;
                case "bCedulaHistorial": {
                    String ced = request.getParameter("cedula");
                    u = uBL.findByOther("id", ced);
                    if (u == null) {
                        request.setAttribute("message", "El alumno no se encuetra en el sistema.");
                        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                    } else {
                        a = aBL.findByOther("idU", String.valueOf(u.getId()));
                        List<Curso> lCur = new ArrayList();
                        if (a != null) {
                            List<Nota> lN = nBL.findAllByOther("alumno", String.valueOf(a.getId()));
                            if (lN.size() <= 0) {
                                request.setAttribute("message", "El alumno no posee ninguna nota por el momento.");
                                request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                            } else {
                                for (Nota nn : lN) {
                                    __c = __cBL.findByOther("id", String.valueOf(nn.getCurso()));
                                    lCur.add(__c);
                                }
                                request.setAttribute("hCursos", lCur);
                                request.setAttribute("hNotas", lN);
                                request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("message", "El alumno no se encuetra en el sistema.");
                            request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
                        }
                    }

                }
                break;

            }
        } catch (SQLException ex) {
            Logger.getLogger(profesorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(profesorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
