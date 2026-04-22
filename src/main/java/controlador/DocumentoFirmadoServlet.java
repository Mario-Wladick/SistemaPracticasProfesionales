/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
* Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
* Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
*/
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;

@WebServlet("/app/subir")
@MultipartConfig(
    maxFileSize = 10 * 1024 * 1024,      // 10MB
    maxRequestSize = 10 * 1024 * 1024,   // 10MB
    fileSizeThreshold = 1024 * 1024      // 1MB
)
public class DocumentoFirmadoServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("text/html");
        response.getWriter().write("<h1>Sistema de Firma Digital - Tocapu</h1><p>Servlet funcionando correctamente</p>");
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // Headers para CORS
    response.setHeader("Access-Control-Allow-Origin", "*");
    response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
    response.setHeader("Access-Control-Allow-Headers", "*");
    
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    try {
        System.out.println("🔥 TOCAPU: Archivo recibido correctamente");
        
        // Obtener parámetros de la URL
        String fileName = request.getParameter("name");
        
        System.out.println("📄 Nombre del archivo: " + fileName);
        System.out.println("📋 Content-Type: " + request.getContentType());
        System.out.println("📊 Content-Length: " + request.getContentLength());
        
        // Respuesta exitosa para Tocapu
        response.getWriter().write(
            "{\"success\": true, \"message\": \"Archivo procesado exitosamente\", \"fileName\": \"" + fileName + "\"}"
        );
        
        System.out.println("✅ TOCAPU: Respuesta enviada correctamente");
        
    } catch (Exception e) {
        System.err.println("❌ Error procesando archivo: " + e.getMessage());
        response.getWriter().write(
            "{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}"
        );
    }
}
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "*");
        response.setStatus(200);
    }
} 