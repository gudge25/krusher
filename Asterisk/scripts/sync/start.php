<?php
    // --- Include ---
    require_once 'settings.php';
    // --- Include function---
    require_once 'functions.php';
    require_once 'sip.php';
    require_once 'trunk.php';
    require_once 'trunk_ael.php';
    require_once 'queue.php';
    require_once 'routein.php';
    require_once 'queue_ael.php';
    require_once 'sip_ael.php';
    require_once 'sip_hint_ael.php';
    require_once 'fop2_sync.php';
    require_once 'ivr_sync.php';
    require_once 'record_ael.php';
    require_once 'base.php';
    require_once 'routeout.php';
    require_once 'global_ael.php';
    require_once 'time_ael.php';
    require_once 'callback.php';
    require_once 'conference_ael.php';

    if (checkScript('start.php') == false)
    {
        $isChange = false;
        //-------------STARTING---------------------------
        sleep(15);
        $changes = [];
        $changes[] = sipdb($folder,         $run, $mysql_link);     //  update sip.conf
        $changes[] = sip_ael($folder,	    $run, $mysql_link);     //  update employees in dialplan
        $changes[] = trunkdb($folder,	    $run, $mysql_link);     //  update trunk
        $changes[] = trunk_ael($folder,     $run, $mysql_link);     //  update trunk
        $changes[] = queuedb($folder,	    $run, $mysql_link);     //  update Queue
        $changes[] = queue_ael($folder,     $run, $mysql_link);     //  update Queue route in ael
        $changes[] = sip_hint_ael($folder,  $run, $mysql_link);     //  Hints
        $changes[] = ivr_sync($folder,	    $run, $mysql_link);     //  IVR_sync
        $changes[] = routein($folder,	    $run, $mysql_link);     //  update incoming route in ael
        $changes[] = routeout($folder,	    $run, $mysql_link);     //  update outgoing route in ael
        $changes[] = basedb($folder,        $run, $mysql_link);     //  update base in ael
        $changes[] = time_ael($folder,	    $run, $mysql_link);     //  update time route in ael
        $changes[] = callback($folder,	    $run, $mysql_link);     //  update callback in ael
        $changes[] = fop2_sync($fop2folder, $run, $mysql_link);     //  Fop2 sync
        $changes[] = globalConfig($folder,  $run);                  //  Global vars
        $changes[] = conference_ael($folder,$run, $mysql_link);     //  update Conference route in ael
        $changes[] = record_ael($folder,    $run, $mysql_link);     //  update records
        $changes = array_unique($changes);

        print_r($changes);
        foreach ($changes as $command)
            if($command != 'no changes')
            {
                exec($command . " > /dev/null &");
                $isChange = true;
            }
        exec("service fop2 reload  > /dev/null &");
        if($isChange)
        {
            sleep(10);
            exec("asterisk -rx 'core reload all' > /dev/null &");
        }

        mysqli_next_result($mysql_link);
        quit();
    }
    else
    {
        $isChange = false;
        //-------------STARTING---------------------------
        $changes = array();
        $changes[] = sipdb($folder,         $run, $mysql_link);     //  update sip.conf
        $changes[] = sip_ael($folder,	    $run, $mysql_link);     //  update employees in dialplan
        $changes[] = trunkdb($folder,	    $run, $mysql_link);     //  update trunk
        $changes[] = trunk_ael($folder,     $run, $mysql_link);     //  update trunk
        $changes[] = queuedb($folder,	    $run, $mysql_link);     //  update Queue
        $changes[] = queue_ael($folder,     $run, $mysql_link);     //  update Queue route in ael
        $changes[] = sip_hint_ael($folder,  $run, $mysql_link);     //  Hints
        $changes[] = ivr_sync($folder,	    $run, $mysql_link);     //  IVR_sync
        $changes[] = routein($folder,	    $run, $mysql_link);     //  update incoming route in ael
        $changes[] = routeout($folder,	    $run, $mysql_link);     //  update outgoing route in ael
        $changes[] = basedb($folder,        $run, $mysql_link);     //  update base in ael
        $changes[] = time_ael($folder,	    $run, $mysql_link);     //  update time route in ael
        $changes[] = callback($folder,	    $run, $mysql_link);     //  update callback in ael
        $changes[] = fop2_sync($fop2folder, $run, $mysql_link);     //  Fop2 sync
        $changes[] = globalConfig($folder,  $run);                  //  Global vars
        $changes[] = conference_ael($folder,$run, $mysql_link);     //  update Conference route in ael
        $changes[] = record_ael($folder,    $run, $mysql_link);     //  update records

        $changes = array_unique($changes);

        print_r($changes);
        foreach ($changes as $command)
            if($command != 'no changes')
            {
                exec($command . " > /dev/null &");
                $isChange = true;
            }
        exec("service fop2 reload  > /dev/null &");
        if($isChange)
        {
            sleep(10);
            exec("asterisk -rx 'core reload all' > /dev/null &");
        }

        mysqli_next_result($mysql_link);
        quit();
    }

?>
