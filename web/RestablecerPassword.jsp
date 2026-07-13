<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alicorp | Restablecer contrase&ntilde;a</title>
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
        .back-link { display:block; text-align:center; margin-top:18px; font-size:13px; color:#C8102E; text-decoration:none; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Restablecer contrase&ntilde;a</h1>
        <p class="subtitle">Ingresa el token que recibiste y tu nueva contrase&ntilde;a.</p>

        <div id="resultado"></div>

        <form id="frmRestablecer">
            <div class="field">
                <label for="txtToken">Token de recuperaci&oacute;n</label>
                <input type="text" id="txtToken" name="txtToken"
                       value="<%= request.getParameter("token") != null ? request.getParameter("token") : "" %>" required>
            </div>
            <div class="field">
                <label for="txtNuevaPassword">Nueva contrase&ntilde;a</label>
                <input type="password" id="txtNuevaPassword" name="txtNuevaPassword" minlength="8"
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$" title="Debe tener m&iacute;nimo 8 caracteres, con may&uacute;sculas, min&uacute;sculas, n&uacute;meros y un s&iacute;mbolo especial" required>
            </div>
            <div class="field">
                <label for="txtConfirmarPassword">Confirmar contrase&ntilde;a</label>
                <input type="password" id="txtConfirmarPassword" name="txtConfirmarPassword" minlength="8" required>
            </div>
            <button type="submit">Cambiar contrase&ntilde;a</button>
        </form>

        <a class="back-link" href="login.jsp">&larr; Volver a inicio de sesi&oacute;n</a>
    </div>

    <script>
        document.getElementById('frmRestablecer').addEventListener('submit', function (e) {
            e.preventDefault();
            var resultado = document.getElementById('resultado');
            var params = new URLSearchParams();
            params.append('accion', 'restablecer');
            params.append('txtToken', document.getElementById('txtToken').value);
            params.append('txtNuevaPassword', document.getElementById('txtNuevaPassword').value);
            params.append('txtConfirmarPassword', document.getElementById('txtConfirmarPassword').value);

            fetch('RecuperarPasswordController', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            }).then(r => r.text()).then(function (res) {
                resultado.style.display = 'block';
                if (res === 'ok') {
                    resultado.className = 'ok';
                    resultado.textContent = 'Contrase\u00f1a actualizada correctamente. Ya puedes iniciar sesi\u00f3n.';
                    setTimeout(function () { window.location.href = 'login.jsp'; }, 2000);
                } else if (res === 'token_invalido') {
                    resultado.className = 'error';
                    resultado.textContent = 'El token no es v\u00e1lido o ha expirado. Solicita uno nuevo.';
                } else if (res === 'password_corta') {
                    resultado.className = 'error';
                    resultado.textContent = 'La contrase\u00f1a debe tener m\u00ednimo 8 caracteres, con may\u00fasculas, min\u00fasculas, n\u00fameros y un s\u00edmbolo especial.';
                } else if (res === 'password_no_coincide') {
                    resultado.className = 'error';
                    resultado.textContent = 'Las contrase\u00f1as no coinciden.';
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
