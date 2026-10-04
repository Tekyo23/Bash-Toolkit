#!/usr/bin/env bash

# Define log directory and file
LOG_DIR="${SCRIPT_DIR}/logs"
LOG_FILE="${LOG_DIR}/bashkit.log"

# Ensure directory exists
mkdir -p "$LOG_DIR"

# Generic logging function
_log() {
	local log_level="$1"
	shift

	local timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

	# Ensure that a log description was given
    	if [[ $# -lt 1 ]]; then
	        echo "ERROR: No log description was given as argument" >&2
 	_log_error "The last log wasn't properly recorded. The description was probably missing"
		return 1
    	fi

	printf '[%s] [%s] %s\n' "$timestamp" "$log_level" "$*" >> "$LOG_FILE"
}

# Category logging functions
_log_info() {
    _log "INFO" "$@"
}

_log_warn() {
    _log "WARN" "$@"
}

_log_error() {
    _log "ERROR" "$@"
}

_log_debug() {
    _log "DEBUG" "$@"
}
