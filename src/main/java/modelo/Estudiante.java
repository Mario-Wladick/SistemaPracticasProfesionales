/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

public class Estudiante {
    private int idEstudiante;
    private int idUsuario;
    private String codigoUniversitario;
    private String nombres;
    private String apellidos;
    private String dni;
    private String email;  // AGREGADO
    private String telefono;
    private String especialidad;
    private int ciclo;
    private double promedioPonderado;
    
    // Constructor vacío
    public Estudiante() {
    }
    
    // Constructor con parámetros principales
    public Estudiante(int idUsuario, String codigoUniversitario, String nombres, String apellidos, String dni) {
        this.idUsuario = idUsuario;
        this.codigoUniversitario = codigoUniversitario;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
    }
    
    // Getters y setters
    public int getIdEstudiante() {
        return idEstudiante;
    }
    
    public void setIdEstudiante(int idEstudiante) {
        this.idEstudiante = idEstudiante;
    }
    
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getCodigoUniversitario() {
        return codigoUniversitario;
    }
    
    public void setCodigoUniversitario(String codigoUniversitario) {
        this.codigoUniversitario = codigoUniversitario;
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
    
    public String getDni() {
        return dni;
    }
    
    public void setDni(String dni) {
        this.dni = dni;
    }
    
    public String getEmail() {  // AGREGADO
        return email;
    }
    
    public void setEmail(String email) {  // AGREGADO
        this.email = email;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getEspecialidad() {
        return especialidad;
    }
    
    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }
    
    public int getCiclo() {
        return ciclo;
    }
    
    public void setCiclo(int ciclo) {
        this.ciclo = ciclo;
    }
    
    public double getPromedioPonderado() {
        return promedioPonderado;
    }
    
    public void setPromedioPonderado(double promedioPonderado) {
        this.promedioPonderado = promedioPonderado;
    }
    
    // Método helper para nombre completo
    public String getNombreCompleto() {
        return nombres + " " + apellidos;
    }
}