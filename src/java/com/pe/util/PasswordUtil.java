package com.pe.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 * Utilidad para hashear y verificar contraseñas de forma segura usando
 * PBKDF2WithHmacSHA256 (viene incluido en el JDK, no requiere agregar
 * ningún .jar externo como BCrypt).
 *
 * Formato guardado en BD: pbkdf2$<iteraciones>$<saltBase64>$<hashBase64>
 * Esto permite reconocer si una contraseña ya está hasheada o si todavía
 * está en texto plano (migración progresiva, ver método isHashed).
 */
public class PasswordUtil {

    private static final String ALGORITMO = "PBKDF2WithHmacSHA256";
    private static final int ITERACIONES = 65536;
    private static final int LONGITUD_KEY = 256; // bits
    private static final int LONGITUD_SALT = 16; // bytes
    private static final String PREFIJO = "pbkdf2$";

    /**
     * Genera el hash de una contraseña en texto plano.
     */
    public static String hashPassword(String passwordPlano) {
        try {
            byte[] salt = new byte[LONGITUD_SALT];
            new SecureRandom().nextBytes(salt);

            byte[] hash = pbkdf2(passwordPlano.toCharArray(), salt, ITERACIONES, LONGITUD_KEY);

            return PREFIJO + ITERACIONES + "$"
                    + Base64.getEncoder().encodeToString(salt) + "$"
                    + Base64.getEncoder().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException("Error generando hash de contraseña", e);
        }
    }

    /**
     * Verifica si una contraseña en texto plano coincide con un hash
     * previamente generado por hashPassword().
     */
    public static boolean verificarPassword(String passwordPlano, String hashGuardado) {
        try {
            if (hashGuardado == null || !isHashed(hashGuardado)) {
                return false;
            }
            String[] partes = hashGuardado.split("\\$");
            // partes[0] = "pbkdf2", partes[1] = iteraciones, partes[2] = salt, partes[3] = hash
            int iteraciones = Integer.parseInt(partes[1]);
            byte[] salt = Base64.getDecoder().decode(partes[2]);
            byte[] hashEsperado = Base64.getDecoder().decode(partes[3]);

            byte[] hashCalculado = pbkdf2(passwordPlano.toCharArray(), salt, iteraciones, hashEsperado.length * 8);

            return constantTimeEquals(hashEsperado, hashCalculado);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Indica si el valor guardado en BD ya tiene formato de hash PBKDF2
     * (útil para diferenciar contraseñas antiguas en texto plano de las
     * ya migradas, y así migrar de forma progresiva sin romper el login).
     */
    public static boolean isHashed(String valorGuardado) {
        return valorGuardado != null && valorGuardado.startsWith(PREFIJO) && valorGuardado.split("\\$").length == 4;
    }

    private static byte[] pbkdf2(char[] password, byte[] salt, int iteraciones, int bits)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        PBEKeySpec spec = new PBEKeySpec(password, salt, iteraciones, bits);
        SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITMO);
        return skf.generateSecret(spec).getEncoded();
    }

    private static boolean constantTimeEquals(byte[] a, byte[] b) {
        if (a.length != b.length) {
            return false;
        }
        int resultado = 0;
        for (int i = 0; i < a.length; i++) {
            resultado |= a[i] ^ b[i];
        }
        return resultado == 0;
    }
}
