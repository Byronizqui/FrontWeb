/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.CarreraBL;
import BL.CicloBL;
import BL.CursoBL;
import BL.GrupoBL;
import BL.ProfesorBL;
import BL.RolBL;
import BL.UsuariosBL;
import LogicaNegocio.Carrera;
import LogicaNegocio.Ciclo;
import LogicaNegocio.Curso;
import LogicaNegocio.Grupo;
import LogicaNegocio.Nota;
import LogicaNegocio.Profesor;
import LogicaNegocio.Rol;
import LogicaNegocio.Usuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
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
public class ofertaServlet extends HttpServlet {

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
            Curso c = null;
            CursoBL cBL = new CursoBL();
            CicloBL _cBL = new CicloBL();
            HttpSession session = request.getSession();
            List<Curso> lista = new ArrayList();
            CarreraBL carreraBL = new CarreraBL();
            String data = request.getParameter("data");
            GrupoBL gBl = new GrupoBL();
            ProfesorBL pBl = new ProfesorBL();
            UsuariosBL uBL = new UsuariosBL();
            RolBL rBL = new RolBL();
            Usuarios u = null;
            Grupo gG = null;
            Profesor p = null;
            switch (data) {
                case "bCursos": {
                    String ca = request.getParameter("carrera");
                    String anyo = request.getParameter("aCiclo");
                    String numero = request.getParameter("nCiclo");

                    Carrera cAux = carreraBL.findByOther("code", ca);
                    if (cAux != null) {
                        List<Ciclo> lC = _cBL.findAllByOther("year", anyo);
                        for (Ciclo cc : lC) {
                            if (cc.getNumero() == Integer.valueOf(numero)) {
                                List<Curso> lCur = cBL.findAllByOther("ciclo", String.valueOf(cc.getId()));
                                List<Curso> lAux = new ArrayList();
                                for (Curso ccc : lCur) {
                                    if (Objects.equals(ccc.getCarrera(), cAux.getId())) {
                                        lAux.add(ccc);
                                    }
                                }
                                if (lAux.size() >= 0) {
                                    request.setAttribute("lCursos", lAux);
                                    request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("message", "No hay cursos para el ciclo seleccionado");
                                    request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                                }
                            }
                        }
                    } else {
                        request.setAttribute("message", "La carrera no existe");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    }
                }
                break;
                case "grupos": {
                    String code = request.getParameter("id");
                    List<Grupo> lGrupo = gBl.findAllByOther("curso", code);
                    if (lGrupo.size() <= 0) {
                        gG = new Grupo();
                        gG.setCurso(Integer.valueOf(code));
                        gG.setNumeroGrupo(-1);
                        lGrupo.add(gG);
                        request.setAttribute("lGrupo", lGrupo);
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    } else {
                        List<Usuarios> lU = new ArrayList();
                        for (Grupo g : lGrupo) {
                            Profesor pAux = pBl.findByOther("id", String.valueOf(g.getProfesor()));
                            Usuarios uAux = uBL.findByOther("pK", String.valueOf(pAux.getUsuarios()));
                            lU.add(uAux);
                        }
                        request.setAttribute("lProfes", lU);
                        request.setAttribute("lGrupo", lGrupo);
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    }
                }
                break;
                case "addGrupo": {
                    String curso = request.getParameter("curso");
                    c = cBL.findByOther("id", curso);
                    request.setAttribute("addGrupo", c);
                    request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                }
                break;
                case "newGrupo": {
                    String curso = request.getParameter("curso");
                    String numero = request.getParameter("numero");
                    String horario = request.getParameter("horario");
                    String profesor = request.getParameter("profesor");
                    u = uBL.findByOther("id", profesor);
                    Rol r = new Rol();
                    if (u != null){
                         r = rBL.findByOther("idU", u.getCedula());
                    }
                    
                    if (u == null) {
                        request.setAttribute("message", "El profesor no existe.");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    } else if (r.getRol() != 2){
                        request.setAttribute("message", "El profesor no existe.");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    } else {
                        p = pBl.findByOther("idU", String.valueOf(u.getId()));
                        gG = new Grupo();
                        gG.setCurso(Integer.valueOf(curso));
                        gG.setHorario(horario);
                        gG.setProfesor(p.getId());
                        gG.setNumeroGrupo(Integer.valueOf(numero));
                        gBl.save(gG);
                        request.setAttribute("message", "El grupo se añadió correctamente.");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    }

                }
                break;
                case "eGrupos":{
                    String id = request.getParameter("id");
                    Grupo gr = gBl.findByOther("id", id);
                    if(gr != null){
                        request.setAttribute("edGrupo", gr);
                        Profesor pp = pBl.findByOther("id", String.valueOf(gr.getProfesor()));
                        Usuarios uu = uBL.findByOther("pK", String.valueOf(pp.getUsuarios()));
                        request.setAttribute("profe", uu);
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    }
                }
                break;
                case "mGrupo":{
                    String curso = request.getParameter("curso");
                    String numero = request.getParameter("numero");
                    String horario = request.getParameter("horario");
                    String profesor = request.getParameter("profesor");
                    String id = request.getParameter("id");
                    u = uBL.findByOther("id", profesor);
                    if (u == null) {
                        request.setAttribute("message", "El profesor no existe.");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    } else {
                        p = pBl.findByOther("idU", String.valueOf(u.getId()));
                        gG = new Grupo();
                        gG.setId(Integer.valueOf(id));
                        gG.setCurso(Integer.valueOf(curso));
                        gG.setHorario(horario);
                        gG.setProfesor(p.getId());
                        gG.setNumeroGrupo(Integer.valueOf(numero));
                        gBl.merge(gG);
                        request.setAttribute("message", "El grupo se editó correctamente.");
                        request.getRequestDispatcher("/ofertaAcademica.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ofertaServlet.class.getName()).log(Level.SEVERE, null, ex);
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
