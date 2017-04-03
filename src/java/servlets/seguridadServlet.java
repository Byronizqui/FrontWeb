/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.AdministradorBL;
import BL.MatriculadorBL;
import BL.RolBL;
import BL.UsuariosBL;
import LogicaNegocio.Administrador;
import LogicaNegocio.Matriculador;
import LogicaNegocio.Rol;
import LogicaNegocio.Usuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class seguridadServlet extends HttpServlet {

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
            Administrador a = null;
            AdministradorBL aBL = new AdministradorBL();
            Matriculador m = null;
            MatriculadorBL mBL = new MatriculadorBL();
            RolBL rBL = new RolBL();
            switch (data) {
                case "aAdmin": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String clave = request.getParameter("clave");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String salario = request.getParameter("salario");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    u = uBL.findByOther("id", cedula);
                    if (u != null) {
                        request.setAttribute("message", "El usario ya se encuentra registrado.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    } else {
                        u = new Usuarios();
                        u.setCedula(cedula);
                        u.setClave(clave);
                        u.setEmail(email);
                        u.setFechaNac(sqlDate);
                        u.setNombre(nombre);
                        uBL.save(u);
                        Usuarios uu = uBL.findByOther("id", String.valueOf(u.getCedula()));
                        a = new Administrador();
                        a.setUsuarios(uu.getId());
                        a.setSalario(Double.valueOf(salario));
                        aBL.save(a);
                        Rol r = new Rol(1, u.getCedula(), 2);
                        rBL.save(r);
                        request.setAttribute("message", "El administrador se agregó correctamente.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                }
                break;
                case "eAdmin": {
                    String code = request.getParameter("codigo");
                    u = uBL.findByOther("id", code);
                    Rol r = new Rol();
                    if (u != null){
                        r = rBL.findByOther("idU", u.getCedula());
                    }
                    if (r.getRol() != 1){
                        request.setAttribute("message", "No se encontró el administrador.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                    if (u != null) {
                        a = aBL.findByOther("idU", String.valueOf(u.getId()));
                        request.setAttribute("eUser", u);
                        request.setAttribute("eAd", a);
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró el administrador.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                }
                break;
                case "mAdmin": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate;
                    String idU = request.getParameter("idU");
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String salario = request.getParameter("salario");
                    date = format.parse(fecha);
                    sqlDate = new java.sql.Date(date.getTime());
                    Usuarios mU = uBL.findByOther("pK", idU);
                    if (mU == null) {
                        request.setAttribute("message", "El administrador no se encuentra en el sistema.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                    Administrador mP = aBL.findByOther("idU", String.valueOf(mU.getId()));
                    mU.setCedula(cedula);
                    mU.setEmail(email);
                    mU.setFechaNac(sqlDate);
                    mU.setNombre(nombre);
                    uBL.merge(mU);
                    mP.setSalario(Double.valueOf(salario));
                    aBL.merge(mP);
                    request.setAttribute("message", "El administrador se editó correctamente.");
                    request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                }
                break;
                case "aMatri": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate1, sqlDate2, sqlDate3;
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String clave = request.getParameter("clave");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String fechaIni = request.getParameter("fechaIni");
                    String fechaFin = request.getParameter("fechaFin");
                    date = format.parse(fecha);
                    sqlDate1 = new java.sql.Date(date.getTime());
                    date = format.parse(fechaIni);
                    sqlDate2 = new java.sql.Date(date.getTime());
                    date = format.parse(fechaFin);
                    sqlDate3 = new java.sql.Date(date.getTime());
                    u = uBL.findByOther("id", cedula);
                    if (u != null) {
                        request.setAttribute("message", "El usario ya se encuentra registrado.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    } else {
                        u = new Usuarios();
                        u.setCedula(cedula);
                        u.setClave(clave);
                        u.setEmail(email);
                        u.setFechaNac(sqlDate1);
                        u.setNombre(nombre);
                        uBL.save(u);
                        Usuarios uu = uBL.findByOther("id", String.valueOf(u.getCedula()));
                        m = new Matriculador();
                        m.setUsuarios(uu.getId());
                        m.setFechaIni(sqlDate2);
                        m.setFechaFin(sqlDate3);
                        mBL.save(m);
                        Rol r = new Rol(1, u.getCedula(), 4);
                        rBL.save(r);
                        request.setAttribute("message", "El matriculador se agregó correctamente.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                }
                break;
                case "eMatri": {
                    String code = request.getParameter("codigo");
                    u = uBL.findByOther("id", code);
                    Rol r = new Rol();
                    if (u != null){
                        r = rBL.findByOther("idU", u.getCedula());
                    }
                    if (r.getRol() != 4){
                        request.setAttribute("message", "No se encontró el matriculador.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                    if (u != null) {
                        m = mBL.findByOther("idU", String.valueOf(u.getId()));
                        request.setAttribute("eUserM", u);
                        request.setAttribute("eMatri", m);
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "No se encontró el matriculador.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                }
                break;
                case "mMatri": {
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                    java.util.Date date;
                    java.sql.Date sqlDate1, sqlDate2, sqlDate3;
                    String idU = request.getParameter("idU");
                    String cedula = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String clave = request.getParameter("clave");
                    String email = request.getParameter("email");
                    String fecha = request.getParameter("fecha");
                    String fechaIni = request.getParameter("fechaIni");
                    String fechaFin = request.getParameter("fechaFin");
                    date = format.parse(fecha);
                    sqlDate1 = new java.sql.Date(date.getTime());
                    date = format.parse(fechaIni);
                    sqlDate2 = new java.sql.Date(date.getTime());
                    date = format.parse(fechaFin);
                    sqlDate3 = new java.sql.Date(date.getTime());
                    Usuarios mU = uBL.findByOther("pK", idU);
                    if (mU == null) {
                        request.setAttribute("message", "El matriculador no se encuentra en el sistema.");
                        request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                    }
                    Matriculador mP = mBL.findByOther("idU", String.valueOf(mU.getId()));
                    mU.setCedula(cedula);
                    mU.setEmail(email);
                    mU.setFechaNac(sqlDate1);
                    mU.setNombre(nombre);
                    uBL.merge(mU);
                    mP.setFechaIni(sqlDate2);
                    mP.setFechaFin(sqlDate3);
                    mBL.merge(mP);
                    request.setAttribute("message", "El Matriculador se editó correctamente.");
                    request.getRequestDispatcher("/seguridad.jsp").forward(request, response);
                }
                break;
            }
        } catch (ParseException ex) {
            Logger.getLogger(seguridadServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(seguridadServlet.class.getName()).log(Level.SEVERE, null, ex);
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
