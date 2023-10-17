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

# Stop Kafka Cluster
kill_port_forward 9093

# Stop APIs
kill_port_forward 8080
kill_port_forward 8081
kill_port_forward 8050

# Stop Databases
kill_port_forward 27017
kill_port_forward 27018

# Stop Jobs
kill_port_forward 5050
kill_port_forward 5051
kill_port_forward 5052
kill_port_forward 5053
kill_port_forward 8051

echo "All port-forwarding jobs have been stopped."
