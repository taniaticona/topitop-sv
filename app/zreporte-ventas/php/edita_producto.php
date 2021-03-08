<?php
include('conexion.php');

$id = $_POST['id'];

//OBTENEMOS LOS VALORES DEL PRODUCTO

$valores = mysql_query("SELECT * FROM productos WHERE prodide = '$id'");
$valores2 = mysql_fetch_array($valores);

$datos = array(
				0 => $valores2['proddescri'], 
				1 => $valores2['unmeide'], 
				2 => $valores2['prodprecio'], 
				);
echo json_encode($datos);
?>

