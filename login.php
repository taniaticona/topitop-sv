   <?php require 'cfg/base.php'; $musuarios->redirecIndex(); $dp = $mempresa->getAll(); ?>
  <!DOCTYPE html>
  <html lang="en">
  <head>
  	<meta charset="utf-8">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<title>:: TopiTop S.A.C :: </title>
  	<!-- Bootstrap -->
  	<link href="css/flatly.css" rel="stylesheet">
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
<form class="form-horizontal well login">
	<div class="msj"></div>
  <fieldset>
    <legend>Iniciar sesión: Topitop</legend>
    <div class="form-group">
      <label for="inputEmail" class="col-lg-2 control-label">Usuario</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario">
      </div>
    </div>
    <div class="form-group">
      <label for="inputPassword" class="col-lg-2 control-label">Contraseña</label>
      <div class="col-lg-10">
        <input type="password" class="form-control" id="clave" name="clave" placeholder="**********">
        <div class="checkbox">
            <a href="forgot.php" >Olvidaste tu contraseña?</a>
        </div>
      </div>
    </div>


    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <button type="submit" class="btn btn-primary btn-block">Iniciar Sesión</button>
      </div>
    </div>
Desarrollado por </span><a  href="http://www.facebook.com/#" >Tania Ticona Encinas</a>
				<div class="clearfix"></div>
  </fieldset>
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
						required: 'Ingrese su contraseña',
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
<footer>
</footer>
</html>
