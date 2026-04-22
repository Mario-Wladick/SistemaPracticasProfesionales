/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Timestamp;

/**
 * Clase que representa un informe parcial de práctica.
 */
public class Informe {
    private int idInforme;
    private int idPractica;
    private int numeroInforme;
    private Timestamp fechaPresentacion;
    private String archivo;
    private String comentarios;
    private boolean aprobado;
    
    /**
     * Constructor vacío
     */
    public Informe() {
    }
    
    /**
     * Constructor con parámetros
     */
    public Informe(int idInforme, int idPractica, int numeroInforme, Timestamp fechaPresentacion, 
                  String archivo, String comentarios, boolean aprobado) {
        this.idInforme = idInforme;
        this.idPractica = idPractica;
        this.numeroInforme = numeroInforme;
        this.fechaPresentacion = fechaPresentacion;
        this.archivo = archivo;
        this.comentarios = comentarios;
        this.aprobado = aprobado;
    }
    
    // Getters y setters
    public int getIdInforme() {
        return idInforme;
    }

    public void setIdInforme(int idInforme) {
        this.idInforme = idInforme;
    }

    public int getIdPractica() {
        return idPractica;
    }

    public void setIdPractica(int idPractica) {
        this.idPractica = idPractica;
    }

    public int getNumeroInforme() {
        return numeroInforme;
    }

    public void setNumeroInforme(int numeroInforme) {
        this.numeroInforme = numeroInforme;
    }

    public Timestamp getFechaPresentacion() {
        return fechaPresentacion;
    }

    public void setFechaPresentacion(Timestamp fechaPresentacion) {
        this.fechaPresentacion = fechaPresentacion;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public boolean isAprobado() {
        return aprobado;
    }

    public void setAprobado(boolean aprobado) {
        this.aprobado = aprobado;
    }

    @Override
    public String toString() {
        return "Informe{" + "idInforme=" + idInforme + ", numeroInforme=" + numeroInforme + 
                ", fechaPresentacion=" + fechaPresentacion + ", aprobado=" + aprobado + '}';
    }
}