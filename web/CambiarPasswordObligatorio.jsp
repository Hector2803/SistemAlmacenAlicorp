<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Seguridad: esta pantalla solo es válida si el usuario acaba de iniciar
    // sesión con una contraseña TEMPORAL (restablecida por el administrador).
    // Ese id se guarda en sesión desde LoginController (idCambioPass).
    // Si no existe, no hay proceso de cambio en curso -> volver al login.
    if (session.getAttribute("idCambioPass") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alicorp | Cambiar contrase&ntilde;a</title>
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
            width: 440px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.13);
            padding: 2.5rem 2rem;
        }
        h1 { font-size: 22px; margin-bottom: 6px; color: #1a1f2e; }
        p.subtitle { color: #666; font-size: 13.5px; margin-bottom: 22px; }
        .field { margin-bottom: 16px; }
        label { display:block; font-size: 13px; font-weight: 500; color:#444; margin-bottom:5px; }
        input {
            width: 100%; height: 44px; border-radius: 8px; border: 1.5px solid #e0e0e0;
            padding: 0 14px; font-size: 13.5px;
        }
        input:focus { border-color: #C8102E; outline:none; }
        button {
            width: 100%; height: 46px; border: none; border-radius: 8px;
            background: #C8102E; color: #fff; font-weight: 600; font-size: 14px; cursor: pointer; margin-top:6px;
        }
        button:hover { background:#a50d26; }
        #resultado { display:none; padding:12px 14px; border-radius:8px; font-size:13px; margin-bottom:16px; }
        .ok { background:#e7f7ec; border:1px solid #a9e0bb; color:#1e7a3d; }
        .error { background:#fdeaea; border:1px solid #f3b6b6; color:#a11d1d; }
        .reglas { background:#f7f8fa; border:1px solid #e5e7eb; border-radius:8px; padding:12px 14px; font-size:12px; color:#555; margin-bottom:18px; }
        .reglas b { color:#1a1f2e; }
        .reglas ul { margin:6px 0 0 18px; }
        .aviso { background:#fff8e1; border:1px solid #ffe08a; border-radius:8px; padding:10px 14px; font-size:12.5px; color:#8a6d00; margin-bottom:18px; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Cambia tu contrase&ntilde;a</h1>
        <p class="subtitle">Tu contrase&ntilde;a fue restablecida por el administrador. Por seguridad, debes definir una nueva antes de ingresar al sistema.</p>

        <div class="aviso">No podr&aacute;s continuar hasta cambiar tu contrase&ntilde;a temporal.</div>

        <div id="resultado"></div>

        <div class="reglas">
            <b>La nueva contrase&ntilde;a debe tener:</b>
            <ul>
                <li>M&iacute;nimo 8 caracteres</li>
                <li>Al menos una letra may&uacute;scula y una min&uacute;scula</li>
                <li>Al menos un n&uacute;mero</li>
                <li>Al menos un car&aacute;cter especial (ej. @ # $ % ! *)</li>
            </ul>
        </div>

        <form id="frmCambiar">
            <div class="field">
                <label for="txtNuevaPassword">Nueva contrase&ntilde;a</label>
                <input type="password" id="txtNuevaPassword" name="txtNuevaPassword" minlength="8"
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$"
                       title="M&iacute;nimo 8 caracteres, con may&uacute;sculas, min&uacute;sculas, n&uacute;meros y un s&iacute;mbolo especial" required>
            </div>
            <div class="field">
                <label for="txtConfirmarPassword">Confirmar nueva contrase&ntilde;a</label>
                <input type="password" id="txtConfirmarPassword" name="txtConfirmarPassword" minlength="8" required>
            </div>
            <button type="submit">Guardar y continuar</button>
        </form>
    </div>

    <script>
        document.getElementById('frmCambiar').addEventListener('submit', function (e) {
            e.preventDefault();
            var resultado = document.getElementById('resultado');
            var pass = document.getElementById('txtNuevaPassword').value;
            var conf = document.getElementById('txtConfirmarPassword').value;

            if (pass !== conf) {
                resultado.style.display = 'block';
                resultado.className = 'error';
                resultado.textContent = 'Las contrase\u00f1as no coinciden.';
                return;
            }

            var params = new URLSearchParams();
            params.append('accion', 'cambioObligatorio');
            params.append('txtNuevaPassword', pass);
            params.append('txtConfirmarPassword', conf);

            fetch('RecuperarPasswordController', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            }).then(r => r.text()).then(function (res) {
                res = res.trim();
                resultado.style.display = 'block';
                if (res === 'ok') {
                    resultado.className = 'ok';
                    resultado.textContent = 'Contrase\u00f1a actualizada correctamente. Redirigiendo al inicio de sesi\u00f3n...';
                    setTimeout(function () { window.location.href = 'login.jsp'; }, 1800);
                } else if (res === 'password_corta') {
                    resultado.className = 'error';
                    resultado.textContent = 'La contrase\u00f1a debe tener m\u00ednimo 8 caracteres, con may\u00fasculas, min\u00fasculas, n\u00fameros y un s\u00edmbolo especial.';
                } else if (res === 'password_no_coincide') {
                    resultado.className = 'error';
                    resultado.textContent = 'Las contrase\u00f1as no coinciden.';
                } else if (res === 'sesion_invalida') {
                    resultado.className = 'error';
                    resultado.textContent = 'La sesi\u00f3n expir\u00f3. Vuelve a iniciar sesi\u00f3n con tu contrase\u00f1a temporal.';
                    setTimeout(function () { window.location.href = 'login.jsp'; }, 2200);
                } else {
                    resultado.className = 'error';
                    resultado.textContent = 'Ocurri\u00f3 un error, intenta de nuevo.';
                }
            }).catch(function () {
                resultado.style.display = 'block';
                resultado.className = 'error';
                resultado.textContent = 'Error de conexi\u00f3n. Intenta de nuevo.';
            });
        });
    </script>
</body>
</html>
