/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import BL.RolBL;
import BL.UsuariosBL;
import LogicaNegocio.Rol;
import LogicaNegocio.Usuarios;
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
public class loginServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        Usuarios u = null;
        UsuariosBL uBL = new UsuariosBL();
        RolBL rBL = new RolBL();
        HttpSession session = request.getSession();
        List<Usuarios> lista = new ArrayList();

        String data = request.getParameter("data");

        switch (data) {
            case "login": {
                try {
                    lista = uBL.findAll(Usuarios.class.getName());
                } catch (SQLException ex) {
                    Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                String usuario = request.getParameter("usuario");
                String contra = request.getParameter("contrasena");
                for (Usuarios usuarios : lista) {
                    if (usuarios.getCedula().equals(usuario) && usuarios.getClave().equals(contra)) {
                        u = usuarios;
                        break;
                    }
                }
                if (u != null) {
                    String nombre = u.getNombre();
                    int i = u.getId();
                    String id = String.valueOf(i);
                    session.setAttribute("usuario", u);
                    session.setAttribute("nombre", nombre);
                    session.setAttribute("id", u.getCedula());
                    Rol r = new Rol();
                    try {
                        r = rBL.findByOther("idU", u.getCedula());
                    } catch (SQLException ex) {
                        Logger.getLogger(loginServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    switch (r.getRol()) {
                        case 1:
                            session.setAttribute("tipo", "1");
                            break;
                        case 3:
                            session.setAttribute("tipo", "3");
                            break;
                        case 2:
                            session.setAttribute("tipo", "2");
                            break;
                        case 4: {
                            session.setAttribute("tipo", "4");
                        }
                        default:
                            break;
                    }
                    
                    session.setAttribute("session", "1");
                    response.sendRedirect("/home.jsp");
                } else {
                    response.sendRedirect("/login.jsp");
                }
            }
            break;
            case "logout": {
                session.removeAttribute("usuario");
                session.removeAttribute("nombre");
                session.removeAttribute("tipo");
                session.removeAttribute("id");
                session.removeAttribute("lCiclos");
                session.invalidate();
                response.sendRedirect("/login.jsp");
            }
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
