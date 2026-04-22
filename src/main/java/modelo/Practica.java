/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Date;

public class Practica {
    private int id;
    private int postulacionId;
    private int supervisorId;
    private Date fechaInicio;
    private Date fechaFin;
    private String estado;
    private int horasCompletadas;
    private int horasRequeridas;
    private double calificacionFinal;
    
    // Constructor vacío
    public Practica() {
    }
    
    // Constructor con parámetros principales
    public Practica(int postulacionId, Date fechaInicio, Date fechaFin) {
        this.postulacionId = postulacionId;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.estado = "en_curso";
        this.horasCompletadas = 0;
        this.horasRequeridas = 240;
    }
    
    // Getters y setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getPostulacionId() {
        return postulacionId;
    }
    
    public void setPostulacionId(int postulacionId) {
        this.postulacionId = postulacionId;
    }
    
    public int getSupervisorId() {
        return supervisorId;
    }
    
    public void setSupervisorId(int supervisorId) {
        this.supervisorId = supervisorId;
    }
    
    public Date getFechaInicio() {
        return fechaInicio;
    }
    
    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }
    
    public Date getFechaFin() {
        return fechaFin;
    }
    
    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }
    
    public String getEstado() {
        return estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public int getHorasCompletadas() {
        return horasCompletadas;
    }
    
    public void setHorasCompletadas(int horasCompletadas) {
        this.horasCompletadas = horasCompletadas;
    }
    
    public int getHorasRequeridas() {
        return horasRequeridas;
    }
    
    public void setHorasRequeridas(int horasRequeridas) {
        this.horasRequeridas = horasRequeridas;
    }
    
    public double getCalificacionFinal() {
        return calificacionFinal;
    }
    
    public void setCalificacionFinal(double calificacionFinal) {
        this.calificacionFinal = calificacionFinal;
    }
}