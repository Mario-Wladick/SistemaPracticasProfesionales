/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/reactjs.jsx to edit this template
 */
// ================================
// TOCAPU INTEGRATION - BÁSICO
// ================================

// Configuración
const TOCAPU_CONFIG = {
    urlLogo: "https://oti.unap.edu.pe/recursos/oti-c.png",
    urlFrom:  "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    urlSend: window.location.origin + "/SistemaPracticasProfesionales-1.0-SNAPSHOT/app/subir"
};

// Función principal para firmar
function signTocapu(tipoUsuario, idPostulacion, contexto = {}) {
    console.log("🔥 Iniciando Tocapu:", tipoUsuario, idPostulacion);
    obj.href = "tocapusign:?url_logo=" + encodeURIComponent(TOCAPU_CONFIG.urlLogo) +
           "&environment=demo" +
           "&from=" + encodeURIComponent(TOCAPU_CONFIG.urlFrom) +
           "&to=" + encodeURIComponent(TOCAPU_CONFIG.urlSend) +
           "&vis_sig_x=128&vis_sig_y=190&vis_sig_width=230&vis_sig_height=46&vis_sig_page=1" +
           "&vis_sig_text=" + encodeURIComponent("FIRMANTE\n\nTITULO\n\n" + fileName + "\nFecha: FECHA\nfirmaUNA 2025 - Gobierno Electronico UNAP");
    
    // Generar nombre del archivo
    const timestamp = new Date().getTime();
    let fileName = "";
    
    if (tipoUsuario === "estudiante") {
        fileName = `postulacion_${idPostulacion}_${timestamp}.pdf`;
    } else if (tipoUsuario === "empresa") {
        fileName = `contrato_${idPostulacion}_${timestamp}.pdf`;
    }
    
    // URL simplificada para Tocapu
    const tocapuUrl = `tocapusign:?environment=demo&from=${encodeURIComponent(TOCAPU_CONFIG.urlFrom)}&to=${encodeURIComponent(TOCAPU_CONFIG.urlSend + "?name=" + fileName)}`;
    
    console.log("URL Tocapu:", tocapuUrl);
    
    // Crear enlace para Tocapu
    const obj = document.createElement("A");
    obj.href = tocapuUrl;
    
    // Activar Tocapu
    obj.click();
    
    alert("Proceso de firma iniciado. Complete la firma en Tocapu.");
}
// Funciones específicas
function firmarPostulacion(idPostulacion) {
    if (confirm("¿Deseas firmar digitalmente tu postulación?")) {
        signTocapu("estudiante", idPostulacion);
    }
}

function firmarAceptacion(idPostulacion) {
    if (confirm("¿Deseas firmar digitalmente la aceptación?")) {
        signTocapu("empresa", idPostulacion);
    }
}

// Inicialización
document.addEventListener('DOMContentLoaded', function() {
    console.log("🚀 Tocapu integration loaded");
});