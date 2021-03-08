<?php
include('conexion.php');
$id = $_POST['id-prod'];
$proceso = $_POST['pro'];
$nombre = $_POST['nombre'];
$tipo = $_POST['tipo'];
$precio_uni = $_POST['precio-uni'];
$precio_dis = $_POST['precio-dis'];
$fecha = date('Y-m-d');
//VERIFICAMOS EL PROCESO

switch($proceso){
	case 'Registro':
		mysql_query("INSERT INTO productos (proddescri, unmeide, prodprecio, precio_dist, fecha_reg)VALUES('$nombre','$tipo','$precio_uni','$precio_dis', '$fecha')");
	break;
	
	case 'Edicion':
		mysql_query("UPDATE productos SET proddescri = '$nombre', unmeide = '$tipo', prodprecio = '$precio_uni', precio_dist = '$precio_dis' WHERE prodide = '$id'");
	break;
}


//ACTUALIZAMOS LOS REGISTROS Y LOS OBTENEMOS

$registro = mysql_query("SELECT * FROM productos ORDER BY prodide ASC");

//CREAMOS NUESTRA VISTA Y LA DEVOLVEMOS AL AJAX

echo '<table class="table table-striped table-condensed table-hover">
        	<tr>
            	<th width="300">Nombre</th>
                <th width="200">Tipo</th>
                <th width="150">Precio Unitario</th>
				<th width="50">Opciones</th>
            </tr>';
	while($registro2 = mysql_fetch_array($registro)){
		echo '<tr>
				<td>'.$registro2['proddescri'].'</td>
				<td>'.$registro2['unmeide'].'</td>
				<td>S/. '.$registro2['prodprecio'].'</td>
				<td><a href="javascript:editarProducto('.$registro2['prodide'].');" class="glyphicon glyphicon-edit"></a> <a href="javascript:eliminarProducto('.$registro2['prodide'].');" class="glyphicon glyphicon-remove-circle"></a></td>
				</tr>';
	}
echo '</table>';
?>