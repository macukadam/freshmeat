#!/usr/bin/env fish

# Set variables
set images_dir ~/Pictures/wallpapers
set i3_config ~/.config/i3/config

# Use fzf to choose a wallpaper
set selected_image (find $images_dir -type f | fzf)

# Check if an image was selected
if test -n "$selected_image"
    # Change the wallpaper
    feh --bg-scale $selected_image

    # Update i3 config
    sed -i "s|exec --no-startup-id feh --bg-scale .*|exec --no-startup-id feh --bg-scale '$selected_image'|g" $i3_config

    # Reload i3 config
    i3-msg reload
end
