package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Almacen;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AlmacenDAO {

    ConexionBD cn = new ConexionBD();

    public List<Almacen> listarActivos() {
        List<Almacen> lista = new ArrayList<>();
        String sql = "SELECT * FROM Almacen WHERE Estado = 'Activo' ORDER BY Idalmacen";
        try {
            Connection con = cn.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Almacen a = new Almacen();
                a.setIdalmacen(rs.getInt("Idalmacen"));
                a.setCodigo(rs.getString("Codigo"));
                a.setNombre(rs.getString("Nombre"));
                a.setDireccion(rs.getString("Direccion"));
                a.setEstado(rs.getString("Estado"));
                lista.add(a);
            }
        } catch (Exception e) {
            System.err.println("No se pudo listar almacenes: " + e.getMessage());
        }
        return lista;
    }
}
