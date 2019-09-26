<?php
    require_once 'settings.php';
    require_once 'functions.php';
    require_once '/usr/src/Aid.php';

    function getCalls($link,  $Aid)
    {
        $result = c_mysqli_call($link, 'imu_GetCall', '');

        if(count($result)>0)
        {
            $url = 'https://localhost:3002/originate';
            foreach ($result as $call)
            {
                $ch = curl_init($url);
                $data = [
                    'Aid' => $Aid,
                    'phone' => $call['dst'],
                    'exten' => $call['src']];
                $payload = json_encode($data);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                curl_setopt($ch, CURLOPT_POST, 1); // set POST method
                curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type:application/json']);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                $itog = curl_exec($ch);
                curl_close($ch);
                mysqli_query($link, 'DELETE FROM meduchet.fifo WHERE id='.$call['id'].';') or die("Query fail: " . mysqli_error($link));
            }
        }

        return true;
    }

    while (1<2)
    {
        getCalls($mysql_link, $Aid);
        sleep(2);
    }

    mysqli_next_result($mysql_link);
    quit();
?>