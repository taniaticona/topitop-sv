 <?php
require '../../../cfg/base.php';
$dp = $mempresa->getAll();
extract($_GET);
$ven1 = $mventas->getVentasFact($factide);
$cliente = $mclientes->clienteIde($clieide);
?>
<html>
	<head>
		<meta charset="utf8">
		<title>Factura</title>
		<link rel="stylesheet" href="css/print.css">
	</head>
	<body>
		<center><img src="img/<?php echo $dp[0]->emprlogo ?>" alt="" style="width:95%"></center>
		<h1>Factura</h1>
		<!-- contenido -->
		<table class="table1">
			<caption>Datos de la Empresa</caption>
			<tr>
				<th>RUC:</th>
				<td><?php echo $dp[0]->emprrif ?></td>
				<th>Nombre:</th>
				<td><?php echo $dp[0]->emprrazsoc ?> <?php echo $dp[0]->emprlema ?></td>
			</tr>
		</table>
		<table class="table1">
			<caption>Datos del Cliente</caption>
			<tr>
				<th>DNI:</th>
				<td><?php echo $cliente[0]->cliecedula ?></td>
				<th>Nombres:</th>
				<td><?php echo $cliente[0]->clierazsoc ?></td>
			</tr>
			<tr>
				<th>Dirección:</th>
				<td><?php echo $cliente[0]->cliedirecc ?></td>
				<th>Teléfono:</th>
				<td><?php echo $cliente[0]->clietelefo ?></td>
			</tr>
		</table>
		<br>
		<table class="table1">
			<thead>
				<tr>
					<th>Fecha</th>
					<th>Descripción</th>
					<th>Precio</th>
					<th>Cantidad</th>
					<th>Total</th>
				</tr>
			</thead>
			<tbody>
				<?php foreach($ven1 as $a) { ?>
					<tr>
						<td><?php echo $a->ventfecha ?></td>
						<td><?php echo $a->proddescri ?></td>
						<td><?php echo $a->ventprecio ?></td>
						<td><?php echo $a->ventcantid ?></td>
						<td><?php echo $cventas->total($a) ?></td>
					</tr>
				<?php } ?>
				<tr class="danger">
					<th colspan="4" class="text-right">Total S/.</th>
					<td><?php echo $mventas->totalPagar($clieide,$factide) ?></td>
				</tr>
			</tbody>
		</table>

		<!-- fin -->
		<div class="botones">
			<button type="button" onclick="window.close()">Cancelar</button>
			<button type="button" onclick="print()">Imprimir</button>
		</div>

	</body>
</html>
