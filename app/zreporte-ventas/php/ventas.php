<?php

if(strlen($_GET['desde'])>0 and strlen($_GET['hasta'])>0){
	$desde = $_GET['desde'];
	$hasta = $_GET['hasta'];

	$verDesde = date('d/m/Y', strtotime($desde));
	$verHasta = date('d/m/Y', strtotime($hasta));
}else{
	$desde = '1111-01-01';
	$hasta = '9999-12-30';

	$verDesde = '__/__/____';
	$verHasta = '__/__/____';
}
require('../fpdf/fpdf.php');
require('conexion.php');

$pdf = new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial', '', 10);
$pdf->Image('../recursos/tienda.gif' , 10 ,8, 10 , 13,'GIF');
$pdf->Cell(18, 10, '', 0);
$pdf->Cell(150, 10, 'Sistema de ventas de ropas - "TOPITOP"', 0);
$pdf->SetFont('Arial', '', 9);
$pdf->Cell(50, 10, 'Hoy: '.date('d-m-Y').'', 0);
$pdf->Ln(15);
$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(70, 8, '', 0);
$pdf->Cell(100, 8, 'Listado de ventas', 0);
$pdf->Ln(10);
$pdf->Cell(60, 8, '', 0);
$pdf->Cell(100, 8, 'Desde: '.$verDesde.' hasta: '.$verHasta, 0);
$pdf->Ln(23);
$pdf->SetFont('Arial', 'B', 8);
$pdf->Cell(15, 8, 'Item', 0);
$pdf->Cell(70, 8, 'Nombre', 0);
$pdf->Cell(25, 8, 'Precio', 0);
$pdf->Cell(40, 8, 'Cantidad', 0);
$pdf->Cell(25, 8, 'Fech. venta', 0);
$pdf->Ln(8);
$pdf->SetFont('Arial', '', 8);
//CONSULTA
$ventas = mysql_query("SELECT * FROM ventas WHERE ventfecha BETWEEN '$desde' AND '$hasta' ");
$item = 0;
$totaluni = 0;
$totaldis = 0;
while($ventas2 = mysql_fetch_array($ventas)){
	$item = $item+1;
	$totaluni = $totaluni + $ventas2['prodprecio'];
	$pdf->Cell(15, 8, $item, 0);
	$pdf->Cell(70, 8,$ventas2['proddescri'], 0);
	$pdf->Cell(40, 8, $ventas2['unmeide'], 0);
	$pdf->Cell(25, 8, 'S/. '.$ventas2['prodprecio'], 0);
	$pdf->Cell(25, 8, $ventas2['ventcantid'], 0);

	$pdf->Cell(25, 8, date('d/m/Y', strtotime($ventas2['ventfecha'])), 0);
	$pdf->Ln(8);
}
$pdf->SetFont('Arial', 'B', 8);
$pdf->Cell(104,8,'',0);
$pdf->Cell(31,8,'Precio total: S/. '.$totaluni,0);
$pdf->Output('reporte.pdf','D');
?>