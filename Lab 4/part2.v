module part2(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
reg [3:0] zero = 4'b0000;
wire [7:0] aluOut, regOut;
ALU main(
.A(SW[3:0]),
.register(regOut),
.key(KEY[3:1]),
.out(aluOut)
);
assign LEDR = regOut;
register reg1(
.D(aluOut),
.Reset_b(SW[9]),
.Clock(KEY[0]),
.q(regOut)
);
seg7 hex0(
.i(SW[3:0]),
.hex(HEX0)
);
seg7 hex1(
.i(zero),
.hex(HEX1)
);
seg7 hex2(
.i(zero),
.hex(HEX2)
);
seg7 hex3(
.i(zero),
.hex(HEX3)
);
seg7 hex4(
.i(regOut[3:0]),
.hex(HEX4)
);
seg7 hex5(
.i(regOut[7:4]),
.hex(HEX5)
);
endmodule


module seg7(input[3:0] i, output reg [6:0] hex);
always @(*)
begin
case(i)
4'h0: hex = 7'b1000000;
4'h1: hex = 7'b1111001;
4'h2: hex = 7'b0100100;
4'h3: hex = 7'b0110000;
4'h4: hex = 7'b0011001;
4'h5: hex = 7'b0010010;
4'h6: hex = 7'b0000010;
4'h7: hex = 7'b1111000;
4'h8: hex = 7'b0000000;
4'h9: hex = 7'b0010000;
4'hA: hex = 7'b0001000;
4'hB: hex = 7'b0000011;
4'hC: hex = 7'b1000110;
4'hD: hex = 7'b0100001;
4'hE: hex = 7'b0000110;
4'hF: hex = 7'b0001110;
default: hex = 7'b1000000;
endcase
end
endmodule

module register (input[7:0] D, input Reset_b, Clock, output reg[7:0] q);
always @(posedge Clock)
begin
if (Reset_b == 1'b0)
q <= 0;
else
q <= D;
end
endmodule

module ALU (input [3:0] A, input [7:0] register, input [2:0] key,
output reg [7:0] out);
wire [3:0] B;
assign B = register[3:0];

wire [3:0] tempSum;
wire carry;
adder4bit adder(.A(A), .B(B), .Cin(1'b0), .S(tempSum), .Cout(carry));

always @(*)
begin
case(~key)
3'd0: out = {3'b000, carry, tempSum};
3'd1: out =  A + B;
3'd2: out = {~(A^B),~(A&B)};
3'd3: out = (A||B)? 8'b00001111:8'b00000000;
3'd4: out = (((A[0]+A[1]+A[2]+A[3]==1'b1))&&((B[0]+B[1]+B[2]+B[3]==2'b10)))?
8'b11110000:8'b00000000;
3'd5: out = {A,B};
3'd6: out = register;
default: out = 8'd0;
endcase
end
endmodule





module adder4bit(input [3:0] A, B, input Cin, output [3:0] S, output Cout);
wire w1, w2, w3;
fullAdder add1(.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(w1));
fullAdder add2(.a(A[1]), .b(B[1]), .Cin(w1), .s(S[1]), .Cout(w2));
fullAdder add3(.a(A[2]), .b(B[2]), .Cin(w2), .s(S[2]), .Cout(w3));
fullAdder add4(.a(A[3]), .b(B[3]), .Cin(w3), .s(S[3]), .Cout(Cout));

endmodule

module fullAdder (input a, b, Cin, output s, Cout);
assign s = Cin^a^b;
assign Cout = (a & b)|(Cin & a)|(Cin & b);
endmodule
