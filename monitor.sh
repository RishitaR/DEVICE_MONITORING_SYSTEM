#!/bin/bash

# Function to monitor CPU usage
monitor_cpu() {
    while true; do
        echo "CPU Usage:"
        cat /proc/stat | grep '^cpu ' | awk '{print "   User: "($2+$4)*100/($2+$4+$5)"%   System: "($4)*100/($2+$4+$5)"%   Idle: "($5)*100/($2+$4+$5)"%"}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to monitor memory usage
monitor_memory() {
    while true; do
        echo "Memory Usage:"
        cat /proc/meminfo | grep -E '^MemTotal|^MemFree|^Buffers|^Cached' | awk '{print "   "$1": "$2}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to monitor disk usage
monitor_disk() {
    while true; do
        echo "Disk Usage:"
        df -h | grep -E '^Filesystem|^/dev/' | awk '{print "   "$1": "$5" used"}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to monitor network interfaces status
#monitor_network_interfaces() {
#   while true; do
#        echo "Network Interfaces Status:"
#        ip -a | grep -E '^[a-z]' | awk '{print "   "$1": "$2}'
#        sleep 2  # Adjust the sleep interval as needed
#    done
#}

# Function to monitor network interfaces status
monitor_network_interfaces() {
    while true; do
        echo "Network Interfaces Status:"
        ip -o link show | awk '{print "   "$2": "$3}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to monitor network traffic
monitor_network_traffic() {
    while true; do
        echo "Network Traffic:"
        cat /proc/net/dev | grep -E '^[a-z]' | awk '{print "   Interface: "$1"   Bytes In: "$2"   Bytes Out: "$10}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to list running processes
list_processes() {
    while true; do
        echo "Running Processes:"
        ps aux | awk 'NR>1 {print "   "$1" "$2" "$3" "$4" "$11}'
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Function to display system information
system_information() {
    while true; do
        echo "System Information:"
        echo "   Hostname: $(hostname)"
        echo "   OS Version: $(uname -a)"
        sleep 2  # Adjust the sleep interval as needed
    done
}

# Main menu function
main_menu() {
    while true; do
        echo "Bash System Monitor"
        echo "-------------------"
        echo "1. Monitor CPU"
        echo "2. Monitor Memory"
        echo "3. Monitor Disk"
        echo "4. Monitor Network Interfaces"
        echo "5. Monitor Network Traffic"
        echo "6. List Running Processes"
        echo "7. System Information"
        echo "8. Exit"
        echo "-------------------"
        echo -n "Enter your choice: "
        read choice
        case $choice in
            1) monitor_cpu ;;
            2) monitor_memory ;;
            3) monitor_disk ;;
            4) monitor_network_interfaces ;;
            5) monitor_network_traffic ;;
            6) list_processes ;;
            7) system_information ;;
            8) exit ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Call the main menu function
main_menu
