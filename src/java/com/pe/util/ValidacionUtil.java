package com.pe.util;

import java.util.regex.Pattern;

/**
 * Validaciones reutilizables para el módulo de usuarios.
 */
public class ValidacionUtil {

    // Dominio corporativo permitido
    public static final String DOMINIO_PERMITIDO = "@alicorp.pe";

    // Formato general de correo válido
    private static final Pattern PATRON_EMAIL =
            Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    /**
     * Valida que el correo tenga formato correcto Y pertenezca al dominio
     * corporativo @alicorp.pe
     */
    public static boolean esCorreoCorporativoValido(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String correo = email.trim().toLowerCase();
        if (!PATRON_EMAIL.matcher(correo).matches()) {
            return false;
        }
        return correo.endsWith(DOMINIO_PERMITIDO);
    }

    /**
     * Mensaje de error estándar a mostrar al usuario.
     */
    public static String mensajeErrorDominio() {
        return "Solo se permiten correos corporativos con dominio " + DOMINIO_PERMITIDO;
    }

    // Mínimo 8 caracteres, al menos una mayúscula, una minúscula, un número y un símbolo especial
    private static final Pattern PATRON_PASSWORD =
            Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$");

    /**
     * Valida que la contraseña tenga al menos 8 caracteres, con mayúsculas,
     * minúsculas, números y al menos un símbolo especial (ej. @ # $ % ! * . -).
     */
    public static boolean esPasswordSegura(String password) {
        if (password == null) {
            return false;
        }
        return PATRON_PASSWORD.matcher(password).matches();
    }

    public static String mensajeErrorPassword() {
        return "La contraseña debe tener al menos 8 caracteres, con mayúsculas, minúsculas, números y un símbolo especial (ej. @ # $ %)";
    }
}
