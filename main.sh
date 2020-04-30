#!/usr/bin/env bash

# Author: kevin
# Email: kevin1491@163.com

cblack=30;
cred=31;
cgreen=32;
cyellow=33;
cblue=34;
cpurple=35;
ccyan=36;
cwhite=37;

bblack=40;
bred=41;
bgreen=42;
byellow=43;
bblue=44;
bpurple=45;
bcyan=46;
bwhite=47;

#get terminal width & height
SCLINES=`tput lines`;
SCCOLNS=`tput cols`;
 
#init board
declare -A board color bcolor;

board_exit()
{
    tput rmcup;
    tput cvvis;
    stty echo;
    exit 0;
}

board_init()
{
  tput civis; 
  stty -echo;
  tput smcup; 
  clear;
  trap 'board_exit;' SIGINT SIGTERM

  local i=0;
  for((i=0;i<SCLINES*SCCOLNS;i++));do
    board[$i]=0;
    color[$i]=$cwhite;
    bcolor[$i]=$bblack;
  done
}

board_random()
{
  for ((i=0;i<SCLINES*SCCOLNS;i++));do
    board[$i]=0;
    color[$i]=$(($cblack+$((RANDOM%7))));
    bcolor[$i]=$(($bblack+$((RANDOM%7))));
  done
}

board_black()
{
  for ((i=0;i<SCLINES*SCCOLNS;i++));do
    #board[$i]=2;
    color[$i]=$(($cblack+2));
    bcolor[$i]=$bblack;
  done
}

board_flush()
{
  clear;
  local i=0;
  for((i=0;i<SCLINES*SCCOLNS;i++));do
      y=$(($i/SCCOLNS));
      x=$(($i%SCCOLNS));
      #echo "$i $x $y ${bcolor[$i]} ${color[$i]}"
      if [ ${board[$i]} != 0 ];then
        echo -ne "\033[${y};${x}H\033[${bcolor[$i]};${color[$i]}m${board[$i]}\033[0m";
      else 
        echo -ne "\033[${y};${x}H\033[${bcolor[$i]};${color[$i]}m \033[0m";
      fi

      if [ $x == 0 ];then
        echo "";
      fi
  done
}

#board_flush_line 10
board_flush_line()
{
  for((i=0;i<SCCOLNS;i++));do
    echo -ne "\033[${1};${i}H\033[${bcolor[$i]};${color[$i]}m${board[$i]}\033[0m";
  done
}

#board_flush_col 10
board_flush_col()
{
  for((i=0;i<SCLINES;i++));do
    echo -ne "\033[${i};${1}H\033[${bcolor[$i]};${color[$i]}m${board[$i]}\033[0m";
  done
}

#board_flush_rect 10 10 10 10
board_flush_rect()
{
  for((i=0;i<$3;i++));do
    for((j=0;j<$4;j++));do
      echo -ne "\033[$(($2+$j));$(($1+$i))H\033[${bcolor[$(($i+$j*SCCOLNS))]};${color[$(($i+$j*SCCOLNS))]}m${board[$(($i+${j}*SCCOLNS))]}\033[0m";
    done
  done
}

#set_backgroud_color $bgreen;
set_backgroud_color()
{
  for((i=0;i<SCLINES*SCCOLNS;i++));do
      bcolor[$i]=$1;
      color[$i]=$1-10;
  done
}

#set_pix_char 10 10 "k"
set_pix_char()
{
  board[$(($2*SCCOLNS+$1))]=$3;
}

#brush_rect 40 10 100 100 $ccyan $bwhite
brush_rect()
{
   for((i=0;i<$3;i++));do
    for((j=0;j<$4;j++));do
      color[$(($1+$2*SCCOLNS+$i+$j*SCCOLNS))]=$6;
      bcolor[$(($1+$2*SCCOLNS+$i+$j*SCCOLNS))]=$7;
    done
  done
}

#TODO debug this
move_board()
{
  for((i=0;i<SCLINES*SCCOLNS;i++));do
     color[$i]=$cblack
     bcolor[$i]=$bblack
     if [ i%SCCOLNS = 0 ];then
       board_flush;
     fi
     board_flush;
     sleep 1;
  done
}

draw_box()
{
 a=2;  
}

board_main() 
{
   board_init;
#   board_random; 
#   board_flush;
   board_black;
   #board_flush_rect 10 10 10 10;
   
#   brush_rect 40 5 50 40 $ccyan $bwhite
   board_flush;
#   set_pix_char 1 10 "k";
#   move_board;
   sleep 100;
   board_exit;
}

board_main;


