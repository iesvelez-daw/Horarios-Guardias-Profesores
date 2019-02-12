<?php
date_default_timezone_set('Europe/Madrid');
include("cabecera.html");
include("funciones.php");

if (login()) {
	$conexion = conectarbd("qabe761.iesluisvelez.org", "qabe761", "599839RMgc", "qabe761");

	if (gettype($conexion) != "object") {

		print "<br/><br/><h1>Error al conectar a la base de datos</h1>";
	} else {
		$hora = date("H");
		$minutos = date("i");

		print '<div name="margen_2" style="width:100%;float:left;height:20%;">
		<br/>
			<select style="font-size:28px;" id="producto" onchange="ShowSelected();" >';
		$hora_actual = saber_hora($hora, $minutos);
		$horas = array();
		$horas[] = "8:15 - 9:15";
		$horas[] = "9:15 - 10:15";
		$horas[] = "10:15 - 11:15";
		$horas[] = "11:45 - 12:45";
		$horas[] = "12:45 - 13:45";
		$horas[] = "13:45 - 14:45";
		$y = 0;

		for ($x = 1; $x <= 6; $x++) {
			if ($x != $hora_actual) {
				print '<option value="' . $x . '">' . $horas[$y] . '</option>';
			} else {
				print '<option value="' . $hora_actual . '">Hora actual</option>';
			}
			$y++;
		}
		print '</select>';

		if (isset($_GET["profesor"]) && isset($_GET["profesor"]) . trim() != "") {

			$consulta = "SELECT periodo,dia,hora,grupo,materia,observaciones FROM HorariosProfesores WHERE idProfesor=(SELECT idProfesor FROM Profesores WHERE nombreProfesor='" . $_GET["profesor"] . "')";
			verconsulta($conexion, $consulta, $_GET["profesor"]);
		}

	}


	print '<script>function ShowSelected(){
		var combo = document.getElementById("producto");
		var selected = combo.options[combo.selectedIndex].value;';
	print "
		document.cookie ='selected='+selected;
		document.location.reload();
		}
		</script>";

	if ($_COOKIE["selected"] >= 1 && $_COOKIE["selected"] <= 6) {

		$consulta = 'SELECT nombreProfesor,diaSemana,hora FROM vAusencias where hora=' . $_COOKIE["selected"];

		verconsulta($conexion, $consulta);
	} else {

		$hora_actual = saber_hora($hora, $minutos);

		$consulta = 'SELECT nombreProfesor,diaSemana,hora FROM vAusencias where hora=' . $hora_actual;
		verconsulta($conexion, $consulta);

	}

	print '<br/><br/><hr/><br/>';

	if (isset($_GET['profesor'])) {
		print '	<a href="index.php">Inicio</a>';
	}

	print '<h1 style="font-size:35px;">Otras ausencias</h1>';

	for ($x = 1; $x <= 6; $x++) {
		if ($x != $hora_actual) {
			$consulta = 'SELECT nombreProfesor,diaSemana,hora FROM vAusencias where hora=' . $x;
			verconsulta($conexion, $consulta);
		}
	}
	print '<br/><br/>';
}
?>

</div>
	<script>setTimeout('document.location.reload()',10000);</script>
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.touch-punch.min.js"></script>
    <script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
    <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>
    <script type="text/javascript" src="js/jquery.selectbox-0.2.js"></script>
    <script type="text/javascript" src="js/id3-minimized.js"></script>
</body>
</html>