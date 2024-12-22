<?php
// Mostrar todos los errores
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

/**
 * Procesa una consulta en lenguaje natural.
 * 
 * @param string $consulta Entrada del usuario en lenguaje natural.
 * @param mysqli $conexion Conexión a la base de datos.
 * @param string &$sql Salida: sentencia SQL generada o cadena vacía si no es reconocida.
 * @return bool True si la consulta es válida, False en caso contrario.
 */
function procesa_consulta($consulta, $conexion, &$sql) {
    // Convertir la consulta a minúsculas y eliminar espacios extra
    $consulta = strtolower(trim($consulta));

    // Separar palabras de la consulta
    $palabras = explode(' ', $consulta);

    // Ignorar palabras decorativas como "de", "más", etc.
    $palabras_ignoradas = ['de', 'más', 'con'];
    $palabras = array_diff($palabras, $palabras_ignoradas);

    // Consultar el diccionario para validar las palabras
    $validas = [];
    $categorias_usadas = []; // Evitar duplicados
    foreach ($palabras as $palabra) {
        if (is_numeric($palabra)) {
            // Manejar números directamente como valores válidos
            $validas[] = ['palabra' => $palabra, 'categoria' => 'numero'];
        } else {
            $query = "SELECT categoria FROM ln_diccionario WHERE palabra = '$palabra'";
            $resultado = $conexion->query($query);

            if ($resultado && $resultado->num_rows > 0) {
                while ($fila = $resultado->fetch_assoc()) {
                    // Evitar duplicados en las categorías
                    if (!in_array($fila['categoria'], $categorias_usadas)) {
                        $validas[] = ['palabra' => $palabra, 'categoria' => $fila['categoria']];
                        $categorias_usadas[] = $fila['categoria'];
                    }
                }
            }
        }
    }

    // Corregir patrones mal interpretados
    // Si aparece 'atributo' y 'garaje', mantener solo 'garaje'
    foreach ($validas as $index => $dato) {
        if ($dato['categoria'] === 'atributo' && isset($validas[$index + 1]) && $validas[$index + 1]['categoria'] === 'garaje') {
            unset($validas[$index]); // Eliminar el atributo
        }
    }

    // Si no se encuentran palabras válidas
    if (empty($validas)) {
        echo "<p>Debug: No se encontraron palabras válidas para la consulta: $consulta</p>";
        $sql = '';
        return false;
    }

    // Construir el patrón para búsqueda en ln_patrones
    $categorias = implode(' ', array_column($validas, 'categoria'));

    // Buscar el patrón en la tabla ln_patrones
    $query_patron = "SELECT consultasql FROM ln_patrones WHERE patron = '$categorias'";
    $resultado_patron = $conexion->query($query_patron);

    if ($resultado_patron && $resultado_patron->num_rows > 0) {
        $fila = $resultado_patron->fetch_assoc();
        $sql = $fila['consultasql'];

        // Reemplazar parámetros (%1, %2, etc.) con las palabras reales
        $contador = 1;
        foreach ($validas as $dato_valido) {
            $sql = str_replace("%$contador", $dato_valido['palabra'], $sql);
            $contador++;
        }
        return true;
    } else {
        echo "<p>Debug: Patrón no encontrado para las categorías: $categorias</p>";
        $sql = '';
        return false;
    }
}
?>
