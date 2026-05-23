#!/usr/bin/zsh

CARD="alsa_card.pci-0000_00_1b.0"
HDMI_PROFILE="output:hdmi-stereo+input:iec958-stereo"
ANALOG_PROFILE="output:analog-stereo+input:iec958-stereo"
HDMI_SINK="alsa_output.pci-0000_00_1b.0.hdmi-stereo"
ANALOG_SINK="alsa_output.pci-0000_00_1b.0.analog-stereo"

current=$(pactl list cards | grep "Active Profile" | head -1 | awk '{print $3}')

if [[ "$current" == "$HDMI_PROFILE" ]]; then
    pactl set-card-profile "$CARD" "$ANALOG_PROFILE"
    pactl set-default-sink "$ANALOG_SINK"
    notify-send -i audio-headphones "Audio" "Switched to Mac Mini 3.5mm"
else
    pactl set-card-profile "$CARD" "$HDMI_PROFILE"
    pactl set-default-sink "$HDMI_SINK"
    notify-send -i audio-headphones "Audio" "Switched to Kuycan DisplayPort"
fi

pkill -SIGRTMIN+9 waybar
