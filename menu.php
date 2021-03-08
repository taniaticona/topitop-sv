 <?php
$menu = $musuarios->opcionesMenu();
?>
<ul class="nopcionesmenu">
	<li>
  	<a href="index.php">
  		<span class="fa fa-home fa-lg"></span> Inicio
  	</a>
  </li>

  <li>
  	<a href="?alt=<?php echo base64_encode('usuarios/vst/micuenta.php') ?>">
  		<span class="fa fa-key fa-lg"></span> Mi Cuenta
  	</a>
  </li>

  <?php foreach($menu as $m) : ?>
    <li>
      <a href="?var=<?php echo $m->sumoide ?>">
        <span class="fa fa-<?php echo $m->sumoicono; ?> fa-lg"></span> <?php echo $m->sumodescri ?>
      </a>
    </li>
  <?php endforeach ?>


  <li>
    <a href="app/zreporte-ventas/vistas/index.php">
      <span class="fa fa-bars fa-lg"></span> Reporte de ventas
    </a>
  </li>


  <li>
    <a href="logout.php">
      <span class="fa fa-sign-out-alt fa-lg"></span> Salir
    </a>
  </li>

</ul>
