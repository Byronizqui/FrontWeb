/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.AlumnoBL;
import BL.CursoBL;
import BL.GrupoBL;
import BL.NotaBL;
import BL.ProfesorBL;
import BL.UsuariosBL;
import BL.alumno_has_GrupoBL;
import LogicaNegocio.Alumno;
import LogicaNegocio.Curso;
import LogicaNegocio.Grupo;
import LogicaNegocio.Nota;
import LogicaNegocio.Profesor;
import LogicaNegocio.Usuarios;
import LogicaNegocio.alumno_has_grupo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Byron
 */
public class registroServlet extends HttpServlet {

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

            Usuarios u = new Usuarios();
            UsuariosBL uBL = new UsuariosBL();
            Profesor p = new Profesor();
            ProfesorBL pBL = new ProfesorBL();
            Grupo g = null;
            GrupoBL gBL = new GrupoBL();
            List<Curso> lC = new ArrayList();
            Curso c = new Curso();
            CursoBL cBL = new CursoBL();
            Alumno a = null;
            AlumnoBL aBL = new AlumnoBL();
            alumno_has_grupo ahg = new alumno_has_grupo();
            alumno_has_GrupoBL ahgBL = new alumno_has_GrupoBL();
            Nota n = new Nota();
            NotaBL nBL = new NotaBL();
            switch (data) {
                case "request": {
                    String id = request.getParameter("id");
                    u = uBL.findByOther("id", id);
                    p = pBL.findByOther("idU", String.valueOf(u.getId()));
                    List<Grupo> lG = gBL.findAllByOther("profesor", String.valueOf(p.getId()));
                    for (Grupo gg : lG) {
                        lC.add(cBL.findByOther("id", String.valueOf(gg.getCurso())));
                    }
                    if (lG.size() <= 0) {
                        request.setAttribute("message", "El profesor no posee grupos");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        request.setAttribute("lCP", lC);
                        request.setAttribute("lGP", lG);
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }

                }
                break;
                case "grupos": {
                    String id = request.getParameter("id");
                    List<alumno_has_grupo> li = ahgBL.findAllByOther("idG", id);
                    List<Alumno> lA = new ArrayList();
                    List<Usuarios> lU = new ArrayList();
                    for (alumno_has_grupo aux : li) {
                        a = aBL.findByOther("id", String.valueOf(aux.getAlumno_id()));
                        lA.add(a);
                    }
                    if (lA.size() <= 0) {
                        request.setAttribute("message", "El grupo no posee alumnos");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        for (Alumno aa : lA) {
                            u = uBL.findByOther("pK", String.valueOf(aa.getUsuarios()));
                            lU.add(u);
                        }
                        Grupo grupo = gBL.findByOther("id", id);
                        request.setAttribute("grupo", grupo);
                        request.setAttribute("lUsuarioGrupo", lU);
                        request.setAttribute("lAlumnoGrupo", lA);
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }
                }
                break;
                case "nota": {
                    String al = request.getParameter("alumno");
                    String gr = request.getParameter("grupo");
                    String no = request.getParameter("nota");
                    a = aBL.findByOther("id", al);
                    g = gBL.findByOther("id", gr);
                    c = cBL.findByOther("id", String.valueOf(g.getCurso()));
                    List<Nota> lN = nBL.findAllByOther("alumno", al);
                    for (Nota nn : lN) {
                        if (nn.getCurso() == c.getId()) {
                            nn.setNota(Integer.valueOf(no));
                            n.setHistorial(no);
                            nBL.merge(nn);
                            request.setAttribute("message", "La nota se modificó correctamente.");
                            request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                        }
                    }
                    n.setAlumno(a.getId());
                    n.setNota(Integer.valueOf(no));
                    n.setCurso(c.getId());
                    n.setHistorial(no);
                    nBL.save(n);
                    request.setAttribute("message", "La nota se agregó correctamente.");
                    request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                }
                break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(registroServlet.class.getName()).log(Level.SEVERE, null, ex);
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
