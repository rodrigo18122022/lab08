<?php
require 'db_config.php';
require 'ln.php';

$mensaje = '';
$resultados = [];
$consulta = '';

// Procesar el formulario al enviar
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $consulta = trim($_POST['consulta']);

    if (empty($consulta)) {
        $mensaje = 'Debe introducir una consulta.';
    } else {
        $sql = '';
        if (procesa_consulta($consulta, $conexion, $sql)) {
            $resultado = $conexion->query($sql);

            if ($resultado && $resultado->num_rows > 0) {
                while ($fila = $resultado->fetch_assoc()) {
                    $resultados[] = $fila;
                }
            } else {
                $mensaje = 'No hay viviendas disponibles.';
            }
        } else {
            $mensaje = 'La consulta no es correcta.';
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Búsqueda de Vivienda</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #0056b3;
        }
        .formulario {
            margin-bottom: 20px;
        }
        .tabla-resultados {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        .tabla-resultados th, .tabla-resultados td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .tabla-resultados th {
            background-color: #0056b3;
            color: white;
        }
        .mensaje-error {
            color: red;
            font-weight: bold;
        }
        .link-volver {
            margin-top: 20px;
            display: block;
            color: #0056b3;
            text-decoration: none;
        }
        .link-volver:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Búsqueda de vivienda</h1>

    <?php if (!empty($mensaje)): ?>
        <p class="mensaje-error"><?= htmlspecialchars($mensaje) ?></p>
    <?php endif; ?>

    <?php if (empty($resultados)): ?>
        <!-- Formulario de búsqueda -->
        <form method="POST" class="formulario">
            <label for="consulta">Introduzca la consulta:</label><br>
            <input type="text" name="consulta" id="consulta" value="<?= htmlspecialchars($consulta) ?>" size="50">
            <button type="submit">Buscar vivienda</button>
        </form>
    <?php else: ?>
        <!-- Resultados de la búsqueda -->
        <h2>Resultados de la búsqueda:</h2>
        <table class="tabla-resultados">
            <thead>
                <tr>
                    <th>Tipo</th>
                    <th>Zona</th>
                    <th>Dormitorios</th>
                    <th>Precio</th>
                    <th>Tamaño</th>
                    <th>Extras</th>
                    <th>Foto</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($resultados as $fila): ?>
                    <tr>
                        <td><?= htmlspecialchars($fila['tipo']) ?></td>
                        <td><?= htmlspecialchars($fila['zona']) ?></td>
                        <td><?= htmlspecialchars($fila['ndormitorios']) ?></td>
                        <td><?= htmlspecialchars($fila['precio']) ?></td>
                        <td><?= htmlspecialchars($fila['metros_cuadrados']) ?></td>
                        <td><?= $fila['garaje'] ? 'Garaje' : 'Sin garaje' ?></td>
                        <td><a href="<?= htmlspecialchars($fila['foto']) ?>">Ver</a></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <a href="index.php" class="link-volver">Buscar otra vivienda</a>
    <?php endif; ?>
</body>
</html>
