
package com.pe.model.entity;
public class Producto {
    private int Idproducto;
    private String Codigo;
    private String Descripcion;
    private int Idcategoria;
    private int Idclasi;
    private int Idauxiliar; 
    private int Iduventa;
    private int Idsubc;
    private String Moneda;
    private String Codigoanexo;
    private double Preciocompra;
    private double PrecioVenta;
    private String fechaRegistro;
    private String obser;
    private double stock;
    private double stockminimo;
    private double stockmaximo;
    private String Estado;
    private Auxiliar auxiliar;

    public Producto() {
    }
    public Producto(int Idproducto) {
        this.Idproducto = Idproducto;
    }

    public Producto(int Idproducto, String Codigo, String Descripcion, int Idcategoria, int Idclasi, int Idauxiliar, int Iduventa, int Idsubc, String Moneda, String Codigoanexo, double Preciocompra, double PrecioVenta, String fechaRegistro, String obser, double stock, double stockminimo, double stockmaximo, String Estado) {
        this.Idproducto = Idproducto;
        this.Codigo = Codigo;
        this.Descripcion = Descripcion;
        this.Idcategoria = Idcategoria;
        this.Idclasi = Idclasi;
        this.Idauxiliar = Idauxiliar;
        this.Iduventa = Iduventa;
        this.Idsubc = Idsubc;
        this.Moneda = Moneda;
        this.Codigoanexo = Codigoanexo;
        this.Preciocompra = Preciocompra;
        this.PrecioVenta = PrecioVenta;
        this.fechaRegistro = fechaRegistro;
        this.obser = obser;
        this.stock = stock;
        this.stockminimo = stockminimo;
        this.stockmaximo = stockmaximo;
        this.Estado = Estado;
    }

    public double getStock() {
        return stock;
    }

    public void setStock(double stock) {
        this.stock = stock;
    }

    public double getStockminimo() {
        return stockminimo;
    }

    public void setStockminimo(double stockminimo) {
        this.stockminimo = stockminimo;
    }

    public double getStockmaximo() {
        return stockmaximo;
    }

    public void setStockmaximo(double stockmaximo) {
        this.stockmaximo = stockmaximo;
    }



    public int getIdproducto() {
        return Idproducto;
    }

    public String getMoneda() {
        return Moneda;
    }

    public void setMoneda(String Moneda) {
        this.Moneda = Moneda;
    }

    public String getCodigoanexo() {
        return Codigoanexo;
    }

    public void setCodigoanexo(String Codigoanexo) {
        this.Codigoanexo = Codigoanexo;
    }

    public void setIdproducto(int Idproducto) {
        this.Idproducto = Idproducto;
    }

    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String Codigo) {
        this.Codigo = Codigo;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public int getIdcategoria() {
        return Idcategoria;
    }

    public void setIdcategoria(int Idcategoria) {
        this.Idcategoria = Idcategoria;
    }

    public int getIdclasi() {
        return Idclasi;
    }

    public void setIdclasi(int Idclasi) {
        this.Idclasi = Idclasi;
    }

    public int getIduventa() {
        return Iduventa;
    }

    public void setIduventa(int Iduventa) {
        this.Iduventa = Iduventa;
    }

    public int getIdsubc() {
        return Idsubc;
    }

    public void setIdsubc(int Idsubc) {
        this.Idsubc = Idsubc;
    }

    public double getPreciocompra() {
        return Preciocompra;
    }

    public void setPreciocompra(double Preciocompra) {
        this.Preciocompra = Preciocompra;
    }

    public double getPrecioVenta() {
        return PrecioVenta;
    }

    public String getObser() {
        return obser;
    }

    public void setObser(String obser) {
        this.obser = obser;
    }

    public void setPrecioVenta(double PrecioVenta) {
        this.PrecioVenta = PrecioVenta;
    }

    public String getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(String fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public int getIdauxiliar() {
        return Idauxiliar;
    }

    public void setIdauxiliar(int Idauxiliar) {
        this.Idauxiliar = Idauxiliar;
    }

    public Auxiliar getAuxiliar() {
        return auxiliar;
    }

    public void setAuxiliar(Auxiliar auxiliar) {
        this.auxiliar = auxiliar;
    }



}
