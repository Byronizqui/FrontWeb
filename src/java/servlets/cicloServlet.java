/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.CicloBL;
import BL.CursoBL;
import LogicaNegocio.Ciclo;
import LogicaNegocio.Curso;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Byron
 */
public class cicloServlet extends HttpServlet {

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
            Ciclo c = null;
            CursoBL cBL = new CursoBL();
            CicloBL _cBL = new CicloBL();
            HttpSession session = request.getSession();
            List<Curso> lista = new ArrayList();

            String data = request.getParameter("data");

            switch (data) {
                case "bAnyo": {
                    List<Curso> _lC = null;
                    List<Curso> _final = new ArrayList();
                    List<Ciclo> lCi = null;
                    String year = request.getParameter("anyo");
                    lCi = _cBL.findAllByOther("year", year);
                    if (lCi != null) {
                        for (Ciclo ciclo : lCi) {
                            _lC = cBL.findAllByOther("ciclo", String.valueOf(ciclo.getId()));
                            _final.addAll(_lC);
                        }
                    }
                    //this.imprimeCursos(_lC);
                    if (_final != null) {
                        request.setAttribute("message", "Mostrando resultados");
                        request.setAttribute("lCiclos", _final);
                        request.getRequestDispatcher("/ciclos.jsp").forward(request, response);
                    }

                }
                break;
                case "aAnyo": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    format.setTimeZone(TimeZone.getTimeZone("Etc/UTC"));
                    String year = request.getParameter("anyo");
                    String number = request.getParameter("numero");
                    String fIni = request.getParameter("fIni");
                    String fFin = request.getParameter("fFin");
                    String activo = request.getParameter("active");
                    date = format.parse(fIni);
                    sqlDate = new java.sql.Date(date.getTime());
                    Ciclo nuevo = new Ciclo();
                    nuevo.setAnyo(Integer.parseInt(year));
                    nuevo.setNumero(Integer.parseInt(number));
                    nuevo.setFechaInit(sqlDate);
                    date = format.parse(fFin);
                    sqlDate = new java.sql.Date(date.getTime());
                    nuevo.setFechaFin(sqlDate);
                    if (activo != null) {
                        List<Ciclo> lC = _cBL.findAll(Ciclo.class.getName());
                        for (Ciclo cc : lC) {
                            if (cc.getAnyo() == nuevo.getAnyo()) {
                                if (cc.getNumero() == nuevo.getNumero()) {
                                    request.setAttribute("message", "El ciclo ya se encuentra registrado");
                                    request.getRequestDispatcher("/ciclos.jsp").forward(request, response);
                                }
                            }
                        }
                        for (Ciclo cc : lC) {
                            if (cc.getActivo() == 1) {
                                cc.setActivo(0);
                                _cBL.merge(cc);
                            }
                        }

                        nuevo.setActivo(1);
                    } else {
                        nuevo.setActivo(0);
                    }
                    _cBL.save(nuevo);
                    request.setAttribute("message", "El ciclo se registró correctamente.");
                    request.getRequestDispatcher("/ciclos.jsp").forward(request, response);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(cicloServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(cicloServlet.class.getName()).log(Level.SEVERE, null, ex);
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
