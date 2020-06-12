
<%@page import="java.util.concurrent.ExecutionException"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String formato=(String) request.getAttribute("vacio"); 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AUTENTICACIÓN</title>
        <style>
            table{width:300px;
                border:black 3px solid;
                margin-left: auto;
                margin-right: auto;
                background: whitesmoke;}
            
            body{background: gainsboro;}
            
            h1,h2{text-align: center;}
            
        </style>
    </head>
    <body>
        <c:set var = "now" value = "<%= new java.util.Date()%>" />
        <p>Fecha y hora de entrada: <fmt:formatDate type = "both" 
         value = "${now}" /></p>
        <h1>Autentificacion</h1>
        <hr>
        <!envia los datos del usuario para verificar>
        <form action="controlador" method="POST">
            <table>
                <tr><td><br></td><td></td></tr>
                
                <tr><td>Usuario  :</td><td><input type='text' name="usuario"  size='12'></td></tr>
                
                <tr><td><br></td><td></td></tr>
                
                <tr><td>Password :</td><td><input type='password' name='clave'  size='12'></td></tr>
                
                <tr><td><br></td><td></td></tr>
            
                <tr><td><input align="center" type="checkbox" name="recordar" value="ON" /><label>recordar</label></td><td></td></tr>
                
                <tr><td><br></td><td></td></tr>
                
                <tr><td><input align="center" type="submit" value="Ingresar" name="ingresar"/></td><td></td></tr>
                
                </table>
            <!indentificador de pagina>
            <input type='hidden' name='acto' value="1" >
            <br><br>
        </form>
        <!consulta si hay mensaje segun verificacion>
        <%if(formato!=null){%>
            <h2><%=formato%></h2>
            <%}%>
    </body>
</html>
