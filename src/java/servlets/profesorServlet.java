/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.ProfesorBL;
import BL.RolBL;
import BL.UsuariosBL;
import LogicaNegocio.Carrera;
import LogicaNegocio.Ciclo;
import LogicaNegocio.Profesor;
import LogicaNegocio.Rol;
import LogicaNegocio.Usuarios;
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

/**
 *
 * @author Byron
 */
public class profesorServlet extends HttpServlet {

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
            Profesor p = null;
            ProfesorBL pBL = new ProfesorBL();
            RolBL rBL = new RolBL();
            switch (data) {
                case "bNombre": {
                    String name = request.getParameter("nombre");
                    List<Usuarios> lU = uBL.findAllByOther("name", name);
                    List<Usuarios> def = new ArrayList();
                    List<Profesor> lP = new ArrayList();
                    for (Usuarios aux : lU) {
                        Rol r = rBL.findByOther("idU", aux.getCedula());
                        if (r.getRol() == 2) {
                            p = pBL.findByOther("idU", String.valueOf(aux.getId()));
                            def.add(aux);
                            lP.add(p);
                        }
                    }
                    if (lP.size() <= 0) {
                        request.setAttribute("message", "No se encontraron profesores que correspondan");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        request.setAttribute("lUsers", def);
                        request.setAttribute("lProfes", lP);
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }
                }
                break;
                case "bCedula": {
                    String id = request.getParameter("cedula");
                    u = uBL.findByOther("id", id);
                    if (u != null) {
                        p = pBL.findByOther("idU", String.valueOf(u.getId()));
                        request.setAttribute("profesor", p);
                        request.setAttribute("usuarios", u);
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró al profesor.");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }

                }
                break;
                case "eProfe": {
                    String code = request.getParameter("codigo");
                    u = uBL.findByOther("id", code);

                    if (u != null) {
                        p = pBL.findByOther("idU", String.valueOf(u.getId()));
                        request.setAttribute("eUser", u);
                        request.setAttribute("eProfe", p);
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró el profesor.");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }
                }
                break;
                case "mProfe": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String idU = request.getParameter("idU");
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String categoria = request.getParameter("categoria");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    Usuarios mU = uBL.findByOther("pK", idU);
                    Profesor mP = pBL.findByOther("idU", String.valueOf(mU.getId()));
                    mU.setCedula(cedula);
                    mU.setEmail(email);
                    mU.setFechaNac(sqlDate);
                    mU.setNombre(nombre);
                    uBL.merge(mU);
                    mP.setCategoria(categoria);
                    pBL.merge(mP);
                    request.setAttribute("message", "El profesor se editó correctamente.");
                    request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                }
                break;
                case "aProfe": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String clave = request.getParameter("clave");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String categoria = request.getParameter("categoria");
                    String salario = request.getParameter("salario");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    Usuarios uA = uBL.findByOther("id", cedula);
                    if (uA != null) {
                        request.setAttribute("message", "El usario ya se encuentra registrado.");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    } else {
                        u = new Usuarios();
                        u.setCedula(cedula);
                        u.setClave(clave);
                        u.setEmail(email);
                        u.setFechaNac(sqlDate);
                        u.setNombre(nombre);
                        uBL.save(u);
                        Usuarios a = uBL.findByOther("id", String.valueOf(u.getCedula()));
                        p = new Profesor();
                        p.setUsuarios(a.getId());
                        p.setCategoria(categoria);
                        p.setSalario(Double.valueOf(salario));
                        pBL.save(p);
                        Rol r = new Rol(0, u.getCedula(), 2);
                        rBL.save(r);
                        request.setAttribute("message", "El profesor se agregó correctamente.");
                        request.getRequestDispatcher("/profesores.jsp").forward(request, response);
                    }

                }

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
        request.setCharacterEncoding("UTF-8");
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
