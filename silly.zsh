# Set the percentage of the terminal that should
# be dedicated to the header here.
HEADERFACTOR=33

# Create a headercmd function that will be called
# to update the contents of the header.
headercmd() {
    ls -1 | column | head -n 8
}

# This is executed before zsh displays the prompt.
precmd() {
    local HEADERLINES=$(expr $(tput lines) \* 100 / $HEADERFACTOR / 10)
    local BODYSTART=$(expr $HEADERLINES + 1)
    
    if [ "$1" != "init" ]
    then
        printf "\0337"
    fi
    
    printf "\033[44;37m\033[1;${HEADERLINES}r\033[?6h\033[H\033[${LINES}L"
    headercmd
    printf "\033[r\033[${HEADERLINES};0H"
    printf '─%.0s' {2..$(tput cols)}
    printf "\r─$(pwd)"
    printf "\033[${BODYSTART};${LINES}r\033[39;49m"
    
    if [ "$1" != "init" ]
    then
        printf "\0338"
    fi
}

# You need to call precmd init once to set things up.
precmd init