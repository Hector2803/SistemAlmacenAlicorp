package com.pe.model.entity;
public class Conductor {

    private Integer Idcond;
    private String Codigo;
    private int Idtipodocumento;
    private String Numerodocumento;
    private String Chofer;
    private String Licencia;
    private String Estado;

    public Conductor() {
    }

    public Conductor(Integer Idcond, String Codigo, int Idtipodocumento, String Numerodocumento, String Chofer, String Licencia, String Estado) {
        this.Idcond = Idcond;
        this.Codigo = Codigo;
        this.Idtipodocumento = Idtipodocumento;
        this.Numerodocumento = Numerodocumento;
        this.Chofer = Chofer;
        this.Licencia = Licencia;
        this.Estado = Estado;
    }
    

    public Integer getIdcond() {
        return Idcond;
    }

    public void setIdcond(Integer Idcond) {
        this.Idcond = Idcond;
    }



    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public int getIdtipodocumento() {
        return Idtipodocumento;
    }

    public void setIdtipodocumento(int Idtipodocumento) {
        this.Idtipodocumento = Idtipodocumento;
    }

    public String getNumerodocumento() {
        return Numerodocumento;
    }

    public void setNumerodocumento(String Numerodocumento) {
        this.Numerodocumento = Numerodocumento;
    }

    public String getChofer() {
        return Chofer;
    }

    public void setChofer(String Chofer) {
        this.Chofer = Chofer;
    }

    public String getLicencia() {
        return Licencia;
    }

    public void setLicencia(String Licencia) {
        this.Licencia = Licencia;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    
}
