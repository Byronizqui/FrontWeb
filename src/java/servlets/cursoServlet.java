/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.CarreraBL;
import BL.CicloBL;
import BL.CursoBL;
import LogicaNegocio.Carrera;
import LogicaNegocio.Ciclo;
import LogicaNegocio.Curso;
import LogicaNegocio.Grupo;
import LogicaNegocio.Nota;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Byron
 */
public class cursoServlet extends HttpServlet {

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

            switch (data) {
                case "bNombre": {
                    String name = request.getParameter("nombre");
                    lista = cBL.findAllByOther("name", name);
                    // his.imprimeCursos(lC);
                    if (lista != null) {
                        request.setAttribute("lCurso", lista);
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontraron resultados");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    }
                }
                break;
                case "bCodigo": {
                    String code = request.getParameter("codigo");
                    lista = cBL.findAllByOther("code", code);
                    if (lista != null) {
                        request.setAttribute("lCurso", lista);
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontraron resultados");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    }
                }
                break;
                case "bCarrera": {
                    String ca = request.getParameter("carrera");
                    Carrera carrera = carreraBL.findByOther("code", ca);
                    if (carrera == null) {
                        request.setAttribute("message", "La carrera no existe");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else {
                        lista = cBL.findAllByOther("ca", String.valueOf(carrera.getId()));
                        if (lista != null) {
                            request.setAttribute("lCurso", lista);
                            request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                        } else {
                            request.setAttribute("message", "No se encontraron resultados");
                            request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                        }
                    }
                }
                break;
                case "addCurso": {
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String creditos = request.getParameter("creditos");
                    String horas = request.getParameter("horas");
                    String carrera = request.getParameter("carrera");
                    String aCiclo = request.getParameter("aCiclo");
                    String nCiclo = request.getParameter("nCiclo");

                    Carrera _C = carreraBL.findByOther("code", carrera);
                    List<Ciclo> _lC = _cBL.findAllByOther("year", aCiclo);

                    if (_C == null) {
                        request.setAttribute("message", "La carrera no existe");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else if (_lC != null) {
                        for (Ciclo cc : _lC) {
                            if (cc.getNumero() == Integer.valueOf(nCiclo)) {
                                Curso cAux = cBL.findByOther("code", codigo);
                                if (cAux != null) {
                                    request.setAttribute("message", "El curso ya se encuentra registrado");
                                    request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                                } else {
                                    Curso def = new Curso(0, _C.getId(), cc.getId(), codigo, nombre,
                                            Integer.parseInt(creditos), Integer.parseInt(horas),
                                            new ArrayList<Grupo>(), new ArrayList<Nota>());
                                    cBL.save(def);
                                    request.setAttribute("message", "El curso se ingresó correctamente");
                                    request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                                }
                            }
                        }

                    } else {
                        request.setAttribute("message", "No se encontraro un ciclo que corresponda");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    }
                }
                break;
                case "eCurso": {
                    String code = request.getParameter("codigo");
                    c = cBL.findByOther("code", code);

                    if (c != null) {
                        Carrera ca = carreraBL.findByOther("id", String.valueOf(c.getCarrera()));
                        Ciclo ci = _cBL.findByOther("id", String.valueOf(c.getCiclo()));
                        //session.setAttribute("lCarrera", lista);
                        request.setAttribute("curso", c);
                        request.setAttribute("carrera", ca);
                        request.setAttribute("ciclo", ci);
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró el curso.");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    }
                }
                break;
                case "mCurso": {
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String creditos = request.getParameter("creditos");
                    String horas = request.getParameter("horas");
                    String carrera = request.getParameter("carrera");
                    String aCiclo = request.getParameter("aCiclo");
                    String nCiclo = request.getParameter("nCiclo");
                    Carrera _C = carreraBL.findByOther("code", carrera);
                    List<Ciclo> _lC = _cBL.findAllByOther("year", aCiclo);
                    if (_C == null) {
                        request.setAttribute("message", "La carrera no existe");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    } else if (_lC != null) {
                        for (Ciclo cc : _lC) {
                            if (cc.getNumero() == Integer.valueOf(nCiclo)) {
                                Curso aux = cBL.findByOther("code", codigo);
                                Curso def = new Curso(aux.getId(), _C.getId(), cc.getId(), codigo, nombre,
                                        Integer.parseInt(creditos), Integer.parseInt(horas),
                                        new ArrayList<Grupo>(), new ArrayList<Nota>());
                                cBL.merge(def);
                                request.setAttribute("message", "El curso se editó correctamente");
                                request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                            }
                        }
                    } else {
                        request.setAttribute("message", "No se encontraro un ciclo que corresponda");
                        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
                    }
                }
                break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(cursoServlet.class.getName()).log(Level.SEVERE, null, ex);
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
