#!/bin/bash
f=$(mktemp)
cat > "$f"
off=$(cat "$f" |wc -l)
echo  -e '\e[?25l'
for i in `seq 1 5 61` ;do
# seq arguments control framerate and length
    if ! cat "$f" | lolcat --force -S $i 2>/dev/null ; then
        # if lolcat not present go directly to /usr/games
        cat "$f" | /usr/games/lolcat --force -S $i
    fi
    if [ ! $a ] && [ -n "$1" ];then
        echo "$1"|toilet -f future --metal
        # after first frame print static message
        printf "\\e[3A"
        # roll back to offset message height
        a=1
    fi
    printf "\\e[${off}A"
    # move cursor back
done|head -n-1
echo -e '\e[2B\e[?25h'
rm "$f"

