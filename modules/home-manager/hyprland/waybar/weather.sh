#!/usr/bin/env bash
# Smart minimal weather display for Waybar

WEATHER_DATA=$(curl -sf "wttr.in/?format=j1" 2>/dev/null)

if [ -z "$WEATHER_DATA" ]; then
    printf '{"text": "󰖐", "tooltip": "Weather unavailable"}'
    exit 0
fi

# Parse using jq with explicit path
TEMP_C=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].temp_C')
TEMP_F=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].temp_F')
FEELS_C=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].FeelsLikeC')
FEELS_F=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].FeelsLikeF')
HUMIDITY=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].humidity')
WIND=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].windspeedKmph')
CONDITION=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherDesc[0].value')
CODE=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherCode')
TOMORROW_HIGH_C=$(echo "$WEATHER_DATA" | jq -r '.weather[1].maxtempC')
TOMORROW_LOW_C=$(echo "$WEATHER_DATA" | jq -r '.weather[1].mintempC')
TOMORROW_HIGH_F=$(echo "$WEATHER_DATA" | jq -r '.weather[1].maxtempF')
TOMORROW_LOW_F=$(echo "$WEATHER_DATA" | jq -r '.weather[1].mintempF')

# Smart icon based on weather code
case "$CODE" in
    113) ICON="󰖙" ;;
    116) ICON="󰖕" ;;
    119|122) ICON="󰖐" ;;
    143|248|260) ICON="󰖑" ;;
    176|263|266|293|296) ICON="󰖗" ;;
    179|182|185|281|284|311|314|317|350|374) ICON="󰼳" ;;
    200|386|389|392|395) ICON="󰙾" ;;
    227|230|323|326|329|332|335|338|365|368|371|377) ICON="󰼶" ;;
    299|302|305|308|356|359) ICON="󰖖" ;;
    *) ICON="󰖐" ;;
esac

# Trend
if [ "$TEMP_C" -lt "$TOMORROW_HIGH_C" ]; then
    TREND=" 󰁝"
elif [ "$TEMP_C" -gt "$TOMORROW_LOW_C" ]; then
    TREND=" 󰁅"
else
    TREND=""
fi

# Output using printf to avoid any newline issues
printf '{"text":"%s","tooltip":"%s | %s°F (feels %s°F) | %s%% humidity | %s km/h | Tomorrow: %s°/%s°F","class":"weather"}' \
    "${ICON} ${TEMP_F}°${TREND}" \
    "$CONDITION" \
    "$TEMP_F" \
    "$FEELS_F" \
    "$HUMIDITY" \
    "$WIND" \
    "$TOMORROW_HIGH_F" \
    "$TOMORROW_LOW_F"
