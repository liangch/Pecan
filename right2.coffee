command: "bash Pecan/scripts/battery"

refreshFrequency: '10s'

render: (output) ->
  values = output.split('|')
  
  # battery charge
  charge = +values[0].replace('%','')
  color = 'none'
  style = ""

  if charge > 75
    battery = "<i class='fas fa-battery-full'></i> #{charge}"
  else if charge > 50
    battery = "<i class='fas fa-battery-three-quarters'></i> #{charge}"
  else if charge > 25
    battery = "<i class='fas fa-battery-half'></i> #{charge}"
  else if charge > 10
    battery = "<i class='fas fa-battery-quarter'></i> #{charge}"
  else
    battery = "<i class='fas fa-battery-empty'></i> #{charge}"
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


  # battery status
  status = values[1].replace(' ','').replace(' ','')
  statusIcon=''

  if status == "charging"
    statusIcon = "<i class='fas fa-bolt'></i>"

  "#{style}<div class='screen'><div class='right2'>#{battery} #{statusIcon}</div></div>"
