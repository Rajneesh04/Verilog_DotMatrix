///////////////////////////////////////////////////////
module dotMatrix(power,clk,up,down,right,left,mat);
input power,clk,up,down,right,left;
reg [3:0]control;
assign control[0]=up,control[1]=right,control[2]=down,control[3]=left;
output [0:3]mat[0:3];
reg [0:3]temp[0:3];
assign mat = temp;

reg [2:0] row=0, col=0;
parameter OFF=3'b000, UP=3'b001, RIGHT=3'b010, DOWN=3'b011, LEFT=3'b100, STAY=3'b101;
reg [3:0] present, next;

always@(posedge clk)
    if(!power) present<=OFF;
    else present<=next;
always@(present,up,down,left,right)
    case(present)
    OFF: temp=0;

    UP:begin
            if(row==0) row = 3;
            else row = row-1;
          //  temp[row][col]=1'b1;
        end

    RIGHT:begin
            if(col==3) col = 0;
            else col = col+1;
         //   temp[row][col]=1'b1;
         end

    DOWN:begin
            if(row==3) row = 0;
            else row = row+1;
//            temp[row][col]=1'b1;
        end

    LEFT:begin
            if(col==0) col = 3;
            else col = col-1;
            //            temp[row][col]=1'b1;

         end

    STAY:begin

         end

//    default:

    endcase
endmodule
