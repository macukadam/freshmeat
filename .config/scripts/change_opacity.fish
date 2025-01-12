#!/usr/bin/env fish

# Paths
set CONFIG_PATH ~/.config/alacritty/alacritty.toml
set TEMP_PATH /tmp/alacritty_temp.toml

# Get the current opacity (assuming a line like `opacity = 0.8`)
set CURRENT_OPACITY (grep "^opacity\s*=\s*" $CONFIG_PATH | awk '{print $3}')

# Check for action
switch $argv[1]
    case "increase"
        set TEST_OPACITY (math "$CURRENT_OPACITY + 0.1")
        if test "$TEST_OPACITY" -le 1
            set NEW_OPACITY $TEST_OPACITY
        end
    case "decrease"
        set TEST_OPACITY (math "$CURRENT_OPACITY - 0.1")
        if test "$TEST_OPACITY" -ge 0.1
            set NEW_OPACITY $TEST_OPACITY
        end
    case '*'
        echo "Invalid command or opacity at its limit."
        exit 1
end

# Update the configuration file if NEW_OPACITY is set
if set -q NEW_OPACITY
    sed "s/opacity\s*=\s*$CURRENT_OPACITY/opacity = $NEW_OPACITY/" $CONFIG_PATH > $TEMP_PATH
    mv $TEMP_PATH $CONFIG_PATH
    echo "Updated opacity to $NEW_OPACITY"
else
    echo "No change in opacity."
end

