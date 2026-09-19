#!/bin/sh
#
# Suspend the system using ACPI.  The configured suspend state will be
# looked up, checked to see
# if it is supported, and "acpiconf -s <state>" will be issued.
#
# Mark Santcroos <marks@ripe.net>
#

PATH=/sbin:/usr/sbin:/usr/bin:/bin

ACPI_SUSPEND_STATE=hw.acpi.suspend_state
ACPI_SUPPORTED_STATES=hw.acpi.supported_sleep_state

# Check for ACPI support
if sysctl $ACPI_SUSPEND_STATE >/dev/null 2>&1; then
	# Get configured suspend state
	SUSPEND_STATE=$(sysctl -n $ACPI_SUSPEND_STATE)

	# Get list of supported suspend states
	SUPPORTED_STATES=$(sysctl -n $ACPI_SUPPORTED_STATES)

	# Check if the configured suspend state is supported by the system
	if echo "$SUPPORTED_STATES" | grep "$SUSPEND_STATE" >/dev/null; then
		# execute ACPI style suspend command
		exec acpiconf -s "$SUSPEND_STATE"
	else
		echo "Requested suspend state $SUSPEND_STATE is not supported."
		echo "Supported states: $SUPPORTED_STATES"
	fi
else
	echo "Error: no ACPI suspend support found."
fi

exit 1
