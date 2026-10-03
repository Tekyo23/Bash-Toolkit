#!/usr/bin/env bash

# Save scrip path
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

#TODO: All actions must generate a line in the log file
# Load all libraries
for module in "$SCRIPT_DIR"/lib/*.sh; do
	source "$module"
done

main() {
	# Ensure that a command is given as argument
	if [[ $# -lt 1 ]]; then
		echo "ERROR: You must choose a command. Use bashkit -help for help" >&2
		# TODO: The error must be logged into the log file
		echo "Usage: $0 <command> [arguments]" # Future implementation: $0 should be bashkit
		return 1
	fi

	local command="$1"
	local function_name="cmd_${command//-/_}" # User functions must start with cmd_
						  # otherwise is a function from the program and should not be accessible

	# Ensure that the function exists
	if ! declare -F "$function_name" >/dev/null; then
		echo "ERROR: Unknown command '$command'" >&2
		# TODO: The error must be logged into the log file
		return 1
	fi

	shift
	"$function_name" "$@"
}

# Execute main only when the script is run directly, not when sourced
if [[ "$BASH_SROUCE[0]}" == "$0" ]]; then
	main "$@"
fi
