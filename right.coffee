commands =
	cpu : "ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.f\",s/4);}'"
	battery : "bash Pecan/scripts/battery"
	disk : "df -H / | awk 'END{print $4}'"
	network : "bash Pecan/scripts/network"

command: "echo " +
	" \"↑↓\" $(#{ commands.network }) " +
	" \"&nbsp;<i class='fa fa-spinner'></i>\"  $(#{ commands.cpu }) " +
	" \"&nbsp;<i class='fas fa-hdd'></i>\"     $(#{ commands.disk })" + 
	" \"&nbsp;<i class='fas fa-heart'></i>\"   $(#{ commands.battery })"

refreshFrequency: '7s'

render: (output) ->
	"<div class='screen'><div class='right'>#{output}</div></div>"
