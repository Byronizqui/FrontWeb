<%-- 
    Document   : home
    Created on : Mar 14, 2017, 9:13:09 AM
    Author     : Byron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Inicio</title>
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
        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
        <!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
        <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
    </head>
    <body class="landing">

        <!-- Header -->
        <header id="header" class="alt skel-layers-fixed">
            <%@ include file="jspf/inicio.jspf" %>
        </header>

        <!-- Banner -->
        <section id="banner">
            <div class="inner">
                <h2>Sistema de Gestión </h2>
                <p>Diseño y programación de plataformas móviles</p>
                
            </div>
        </section>
        <footer id="footer">
                <span class="copyright">
                    <a>&copy; Copyright. Lab 1 - 2 Móviles</a>	
                </span>
            </footer>
    </body>
</html>
