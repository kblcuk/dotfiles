function update_fish_theme --on-variable background_mode
    if [ "$background_mode" = dark ]
        fish_config theme choose "Rosé Pine Moon"
        return
    end
    fish_config theme choose "Rosé Pine Dawn"
end

# Apply theme immediately (--on-variable only fires when value changes,
# so call directly to ensure FZF_DEFAULT_OPTS is always set on startup).
update_fish_theme
