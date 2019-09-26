<?php

    function c_mysqli_call(mysqli $dbLink, $procName, $params="")
    {
        if(!$dbLink) {
            throw new Exception("The MySQLi connection is invalid.");
        }
        else
        {
            // Execute the SQL command.
            // The multy_query method is used here to get the buffered results,
            // so they can be freeded later to avoid the out of sync error.
            $sql = "CALL {$procName}({$params});";
            //echo $sql."\r\n";
            $sqlSuccess = $dbLink->multi_query($sql);

            if($sqlSuccess)
            {
                if($dbLink->more_results())
                {
                    // Get the first buffered result set, the one with our data.
                    $result = $dbLink->use_result();
                    $output = array();

                    // Put the rows into the outpu array
                    while($row = $result->fetch_assoc())
                    {
                        $output[] = $row;
                    }

                    // Free the first result set.
                    // If you forget this one, you will get the "out of sync" error.
                    $result->free();

                    // Go through each remaining buffered result and free them as well.
                    // This removes all extra result sets returned, clearing the way
                    // for the next SQL command.
                    while($dbLink->more_results() && $dbLink->next_result())
                    {
                        $extraResult = $dbLink->use_result();
                        if($extraResult instanceof mysqli_result){
                            $extraResult->free();
                        }
                    }

                    return $output;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                throw new Exception("The call failed: " . $dbLink->error);
            }
        }
    }

?>