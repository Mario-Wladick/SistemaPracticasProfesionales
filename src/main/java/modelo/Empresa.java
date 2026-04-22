/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Timestamp;
public class Empresa {
    private int idEmpresa;
    private int idUsuario;
    private String razonSocial;
    private String ruc;
    private String descripcion;
    private String direccion;
    private String telefono;
    private String sitioWeb;
    private String sector;  // AGREGADO
    private String tipoEmpresa;  // AGREGADO
    private boolean verificada;  // AGREGADO
    private Timestamp fechaRegistro;  // AGREGADO
    private Timestamp fechaVerificacion;  // AGREGADO
    private String emailContacto;  // ← AGREGAR ESTA LÍNEA
    
    // Constructor vacío
    public Empresa() {
    }
    
    // Constructor con parámetros principales
    public Empresa(int idUsuario, String razonSocial, String ruc) {
        this.idUsuario = idUsuario;
        this.razonSocial = razonSocial;
        this.ruc = ruc;
        this.verificada = false;
        this.fechaRegistro = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters y setters
    public int getIdEmpresa() {
        return idEmpresa;
    }
    
    public void setIdEmpresa(int idEmpresa) {
        this.idEmpresa = idEmpresa;
    }
    
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getRazonSocial() {
        return razonSocial;
    }
    
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }
    
    public String getRuc() {
        return ruc;
    }
    
    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public String getDireccion() {
        return direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getSitioWeb() {
        return sitioWeb;
    }
    
    public void setSitioWeb(String sitioWeb) {
        this.sitioWeb = sitioWeb;
    }
    
    public String getSector() {  // AGREGADO
        return sector;
    }
    
    public void setSector(String sector) {  // AGREGADO
        this.sector = sector;
    }
    
    public String getTipoEmpresa() {  // AGREGADO
        return tipoEmpresa;
    }
    
    public void setTipoEmpresa(String tipoEmpresa) {  // AGREGADO
        this.tipoEmpresa = tipoEmpresa;
    }
    
    public boolean isVerificada() {  // AGREGADO
        return verificada;
    }
    
    public void setVerificada(boolean verificada) {  // AGREGADO
        this.verificada = verificada;
    }
    
    public Timestamp getFechaRegistro() {  // AGREGADO
        return fechaRegistro;
    }
    
    public void setFechaRegistro(Timestamp fechaRegistro) {  // AGREGADO
        this.fechaRegistro = fechaRegistro;
    }
    
    public Timestamp getFechaVerificacion() {  // AGREGADO
        return fechaVerificacion;
    }
    
    public void setFechaVerificacion(Timestamp fechaVerificacion) {  // AGREGADO
        this.fechaVerificacion = fechaVerificacion;
    }
    
    // ← AGREGAR ESTOS MÉTODOS AL FINAL:
    public String getEmailContacto() {
        return this.emailContacto;
    }
    
    public void setEmailContacto(String emailContacto) {
        this.emailContacto = emailContacto;
    }
    
}