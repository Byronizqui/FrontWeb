/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.CarreraBL;
import LogicaNegocio.Carrera;
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
public class carreraServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            List<Carrera> lista = new ArrayList();
            CarreraBL cBL = new CarreraBL();
            String data = request.getParameter("data");
            Carrera carrera = new Carrera();
            switch (data) {
                case "bNombre": {
                    String name = request.getParameter("nombre");
                    lista = cBL.findAllByOther("name", name);

                    if (lista != null) {
                        request.setAttribute("lCarrera", lista);
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    }
                    //response.sendRedirect("/carreras.jsp");
                }
                break;
                case "nCarrera": {
                    String name = request.getParameter("nombre");
                    String code = request.getParameter("codigo");
                    String tit = request.getParameter("titulo");
                    Carrera aux = cBL.findByOther("code", code);

                    if (aux == null) {
                        carrera.setCodigo(code);
                        carrera.setNombre(name);
                        carrera.setTitulo(tit);
                        cBL.save(carrera);
                        request.setAttribute("message", "La carrera se ingresó correctamente.");
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Error! La carrera ya existe.");
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    }
                }
                break;
                case "bCodigo": {
                    String code = request.getParameter("codigo");
                    lista = cBL.findAllByOther("code", code);

                    if (lista != null) {
                        //session.setAttribute("lCarrera", lista);
                        request.setAttribute("lCarrera", lista);
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    }

                }
                break;
                case "eCarrera": {
                    String code = request.getParameter("codigo");
                    carrera = cBL.findByOther("code", code);

                    if (carrera != null) {
                        //session.setAttribute("lCarrera", lista);
                        request.setAttribute("carrera", carrera);
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    }
                    else {
                        request.setAttribute("message", "No se encontró la carrera.");
                        request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                    }
                }
                break;
                case "mCarrera": {
                    String id = request.getParameter("id");
                    String name = request.getParameter("nombre");
                    String code = request.getParameter("codigo");
                    String tit = request.getParameter("titulo");
                    carrera.setId(Integer.valueOf(id));
                    carrera.setCodigo(code);
                    carrera.setNombre(name);
                    carrera.setTitulo(tit);
                    cBL.merge(carrera);
                    request.setAttribute("message", "La carrera se modificó correctamente.");
                    request.getRequestDispatcher("/carreras.jsp").forward(request, response);
                }
                break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(cicloServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "Ocurrió un error al procesar la solicitud");
                    request.getRequestDispatcher("/carreras.jsp").forward(request, response);
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
