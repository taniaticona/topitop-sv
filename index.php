 <?php require 'cfg/base.php'; $musuarios->redirecLogin(); $dp = $mempresa->getAll(); ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>:: TopiTop S.A.C :: Inicio </title>
	<!-- Bootstrap -->
	<link href="css/flatly.css" rel="stylesheet">
	<link href="lib/fontawesome/css/all.css" rel="stylesheet">
	<link href="lib/chosen/chosen.css" rel="stylesheet">
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<link href="css/principal.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="lib/jquery-validation/dist/jquery.validate.min.js"></script>
	<script src="lib/chosen/chosen.jquery.js"></script>
	<script src="js/funciones.js"></script>
	</head>
	<style type="text/css">
		.col-sm-10.top {
    margin-top: -35px;
}
.well {
    min-height: 20px;
    padding: 19px;
    margin-bottom: 20px;
    background-color: #fffffff0;
    }
    a {
    color: #976445;
    text-decoration: none;
	}
	a:hover {
    color: #000;
    text-decoration: none;
	}
	</style>
	<body>
		<div class="modal fade">
	  	<div class="modal-dialog">
	    <div class="modal-content">
	    </div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	<div class="col-sm-10 col-sm-offset-1" >
		<div class="logo">
			<img src="img/<?php echo $dp[0]->emprlogo ?>" alt="" class="logo">
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="col-sm-10  col-sm-offset-1">
		<div class="col-sm-2 menu"><?php require 'menu.php'; ?></div>
		<div class="col-sm-10 top">
			<div class="well">

				<?php require 'contenido.php'; ?><div class="clearfix"></div><div class="space-20"></div>
			</div>
		</div>
	</div>

</body>
<div class="col-md-12">
	<footer>
	<span style="margin-left:30px"><a href="#">Inicio</a> |<a href="#"> Desarrolladores </a> |<a href="#">Ayuda</a></span>

</footer>
</div>
</html>
