#!/usr/bin/tcsh

# Script to transfer data between your local machine and lovelace.
# Usage: tcsh cp_coaraci.tcsh send|get -f|-d <file_or_directory_name>

set user_name = 'felipecr'

ssh $user_name@gate.ifi.unicamp.br -NL 50022:coaraci.ifi.unicamp.br:22 &
set TUNNEL_PID = $!
echo "SSH tunnel started with PID $TUNNEL_PID"

sleep 5

set job = ""
set type = ""
set name = ""

# Parse command-line arguments
foreach arg ($argv)
    switch ($arg)
        case "send":
            set job = "send"
            breaksw
        case "get":
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
    echo "Usage: tcsh cp_coaraci.tcsh -send|-get -f|-d <file_or_directory_name>"
    # exit 1
endif

set DIR = "/home/users/$user_name/Troca"

echo "User: $user_name"
echo "Job: $job"
echo "Type: $type"
echo "To be copied: $name"
echo "Path on coaraci: $DIR"

switch ("$type")
    case "file":
        switch ("$job")
            case "send":
                echo "Copying file to coaraci..."
                scp -P 50022 $name $user_name@localhost:$DIR
                breaksw
            case "get":
                echo "Copying file from coaraci..."
                scp -P 50022 $user_name@localhost:$DIR/$name .
                breaksw
            default:
                echo "Error: 'Job' must be '-send' or '-get'."
		# exit 1
        endsw
        breaksw

    case "dir":
        switch ("$job")
            case "send":
                echo "Copying directory to coaraci..."
                scp -rP 50022 $name $user_name@localhost:$DIR
                breaksw
            case "get":
                echo "Copying directory from coaraci..."
                scp -rP 50022 $user_name@localhost:$DIR/$name .
                breaksw
            default:
                echo "Error: 'Job' must be '-send' or '-get'."
		# exit 1
        endsw
        breaksw

    default:
        echo "Error: 'Type' must be '-f' (file) or '-d' (directory)."
	# exit 1
endsw

kill $TUNNEL_PID
echo "SSH tunnel closed."

exit 0
