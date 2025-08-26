function update_theme --on-variable background_mode
  if [ "$background_mode" = "dark" ]
    fish_config theme choose "Rosé Pine Moon"
  else if [ "$background_mode" = "light" ]
    fish_config theme choose "Rosé Pine Dawn"
  end
end

update_theme

