
package com.pe.model.entity;

public class TipoDocumento {
    private Integer Idtipodocumento,Codigo;
    private String TipoDocumento;

    public TipoDocumento(Integer Idtipodocumento, Integer Codigo, String TipoDocumento) {
        this.Idtipodocumento = Idtipodocumento;
        this.Codigo = Codigo;
        this.TipoDocumento = TipoDocumento;
    }

    public TipoDocumento() {
    }

    public Integer getIdtipodocumento() {
        return Idtipodocumento;
    }

    public void setIdtipodocumento(Integer Idtipodocumento) {
        this.Idtipodocumento = Idtipodocumento;
    }

    public Integer getCodigo() {
        return Codigo;
    }

    public void setCodigo(Integer Codigo) {
        this.Codigo = Codigo;
    }

    public String getTipoDocumento() {
        return TipoDocumento;
    }

    public void setTipoDocumento(String TipoDocumento) {
        this.TipoDocumento = TipoDocumento;
    }
    
    
}
