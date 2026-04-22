/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Map;  // ← AGREGAR ESTE IMPORT

public class OfertaPractica {
    private int id;
    private int empresaId;
    private String titulo;
    private String descripcion;
    private String requisitos;
    private String modalidad;
    private String area;
    private int duracionMeses;
    private int vacantes;
    private Date fechaLimitePostulacion;
    private String estado;
    private Timestamp fechaPublicacion;
    
    // ← AGREGAR ESTOS NUEVOS ATRIBUTOS:
    private boolean yaPostulo;
    private Map<String, String> empresa;
    private double remuneracion;
    
    // Constructor vacío
    public OfertaPractica() {
    }
    
    // Constructor con parámetros principales
    public OfertaPractica(int empresaId, String titulo, String descripcion, String modalidad, String area) {
        this.empresaId = empresaId;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.modalidad = modalidad;
        this.area = area;
        this.estado = "activa";
        this.vacantes = 1;
        this.fechaPublicacion = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters y setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getEmpresaId() {
        return empresaId;
    }
    
    public void setEmpresaId(int empresaId) {
        this.empresaId = empresaId;
    }
    
    public String getTitulo() {
        return titulo;
    }
    
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getRequisitos() {
        return requisitos;
    }
    
    public void setRequisitos(String requisitos) {
        this.requisitos = requisitos;
    }
    
    public String getModalidad() {
        return modalidad;
    }
    
    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }
    
    public String getArea() {
        return area;
    }
    
    public void setArea(String area) {
        this.area = area;
    }
    
    public int getDuracionMeses() {
        return duracionMeses;
    }
    
    public void setDuracionMeses(int duracionMeses) {
        this.duracionMeses = duracionMeses;
    }
    
    public int getVacantes() {
        return vacantes;
    }
    
    public void setVacantes(int vacantes) {
        this.vacantes = vacantes;
    }
    
    public Date getFechaLimitePostulacion() {
        return fechaLimitePostulacion;
    }
    
    public void setFechaLimitePostulacion(Date fechaLimitePostulacion) {
        this.fechaLimitePostulacion = fechaLimitePostulacion;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public Timestamp getFechaPublicacion() {
        return fechaPublicacion;
    }
    
    public void setFechaPublicacion(Timestamp fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }
    
    // ← AGREGAR TODOS ESTOS MÉTODOS NUEVOS:
    
    public int getIdOferta() {
        return this.id;
    }
    
    public void setYaPostulo(boolean yaPostulo) {
        this.yaPostulo = yaPostulo;
    }
    
    public boolean isYaPostulo() {
        return yaPostulo;
    }
    
    public Map<String, String> getEmpresa() {
        return this.empresa;
    }
    
    public void setEmpresa(Map<String, String> empresa) {
        this.empresa = empresa;
    }
    
    public String getConocimientosRequeridos() {
        return this.requisitos;
    }
    
    public double getRemuneracion() {
        return this.remuneracion;
    }
    
    public void setRemuneracion(double remuneracion) {
        this.remuneracion = remuneracion;
    }
    
    public int getDuracion() {
        return this.duracionMeses;
    }
    public int getIdEmpresa() {
    return this.empresaId;
}
}