#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for mon in $(polybar --list-monitors | cut -d':' -f1)
do
	MONITOR=$mon polybar example &
done

echo "Bars launched..."
