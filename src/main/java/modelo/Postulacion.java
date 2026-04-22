/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Timestamp;

public class Postulacion {
    private int id;
    private int estudianteId;
    private int ofertaId;
    private String cartaPresentacion;
    private String estado;
    private Timestamp fechaPostulacion;
    private Timestamp fechaRespuesta;
    private String comentariosEmpresa;
    
    // Constructor vacío
    public Postulacion() {
    }
    
    // Constructor con parámetros principales
    public Postulacion(int estudianteId, int ofertaId, String cartaPresentacion) {
        this.estudianteId = estudianteId;
        this.ofertaId = ofertaId;
        this.cartaPresentacion = cartaPresentacion;
        this.estado = "pendiente";
        this.fechaPostulacion = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters y setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getEstudianteId() {
        return estudianteId;
    }
    
    public void setEstudianteId(int estudianteId) {
        this.estudianteId = estudianteId;
    }
    
    public int getOfertaId() {
        return ofertaId;
    }
    
    public void setOfertaId(int ofertaId) {
        this.ofertaId = ofertaId;
    }
    
    public String getCartaPresentacion() {
        return cartaPresentacion;
    }
    
    public void setCartaPresentacion(String cartaPresentacion) {
        this.cartaPresentacion = cartaPresentacion;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public Timestamp getFechaPostulacion() {
        return fechaPostulacion;
    }
    
    public void setFechaPostulacion(Timestamp fechaPostulacion) {
        this.fechaPostulacion = fechaPostulacion;
    }
    
    public Timestamp getFechaRespuesta() {
        return fechaRespuesta;
    }
    
    public void setFechaRespuesta(Timestamp fechaRespuesta) {
        this.fechaRespuesta = fechaRespuesta;
    }
    
    public String getComentariosEmpresa() {
        return comentariosEmpresa;
    }
    
    public void setComentariosEmpresa(String comentariosEmpresa) {
        this.comentariosEmpresa = comentariosEmpresa;
    }
    

}
