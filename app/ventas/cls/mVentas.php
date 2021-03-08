 <?php

class mVentas {

	protected $bdh, $con, $msj;

	public function __clone() {

	}

	public function __construct() {
		$this->dbh = new Conexion();
		$this->msj = array();
		$this->con = $this->dbh->conectar();
		if(isset($_POST)) {
			foreach($_POST as $i=>$r) {
				$this->$i = $r;
			}
		}
	}

	public function insertArticulo() {
		$sql = "SELECT insertarticulo(?, ?, ?) AS response";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$this->producto);
		$res->bindParam(2,$this->cantidad);
		$res->bindParam(3,$this->clieide);
		if ($res->execute()==1) {
			$row = $res->fetchAll(PDO::FETCH_OBJ);
			$rt = $row[0]->response;
		} else {
			$rt = print_r($res->errorInfo());
		}
		return $rt;
	}

	public function getVentas($clieide) {
		$sql = "SELECT * FROM vw_ventas WHERE factide=0 and clieide=?";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$clieide);
		$res->execute();
		return $res->fetchAll(PDO::FETCH_OBJ);
	}

	public function getVentasFact($fact) {
		$sql = "SELECT * FROM vw_ventas WHERE factide=?";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$fact);
		$res->execute();
		return $res->fetchAll(PDO::FETCH_OBJ);
	}

	public function totalPagar($cliente, $factura) {
		$sql = "SELECT totalpagar(?, ?) as total";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$cliente);
		$res->bindParam(2,$factura);
		$res->execute();
		$row = $res->fetchAll(PDO::FETCH_OBJ);
		return $row[0]->total;
	}

	public function ventaDelete() {
		$sql = "CALL deleteventa(?)";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$this->ventide);
		return $res->execute();
	}

	public function facturar($clieide) {
		$total = $this->totalPagar($clieide,0);
		$sub = $total-($total*0.12);
		$iva = $total*0.12;
		$sql = "INSERT INTO factura (clieide, facttotal, factsubtot, factiva, factfecha, usuaide) values (?, ?, ?, ?, now(), ?)";
		$res = $this->con->prepare($sql);
		$res->bindParam(1,$clieide);
		$res->bindParam(2,$total);
		$res->bindParam(3,$sub);
		$res->bindParam(4,$iva);
		$res->bindParam(5,$_SESSION['usuaide']);
		$res->execute();

		$last = $this->con->lastInsertId();
		$todo = $this->getVentas($this->clieide);

		$sql = "UPDATE ventas set factide=? where ventide=?";
		$res = $this->con->prepare($sql);
		foreach($todo as $t) {
			$res->bindParam(1,$last);
			$res->bindParam(2,$t->ventide);
			$res->execute();
		}
		return $last;
	}

}