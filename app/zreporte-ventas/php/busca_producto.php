<?php
include('conexion.php');

$dato = $_POST['dato'];

//EJECUTAMOS LA CONSULTA DE BUSQUEDA

$registro = mysql_query("SELECT * FROM ventas WHERE proddescri LIKE '%$dato%' OR ventide LIKE '%$dato%' ORDER BY menuide ASC");

//CREAMOS NUESTRA VISTA Y LA DEVOLVEMOS AL AJAX

echo '<table class="table table-striped table-condensed table-hover">
        	<tr>
            	<th width="200">Item</th>
            	<th width="300">Nombre</th>
                <th width="150">Precio</th>
                <th width="150">Cantidad</th>
                <th width="150">Fecha Venta</th>
                <th width="50">Opciones</th>
            </tr>';
if(mysql_num_rows($registro)>0){
	while($registro2 = mysql_fetch_array($registro)){
		echo '<tr>
				<td>'.$registro2['ventide'].'</td>
				<td>'.$registro2['proddescri'].'</td>
				<td>S/. '.$registro2['ventprecio'].'</td>
				<td>'.$registro2['ventcantid'].'</td>
				<td>'.fechaNormal($registro2['ventfecha']).'</td>
				<td><a href="javascript:eliminarProducto('.$registro2['menuide'].');" class="glyphicon glyphicon-remove-circle"></a></td>
				</tr>';
	}
}else{
	echo '<tr>
				<td colspan="6">No se encontraron resultados</td>
			</tr>';
}
echo '</table>';
?>