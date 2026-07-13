<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alicorp | Recuperar contrase&ntilde;a</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=fallback">
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
        .card {
            width: 420px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.13);
            padding: 2.5rem 2rem;
        }
        h1 { font-size: 22px; margin-bottom: 6px; color: #1a1f2e; }
        p.subtitle { color: #666; font-size: 13.5px; margin-bottom: 22px; }
        .field { margin-bottom: 18px; }
        label { display:block; font-size: 13px; font-weight: 500; color:#444; margin-bottom:5px; }
        input[type=email] {
            width: 100%; height: 44px; border-radius: 8px; border: 1.5px solid #e0e0e0;
            padding: 0 14px; font-size: 13.5px;
        }
        input[type=email]:focus { border-color: #C8102E; outline:none; }
        button {
            width: 100%; height: 46px; border: none; border-radius: 8px;
            background: #C8102E; color: #fff; font-weight: 600; font-size: 14px; cursor: pointer;
        }
        button:hover { background:#a50d26; }
        .msg { background:#eef6ff; border:1px solid #bcdcff; color:#2154a3; padding:12px 14px; border-radius:8px; font-size:13px; margin-bottom:18px; }
        .token-box { background:#fff8e1; border:1px solid #ffe08a; color:#7a5a00; padding:12px 14px; border-radius:8px; font-size:12.5px; margin-bottom:18px; word-break: break-all; }
        .back-link { display:block; text-align:center; margin-top:18px; font-size:13px; color:#C8102E; text-decoration:none; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Recuperar contrase&ntilde;a</h1>
        <p class="subtitle">Ingresa tu correo corporativo y te ayudaremos a restablecer tu contrase&ntilde;a.</p>

        <% if (request.getAttribute("mensaje") != null) { %>
        <div class="msg"><%= request.getAttribute("mensaje") %></div>
        <% } %>

        <% if (request.getAttribute("tokenDemo") != null) { %>
        <div class="token-box">
            <strong>Modo demo (sin correo configurado todav&iacute;a):</strong><br>
            Tu token de recuperaci&oacute;n es:<br>
            <code><%= request.getAttribute("tokenDemo") %></code><br><br>
            Cop&iacute;alo y p&eacute;galo en la
            <a href="RestablecerPassword.jsp?token=<%= request.getAttribute("tokenDemo") %>">pantalla de restablecer contrase&ntilde;a</a>.
            Expira en 30 minutos.
        </div>
        <% } %>

        <form action="RecuperarPasswordController" method="POST">
            <input type="hidden" name="accion" value="solicitar">
            <div class="field">
                <label for="txtEmailRecuperacion">Correo corporativo</label>
                <input type="email" id="txtEmailRecuperacion" name="txtEmailRecuperacion"
                       placeholder="tu.correo@alicorp.pe" required>
            </div>
            <button type="submit">Enviar solicitud</button>
        </form>

        <a class="back-link" href="login.jsp">&larr; Volver a inicio de sesi&oacute;n</a>

        <div style="margin-top:20px; padding-top:16px; border-top:1px solid #eee; text-align:center; font-size:12px; color:#888;">
            &iquest;No tienes acceso a tu correo o sigue sin funcionar?<br>
            Cont&aacute;ctate con el <b>Administrador del sistema</b> para que te genere una nueva contrase&ntilde;a directamente.
        </div>
    </div>
</body>
</html>
