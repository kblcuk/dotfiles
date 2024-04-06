#!/usr/bin/env fish

# Function to monitor macOS theme changes
function monitor_theme_changes
    while true
        echo 'Updating color theme...'
        set current_theme (defaults read -g AppleInterfaceStyle 2>/dev/null)
        if test "$current_theme" = "Dark"
            # update_fish_config "dark"
            echo 'Updating color theme... Dark'
            set --universal background_mode "dark"
        else
            # update_fish_config "light"
            echo 'Updating color theme... Light'
            set --universal background_mode "light"
        end
        sleep 5  # Adjust sleep duration as needed
    end
end

# Subscribe to macOS color mode changes
monitor_theme_changes &

# Keep the script running
wait

