`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 11/17/2019 08:33:42 PM
// Module Name: DOTMATRIX
// Project Name:

//////////////////////////////////////////////////////////////////////////////////


module DOTMATRIX_VERSION2(reset,power,clk,up,down,right,left,
                            y00,y01,y02,y03,
                            y10,y11,y12,y13,
                            y20,y21,y22,y23,
                            y30,y31,y32,y33);

input reset,power,clk,up,down,right,left;
output y00,y01,y02,y03,y10,y11,y12,y13,y20,y21,y22,y23,y30,y31,y32,y33;

reg [3:0]control;
reg [0:3]mat[0:3];
reg [3:0] i,j;
reg [1:0] row, col;
reg [3:0] present, next;

parameter INITIALLY = 4'b1111,	//4'hf
	    OFF       = 4'b1010,      //4'ha
          START     = 4'b0101;      //4'h5


always@(posedge clk)begin//1
      //assigning input
      control = {left,down,right,up};
      if(power)begin//1.1
            if(reset)  present<=INITIALLY;
            else present<=next;
      end else present<=OFF; //1.1
end//1

//end
always@(posedge clk)
begin//2
    case(present)
        //INPUT 1010 : (5)assign 0 to all the LEDs
        OFF : begin
                  for(j=0;j<4;j=j+1) begin
                        for(i=0;i<4;i=i+1) begin
                              mat[i][j]=0;
                        end
                  end
              end
        //INPUT 1111 : (15)assign 1 to all the LEDs and move to next state
        INITIALLY : begin
                        row=0;col=0;
                        for(j=0;j<4;j=j+1) begin
                              for(i=0;i<4;i=i+1) begin
                                    if(i==row & j==col) mat[i][j]=1'b1;
                                    else mat[i][j]=1'b0;
                              end
                        end
                       next = START;
                    end
        START : begin//3
                  case(control)
                        //INPUT 0001 : move up in the same column
                        4'b0001 : begin  //5
                                    row = row - 2'b01;
                                    for(j=0;j<4;j=j+1) begin
                                          for(i=0;i<4;i=i+1) begin
                                                if(i==row & j==col) mat[i][j]=1'b1;
                                                else mat[i][j]=1'b0;
                                          end
                                    end
                              end
                        //INPUT 0010 : move right in the same row
                       4'b0010 : begin
                                    col = col + 2'b01;
                                    for(j=0;j<4;j=j+1)    begin
                                          for(i=0;i<4;i=i+1)  begin
                                                if(i==row & j==col) mat[i][j]=1'b1;
                                                else mat[i][j]=1'b0;
                                          end
                                    end
                              end
                        //INPUT 0100 : move down in the same column
                        4'b0100 : begin
                                    row = row + 2'b01;
                                    for(j=0;j<4;j=j+1) begin
                                          for(i=0;i<4;i=i+1) begin
                                                if(i==row & j==col) mat[i][j]=1'b1;
                                                else mat[i][j]=1'b0;
                                          end
                                    end
                              end
                        //INPUT 1000 : move left in the same row
                        4'b1000 : begin
                                    col = col - 2'b01;
                                    for(j=0;j<4;j=j+1) begin
                                          for(i=0;i<4;i=i+1) begin
                                                if(i==row & j==col) mat[i][j]=1'b1;
                                                else mat[i][j]=1'b0;
                                          end
                                    end
                              end
                        //if input doesn't match with any of the above than stay at the previous state
                        default : begin
                                    for(j=0;j<4;j=j+1)    begin
                                          for(i=0;i<4;i=i+1)  begin
                                                if(i==row & j==col) mat[i][j]=1'b1;
                                                else mat[i][j]=1'b0;
                                          end
                                    end
                              end
                  endcase    //5
            end//3
      ////if input doesn't match with any of the above than light up the led at position [0][0].
      default : begin
                  row=0;col=0;
                  for(j=0;j<4;j=j+1) begin
                        for(i=0;i<4;i=i+1) begin
                              if(i==row & j==col) mat[i][j]=1'b1;
                              else mat[i][j]=1'b0;
                        end
                  end
                  next = START;
            end
    endcase//
end//2

//assigning state to the output wires
assign y00 = mat[0][0];   assign y01 = mat[0][1];   assign y02 = mat[0][2];   assign y03 = mat[0][3];
assign y10 = mat[1][0];   assign y11 = mat[1][1];   assign y12 = mat[1][2];   assign y13 = mat[1][3];
assign y20 = mat[2][0];   assign y21 = mat[2][1];   assign y22 = mat[2][2];   assign y23 = mat[2][3];
assign y30 = mat[3][0];   assign y31 = mat[3][1];   assign y32 = mat[3][2];   assign y33 = mat[3][3];
	
endmodule

