#!/usr/bin/tcsh

# Script to transfer data between your local machine and lovelace.
# Usage: tcsh cp_lovelace_switch.tcsh -send|-get -f|-d <file_or_directory_name>

set user_name = 'felipecr'
set job = ""
set type = ""
set name = ""

# Parse command-line arguments
foreach arg ($argv)
    switch ($arg)
        case "-send":
            set job = "send"
            breaksw
        case "-get":
            set job = "get"
            breaksw
        case "-f":
            set type = "file"
            breaksw
        case "-d":
            set type = "dir"
            breaksw
        default:
            set name = "$arg"
            breaksw
    endsw
end

# Validate arguments
if ("$job" == "" || "$type" == "" || "$name" == "") then
    echo "Usage: tcsh cp_lovelace_switch.tcsh -send|-get -f|-d <file_or_directory_name>"
    exit 1
endif

set DIR = "~/homelovelace/Troca"

echo "User: $user_name"
echo "Job: $job"
echo "Type: $type"
echo "To be copied: $name"
echo "Path on Lovelace: $DIR"

switch ("$type")
    case "file":
        switch ("$job")
            case "send":
                echo "Copying file to Lovelace..."
                scp -P 31459 $name $user_name@cenapad.unicamp.br:$DIR
                breaksw
            case "get":
                echo "Copying file from Lovelace..."
                scp -P 31459 $user_name@cenapad.unicamp.br:$DIR/$name .
                breaksw
            default:
                echo "Error: 'Job' must be '-send' or '-get'."
                exit 1
        endsw
        breaksw

    case "dir":
        switch ("$job")
            case "send":
                echo "Copying directory to Lovelace..."
                scp -rP 31459 $name $user_name@cenapad.unicamp.br:$DIR
                breaksw
            case "get":
                echo "Copying directory from Lovelace..."
                scp -rP 31459 $user_name@cenapad.unicamp.br:$DIR/$name .
                breaksw
            default:
                echo "Error: 'Job' must be '-send' or '-get'."
                exit 1
        endsw
        breaksw

    default:
        echo "Error: 'Type' must be '-f' (file) or '-d' (directory)."
        exit 1
endsw

exit 0

