<?php

error_reporting(0);

function login(){
	$dominio = 'Area restringida';
// usuario => contraseña
$usuarios = array('admin' => 'admin', 'usuario' => 'usuario');
if (empty($_SERVER['PHP_AUTH_DIGEST'])) {
    header('HTTP/1.1 401 Unauthorized');
    header('WWW-Authenticate: Digest realm="'.$dominio.
           '",qop="auth",nonce="'.uniqid().'",opaque="'.md5($dominio).'"');
}
// Analizar la variable PHP_AUTH_DIGEST
if (!($datos = analizar_http_digest($_SERVER['PHP_AUTH_DIGEST'])) ||
    !isset($usuarios[$datos['username']]))
    die('Credenciales incorrectas');
// Generar una respuesta válida
$A1 = md5($datos['username'] . ':' . $dominio . ':' . $usuarios[$datos['username']]);
$A2 = md5($_SERVER['REQUEST_METHOD'].':'.$datos['uri']);
$respuesta_válida = md5($A1.':'.$datos['nonce'].':'.$datos['nc'].':'.$datos['cnonce'].':'.$datos['qop'].':'.$A2);
if ($datos['response'] != $respuesta_válida){
	   return false;
}
else{
	return true;
}
};

function analizar_http_digest($txt){
    // Protección contra datos ausentes
    $partes_necesarias = array('nonce'=>1, 'nc'=>1, 'cnonce'=>1, 'qop'=>1, 'username'=>1, 'uri'=>1, 'response'=>1);
    $datos = array();
    $claves = implode('|', array_keys($partes_necesarias));
    preg_match_all('@(' . $claves . ')=(?:([\'"])([^\2]+?)\2|([^\s,]+))@', $txt, $coincidencias, PREG_SET_ORDER);
    foreach ($coincidencias as $c) {
        $datos[$c[1]] = $c[3] ? $c[3] : $c[4];
        unset($partes_necesarias[$c[1]]);
    }
    return $partes_necesarias ? false : $datos;
}

function conectarbd($host, $usuario, $passwd,$bd){
	$conexion = mysqli_connect($host, $usuario, $passwd,$bd);
	return $conexion;
}

function traducirdia($dia){
	switch($dia){
		case "Mon":
		$dia="Lunes";
		break;
		case "Tues":
		$dia="Martes";
		break;
		case "Wed":
		$dia="Mi&ecuate;rcoles";
		break;
		case "Thu":
		$dia="Jueves";
		break;
		case "Fri":
		$dia="Viernes";
		break;
		case "Sat":
		$dia="Sábado";
		break;
		case "Sun":
		$dia="Domingo";
		break;
	}
	return $dia;
}

function traducirhora($hora){

	switch($hora){
		case 1:
		$hora="8:15 - 9:15";
		break;
		
		case 2:
		$hora="9:15 - 10:15";
		break;
		
		case 3:
		$hora="10:15 - 11:15";
		break;
		
		case 4:
		$hora="11:45 - 12:45";
		break;
		
		case 5:
		$hora="12:45 - 13:45";
		break;
		
		case 6:
		$hora="13:45 - 14:45";
		break;
	}	
	return $hora;
}

function saber_hora($hora,$minutos){
	$hora_actual=0;
	if($hora==8 && $minutos>=15 || $hora==9 && $minutos<15){
		$hora_actual=1;
	}
	
	if($hora==9 && $minutos>=15 || $hora==10 && $minutos<15){
		$hora_actual=2;
	}
	
	if($hora==10 && $minutos>=15 || $hora==11 && $minutos<15){
		$hora_actual=3;
	}
	
	if($hora==11 && $minutos>=45 || $hora==12 && $minutos<45){
		$hora_actual=4;
	}
	
	if($hora==12 && $minutos>=45 || $hora==13 && $minutos<45){
		$hora_actual=5;
	}
	
	if($hora==13 && $minutos>=45 || $hora==14 && $minutos<45){
		$hora_actual=6;
	}
	return $hora_actual;
}

function verconsulta($conexion,$consulta,$label=""){
	if($label==""){$label="Nombre Profesor";}
		mysqli_set_charset($conexion, "utf8");
		$respuesta = mysqli_query($conexion,$consulta) or die("No se pudo ejecutar la consulta: ".mysqli_error());
		if(mysqli_affected_rows($conexion)>0){
		print '<br/><br/><table style="width:80%;" id="customers">
		<tr>
			<th>'.$label.'</th>
			<th>Dia</th>
		<th>Hora</th>
		</tr>
		';
		
		while ($fila = mysqli_fetch_array($respuesta, MYSQL_NUM)) {
			$fila[1]=traducirdia($fila[1]);
			$fila[2]=traducirhora($fila[2]);
		$ascii=ord($fila[0][0]);
			if($ascii>=48 && $ascii<=57){
				$enlace="";
			}
			else{
				$enlace='<a href="index.php?profesor='.$fila[0].'"/>';
			}
			print '<tr><td>'.$enlace.$fila[0].'</td>';
			print '<td>'.$fila[1].'</td>';
			print '<td>'.$fila[2].'</td>';
			print '</tr>';
		}
		
		print '</table>';
}
}
?>