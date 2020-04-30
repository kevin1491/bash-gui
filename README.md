# bash-gui
A simple bash GUI, you can draw lines,boxes,write characters in your bash command line. 

Maybe you can write a simple game using this framework!  



# examples

## - get a random background

###  edit board_main function like this

````
board_init;
board_random;
board_flush;
````

![image](https://github.com/kevin1491/bash-gui/raw/master/img/random.png)


## - draw line

###  edit board_main function like this

````
board_init;
board_black;
draw_line 2 0 100 $bwhite;
board_flush;
````

## - draw broken line

###  edit board_main function like this

````
board_init;
board_black;
draw_broken_line 2 0 100 $bwhite;
board_flush;
````
