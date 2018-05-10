command: "date +\"%-m/%-d %H:%M\""

refreshFrequency: 10000

render: (output) ->
	"<div class='screen'><div class='holder'><div class='center'>#{output}</div></div></div>"