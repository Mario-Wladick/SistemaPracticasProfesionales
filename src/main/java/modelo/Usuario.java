/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Timestamp;

public class Usuario {
    private int idUsuario;
    private String username;
    private String email;  // AGREGADO
    private String password;
    private String tipoUsuario;
    private boolean estado;
    private Timestamp fechaRegistro;
    private Timestamp ultimoAcceso;  // AGREGADO
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor con parámetros principales
    public Usuario(String username, String email, String password, String tipoUsuario) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.tipoUsuario = tipoUsuario;
        this.estado = true;
        this.fechaRegistro = new Timestamp(System.currentTimeMillis());
    }
    
    // Getters y setters
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {  // AGREGADO
        return email;
    }
    
    public void setEmail(String email) {  // AGREGADO
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getTipoUsuario() {
        return tipoUsuario;
    }
    
    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }
    
    public boolean isEstado() {
        return estado;
    }
    
    public void setEstado(boolean estado) {
        this.estado = estado;
    }
    
    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }
    
    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
    
    public Timestamp getUltimoAcceso() {  // AGREGADO
        return ultimoAcceso;
    }
    
    public void setUltimoAcceso(Timestamp ultimoAcceso) {  // AGREGADO
        this.ultimoAcceso = ultimoAcceso;
    }
    
    @Override
    public String toString() {
        return "Usuario{" +
                "idUsuario=" + idUsuario +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", tipoUsuario='" + tipoUsuario + '\'' +
                ", estado=" + estado +
                '}';
    }
}