<?php

    function globalConfig($ARG1, $ARG2)
    {
        $file       = $ARG1."extensions/global.ael";
        shell_exec("rm -f $file");
        $out_data = $in_data = array();
        if(file_exists($file))
            $in_data = file($file);
        else
            $in_data = '';
        file_put_contents($file,' globals {'."\n", FILE_APPEND);
        if((int)getenv('NODE_PORT') == 80)
        {
            //file_put_contents($file,'       ApiGetClient            =https://localhost:443/api/cc/contacts/sip/;'."\n", FILE_APPEND);
            //file_put_contents($file,'       ApiSetDial              =https://localhost:443/api/crm/clients/ex/setdial/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPostContact          =--user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -H "Content-Type: application/json" -k https://localhost:443/api/cc/contacts;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPostdeals            =-H "Content-Type: application/json" -X POST -k https://localhost:443/api/sl/deals/create;'."\n", FILE_APPEND);
            //file_put_contents($file,'       ApiCheckClient          =https://localhost:443/api/crm/clients/check/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPin                  =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:443/api/cc/contacts/callerID/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiSequence             =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:443/api/us/sequence/next/dcID;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiFindClient           =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:443/api/crm/clients/find/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiRecordForce          =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X POST --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:443/api/ast/records/force;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiOriginate            =curl -k -X POST --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:91/originate;'."\n", FILE_APPEND);
        }
        else
        {
            //file_put_contents($file,'       ApiGetClient            =https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/cc/contacts/sip/;'."\n", FILE_APPEND);
            //file_put_contents($file,'       ApiSetDial              =https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/crm/clients/ex/setdial/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPostContact          =--user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -H "Content-Type: application/json" -k https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/cc/contacts;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPostdeals            =-H "Content-Type: application/json" -X POST -k https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/sl/deals/create;'."\n", FILE_APPEND);
            //file_put_contents($file,'       ApiCheckClient          =https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/crm/clients/check/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiPin                  =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/cc/contacts/callerID/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiSequence             =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/us/sequence/next/dcID;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiFindClient           =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/crm/clients/find/;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiRecordForce          =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X POST --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:'.((int)getenv('NODE_PORT')+10).'/api/ast/records/force;'."\n", FILE_APPEND);
            file_put_contents($file,'       ApiOriginate            =curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X POST --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:'.((int)getenv('NODE_PORT')+11).'/originate;'."\n", FILE_APPEND);
        }
        file_put_contents($file,'};'."\n\n", FILE_APPEND);
        echo 'global: created "'.$file .'"'."\n";
        if(file_exists($file))
            $out_data = file($file);
        else
            $out_data = '';
        return checkFile($ARG2."asterisk -rx 'ael reload'", $in_data, $out_data);
    }

?>
