 <html style="background:url(img/log.jpg) no-repeat fixed center center / cover;">
<meta charset="utf-8">
<link href="https://bootswatch.com/3/flatly/bootstrap.min.css" rel="stylesheet">
<title>Recuperación de contraseña</title>
<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>:: TopiTop S.A.C :: Inicio </title>
  <!-- Bootstrap -->
  <link href="https://bootswatch.com/3/flatly/bootstrap.min.css" rel="stylesheet">
  <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
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
<body>
<div class="col-sm-6 col-sm-offset-3">

<form class="form-horizontal well " action='#' method='post'>
  <div class="msj"></div>
  <fieldset>
    <legend>¿Olvidaste tu contraseña?</legend>
    <div class="form-group">
      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" id="usuaapelli" name="usuaapelli" placeholder="Email">
      </div>
    </div>



    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <input class="btn btn-primary btn-block"  type='submit' name='submit' value='Recuperar contraseña'/>
      </div>
    </div>
Desarrollado por </span><a  href="http://www.facebook.com/#" >Tania Ticona Encinas</a>
        <div class="clearfix"></div>
  </fieldset>
</form>

    </div>


<?php
if(isset($_POST['submit']))
{
 mysql_connect('localhost','root','') or die(mysql_error());
 mysql_select_db('baseventastt') or die(mysql_error());
 $mail=$_POST['usuaapelli'];
 $q=mysql_query("select * from usuario where usuaapelli='".$mail."' ") or die(mysql_error());
 $p=mysql_affected_rows();
 if($p!=0)
 {
  $res=mysql_fetch_array($q);
  $to=$res['usuaapelli'];
  $subject='Remind acceclave';
  $message='Your acceclave : '.$res['acceclave'];
  $headers='From:vladimir.mamani@outlook.com';
  $m=mail($to,$subject,$message,$headers);
  if($m)
  {
    echo'Verifique su Email';
  }
  else
  {
   echo'No se pudo enviar email';
  }
 }
 else
 {
  echo'Email no existente';
 }
}
?>
</body>
</html>