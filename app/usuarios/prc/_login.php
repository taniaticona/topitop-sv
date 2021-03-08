 <?php
require '../../../cfg/base.php';
$res = $musuarios->login();
if(count($res)>0) {
	$_SESSION = array(
			'usuaide'=>$res[0]->usuaide,
		);
	echo 1;
} else {
	echo 'Datos no válidos. Verifique';
}
?>