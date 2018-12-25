commands =
	cpu : "ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.0f\", s/4);}'"
	battery : "bash Pecan/scripts/battery"
	disk : "df -H / | awk 'END{print $4}'"
	network : "bash Pecan/scripts/network"
	ws: "bash Pecan/scripts/ws"
	wifi: "networksetup -getairportnetwork en0 | cut -c 24-"

icon_path = "/Pecan/icons"

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

render: (output) -> """
	<div class='screen'>
		<div class='right'>
			↑↓<span id='network'>network</span>
			<img src='#{icon_path}/cpu.png' class='icon'><span id='cpu'>cpu</span>
			<img src='#{icon_path}/wifi.png' class='icon'><span class='small' id='wifi'>wifi</span>
			<img src='#{icon_path}/disk.png' class='icon'><span id='disk'>disk</span>
			<img src='#{icon_path}/battery100.png' class='icon' id='battery_icon'><span id='battery'>battery</span>
			<span id='ws'>ws</span>
		</div>
	</div>
"""

update: (output, domEl) ->
	outputs = output.split('||')
	cpu = outputs[0]
	battery = outputs[1]
	disk = outputs[2]
	network = outputs[3]
	workspace = outputs[4]
	wifi = outputs[5]

	ws = workspace.split('|')[1].slice(0,3)
	if ws == "bsp"
		ws = "<i class='far fa-th-large'></i>"
	else if ws == "mon"
    	ws = "<i class='far fa-dice-one'></i>"
	else if ws == "flo"
    	ws = "<i class='far fa-clone'></i>"

	charge = +battery.replace('%','')
	if charge > 75
		battery_icon = "battery100.png"
	else if charge > 50
		battery_icon = "battery70.png"
	else if charge > 25
		battery_icon = "battery50.png"
	else if charge > 10
		battery_icon = "battery10.png"
	else
		battery_icon = "battery0.png"

	$('#network').html(network)
	$('#cpu').html(cpu)
	$('#wifi').html(wifi)
	$('#disk').html(disk)
	$('#battery').html(battery)
	$('#battery_icon').attr('src', icon_path + '/' + battery_icon)
	$('#ws').html(ws)