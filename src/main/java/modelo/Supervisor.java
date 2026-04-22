/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

public class Supervisor {
    private int id;
    private int usuarioId;
    private int empresaId;
    private String nombres;
    private String apellidos;
    private String cargo;
    private String telefono;
    
    // Constructor vacío
    public Supervisor() {
    }
    
    // Constructor con parámetros
    public Supervisor(int usuarioId, int empresaId, String nombres, String apellidos, String cargo) {
        this.usuarioId = usuarioId;
        this.empresaId = empresaId;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.cargo = cargo;
    }
    
    // Getters y setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUsuarioId() {
        return usuarioId;
    }
    
    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }
    
    public int getEmpresaId() {
        return empresaId;
    }
    
    public void setEmpresaId(int empresaId) {
        this.empresaId = empresaId;
    }
    
    public String getNombres() {
        return nombres;
    }
    
    public void setNombres(String nombres) {
        this.nombres = nombres;
    }
    
    public String getApellidos() {
        return apellidos;
    }
    
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
    
    public String getCargo() {
        return cargo;
    }
    
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getNombreCompleto() {
        return nombres + " " + apellidos;
    }
}
