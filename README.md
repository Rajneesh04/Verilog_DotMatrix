# Verilog_DotMatrix

Dependencies: Verilog, Xillinx(or any other simulator)

This is a verolog based implementation of a general purpose controller which can be used to navigate in four different direction

INPUT | Direction

0001  | Up
0010  | Right
0100  | Down
1000  | Left

Other INPUTS

POWER : == 0 sytem is off
        == 1 system is on
RESET : == 1 to reset

clk : A clock signal with frequency much higher than the frequency of change of input so that system can work smoothly;
