commands =
	cpu : "ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.f\",s/4);}'"
	battery : "bash Pecan/scripts/battery"
	disk : "df -H / | awk 'END{print $4}'"
	network : "bash Pecan/scripts/network"
	ws: "bash Pecan/scripts/ws"
	wifi: "networksetup -getairportnetwork en0 | cut -c 24-"

# command: "echo " +
# 	" \"↑↓\" $(#{ commands.network }) " +
# 	" \"&nbsp;<i class='fa fa-spinner'></i>\" $(#{ commands.cpu }) " +
# 	" \"&nbsp;<i class='fas fa-hdd'></i>\" $(#{ commands.disk })" +
# 	" \"&nbsp;<i class='fas fa-battery-full'></i>\" $(#{ commands.battery })"
command: """
echo \
$(#{commands.cpu})'||'\
$(#{commands.battery})'||'\
$(#{commands.disk})'||'\
$(#{commands.network})'||'\
$(#{commands.ws})'||'\
$(#{commands.wifi})'||'\
"""

refreshFrequency: '7s'

render: (output) ->
	outputs = output.split('||')
	cpu = outputs[0]
	battery = outputs[1]
	disk = outputs[2]
	network = outputs[3]
	workspace = outputs[4]
	wifi = outputs[5]

	ws = workspace.split('|')[1].slice(0,3)
	if ws == "bsp"
		ws = "<i class='fas fa-th-large'></i>"
	else if ws == "mon"
    	ws = "<i class='fas fa-dice-one'></i>"
	else if ws == "flo"
    	ws = "<i class='fas fa-clone'></i>"


	charge = +battery.replace('%','')
	if charge > 75
		battery = "<i class='fas fa-battery-full'></i> #{charge}%"
	else if charge > 50
		battery = "<i class='fas fa-battery-three-quarters'></i> #{charge}%"
	else if charge > 25
		battery = "<i class='fas fa-battery-half'></i> #{charge}%"
	else if charge > 10
		battery = "<i class='fas fa-battery-quarter'></i> #{charge}%"
	else
		battery = "<i class='fas fa-battery-empty'></i> #{charge}%"
		color = "#F44336"
		style = "<style>
		.quadrat {
		-webkit-animation: NAME-YOUR-ANIMATION 0.5s infinite; 
		}
		@-webkit-keyframes NAME-YOUR-ANIMATION {
		0%, 50% {
			background-color: #95afc0;
		}
		50%, 100% {
			background-color: #eb2f06;
		}
		}</style>"

	"<div class='screen'><div class='right'>
	↑↓ #{network}
	<i class='fas fa-microchip'></i> #{cpu}
	<i class='far fa-signal'></i> #{wifi}
	<i class='fas fa-hdd'></i> #{disk}
	#{battery}
	#{ws}
	</div></div>"