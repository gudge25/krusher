<?php
/**
 * 发送post请求
 * @param string $url 请求地址
 * @param array $post_data post键值对数据
 * @return string
 */

function send_post_curl($url, $post_data)
{
    $data_string = json_encode($post_data);
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Content-Length: ' . strlen($data_string)]);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 1800);
    $result = curl_exec($ch);
    file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' :: '.print_r($ch, true)."\r\n", FILE_APPEND);
    file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' :: '.print_r($result, true)."\r\n", FILE_APPEND);
    // Close cURL session handle
    curl_close($ch);
}

function send_post($url, $post_data) {
    $postdata = http_build_query($post_data);
    $options = [
        'http' => [
            'method' => 'POST',
            'header' => 'Content-type:application/json',
            'content' => $postdata,
            'timeout' => 15 * 60 // 超时时间（单位:s）
        ],
        "ssl" => [
            "verify_peer" => false,
            "verify_peer_name" => false,
        ],
    ];
    $context = stream_context_create($options);
    file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' : '.print_r($url, true)."\r\n", FILE_APPEND);
    try {
        $result = file_get_contents($url, false, $context);
        file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' : '.print_r($result, true)."\r\n", FILE_APPEND);
    }
    catch (Exception $e) {
        //echo $e->getMessage();
        file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' : '.print_r($e->getMessage(), true)."\r\n", FILE_APPEND);
    }
    return $result;
}
file_put_contents('/tmp/sms_send.log', date("Y-m-d H:i:s").' : '.print_r($argv, true)."\r\n", FILE_APPEND);

$post_data = [
    'name' => $argv[2],
    'number' => $argv[3],
    'content' => $argv[4]
];
//send_post('http://192.168.2.1/goip/post.php', $post_data);
//send_post($argv[1], $post_data);
send_post_curl($argv[1], $post_data);
?>