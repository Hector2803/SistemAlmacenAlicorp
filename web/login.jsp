<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alicorp | Iniciar Sesion</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=fallback">
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', 'Source Sans Pro', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .login-wrapper {
            display: flex;
            width: 860px;
            min-height: 520px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 40px rgba(0,0,0,0.13);
        }

        /* ── Panel izquierdo rojo ── */
        .left-panel {
            width: 42%;
            background: #C8102E;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 2.5rem 2rem;
        }

        .brand-logo {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 1rem;
        }

        .brand-logo-text {
            font-size: 32px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.5px;
            line-height: 1;
            position: relative;
            display: inline-block;
        }

        .brand-logo-text .letter-a {
            color: #ffffff;
            position: relative;
            display: inline-block;
        }

        .brand-logo-text .leaf {
            display: inline-block;
            width: 10px;
            height: 10px;
            background: #4CAF50;
            border-radius: 50% 50% 0 50%;
            transform: rotate(-40deg);
            position: absolute;
            top: -2px;
            left: 2px;
        }

        .brand-tagline {
            font-size: 13px;
            color: rgba(255,255,255,0.70);
            line-height: 1.6;
            margin-top: 0.5rem;
        }

        .features {
            display: flex;
            flex-direction: column;
            gap: 1.1rem;
            margin: 1.5rem 0;
        }

        .feature-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .feature-icon {
            width: 36px;
            height: 36px;
            background: rgba(255,255,255,0.15);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .feature-icon i {
            font-size: 16px;
            color: #ffffff;
        }

        .feature-text strong {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #ffffff;
            margin-bottom: 2px;
        }

        .feature-text span {
            font-size: 12px;
            color: rgba(255,255,255,0.70);
            line-height: 1.4;
        }

        .left-footer {
            font-size: 11px;
            color: rgba(255,255,255,0.40);
        }

        /* ── Panel derecho blanco ── */
        .right-panel {
            flex: 1;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2.5rem 2.5rem;
        }

        .form-box {
            width: 100%;
            max-width: 320px;
        }

        .form-title {
            font-size: 22px;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 4px;
        }

        .form-subtitle {
            font-size: 13px;
            color: #888;
            margin-bottom: 1.8rem;
        }

        /* Mensaje de error */
        .msg-error {
            background: #fff0f2;
            border: 1px solid #f5c2c7;
            color: #C8102E;
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 13px;
            margin-bottom: 1rem;
        }

        /* Campos */
        .field {
            display: flex;
            flex-direction: column;
            gap: 5px;
            margin-bottom: 1rem;
        }

        .field label {
            font-size: 13px;
            font-weight: 500;
            color: #444;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap .icon-left {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 15px;
            pointer-events: none;
        }

        .input-wrap input {
            width: 100%;
            height: 44px;
            padding: 0 40px 0 38px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            color: #1a1a1a;
            background: #fff;
            outline: none;
            transition: border-color 0.15s, box-shadow 0.15s;
            font-family: inherit;
        }

        .input-wrap input:focus {
            border-color: #C8102E;
            box-shadow: 0 0 0 3px rgba(200,16,46,0.10);
        }

        .input-wrap input::placeholder {
            color: #bbb;
        }

        .btn-eye {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #aaa;
            padding: 4px;
            display: flex;
            align-items: center;
        }

        .btn-eye:hover { color: #555; }

        /* Fila remember + forgot */
        .row-opts {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.4rem;
        }

        .remember-label {
            display: flex;
            align-items: center;
            gap: 7px;
            font-size: 13px;
            color: #555;
            cursor: pointer;
        }

        .remember-label input[type="checkbox"] {
            width: 15px;
            height: 15px;
            accent-color: #C8102E;
            cursor: pointer;
        }

        .forgot-link {
            font-size: 13px;
            color: #C8102E;
            text-decoration: none;
        }

        .forgot-link:hover { text-decoration: underline; }

        /* Boton principal */
        .btn-login {
            width: 100%;
            height: 46px;
            background: #C8102E;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.15s, transform 0.1s;
            font-family: inherit;
            letter-spacing: 0.2px;
        }

        .btn-login:hover { background: #a50d25; }
        .btn-login:active { transform: scale(0.98); }

        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 11px;
            color: #ccc;
        }
    </style>
</head>
<body>

<div class="login-wrapper">

    <!-- Panel izquierdo -->
    <div class="left-panel">
        <div>
            <div class="brand-logo">
                <span class="brand-logo-text">
                    <span class="letter-a">A<span class="leaf"></span></span>licorp
                </span>
            </div>
            <p class="brand-tagline">Sistema de Gesti&oacute;n de Logística e Inventarios &mdash; Alicorp S.A.A.</p>
        </div>

        <div class="features">
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <div class="feature-text">
                    <strong>Control de inventario</strong>
                    <span>Registro de productos de ingreso y salida en tiempo real</span>
                </div>
            </div>
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="feature-text">
                    <strong>Dashboard log&iacute;stico</strong>
                    <span>KPIs y reportes de stock, m&iacute;nimos y m&aacute;ximos</span>
                </div>
            </div>
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fas fa-route"></i>
                </div>
                <div class="feature-text">
                    <strong>Trazabilidad de lotes</strong>
                    <span>Kardex autom&aacute;tico por producto y movimiento</span>
                </div>
            </div>
        </div>

        <p class="left-footer">Alicorp S.A.A. &middot; RUC 20100055237 &middot; SIGA v1.0</p>
    </div>

    <!-- Panel derecho -->
    <div class="right-panel">
        <div class="form-box">
            <h1 class="form-title">Inicia sesi&oacute;n</h1>
            <p class="form-subtitle">Accede con tus credenciales asignadas</p>

            <!-- Mensaje de error -->
            <% if (request.getAttribute("mensaje") != null) { %>
            <div class="msg-error">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getAttribute("mensaje") %>
            </div>
            <% } %>

            <form action="LoginController" method="POST">

                <div class="field">
                    <label for="txtUsuario">Correo corporativo</label>
                    <div class="input-wrap">
                        <i class="fas fa-envelope icon-left"></i>
                        <input type="email"
                               name="txtUsuario"
                               id="txtUsuario"
                               placeholder="tu.correo@alicorp.pe"
                               autocomplete="username"
                               required>
                    </div>
                </div>

                <div class="field">
                    <label for="txtPassword">Contrase&ntilde;a</label>
                    <div class="input-wrap">
                        <i class="fas fa-lock icon-left"></i>
                        <input type="password"
                               name="txtPassword"
                               id="txtPassword"
                               placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;"
                               autocomplete="current-password"
                               required>
                        <button type="button" class="btn-eye" onclick="togglePassword()" title="Mostrar/Ocultar">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="row-opts">
                    <label class="remember-label">
                        <input type="checkbox" id="remember"> Recordarme
                    </label>
                    <a href="RecuperarPassword.jsp" class="forgot-link">&iquest;Olvidaste tu contrase&ntilde;a?</a>
                </div>

                <button type="submit" name="btnEntrar" class="btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    Iniciar sesi&oacute;n
                </button>

            </form>

            <p class="form-footer">
                Al iniciar sesi&oacute;n aceptas los
                <a href="#" onclick="document.getElementById('modalTerminos').style.display='flex'; return false;" style="color:#C8102E; font-weight:500; text-decoration:none;">T&eacute;rminos y Condiciones</a>
                de uso del sistema.
            </p>
            <p class="form-footer">Sistema de Log&iacute;stica &middot; Dise&ntilde;o e Implementaci&oacute;n de AE &middot; 2026</p>
        </div>
    </div>
</div>

<!-- Modal Términos y Condiciones -->
<div id="modalTerminos" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.5); z-index:9999; align-items:center; justify-content:center; padding:1rem;">
    <div style="background:#fff; border-radius:14px; max-width:560px; width:100%; max-height:80vh; overflow-y:auto; box-shadow:0 12px 40px rgba(0,0,0,0.25);">
        <div style="background:#C8102E; color:#fff; padding:18px 24px; border-radius:14px 14px 0 0; display:flex; align-items:center; justify-content:space-between;">
            <h4 style="margin:0; font-size:16px; font-weight:600;"><i class="fas fa-file-contract"></i> T&eacute;rminos y Condiciones</h4>
            <span onclick="document.getElementById('modalTerminos').style.display='none';" style="cursor:pointer; font-size:20px; line-height:1;">&times;</span>
        </div>
        <div style="padding:24px; font-size:13.5px; color:#444; line-height:1.6;">
            <p><strong>1. Uso autorizado.</strong> Este sistema es de uso exclusivo del personal autorizado de Alicorp S.A.A. Las credenciales de acceso son personales e intransferibles.</p>
            <p><strong>2. Confidencialidad.</strong> La informaci&oacute;n de inventario, usuarios y movimientos registrada en el sistema es confidencial y no debe compartirse fuera de la organizaci&oacute;n.</p>
            <p><strong>3. Responsabilidad del usuario.</strong> Cada usuario es responsable de las acciones realizadas bajo su cuenta. Toda actividad queda registrada en la bit&aacute;cora de accesos del sistema.</p>
            <p><strong>4. Seguridad.</strong> Est&aacute; prohibido compartir contrase&ntilde;as o intentar acceder a m&oacute;dulos fuera del rol asignado.</p>
            <p><strong>5. Disponibilidad.</strong> El sistema puede presentar mantenimientos programados que ser&aacute;n comunicados con anticipaci&oacute;n por el &aacute;rea de TI.</p>
        </div>
        <div style="padding:14px 24px; border-top:1px solid #f0f0f0; text-align:right;">
            <button onclick="document.getElementById('modalTerminos').style.display='none';" style="background:#C8102E; color:#fff; border:none; border-radius:8px; padding:9px 22px; font-size:13px; font-weight:500; cursor:pointer;">Entendido</button>
        </div>
    </div>
</div>

<!-- Scripts AdminLTE (requeridos por el proyecto) -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="dist/js/adminlte.min.js"></script>

<script>
    function togglePassword() {
        var input = document.getElementById('txtPassword');
        var icon  = document.getElementById('eyeIcon');
        if (input.type === 'password') {
            input.type = 'text';
            icon.className = 'fas fa-eye-slash';
        } else {
            input.type = 'password';
            icon.className = 'fas fa-eye';
        }
    }

</script>

<%
    HttpSession sesion = request.getSession();
    String tipo = "";
    if (request.getAttribute("tipo") != null) {
        tipo = request.getAttribute("tipo").toString();
        if (tipo.equalsIgnoreCase("Administrador")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("Producto.jsp");
        } else if (tipo.equalsIgnoreCase("Almacen")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("Producto.jsp");
        } else if (tipo.equalsIgnoreCase("Compra")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("Proveedor.jsp");
        } else if (tipo.equalsIgnoreCase("Venta")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("ListarFacturaventa.jsp");
        } else if (tipo.equalsIgnoreCase("Supervisor")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("Producto.jsp");
        } else if (tipo.equalsIgnoreCase("Logistico")) {
            sesion.setAttribute("usuario", request.getAttribute("usuario"));
            sesion.setAttribute("tipo", tipo);
            response.sendRedirect("Producto.jsp");
        }
    }

    if (request.getParameter("cerrar") != null) {
        Object usuarioCerrando = session.getAttribute("usuario");
        if (usuarioCerrando != null) {
            new com.pe.DAO.AuditoriaDAO().registrar(usuarioCerrando.toString(), "Cierre de sesión", "Auth", "");
        }
        session.invalidate();
    }
%>

</body>
</html>
