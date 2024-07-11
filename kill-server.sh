#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Usage function to display help
usage() {
  echo -e "${CYAN}Usage: kill-server [-f] [-a] <port>${NC}"
  echo -e "${CYAN}  -f  Forcefully kill the process without confirmation${NC}"
  echo -e "${CYAN}  -a  Kill all processes running on the specified port with single confirmation${NC}"
  echo -e "${CYAN}  -h  Show this help message${NC}"
  exit 1
}

FORCE=false
KILL_ALL=false

# Parse command line options
while getopts ":fah" option; do
  case $option in
    f)
      FORCE=true
      ;;
    a)
      KILL_ALL=true
      ;;
    h)
      usage
      ;;
    *)
      echo -e "${RED}Invalid option: -${OPTARG}${NC}"
      usage
      ;;
  esac
done

shift $((OPTIND - 1))

# Check if port number is provided
if [ -z "$1" ]; then
  echo -e "${RED}No port specified.${NC}"
  usage
fi

PORT=$1

# Ensure the port number is valid
if ! [[ $PORT =~ ^[0-9]+$ ]]; then
  echo -e "${RED}Invalid port: $PORT${NC}"
  usage
fi

# Check if the script is running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  PIDS=$(lsof -t -i tcp:$PORT)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  PIDS=$(lsof -t -i :$PORT)
else
  echo -e "${RED}Unsupported OS type: $OSTYPE${NC}"
  exit 1
fi

# Function to kill a process
kill_process() {
  local PID=$1
  local PROCESS_DETAILS=$2
  kill -9 $PID
  if [ "$FORCE" = true ]; then
    echo -e "${RED}Forcefully killed process $PID on port $PORT.${NC}"
  else
    echo -e "${RED}Killed process $PID on port $PORT.${NC}"
  fi
}

# Check if any process is running on the specified port
if [ -n "$PIDS" ]; then
  echo -e "${GREEN}Processes running on port $PORT:${NC}"
  for PID in $PIDS; do
    PROCESS_DETAILS=$(ps -p $PID -o comm=)
    echo -e "${YELLOW}  - Process $PID ($PROCESS_DETAILS)${NC}"
  done

  if [ "$KILL_ALL" = true ]; then
    if [ "$FORCE" = true ]; then
      for PID in $PIDS; do
        PROCESS_DETAILS=$(ps -p $PID -o comm=)
        kill_process $PID $PROCESS_DETAILS
      done
    else
      read -p "Are you sure you want to kill all these processes running on port $PORT? (y/n): " CONFIRM_ALL
      if [[ $CONFIRM_ALL == [yY] ]]; then
        for PID in $PIDS; do
          PROCESS_DETAILS=$(ps -p $PID -o comm=)
          kill_process $PID $PROCESS_DETAILS
        done
      else
        echo -e "${YELLOW}No processes killed on port $PORT.${NC}"
      fi
    fi
  else
    for PID in $PIDS; do
      PROCESS_DETAILS=$(ps -p $PID -o comm=)
      if [ "$FORCE" = true ]; then
        kill_process $PID $PROCESS_DETAILS
      else
        read -p "Are you sure you want to kill process $PID on port $PORT? (y/n): " CONFIRM
        if [[ $CONFIRM == [yY] ]]; then
          kill_process $PID $PROCESS_DETAILS
          break
        else
          echo -e "${YELLOW}Process $PID on port $PORT not killed.${NC}"
        fi
      fi
    done
  fi
else
  echo -e "${RED}No process found on port $PORT.${NC}"
fi
