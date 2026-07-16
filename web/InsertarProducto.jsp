<%@page import="com.pe.model.entity.UnidadVenta"%>
<%@page import="com.pe.DAO.UnidadVentaDAO"%>
<%@page import="com.pe.model.entity.Auxiliar"%>
<%@page import="com.pe.DAO.AuxiliarDAO"%>
<%@page import="com.pe.model.entity.Subcategoria"%>
<%@page import="com.pe.DAO.SubcategoriaDAO"%>
<%@page import="com.pe.model.entity.Categoria"%>
<%@page import="com.pe.DAO.CategoriaDAO"%>
<%@page import="com.pe.model.entity.Clasificacion"%>
<%@page import="com.pe.DAO.ClasificacionDAO"%>
<%@page import="com.pe.DAO.ProductoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="utf-8">
        <title>Nuevo Producto | Alicorp</title>
        <%@include file="css-plantilla.jsp" %>
        <style>
            .form-card{background:#fff;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,.07);padding:24px;margin-bottom:20px}
            .form-card h3{font-size:13px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:18px;padding-bottom:10px;border-bottom:1px solid #f0f0f0}
            .form-label{font-size:13px;font-weight:500;color:#444;margin-bottom:5px;display:block}
            .form-ali{border:1.5px solid #e0e0e0;border-radius:8px;height:44px;font-size:13.5px;padding:0 14px;width:100%;transition:border-color .15s;color:#1a1f2e;background:#fff}
            .form-ali:focus{border-color:#C8102E;box-shadow:0 0 0 3px rgba(200,16,46,.1);outline:none}
            .form-ali[readonly]{background:#f8f9fc;color:#888}
            textarea.form-ali{height:auto;padding:10px 14px;resize:vertical}
            select.form-ali{-webkit-appearance:none}
        </style>
    </head>
    <body class="hold-transition sidebar-mini">

        <%@include file="Frmmenu.jsp" %>

        <div class="content-wrapper">
            <section class="content-header" style="padding:18px 24px 10px;">
                <div class="container-fluid">
                    <h3 style="font-size:20px; font-weight:600; color:#1a1f2e; margin:0;">
                        <i class="fas fa-box" style="color:#C8102E; margin-right:10px;"></i>
                        Registrar Nuevo Producto
                    </h3>
                    <p style="font-size:12px; color:#888; margin:3px 0 0 30px;">Alicorp S.A.A. &mdash; Inventario</p>
                </div>
            </section>

            <section class="content" style="padding:0 24px 24px;">
                <div class="container-fluid">
                    <form id="newproducto" action="ProductoController" method="Post" name="frm_nuevo">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-id-card" style="color:#C8102E;margin-right:6px;"></i>Datos del Producto</h3>
                                    <% ProductoDAO com = new ProductoDAO();
                                       String numserie = com.Numserie(); %>
                                    <div class="mb-3">
                                        <label class="form-label">C&oacute;digo</label>
                                        <input class="form-ali" id="Txtcodigo" type="text" name="Txtcodigo" value="<%=numserie%>" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Descripci&oacute;n</label>
                                        <div style="display:flex; gap:8px;">
                                            <input type="text" id="Txtdescripcion" name="Txtdescripcion" class="form-ali" placeholder="Ej: Aceite Primor Botella 1L" oninput="resetValidacionProducto()" required>
                                            <button type="button" onclick="validarProducto()" class="btn"
                                                    style="white-space:nowrap; background:#1a1f2e; color:#fff; border:none; border-radius:8px; padding:0 16px; font-size:13px; font-weight:500;">
                                                <i class="fas fa-check-circle"></i> Validar
                                            </button>
                                        </div>
                                        <div id="msgValidacion" style="font-size:12.5px; margin-top:6px; display:none;"></div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Clasificaci&oacute;n</label>
                                        <select class="form-ali" name="Txtmarca" required>
                                            <option value="" disabled selected>Seleccione clasificaci&oacute;n</option>
                                            <% ClasificacionDAO mar = new ClasificacionDAO();
                                               List<Clasificacion> list = mar.ListadoEstadoActivos();
                                               Iterator<Clasificacion> ite = list.iterator();
                                               Clasificacion m = null;
                                               while (ite.hasNext()) { m = ite.next(); %>
                                            <option value="<%=m.getIdclasi()%>"><%=m.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Categor&iacute;a</label>
                                        <select class="form-ali" id="selCategoria" name="Txtcategoria" required>
                                            <option value="" disabled selected>Seleccione categor&iacute;a</option>
                                            <% CategoriaDAO cat = new CategoriaDAO();
                                               List<Categoria> lista = cat.ListadoEstadoActivos();
                                               Iterator<Categoria> iter = lista.iterator();
                                               Categoria c = null;
                                               while (iter.hasNext()) { c = iter.next(); %>
                                            <option value="<%=c.getIdcategoria()%>"><%=c.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Subcategor&iacute;a</label>
                                        <select class="form-ali" id="selSubcategoria" name="TxtIdpublico" required>
                                            <option value="" disabled selected>Primero elige una categor&iacute;a</option>
                                            <% SubcategoriaDAO pd = new SubcategoriaDAO();
                                               List<Subcategoria> listaa = pd.listarSubcategoria();
                                               Iterator<Subcategoria> iterr = listaa.iterator();
                                               Subcategoria pbl = null;
                                               while (iterr.hasNext()) { pbl = iterr.next(); %>
                                            <option value="<%=pbl.getIdsubc()%>" data-categoria="<%=pbl.getIdcategoria()%>" style="display:none;"><%=pbl.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Unidad de Medida</label>
                                        <select class="form-ali" name="Txtunidadv" required>
                                            <option value="" disabled selected>Seleccione unidad</option>
                                            <% UnidadVentaDAO univ = new UnidadVentaDAO();
                                               List<UnidadVenta> lt = univ.ListaUnidadVenta();
                                               Iterator<UnidadVenta> itra = lt.iterator();
                                               UnidadVenta uv = null;
                                               while (itra.hasNext()) { uv = itra.next(); %>
                                            <option value="<%=uv.getIduventa()%>"><%=uv.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-card">
                                    <h3><i class="fas fa-truck" style="color:#C8102E;margin-right:6px;"></i>Proveedor y Precios</h3>
                                    <div class="mb-3">
                                        <label class="form-label">Proveedor</label>
                                        <select class="form-ali" name="Txtproveedor" required>
                                            <option value="" disabled selected>Seleccione proveedor</option>
                                            <% AuxiliarDAO auxDao = new AuxiliarDAO();
                                               List<Auxiliar> listaProv = auxDao.ListadoProveedor();
                                               Iterator<Auxiliar> iterProv = listaProv.iterator();
                                               Auxiliar prov = null;
                                               while (iterProv.hasNext()) { prov = iterProv.next(); %>
                                            <option value="<%=prov.getIdauxiliar()%>"><%=prov.getNombre()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">C&oacute;digo del Proveedor <span style="color:#aaa;font-weight:400;">(opcional)</span></label>
                                        <input type="text" maxlength="20" name="Txtcodanexo" class="form-ali" placeholder="SKU o c&oacute;digo interno del proveedor">
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <label class="form-label">Precio de Costo (S/)</label>
                                            <input type="number" step="0.01" min="0" name="Txtpcompra" class="form-ali" placeholder="0.00" required>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label">Precio de Venta (S/)</label>
                                            <input type="number" step="0.01" min="0" name="Txtpventa" class="form-ali" placeholder="0.00" required>
                                        </div>
                                    </div>
                                    <div class="mb-3" style="margin-top:16px;">
                                        <% Date dNow = new Date();
                                           SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                                           String currentDate = ft.format(dNow); %>
                                        <label class="form-label">Fecha de Registro</label>
                                        <input class="form-ali" type="text" name="Txtfechaderegistro" value="<%=currentDate%>" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Observaci&oacute;n <span style="color:#aaa;font-weight:400;">(opcional)</span></label>
                                        <textarea name="Txtobser" class="form-ali" rows="3" placeholder="Notas adicionales sobre el producto"></textarea>
                                    </div>
                                    <p style="font-size:11.5px;color:#999;margin-top:-6px;">El stock inicial y el stock m&iacute;nimo/m&aacute;ximo se configuran despu&eacute;s, desde <b>Inventario &rarr; Stock M&iacute;n / M&aacute;x</b>.</p>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between" style="margin-top:4px;">
                            <a href="Producto.jsp" style="background:#f0f0f0;color:#555;border:none;border-radius:8px;padding:11px 22px;font-size:13.5px;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                            <button id="btnGuardar" onclick="return puedeGuardar()" type="submit" class="btn" name="accion" style="background:#C8102E;color:#fff;border:none;border-radius:8px;padding:11px 28px;font-size:13.5px;font-weight:500;">
                                <i class="fas fa-save"></i> Guardar Producto
                            </button>
                        </div>
                    </form>
                </div>
            </section>
        </div>

        <%@include file="js-plantilla.jsp"%>
        <script src="Validacionysweetalert/Producto.js" type="text/javascript"></script>
        <script>
            // Cascada: al elegir Categoría, solo se muestran las Subcategorías de esa categoría.
            function filtrarSubcategorias() {
                var idCategoria = document.getElementById('selCategoria').value;
                var selSub = document.getElementById('selSubcategoria');
                var opciones = selSub.querySelectorAll('option[data-categoria]');
                opciones.forEach(function (op) {
                    if (op.getAttribute('data-categoria') === idCategoria) {
                        op.style.display = '';
                    } else {
                        op.style.display = 'none';
                        if (op.selected) { op.selected = false; }
                    }
                });
                selSub.value = '';
            }
            document.getElementById('selCategoria').addEventListener('change', filtrarSubcategorias);
        </script>
        <script>
            // Estado de validación del producto: null = sin validar, 'nuevo', 'existe'
            var estadoValidacion = null;
            var codigoExistente = null;
            var codigoGenerado = document.getElementById('Txtcodigo').value; // el correlativo que asignó el sistema

            function resetValidacionProducto() {
                estadoValidacion = null;
                codigoExistente = null;
                document.getElementById('Txtcodigo').value = codigoGenerado;
                var m = document.getElementById('msgValidacion');
                m.style.display = 'none';
                m.innerHTML = '';
            }

            function validarProducto() {
                var desc = document.getElementById('Txtdescripcion').value.trim();
                var m = document.getElementById('msgValidacion');
                if (desc === '') {
                    swal("Escribe primero la descripción del producto", {icon: "warning"});
                    return;
                }
                fetch('ProductoController?accion=validarNombre&descripcion=' + encodeURIComponent(desc))
                    .then(function (r) { return r.text(); })
                    .then(function (res) {
                        res = res.trim();
                        m.style.display = 'block';
                        if (res === 'NUEVO') {
                            estadoValidacion = 'nuevo';
                            codigoExistente = null;
                            document.getElementById('Txtcodigo').value = codigoGenerado;
                            m.style.color = '#2E7D46';
                            m.innerHTML = '<i class="fas fa-check-circle"></i> Producto nuevo. Se asignará el código <b>' + codigoGenerado + '</b>.';
                        } else {
                            estadoValidacion = 'existe';
                            codigoExistente = res;
                            document.getElementById('Txtcodigo').value = res;
                            m.style.color = '#C8102E';
                            m.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Este producto ya está registrado con el código <b>' + res + '</b>. No se puede duplicar; para agregar stock usa <b>Nota de Ingreso</b>.';
                        }
                    })
                    .catch(function () {
                        m.style.display = 'block';
                        m.style.color = '#C8102E';
                        m.innerHTML = 'No se pudo validar. Intenta de nuevo.';
                    });
            }

            // Reemplaza el guardado: obliga a validar antes y bloquea duplicados.
            function puedeGuardar() {
                if (estadoValidacion === null) {
                    swal("Primero presiona «Validar» para comprobar el producto", {icon: "warning"});
                    return false;
                }
                if (estadoValidacion === 'existe') {
                    swal({
                        title: "Producto ya registrado",
                        text: "Ya existe con el código " + codigoExistente + ". No se puede duplicar. Para agregar stock usa Nota de Ingreso.",
                        icon: "info"
                    });
                    return false;
                }
                return true; // 'nuevo' → los campos required validan el resto
            }
        </script>
    </body>
</html>
