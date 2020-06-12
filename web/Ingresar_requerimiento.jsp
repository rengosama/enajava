<%-- 
    Document   : Ingresar_requerimiento
    Created on : 31-may-2020, 7:37:47
    Author     : felip
--%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<!mensaje segun verificaciones>
<%
    String formato=(String) request.getAttribute("vacio1"); 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingresar Requerimiento</title>
        <!importa la libreria de jquery atravez de google puede descargarse la libreria>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            //$(document).ready(function() permite que cargue la pagina antes de usar las funciones
	    $(document).ready(function(){
                
            //jquery change funtionc es para cuando cambie la lista de gerentes
            $('#listag').change(function(){
                
            //jquery dentro del change que borra las opciones de departamentos al hacer un cambio en la lista de gerentes
            $("#listad").empty();
            
            //llama la funcion java script recargar lista, se explicara mas adelante
            recargarlista1();
            });
            });
            
            //se crea la variable gerentes que guardara los gerentes existentes
            var gerentes=[];
            
            //se llama a la conexion con la base de datos
            <%try{ 
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
            
            //en la base de datos el gerente y el departamento del gerente
            //se encuentran juntos en la tabla gerencia, se ejecuta la consulta para mostrar todos los gerentes
            String query="select distinct gerente from gerencia";
            Statement st=conn.createStatement();
            ResultSet rs=st.executeQuery(query);
            
            //la variable i sera importante ya que en javascript aun no aprendo a trabajar matrices se explicara mas adelante
            int i=0;
            
            //en este while se crea se comienzan a guardar todos los registros de gerente en la variable java script
            //gerentes[gerentes.length] que guarda el dato en el ultimo registro del array como no tiene registros 
            //lo guarda en el indice 0
            //se crea la variable javascript var departamento"numero de la variable i"=[] la cual se crean en base a la cantidad de registros de gerentes
            //que mas adelante guardara los departamentos (son variables distintas ya que cambia su nombre con cada bucle)
            while(rs.next()){%>
            gerentes[gerentes.length]="<%=rs.getString("gerente")%>";
            var departamento<%=i%>=[];
            
            //la variable i va suamndo cada registro que guarda, osea es la cantidad de variables departamento(i)=[] y
            // es la que cambia su nombre, a su ves es el mismisimo indice para identificar y llamar las variables mas adelante
            <%i=i+1;}
            
            //se ejecuta la consulta que entrega el gerente y su departamento ya que se necesitara el gerente para la condicion
            //y el departamento para asignar los valores
            query="select depgerente, gerente from gerencia";
            rs=st.executeQuery(query);

            //el siguiente while realizara la funcion de asignar los valores a las variables departamento(i)=[]
            while(rs.next()){

            //el siguiente for dentro del while realizara la funcion que recorrera las variables departamento(i)
            //la condicion JAVASCRIPT sera si el gerente guardado en LA VARIABLE gerentes indice 0
            //corresponde a la del registro que entrega la consulta del campo gerente
            //sino corresponde seguira el bucle preguntando si el siguiente encargado corresponde al registro
            //si corresponde se guardara en la variable encargados con su propio indice ejemplo:
            // gerentes[0] corresponde al indice de departamento[0]=[] en la variable departamento se guardaran
            //todos los departamentos a los que pertenesca el gerente guardado en el indice gerentes[0]
            //estonces el bucle for con la variable i es la que sabe el numero de gerentes guardados en gerentes[]
            //estonces el bucle no puede exederce ya que es todo preciso y sin errores pensado para que si se
            //ingresan mas gerentes en la bdd los guarde y realize su respectiva asignacion, cada gerente tendra su variable departamento
            //con su propio indice tambien se podran asignar mas de un departamento a un gerente y se guardara correctamente
            //puede ser engorroso pero es la manera mas ultil y propia que encontre para que carge datos segun los registros
            //de la base de datos
            for(int e=0;e<i;e++){%>
            
                if(gerentes[<%=e%>]==="<%=rs.getString("gerente")%>"){
                departamento<%=e%>[departamento<%=e%>.length]="<%=rs.getString("depgerente")%>";
            
            }
            <%}}%>
            //se crea la funcion recargar lista que es llamada en la funcion change
            // ya que en la funcion jquery change al hacer un cambio en el select de gerentes se ejecuta
            //con la funcion empty de jquery se vacio la lista opciones de departamentos 
            // append agrega a la listad(departamentos)que es la id, agrega la opcion 1 que es la por defecto
            function recargarlista1(){
                $("#listad").append("<option value=\"1\" label=\"Todos\"></option>");
                
            //aqui se crea un bucle que preguntara por todos los gerentes guardados en la variable gerentes
            //nuevamente se ocupa la variable i que tiene el numero de gerentes guardados
            //con lo cual se ejecuta hasta encontrar el gerente que que se busca en la condicion
            <%for(int e=0;e<i;e++){%>
                    
            //condicion javascript que recorre los registros guardados el cual mediante el for compara si el valor de
            //la lista de gerentes (listag) que es su id, .val que obtiene el valor del select de gerente
            //la variable e como recorre los registros es puesta en el indice de gerentes que a su ves es comparada con el
            //valor del select de gerentes si es correcto se implementara ese mismo indice e en la variable departamento ya que en el ejemplo 
            //anterior se dijo que la variable gerentes el gerente guardado en el indice corresponde al nombre de la variable 
            //departamento(mas el numero que esta ingresado en el nombre de la variable este numero
            //es el indice de la variable gerentes) esto se puede comprobar en configuraciones
            //del navegador herramientas de desarrollador ponga la pestaña consola y al seleccionar un gerente en las opciones
            //coloque en la consola departamento le sadran distintos nombres ejemplo departamento0,departamento1,departamento2
            //seleccione cualquiera y mostrara los departamentos que a su ves el ultimo numero de la variable departamento"aqui"
            //que selecciono corresponde al indice de la variable gerentes["aqui"] que tambien puede ver en consola escribiendo
            //gerentes
                       if(gerentes[<%=e%>]===$("#listag").val()){
                           
            //for javascript que segun el indice de gerentes["este"] del if se coloca en el nombre de departamento"aqui"
            //y se cuenta la cantidad de indices con el metodo length y repetir segun departamentos del gerente
            // realiza el blucle para agregar las opciones al select de listad que es el id de departamento
            //se cuentan los indices dentro de la variable departamento"e"[e] y se imprimen con el append uno a uno
                           for(i=0;i<departamento<%=e%>.length;i++){
            $("#listad").append("<option value='"+departamento<%=e%>[i]+"'>"+departamento<%=e%>[i]+"</option>");
            };};
            <%}%>
            }
            <%}catch(Exception e){}%>
            
            </script>
            <!mismo codigo diferentes campos>
        <script>
            //$(document).ready(function() permite que cargue la pagina antes de usar las funciones
	    $(document).ready(function(){
            $('#listam').change(function(){
            $("#lista2").empty();
            recargarlista();
            });
            });
            var departamentom=[];
            <%try{ 
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
            String query="select departamento from depa";
            Statement st=conn.createStatement();
            ResultSet rs=st.executeQuery(query);
            int i=0;
            while(rs.next()){%>
            departamentom[departamentom.length]="<%=rs.getString("departamento")%>";
            var encargados<%=i%>=[];
            <%i=i+1;}
            query="select departamento,encargado from encargados";
            rs=st.executeQuery(query);
            while(rs.next()){
            for(int e=0;e<i;e++){%>
            
                if(departamentom[<%=e%>]==="<%=rs.getString("departamento")%>"){
                encargados<%=e%>[encargados<%=e%>.length]="<%=rs.getString("encargado")%>";
            
            }
            <%}}%>
            
            function recargarlista(){
                $("#lista2").append("<option value=\"1\" label=\"Seleccione\"></option>");
            <%for(int e=0;e<i;e++){%>
                       if(departamentom[<%=e%>]===$("#listam").val()){
                           for(i=0;i<encargados<%=e%>.length;i++){
            $("#lista2").append("<option value='"+encargados<%=e%>[i]+"'>"+encargados<%=e%>[i]+"</option>");
            };};
            <%}%>
            }
            <%}catch(Exception e){}%>
            
            </script>
            <style>
                table{
                border:black 3px solid;
                
                background: whitesmoke}
            
                body{background: appworkspace;}
            </style>
    </head>
    <body>
        <c:set var = "now" value = "<%= new java.util.Date()%>" />
        <p>Fecha y hora de entrada: <fmt:formatDate type = "both" 
         value = "${now}" /></p>
        <h1>Ingresar Requerimiento</h1>
        <hr>
        <form action="controlador" method="POST">
            
            <table>
                
                <tr><td><br></td><td></td></tr>
                    <!datos cargados de la base de datos gerentes >
                <tr>
                    <td>Gerencia</td><td><select id="listag" name="gerencia" style="width:200px" >
                    <option value="1" label="Seleccione"></option>
                    <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
                    String query="select distinct gerente from gerencia ";
                    Statement st=conn.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    while(rs.next()){%>
                    
                    <option value="<%=rs.getString("gerente")%>" label="<%=rs.getString("gerente")%>"></option>
                    <%}
                    }catch(Exception e){}%>
                    </select></td>
                </tr>
                
                <tr><td><br></td><td></td></tr>
                
                    <!este select de departamentos de gerentes se recargara a travez de la funcion de javascript,jquery antes descrita>
                <tr>
                    <td>Departamento</td><td><select id="listad" name="departamentog" style="width:200px" >
                    <option value="1" label="Seleccione"></option>
                    </select></td>
                </tr>
                
                <tr><td><br></td><td></td></tr>
                    
                <!datos cargados de la bdd de departamentos de mantencion >
                <tr>
                    <td>Asignado a</td><td><select id="listam" style="width:200px" name="departamentosm">
                    <option value="1" label="Seleccione"></option>
                    <%
                    try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
                    String query="select departamento from depa ";
                    Statement st=conn.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    while(rs.next()){%>
                    
                    <option value="<%=rs.getString("departamento")%>" label="<%=rs.getString("departamento")%>"></option>
                            
                    <%}
                    }catch(Exception e){}
                    %>
                    </select></td>
                </tr>
                    
                <tr><td><br></td><td></td></tr>
                  
                <!este select se cargara con las funciones anteriores de js,jq >
                <tr>
                    <td>Encargado</td><td><select id="lista2" style="width:200px;" name="encargados">
                    <option value="1" label="Seleccione"></option>
                    </select></td>
                </tr>
                    
                <tr><td><br></td><td></td></tr>
                    
                <!campo requerimiento>
                <tr>
                    <td>Requerimiento :</td><td><input type='text' name='descripcion' style="width:200px;height:50px"></td>
                </tr>
                    
                <tr><td><br></td><td></td></tr>
                    
                    <tr>
                        <td><input type='submit' value="Guardar" name="guardar"></td><td></td>
                    </tr>
                    
                    <tr><!identificador de pagina>
                        <td><input type='hidden' name="acto" value="2"></td><td></td>
                    </tr>
            </table>
                    
        </form>
        <br>
        <!consulta si hay mensaje para mostrar>
        <%if(formato!=null){%>
        <p align="center"><%=formato%></p>
        <%}%>
        <br>
        <!form para volver al menu principal>
        <form action="Menu_principal.jsp">
        <input type='submit' value="Volver al menu principal"  size='12'>
        </form>
    </body>
</html>
