
//testbench module
module testbench();

reg reset,power,clk,up,down,right,left;
wire y00,y01,y02,y03,
     y10,y11,y12,y13,
     y20,y21,y22,y23,
     y30,y31,y32,y33;

DOTMATRIX_VERSION2 test(reset,power,clk,up,down,right,left,
                            y00,y01,y02,y03,
                            y10,y11,y12,y13,
                            y20,y21,y22,y23,
                            y30,y31,y32,y33);
initial begin
      clk = 0;
      forever #5 clk = ~ clk;
end

initial begin
      power = 1'b0; up = 1'b0; down = 1'b0; right = 1'b0; left = 1'b0;
      #18 power =1'b1; reset = 1'b1;
      #20 reset = 1'b0;
      #20 up = 1'b0; down = 1'b1; right = 1'b0; left = 1'b0;
      #30 up = 1'b0; down = 1'b0; right = 1'b1; left = 1'b0;
      #25 up = 1'b1; down = 1'b0; right = 1'b0; left = 1'b0;
      #30 up = 1'b0; down = 1'b1; right = 1'b0; left = 1'b0;
      #25 up = 1'b0; down = 1'b1; right = 1'b1; left = 1'b0;
      #30 up = 1'b0; down = 1'b0; right = 1'b0; left = 1'b1;
      #250 $finish;
end

endmodule
