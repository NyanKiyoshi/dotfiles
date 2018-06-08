# trim a mp3 file
#   Format=hh:mm:ss
# example:
#   mp3trim input.mp3 output.mp3 0:03:53
#   mp3trim input.mp3 output.mp3 0:01:05.2 0:03:53
# TODO Colors.sh
mp3trim() {
    # number params < 3
    if [ $# -lt 3 ]; then
        echo -e "USAGE: $0 \033[4mINPUTFILE\033[0m \033[4mOUTPUTFILE\033[0m [\033[4mSTARTTIME\033[0m] \033[4mENDTIME\033[0m\nTIMEFORMAT: HH:MM:SS"
        return
    fi
    
    OUTPUTFILE=$2
    INPUTFILE=$1

    shift 2

    # if not STARTTIME passed but just ENDTIME -> set default
    if [[ -z "$2" ]]; then
        STARTTIME="00:00:00"
    else
        # starttime passed then, store and shift
        STARTTIME=$1
        shift
    fi

    ENDTIME=$1

    ffmpeg -i "$INPUTFILE" -ss $STARTTIME -t $ENDTIME "$OUTPUTFILE"
}
