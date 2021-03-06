<?php
    function sip_ael($ARG1, $ARG2, $link)
    {
        $file       = $ARG1."extensions/db_sip.ael";
        $result = c_mysqli_call($link, 'ast_GetSippeersEmploy', '');

        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';

        $struct = array();
        foreach ($result as $info)
        {
            $struct[$info['Aid']]['info'][$info['sipName']] = $info;
            $struct[$info['Aid']]['Aid'] = $info['Aid'];
        }
        shell_exec("rm -f $file");
        if (count($struct) > 0)
        {
            file_put_contents($file,"\n", FILE_APPEND);
            file_put_contents($file,"/*   Do not edit this file, file update from MySQL   */\n", FILE_APPEND);
            file_put_contents($file,"\n", FILE_APPEND);
            //start context
            foreach ($struct as $context) {
                file_put_contents($file, 'context db_sip_' . $context['Aid'] . " { \n", FILE_APPEND);
                foreach ($context['info'] as $sip)
                    if (isset($sip['sipName']) && preg_match("/^[a-zA-Z0-9._-]+$/i", $sip['sipName']))
                    {
                        file_put_contents($file,'     '.$sip['sipName'].'      =>  { Dial(SIP/'.$sip['sipName'].'_'.$context['Aid'].',${dialtime},${options}); Hangup; }'."\n", FILE_APPEND);
                        file_put_contents($file,'     '.$sip['sipName'].'_'.$context['Aid'].'      =>  { Dial(SIP/'.$sip['sipName'].'_'.$context['Aid'].',${dialtime},${options}); Hangup; }'."\n", FILE_APPEND);
                    }
                file_put_contents($file,'   h => { if("${CallType}" != "101318") &postCallincard(); } '."\n", FILE_APPEND);
                file_put_contents($file,'   i => { disposition=FAILED; &postCallincard(); } '."\n", FILE_APPEND);
                file_put_contents($file,"}\n\n", FILE_APPEND);
            }
            echo 'sip_ael: created "'.$file .'"'."\n";
            if(file_exists($file))
                $out_data = file($file);
            else
                $out_data = '';
            return checkFile($ARG2."asterisk -rx 'ael reload'", $in_data, $out_data);
        }
        else
            return 'no changes';
    }
?>