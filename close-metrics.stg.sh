#!/bin/bash

# Function to kill port-forwarding processes
kill_port_forward() {
    local port=$1

    # Identify PIDs of processes that are port-forwarding the specified port
    local pids=$(lsof -ti tcp:$port)

    # Kill the processes if they exist
    if [ -n "$pids" ]; then
        echo "Stopping port-forwarding on port $port..."
        kill -9 $pids
    fi
}

kill_port_forward 9090
kill_port_forward 3000

echo "All port-forwarding metrics have been stopped."