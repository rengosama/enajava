<%-- 
    Document   : Menu_principal
    Created on : 31-may-2020, 7:37:13
    Author     : felip
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Principal</title>
        <style>
            table{width:300px;
                border:black 3px solid;
                margin-left: auto;
                margin-right: auto;
                background: whitesmoke}
            
            body{background: gainsboro;}
            
        </style>
    </head>
    <body>
        
        <h1 align="center">Menu Principal</h1>
        <hr>
        <!menu principal solo son enlaces de las tres paginas ingresar requerimiento consultar y cerrar>
        <table>
            <tr><td><img src="imagenes/edit-list.png" width="20" height="20" alt="edit-list"/></td><td><a href="Ingresar_requerimiento.jsp" style="color:black;"><h2>Ingresar requerimiento</h2></a></td></tr>
        </table>
        <br>
        <table>
            <tr><td><img src="imagenes/edit-list.png" width="20" height="20" alt="edit-list"/></td><td><a href="Consultar_requerimientos.jsp" style="color:black;"><h2>Consultar requerimiento</h2></a></td></tr>
        </table>
        <br>
        <table>
            <tr><td><img src="imagenes/edit-list.png" width="20" height="20" alt="edit-list"/></td><td><a href="Cerrar_requerimientos.jsp" style="color:black;"><h2>Cerrar requerimientos</h2></a></td></tr>
        </table>
          
    </body>
</html>
