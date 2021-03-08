 <?php require '../../../cfg/base.php'; ?>
<?php $dp = $musuarios->usuarioIde($usuaide) ?>
<form class="form-horizontal update"style="padding-left: 165px;">
	<?php echo $fn->modalHeader('Editar Usuario') ?>
	<div class="modal-body">
	<div class="msj"></div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Nacionalidad:
			</label>
			<div class="col-sm-9">
				<select name="nacion" class="form-control">
					<option value="PE" <?php echo $fn->selected($dp[0]->clienacion,'PE') ?>>Perú</option>
					<option value="CO" <?php echo $fn->selected($dp[0]->clienacion,'CO') ?>>Colombia</option>
					<option value="CL" <?php echo $fn->selected($dp[0]->clienacion,'CL') ?>>Chile</option>
					<option value="BR" <?php echo $fn->selected($dp[0]->clienacion,'BR') ?>>Brasil</option>
					<option value="AR" <?php echo $fn->selected($dp[0]->clienacion,'AR') ?>>Argentina</option>
					<option value="BO" <?php echo $fn->selected($dp[0]->clienacion,'BO') ?>>Bolivia</option>
					<option value="UR" <?php echo $fn->selected($dp[0]->clienacion,'UR') ?>>Uruguay</option>
					<option value="PA" <?php echo $fn->selected($dp[0]->clienacion,'PA') ?>>Paraguay</option>
					<option value="EC" <?php echo $fn->selected($dp[0]->clienacion,'EC') ?>>Ecuador</option>
					<option value="VE" <?php echo $fn->selected($dp[0]->clienacion,'VE') ?>>Venezuela</option>
					<option value="E" <?php echo $fn->selected($dp[0]->clienacion,'E') ?>>Extranjero</option>				</select>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				DNI:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="cedula" value="<?php echo $dp[0]->usuacedula ?>"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Nombres:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="nombre" value="<?php echo $dp[0]->usuanombre ?>"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Email:
			</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" name="apelli" value="<?php echo $dp[0]->usuaapelli ?>"></input>
			</div>
		</div>



		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Usuario:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="usuari" value="<?php echo $dp[0]->acceusuari ?>"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Contraseña:
			</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" name="clave" id="clave" value="<?php echo $dp[0]->acceclave ?>"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Confirmar:
			</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" name="clave2" value="<?php echo $dp[0]->acceclave ?>"></input>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<?php echo $fn->modalFooter(); ?>
	<input type="hidden" name="usuaide" value="<?php echo $dp[0]->usuaide ?>">
</form>

<script>
	$(function(){
		var formulario = '.update'
		$(formulario).validate({
			rules: {
				nacion: {
					required: true,
				},
				cedula: {
					required: true,
					number: true,
				},
				apelli: {
					required: true,
				},
				nombre: {
					required: true,
				},
				usuari: {
					required: true,
				},
				clave: {
					required: true,
				},
				clave2: {
					required: true,
					equalTo: '#clave',
				},
			},
			 messages: {
				nacion: {
					required: 'Ingrese su usuario',
				},
				cedula: {
					required: 'Indique la clave',
				},
				apelli: {
					required: 'Ingrese su usuario',
				},
				nombre: {
					required: 'Ingrese su usuario',
				},
				usuari: {
					required: 'Ingrese su usuario',
				},
				clave: {
					required: 'Ingrese su usuario',
				},
				clave2: {
					required: 'Ingrese su usuario',
					equalTo: 'No coinciden las claves',
				},
			},
			submitHandler: function(form) {
				$.post('app/usuarios/prc/_usuarios.update.php',$(formulario).serialize(),function(data){
					if(data==1) {
						load('app/usuarios/vst/usuarios.lista.php','','usuarios-lista');
						cerrarmodal()
					} else {
						alerta('msj','danger',data)
					}
				})
			}
		});
	})
</script>