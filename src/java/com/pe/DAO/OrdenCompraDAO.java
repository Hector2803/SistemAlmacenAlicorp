package com.pe.DAO;

import com.pe.conection.ConexionBD;
import com.pe.model.entity.Auxiliar;
import com.pe.model.entity.DetalleOrdenCompra;
import com.pe.model.entity.OrdenCompra;
import com.pe.model.entity.Producto;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO para el modulo de Ordenes de Compra.
 * Sigue el mismo patron de conexion y manejo de excepciones
 * que el resto de los DAO del proyecto (AuxiliarDAO, ProductoDAO, etc).
 */
public class OrdenCompraDAO {

    ConexionBD cn = new ConexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    CallableStatement call;

    // ── Listar todas las ordenes de compra ──────────────────────
    public List<OrdenCompra> listarOC() {
        ArrayList<OrdenCompra> lista = new ArrayList<>();
        String sql = "SELECT oc.*, a.Nombre AS NombreProveedor "
                + "FROM OrdenCompra oc "
                + "INNER JOIN Auxiliar a ON a.Idauxiliar = oc.Idauxiliar "
                + "ORDER BY oc.Idordencompra DESC";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrdenCompra oc = new OrdenCompra();
                oc.setIdordencompra(rs.getInt("Idordencompra"));
                oc.setCodigo(rs.getString("Codigo"));
                oc.setIdauxiliar(rs.getInt("Idauxiliar"));
                oc.setFechaEmision(rs.getString("FechaEmision"));
                oc.setFechaEntrega(rs.getString("FechaEntrega"));
                oc.setOrigen(rs.getString("Origen"));
                oc.setEstado(rs.getString("Estado"));
                oc.setTotal(rs.getDouble("Total"));
                oc.setObservacion(rs.getString("Observacion"));
                Auxiliar prov = new Auxiliar();
                prov.setNombre(rs.getString("NombreProveedor"));
                oc.setAuxiliar(prov);
                lista.add(oc);
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    // ── Listar solo pendientes (para el dashboard / bandeja) ─────
    public List<OrdenCompra> listarPendientes() {
        ArrayList<OrdenCompra> lista = new ArrayList<>();
        String sql = "SELECT oc.*, a.Nombre AS NombreProveedor "
                + "FROM OrdenCompra oc "
                + "INNER JOIN Auxiliar a ON a.Idauxiliar = oc.Idauxiliar "
                + "WHERE oc.Estado = 'Pendiente' "
                + "ORDER BY oc.Idordencompra DESC";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrdenCompra oc = new OrdenCompra();
                oc.setIdordencompra(rs.getInt("Idordencompra"));
                oc.setCodigo(rs.getString("Codigo"));
                oc.setFechaEmision(rs.getString("FechaEmision"));
                oc.setOrigen(rs.getString("Origen"));
                oc.setEstado(rs.getString("Estado"));
                oc.setTotal(rs.getDouble("Total"));
                Auxiliar prov = new Auxiliar();
                prov.setNombre(rs.getString("NombreProveedor"));
                oc.setAuxiliar(prov);
                lista.add(oc);
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    // ── Buscar una OC por id (con su proveedor) ──────────────────
    public OrdenCompra buscarPorId(int id) {
        OrdenCompra oc = new OrdenCompra();
        String sql = "SELECT oc.*, a.Nombre AS NombreProveedor, a.Numerodocumento "
                + "FROM OrdenCompra oc "
                + "INNER JOIN Auxiliar a ON a.Idauxiliar = oc.Idauxiliar "
                + "WHERE oc.Idordencompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                oc.setIdordencompra(rs.getInt("Idordencompra"));
                oc.setCodigo(rs.getString("Codigo"));
                oc.setIdauxiliar(rs.getInt("Idauxiliar"));
                oc.setFechaEmision(rs.getString("FechaEmision"));
                oc.setFechaEntrega(rs.getString("FechaEntrega"));
                oc.setOrigen(rs.getString("Origen"));
                oc.setEstado(rs.getString("Estado"));
                oc.setTotal(rs.getDouble("Total"));
                oc.setObservacion(rs.getString("Observacion"));
                Auxiliar prov = new Auxiliar();
                prov.setNombre(rs.getString("NombreProveedor"));
                prov.setNumerodocumento(rs.getString("Numerodocumento"));
                oc.setAuxiliar(prov);
                oc.setDetalle(listarDetalle(id));
            }
        } catch (SQLException e) {
        }
        return oc;
    }

    // ── Listar el detalle (productos) de una OC ──────────────────
    public List<DetalleOrdenCompra> listarDetalle(int idordencompra) {
        ArrayList<DetalleOrdenCompra> lista = new ArrayList<>();
        String sql = "SELECT d.*, p.Codigo AS CodigoProducto, p.Descripcion "
                + "FROM DetalleOrdenCompra d "
                + "INNER JOIN Producto p ON p.Idproducto = d.Idproducto "
                + "WHERE d.Idordencompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idordencompra);
            rs = ps.executeQuery();
            while (rs.next()) {
                DetalleOrdenCompra d = new DetalleOrdenCompra();
                d.setIddetalleoc(rs.getInt("Iddetalleoc"));
                d.setIdordencompra(rs.getInt("Idordencompra"));
                d.setIdproducto(rs.getInt("Idproducto"));
                d.setCantidad(rs.getDouble("Cantidad"));
                d.setPrecioUnitario(rs.getDouble("PrecioUnitario"));
                d.setSubtotal(rs.getDouble("Subtotal"));
                Producto p = new Producto();
                p.setCodigo(rs.getString("CodigoProducto"));
                p.setDescripcion(rs.getString("Descripcion"));
                d.setProducto(p);
                lista.add(d);
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    // ── Generar el siguiente codigo correlativo (OC-000001) ──────
    public String generarCodigo() {
        String codigo = "OC-000001";
        String sql = "{call sp_generar_correlativoOC()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                codigo = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return codigo;
    }

    // ── Registrar una nueva OC (cabecera) y devolver su id ────────
    public int registrar(OrdenCompra oc) {
        int idGenerado = -1;
        String sql = "INSERT INTO OrdenCompra "
                + "(Codigo, Idauxiliar, FechaEmision, FechaEntrega, Origen, Estado, Total, Observacion, Idusuario) "
                + "VALUES (?, ?, NOW(), ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, oc.getCodigo());
            ps.setInt(2, oc.getIdauxiliar());
            ps.setString(3, oc.getFechaEntrega());
            ps.setString(4, oc.getOrigen());
            ps.setString(5, oc.getEstado());
            ps.setDouble(6, oc.getTotal());
            ps.setString(7, oc.getObservacion());
            ps.setString(8, oc.getIdusuario());
            int filas = ps.executeUpdate();
            if (filas > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) {
                    idGenerado = keys.getInt(1);
                }
            }
        } catch (SQLException e) {
        }
        return idGenerado;
    }

    // ── Registrar el detalle (un producto) de una OC ──────────────
    public boolean registrarDetalle(DetalleOrdenCompra d) {
        boolean ok = false;
        String sql = "INSERT INTO DetalleOrdenCompra "
                + "(Idordencompra, Idproducto, Cantidad, PrecioUnitario, Subtotal) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, d.getIdordencompra());
            ps.setInt(2, d.getIdproducto());
            ps.setDouble(3, d.getCantidad());
            ps.setDouble(4, d.getPrecioUnitario());
            ps.setDouble(5, d.getSubtotal());
            ok = ps.executeUpdate() > 0;
        } catch (SQLException e) {
        }
        return ok;
    }

    // ── Recalcular y actualizar el total de una OC ────────────────
    public void actualizarTotal(int idordencompra) {
        String sql = "UPDATE OrdenCompra SET Total = "
                + "(SELECT IFNULL(SUM(Subtotal),0) FROM DetalleOrdenCompra WHERE Idordencompra = ?) "
                + "WHERE Idordencompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idordencompra);
            ps.setInt(2, idordencompra);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    // ── Editar cabecera (proveedor, fecha entrega, observacion) ───
    public boolean editar(OrdenCompra oc) {
        boolean ok = false;
        String sql = "UPDATE OrdenCompra SET Idauxiliar = ?, FechaEntrega = ?, Observacion = ? "
                + "WHERE Idordencompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, oc.getIdauxiliar());
            ps.setString(2, oc.getFechaEntrega());
            ps.setString(3, oc.getObservacion());
            ps.setInt(4, oc.getIdordencompra());
            ok = ps.executeUpdate() > 0;
        } catch (SQLException e) {
        }
        return ok;
    }

    // ── Eliminar un detalle especifico ─────────────────────────────
    public boolean eliminarDetalle(int iddetalleoc) {
        boolean ok = false;
        String sql = "DELETE FROM DetalleOrdenCompra WHERE Iddetalleoc = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, iddetalleoc);
            ok = ps.executeUpdate() > 0;
        } catch (SQLException e) {
        }
        return ok;
    }

    // ── Cambiar estado: Aprobar ─────────────────────────────────────
    public boolean aprobar(int id, String usuario) {
        return cambiarEstado(id, "Aprobado", usuario);
    }

    // ── Cambiar estado: Anular ───────────────────────────────────────
    public boolean anular(int id, String usuario) {
        return cambiarEstado(id, "Anulado", usuario);
    }

    // ── Cambiar estado: Completar (mercaderia recibida -> aumenta el stock) ──
    public boolean completar(int id, String usuario) {
        boolean ok = false;
        try {
            con = cn.getConnection();
            con.setAutoCommit(false);

            // 1) Solo se procesa si la orden todavía NO estaba completada (evita duplicar stock
            //    si por algún motivo se vuelve a llamar sobre la misma orden).
            String sqlEstadoActual = "SELECT Estado FROM OrdenCompra WHERE Idordencompra = ?";
            ps = con.prepareStatement(sqlEstadoActual);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            String estadoActual = rs.next() ? rs.getString("Estado") : "";
            if ("Completado".equalsIgnoreCase(estadoActual)) {
                con.setAutoCommit(true);
                return false;
            }

            // 2) Cambiar el estado de la orden.
            String sqlEstado = "UPDATE OrdenCompra SET Estado = 'Completado', Idusuario = ? WHERE Idordencompra = ?";
            ps = con.prepareStatement(sqlEstado);
            ps.setString(1, usuario);
            ps.setInt(2, id);
            int filas = ps.executeUpdate();

            // 3) Aumentar el stock de cada producto de la orden (la mercadería ya llegó al almacén).
            String sqlStock = "UPDATE Producto SET Stock = Stock + ? WHERE Idproducto = ?";
            PreparedStatement psStock = con.prepareStatement(sqlStock);
            String sqlDetalle = "SELECT Idproducto, Cantidad FROM DetalleOrdenCompra WHERE Idordencompra = ?";
            PreparedStatement psDet = con.prepareStatement(sqlDetalle);
            psDet.setInt(1, id);
            ResultSet rsDet = psDet.executeQuery();
            while (rsDet.next()) {
                psStock.setDouble(1, rsDet.getDouble("Cantidad"));
                psStock.setInt(2, rsDet.getInt("Idproducto"));
                psStock.executeUpdate();
            }

            con.commit();
            con.setAutoCommit(true);
            ok = filas > 0;
        } catch (SQLException e) {
            try {
                con.rollback();
                con.setAutoCommit(true);
            } catch (SQLException ex) {
            }
            System.err.println("Error al completar orden de compra: " + e.getMessage());
        }
        return ok;
    }

    private boolean cambiarEstado(int id, String nuevoEstado, String usuario) {
        boolean ok = false;
        String sql = "UPDATE OrdenCompra SET Estado = ?, Idusuario = ? WHERE Idordencompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nuevoEstado);
            ps.setString(2, usuario);
            ps.setInt(3, id);
            ok = ps.executeUpdate() > 0;
        } catch (SQLException e) {
        }
        return ok;
    }

    // ── Eliminar una OC completa (solo si esta Pendiente) ────────────
    public boolean eliminar(int id) {
        boolean ok = false;
        String sql = "DELETE FROM OrdenCompra WHERE Idordencompra = ? AND Estado = 'Pendiente'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ok = ps.executeUpdate() > 0;
        } catch (SQLException e) {
        }
        return ok;
    }

    // ── Contador para el dashboard (igual contrato que el resto del DAO) ──
    public String contarPendientes() {
        String mensaje = "0";
        String sql = "{call sp_generar_contarOC()}";
        try {
            con = cn.getConnection();
            call = con.prepareCall(sql);
            rs = call.executeQuery();
            if (rs.next()) {
                mensaje = rs.getString(1);
            }
        } catch (SQLException e) {
        }
        return mensaje;
    }
}
