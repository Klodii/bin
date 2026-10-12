#!/bin/bash

# In order to use the script by other commands, we have to source the file with
# the full path
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
if [[ -f "$SCRIPT_DIR/utils" ]]; then
    source "$SCRIPT_DIR/utils"
else
    echo "Error: utils file not found in $SCRIPT_DIR"
    exit 1
fi
SCRIPT_NAME=${0##*/}
function help {
    # here-document used instead of echoing all lines
   cat <<-HMESSAGE
Music player

Usage:
  $SCRIPT_NAME [-hn] <command>

Options:
  -h     Print this help and exit
  -n     Send notification

Commands:
  start    Start a new playlist
  stop     Stop the music
  play     Play a paused song
  pause    Pause the song
  prev     Go to the previous song
  next     Go to the next song
  info     Print the current song informations
HMESSAGE
}
NOTIFY=':' # no-op, do nothing command
while getopts "hn" option; do
    case $option in
        h ) help; exit 0;;
        n ) NOTIFY=notify_info;;
        \?)
            echo "Error: Invalid option"
            exit 1;;
    esac
done
shift $((OPTIND -1)) # remove all options from $#

if [ "$(current_os)" = 'macos' ]; then
    exit_w_error "This OS is not yet handled"
else
    if is_installed mpc; then
        function is_song_running {
            is_song_playing=$(mpc status | grep -q '\[playing\]')
            is_song_paused=$(mpc status | grep -q '\[paused\]')
            is_song_playing ] || [ is_song_paused ]
        }
        function get_song_title {
            if is_song_running ;then
                mpc status | head -n 1
            fi
        }
        function start_player {
            mpc clear
            mpc listall | mpc add
            mpc shuffle
            mpc play
            $NOTIFY "MusicPlayer" "Started the player";
        }
        function stop_player {
            mpc stop
            $NOTIFY "MusicPlayer" "Stopped the player";
        }
        function play {
            if is_song_running; then
                song_title=$(get_song_title)
                mpc play
                $NOTIFY "MusicPlayer" "Playing $song_title";
            else
                start_player
            fi
        }
        function pause {
            mpc pause
            $NOTIFY "MusicPlayer" "Song Paused";
        }
        function prev {
            mpc prev
            $NOTIFY "MusicPlayer" "Changed to the previous song";
        }
        function next {
            mpc next
            $NOTIFY "MusicPlayer" "Changed to the next song";
        }

        function current_song { mpc status; }
    else
        function start_player {
            MUSIC_FOLDER="$HOME/my-music"
            mpv --vo=null --video=no --no-video --term-osd-bar --no-resume-playback --shuffle "$MUSIC_FOLDER"
        }
        function stop_player { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
        function play { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
        function pause { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
        function prev { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
        function next { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
        function current_song { exit_w_error_and_notify "$SCRIPT_NAME" "Command unavailable. Install mpc"; }
    fi
fi

COMMAND=$1
case "$COMMAND" in
    start) start_player ;;
    stop) stop_player ;;
    play) play ;;
    pause) pause ;;
    prev) prev ;;
    next) next ;;
    info) current_song ;;
esac
