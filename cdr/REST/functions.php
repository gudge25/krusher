<?php
function jdecoder($json_str) {
  $cyr_chars = array (
    '\u0430' => 'а', '\u0410' => 'А',
    '\u0431' => 'б', '\u0411' => 'Б',
    '\u0432' => 'в', '\u0412' => 'В',
    '\u0433' => 'г', '\u0413' => 'Г',
    '\u0434' => 'д', '\u0414' => 'Д',
    '\u0435' => 'е', '\u0415' => 'Е',
    '\u0451' => 'ё', '\u0401' => 'Ё',
    '\u0436' => 'ж', '\u0416' => 'Ж',
    '\u0437' => 'з', '\u0417' => 'З',
    '\u0438' => 'и', '\u0418' => 'И',
    '\u0439' => 'й', '\u0419' => 'Й',
    '\u043a' => 'к', '\u041a' => 'К',
    '\u043b' => 'л', '\u041b' => 'Л',
    '\u043c' => 'м', '\u041c' => 'М',
    '\u043d' => 'н', '\u041d' => 'Н',
    '\u043e' => 'о', '\u041e' => 'О',
    '\u043f' => 'п', '\u041f' => 'П',
    '\u0440' => 'р', '\u0420' => 'Р',
    '\u0441' => 'с', '\u0421' => 'С',
    '\u0442' => 'т', '\u0422' => 'Т',
    '\u0443' => 'у', '\u0423' => 'У',
    '\u0444' => 'ф', '\u0424' => 'Ф',
    '\u0445' => 'х', '\u0425' => 'Х',
    '\u0446' => 'ц', '\u0426' => 'Ц',
    '\u0447' => 'ч', '\u0427' => 'Ч',
    '\u0448' => 'ш', '\u0428' => 'Ш',
    '\u0449' => 'щ', '\u0429' => 'Щ',
    '\u044a' => 'ъ', '\u042a' => 'Ъ',
    '\u044b' => 'ы', '\u042b' => 'Ы',
    '\u044c' => 'ь', '\u042c' => 'Ь',
    '\u044d' => 'э', '\u042d' => 'Э',
    '\u044e' => 'ю', '\u042e' => 'Ю',
    '\u044f' => 'я', '\u042f' => 'Я',
    '\r' => '',
    '\n' => '<br />',
    '\t' => ''
  );
 
  foreach ($cyr_chars as $key => $value) {
    $json_str = str_replace($key, $value, $json_str);
  }
  return $json_str;
}

function cors() {
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }

    // Access-Control headers are received during OPTIONS requests
    if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

        exit(0);
    }
}


function RestGet($link, $Arg, $Query){
	if(isset($_GET[$Arg]))
	{
		$result = mysqli_query($link, $Query);
		$rows = array();
		while($r = mysqli_fetch_assoc($result)) {
		    $rows[] = $r; 
		}
		print jdecoder(json_encode($rows));
		exit(0);
	}
}

function RestPOST($Arg, $query){
	$inputJSON = file_get_contents('php://input');
	$input= json_decode($inputJSON, TRUE ); //convert JSON into array
	print_r($inputJSON);
	//print_r(json_encode($input));
	exit;
} 
?>
