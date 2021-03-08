 <?php require '../../../cfg/base.php'; ?>
<form class="form-horizontal insert">
	<?php echo $fn->modalHeader('Agregar Usuario') ?>
<?php

$clave=md5("clave");

?>
	<div class="modal-body"style="padding-left: 160px;">
	<div class="msj"></div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Nacionalidad:
			</label>
			<div class="col-sm-9">
				<select name="nacion" class="form-control">
					<option value="PE">Perú</option>
					<option value="CO">Colombia</option>
					<option value="Cl">Chile</option>
					<option value="BR">Brasil</option>
					<option value="AR">Argentina</option>
					<option value="BO">Bolivia</option>
					<option value="UR">Uruguay</option>
					<option value="PA">Paraguay</option>
					<option value="EC">Ecuador</option>
					<option value="VE">Venezuela</option>
					<option value="E">Otro</option>
				</select>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				DNI:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="cedula"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Nombres:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="nombre"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Email:
			</label>
			<div class="col-sm-9">
				<input type="email" class="form-control" name="apelli"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Usuario:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="usuari"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Contraseña:
			</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" name="clave" id="clave"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Confirmar:
			</label>
			<div class="col-sm-9">
				<input type="password" class="form-control" name="clave2"></input>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<?php echo $fn->modalFooter(); ?>
</form>

<script>
	$(function(){
		var formulario = '.insert'
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
				$.post('app/usuarios/prc/_usuarios.insert.php',$(formulario).serialize(),function(data){
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