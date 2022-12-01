#!/usr/bin/env bash

# Save current screen
tput smcup

if ! command -v nmap &> /dev/null; then
    echo "[$(date)] WARN - Tool 'nmap' is not installed. Abort."
    # Restore the screen before exiting
    tput rmcup
    exit 0
fi

if [[ -z "$SUBNETS" ]]; then
    echo "[$(date)] WARN - No subnets to validate. Abort."
    tput rmcup
    exit 0
fi

if [[ -z "$ADDRESS_SPACE" ]]; then
    echo "[$(date)] WARN - No VPC CIDR to validate against. Abort."
    tput rmcup
    exit 0
fi

echo "[$(date)] INFO - Validating IF subnets SUBNETS fit within VPC CIDR $ADDRESS_SPACE. BEGIN."

for subnet in $SUBNETS; do
    subnetUsable=$(nmap -n -sL $subnet | awk '/Nmap scan report/{print $NF}')
    addressSpaceUsable=$(nmap -n -sL $ADDRESS_SPACE | awk '/Nmap scan report/{print $NF}')

    if [[ "$addressSpaceUsable" != *"$subnetUsable"* ]]; then
        echo "[$(date)] ERROR - SUBNET $subnet does NOT FIT within VPC CIDR $ADDRESS_SPACE. Fail."
        tput rmcup  # Restore the screen on error
        exit 1
    else
        echo "[$(date)] INFO - SUBNET $subnet FITS within VPC CIDR $ADDRESS_SPACE. OK."
    fi
done

echo "[$(date)] INFO - Validating IF subnets SUBNETS fit within VPC CIDR $ADDRESS_SPACE. END."

# Restore the screen after successful execution
tput rmcup