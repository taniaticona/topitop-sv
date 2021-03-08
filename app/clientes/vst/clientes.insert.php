 <?php
require '../../../cfg/base.php';
?>
<form class="form-horizontal insert">
	<?php echo $fn->modalHeader('Agregar Cliente') ?>
	<div class="modal-body" style="padding-left: 160px;">
	<div class="msj"></div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Nacionalidad:
			</label>
			<div class="col-sm-9">
				<select name="nacion" class="form-control">
					<option value="AR">Argentina</option>
					<option value="CO">Colombia</option>
					<option value="Cl">Chile</option>
					<option value="BR">Brasil</option>
					<option value="PE">Perú</option>
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
				<input class="form-control" name="razsoc"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Dirección:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="direcc"></input>
			</div>
		</div>
		<div class="form-group col-sm-12">
			<label class="control-label col-sm-3 bolder">
				Teléfono:
			</label>
			<div class="col-sm-9">
				<input class="form-control" name="telefo"></input>
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
				razsoc: {
					required: true,
				},
				telefo: {
					number: true
				},
			},
			 messages: {
				nacion: {
					required: 'Obligatorio',
				},
				cedula: {
					required: 'Obligatorio',
					number: 'Numérico',
				},
				razsoc: {
					required: 'Obligatorio',
				},
				telefo: {
					number: 'Numérico'
				},
			},
			submitHandler: function(form) {
				$.post('app/clientes/prc/_clientes.insert.php',$(formulario).serialize(),function(data){
					if(data==1) {
						load('app/clientes/vst/clientes.lista.php','','clientes-lista');
						cerrarmodal()
					} else {
						alerta('msj','danger',data)
					}
				})
			}
		});
	})
</script>