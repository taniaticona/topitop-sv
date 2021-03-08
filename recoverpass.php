   <?php
  error_reporting(E_ALL ^ E_NOTICE);
  session_start();
  $userid = $_SESSION['userid'];
  $username = $_SESSION['username'];
  ?>

  <?php require 'cfg/base.php'; $musuarios->redirecIndex(); $dp = $mempresa->getAll(); ?>
  <!DOCTYPE html>
  <html lang="en">
  <head>
  	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<title>:: TopiTop S.A.C  - ¿Olvidó su contraseña?:: </title>
  	<!-- Bootstrap -->
  	<link href="lib/bootstrap/css/bootstrap.mins.css" rel="stylesheet">
  	<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  <link href="css/login.css" rel="stylesheet">
</head>
<body>

	<div class="col-sm-8 col-sm-offset-2">
		<!--<div class="col-sm-12"><img src="img/<?php echo $dp[0]->emprlogo ?>" alt="" class="logo"></div>-->
	</div>
	<div class="clearfix"></div>
	<div class="space-40"></div>
	<div class="container-fluid">
		<div class="col-sm-6 col-sm-offset-3">
			<form action="" class="well login" style="padding-top: 50px; padding-bottom: 50px; box-shadow: 0px 0px 20px -5px #000">
				<div class="msj"></div>
				<div class="form-group col-sm-6">
					<label for="" class="bolder col-sm-20 control-label"></label>
					<h3 style="width: 600px; margin-left: -90px; margin-top: -30px;margin-bottom: -10px;">Olvidaste tu contraseña?</h3>

				</div>
				<div class="form-group col-sm-6">
					<label for="" class="bolder col-sm-12 control-label"></label>
					<div class="col-sm-10">
						<input type="email" class="form-control" name="usuaapelli" placeholder="Email">
					</div>
					<a href="recoverpass.php" style="width:300px;color:#afafaf; text-decoration:none;"></a>
					<div class="col-sm-2">

						<button class="btn btn-primary pull-right"><i class="fa fas-unlock">Enviar</i></button>
					</div>
				</div>
				<span  style="width:10px;color:#666;padding-left: 215px;"></span>Developed by </span><a  href="http://www.facebook.com/#" style="width:10px;color:rgba(200, 6, 81, 0.41);padding-left: 0px; text-decoration:none;">Ruth</a>

				<div class="clearfix"></div>
			</form>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="js/jquery.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="lib/jquery-validation/dist/jquery.validate.min.js"></script>
	<script src="js/funciones.js"></script>
	<script>
		$(function(){
			var formulario = '.login'
			$(formulario).validate({
				rules: {
					usuario: {
						required: true,
					},
					clave: {
						required: true,
					},
				},
				 messages: {
					usuario: {
						required: 'Ingrese su usuario',
					},
					clave: {
						required: 'Indique la clave',
					},
				},
				submitHandler: function(form) {
					$.post('app/usuarios/prc/_login.php',$(formulario).serialize(),function(data){
						if(data==1) {
							location.href="index.php"
						} else {
							alerta('msj','danger',data)
						}
					})
				}
			});
		})
	</script>
</body>
</html>
