module part3(SW, KEY, LEDR);
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR;

rotatingRegister r1(
.clock(KEY[0]),
.reset(SW[9]),
.parallelLoadIn(KEY[1]),
.rotateRight(KEY[2]),
.ASright(KEY[3]),
.dataIn(SW[7:0]),
.Q(LEDR[7:0])
);
endmodule

module rotatingRegister(input reset, clock, parallelLoadIn,
rotateRight, ASright, input [7:0] dataIn, output [7:0] Q);
wire [7:0] q;
wire AS;
mux2to1 AS_Shift(.s(ASright), .a(q[7]), .b(q[0]), .out(AS));

singleBitRotatingRegister bit7(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[7]), .Qleft(AS), .Qright(q[6]), .Q(q[7]));

singleBitRotatingRegister bit6(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[6]), .Qleft(q[7]), .Qright(q[5]), .Q(q[6]));

singleBitRotatingRegister bit5(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[5]), .Qleft(q[6]), .Qright(q[4]), .Q(q[5]));

singleBitRotatingRegister bit4(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[4]), .Qleft(q[5]), .Qright(q[3]), .Q(q[4]));

singleBitRotatingRegister bit3(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[3]), .Qleft(q[4]), .Qright(q[2]), .Q(q[3]));

singleBitRotatingRegister bit2(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[2]), .Qleft(q[3]), .Qright(q[1]), .Q(q[2]));

singleBitRotatingRegister bit1(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[1]), .Qleft(q[2]), .Qright(q[0]), .Q(q[1]));

singleBitRotatingRegister bit0(.clk(clock), .reset(reset),
.loadIn(parallelLoadIn), .rotateRight(rotateRight),
   .dataIn(dataIn[0]), .Qleft(q[1]), .Qright(q[7]), .Q(q[0]));

assign Q = q;

endmodule

module singleBitRotatingRegister(input clk, reset, loadIn,
rotateRight, dataIn, Qleft, Qright, output Q);
wire w1, Win;

mux2to1 rotate  (.s(rotateRight), .a(Qleft), .b(Qright), .out(w1));
mux2to1 load    (.s(loadIn), .a(w1), .b(dataIn), .out(Win));

D_ff flipflop(.D(Win), .reset(reset), .clk(clk), .Q(Q));
endmodule


module D_ff (input D, reset, clk, output reg Q);
always @(posedge clk)
begin
if (reset == 1'b1)
Q <= 0;
else
Q <= D;
end
endmodule

module mux2to1(input s, a, b, output out);
assign out = s?b:a;
endmodule
