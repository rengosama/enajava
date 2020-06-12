
package verificacion;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//en caso de no estar conectada la base de datos no mostra ningun dato de los select

@WebServlet(name = "Controlador", urlPatterns = {"/controlador"})
public class Controlador extends HttpServlet {

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
        
        //comienza con la autentificacion que es acto 1
        if("1".equals(request.getParameter("acto"))){
            
        //verifica que no sean nullos o sin texto antes que nada los campos y en caso contrario mostrara un mensaje para que 
        //el usuario ingrese su inicio de sesion
        
        if(!"".equals(request.getParameter("usuario")) && request.getParameter("usuario")!=null
        &&!"".equals(request.getParameter("clave")) && request.getParameter("clave")!=null){
            
        //se conecta a la bdd con la consulta correspondiente en la tabla usuariosla cual de todos los usuarios registrados los
        //reccore para ver si coinciden que el que se ha ingresado
        try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
        String query="select nick,contraseña from usuarios ";
        Statement st=conn.createStatement();
        ResultSet rs=st.executeQuery(query);
        while(rs.next()){
            
            //si el usuario ingresado coincide con los usuarios registrados accedera al menu principal
            if(request.getParameter("usuario").equals(rs.getString("nick"))
            &&request.getParameter("clave").equals(rs.getString("contraseña")) ){
            request.getRequestDispatcher("Menu_principal.jsp").forward(request, response);
            }
        }{
        //en caso que no encuentre registros coincidentes mandara el siguiente mensaje 
        request.setAttribute("vacio","Su nombre de usuario y contraseña no coinciden con un usuario registrado");
        request.getRequestDispatcher("index.jsp").forward(request, response);}
        
        //en caso que no este conectada la bdd mandara el siguiente mensaje y cargara la pagina otra vez 
        //evitando que se caiga
        }catch(ClassNotFoundException | SQLException e){
            request.setAttribute("vacio","No hay conexion");
            request.getRequestDispatcher("index.jsp").forward(request, response);}
        }
        //manda el siguiente mensaje si no se ingresan datos en los campos y oprimen el submit
        else{
            request.setAttribute("vacio","Ingrese su nombre de usuario y contraseña");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        }
        
        //acto 2 ingresar requerimientos
        if("2".equals(request.getParameter("acto"))){ 
            
            //se valida que los campos no tengan los valores por defecto de los option y el campo
            //descripcion verifica que no este vacio y sea menor a 300 caracteres
        if(!"1".equals(request.getParameter("gerencia")) && 
        !"1".equals(request.getParameter("departamentog")) && 
        !"1".equals(request.getParameter("departamentosm")) &&
        !"1".equals(request.getParameter("encargados")) &&
        !"".equals(request.getParameter("descripcion")) &&
        300>=request.getParameter("descripcion").length() ){
        
            //conecta a la bdd cada valor a insertar sera los parametros pasados a travez de los option de cada campo mas el campo de texto
            //descripcion del requerimiento
        try{
            int update;
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
        String query="INSERT INTO requerimientos VALUES('"+request.getParameter("gerencia")+"','"+request.getParameter("departamentog")+"','"+
        request.getParameter("departamentosm")+"','"+request.getParameter("encargados")+"','"+request.getParameter("descripcion")+"','Abierto',null)";
        Statement st=conn.createStatement();
        update=st.executeUpdate(query);
        //confirma al usuario el registro del requerimiento
        if(update==1){
            request.setAttribute("vacio1","El requerimiento se a registrado correctamente ");
        }
        request.getRequestDispatcher("Ingresar_requerimiento.jsp").forward(request, response);
        }
        //en caso de falla mandara el siguiente mensaje
        catch(ClassNotFoundException | SQLException e){
            request.setAttribute("vacio1","El requerimiento que ingreso ya se encuentra registrado o no hay conexion con la base de datos");
            request.getRequestDispatcher("Ingresar_requerimiento.jsp").forward(request, response);
        }  
        //en caso que los campo no se ubieran ingresado valores o supere los 300 caracteres descripcion enviara el siguiente mensaje
        }else{
        request.setAttribute("vacio1","Ingrese parametros validos, recuerde que la"
        + " descripcion del requerimiento solo puede contener maximo 300 caracateres ");
        request.getRequestDispatcher("Ingresar_requerimiento.jsp").forward(request, response); 
        }
        
        }
        
        
        
        
        //consulta los requerimietos acto 3
        if("3".equals(request.getParameter("acto"))){
            
            //se crea la consulta predeterminada
            String query1="select*from requerimientos ";
            String p1="";
            String p2="";
            String p3="";
            
            //si se selecciona una opcion de gerencia agrega la condicion del where para que muestre segun ese gerente se agrega a p1 que se concatenara 
            //con las demas variables
            if(!"1".equals(request.getParameter("gerencia"))){
                p1="where gerencia='"+request.getParameter("gerencia")+"' ";
            }
            
            //consulta si se ingreso un dato pregunta si se eligio un gerente estonces pasa a ser el else que pone el and en vez de where en caso que
            //se ubiera elegido un gerente y se concatenara con las demas
            if(!"1".equals(request.getParameter("departamentog"))){
                
                if("".equals(p1)){
                    p2="where departamento='"+request.getParameter("departamentog")+"' ";
                }else{
                    p2="and departamento='"+request.getParameter("departamentog")+"' ";
                }
                
            }
            //pregunta si selecciono un dato  de los departamentos de mantencion si se selecciono una opcion si los campos anteriores no se seleccionaron
            // opciones se asigna la condicion where y si se seleccionaron opciones añade el and
            if(!"1".equals(request.getParameter("departamentosm"))){
                
                if("".equals(p1) || "".equals(p2)){
                    p3="where departamentom='"+request.getParameter("departamentosm")+"' ";
                }else{
                    p3="and departamentom='"+request.getParameter("departamentosm")+"' ";
                }
                
            }
            
            //se concatena tod para hacer la consulta completa segun las opciones que se eligieron 
            String query2=query1+""+p1+""+p2+""+p3;
            
            //se envia el string concatenado
            request.setAttribute("query1",query2);
            
            request.getRequestDispatcher("Consultar_requerimientos.jsp").forward(request, response); 
        }
        
        
        
        
        //lo mismo que acto 3 consultar requerimiento este hace la consulta para buscar requerimietnos a cerrar
        // en cerrar requerimientos acto 4 
        if("4".equals(request.getParameter("acto"))){
            
            
            String query1="select*from requerimientos ";
            String p1="";
            String p2="";
            String p3="";
            
            if(!"1".equals(request.getParameter("gerencia"))){
                p1="where gerencia='"+request.getParameter("gerencia")+"' ";
            }
            
            if(!"1".equals(request.getParameter("departamentog"))){
                
                if("".equals(p1)){
                    p2="where departamento='"+request.getParameter("departamentog")+"' ";
                }else{
                    p2="and departamento='"+request.getParameter("departamentog")+"' ";
                }
                
            }
            
            if(!"1".equals(request.getParameter("departamentosm"))){
                
                if("".equals(p1) && "".equals(p2)){
                    p3="where departamentom='"+request.getParameter("departamentosm")+"' ";
                }else{
                    p3="and departamentom='"+request.getParameter("departamentosm")+"' ";
                }
                
            }
            
            String query2=query1+""+p1+""+p2+""+p3;
            
            request.setAttribute("query1",query2);
            
            request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response); 
        }
        
        
        
        
        //aqui este es el complemento de cerrar requerimiento acto 5 se envia el parametro del requerimiento a cerra
        //en la base de datos se les asigno un codigo unico autoincrementable que identifica los requerimientos
        //el cual aqui se utilizara para darle a ese requerimiento el estado de cerrado con el update
        if("5".equals(request.getParameter("acto"))){
        
        try{
        int update;
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull","root","");
        String query="update requerimientos set estado='Cerrado' where codigo="+request.getParameter("codigo")+"";
        Statement st=conn.createStatement();
        update=st.executeUpdate(query);
        
        //envia el siguiente mensaje si cambio el requerimiento correctamente
        if(update==1){
            request.setAttribute("vacio","El requerimiento se cerro correctamente");
        }
        request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response);
        }
        //en caso de error enviara el siguiente mensaje
        catch(ClassNotFoundException | SQLException e){
            request.setAttribute("vacio","se a perdido la conexion");
            request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response);
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
