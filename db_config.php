<?php
// Configuración de conexión a la base de datos
$host = 'localhost'; 
$user = 'root'; 
$password = ''; 
$dbname = 'lindavista'; 

$conexion = new mysqli($host, $user, $password, $dbname);


if ($conexion->connect_error) {
    die('Error de conexión: ' . $conexion->connect_error);
}

$conexion->set_charset('utf8');

?>
