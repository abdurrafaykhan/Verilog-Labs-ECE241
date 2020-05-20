module alu(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, STORE);
 
 input [7:0]SW;
 input [2:0] KEY;
 output [6:0] HEX0;
 output [6:0] HEX1;
 output [6:0] HEX2;
 output [6:0] HEX3;
 output [6:0] HEX4;
 output [6:0] HEX5;
 output [7:0]LEDR;
 output [4:0]STORE;
 alu a(SW[7:4], SW[3:0], KEY, LEDR, STORE);
 
 seg7 hex0(SW[0], SW[1], SW[2], SW[3], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
 seg7 hex1(0, 0, 0, 0, HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);
 seg7 hex2(SW[4], SW[5], SW[6], SW[7], HEX2[0], HEX2[1], HEX2[2], HEX2[3], HEX2[4], HEX2[5], HEX2[6]);
 
 
 seg7 hex3(0, 0, 0, 0, HEX3[0], HEX3[1], HEX3[2], HEX3[3], HEX3[4], HEX3[5], HEX3[6]);
 seg7 hex4(LEDR[0], LEDR[1], LEDR[2], LEDR[3], HEX4[0], HEX4[1], HEX4[2], HEX4[3], HEX4[4], HEX4[5], HEX4[6]);
 seg7 hex5(LEDR[4], LEDR[5], LEDR[6], LEDR[7], HEX5[0], HEX5[1], HEX5[2], HEX5[3], HEX5[4], HEX5[5], HEX5[6]);

endmodule

module alu(input [3:0]A, input[3:0]B, input[2:0]KEY, output reg [7:0]ALUout, output [4:0]STORE);
 
   adder4bit u (A[3:0], B[3:0], 0, STORE[3:0], STORE[4]);
 always @(*)
  begin
  case (KEY)
   3'b000 : ALUout = {3'b000, STORE};
   3'b001 : ALUout = A + B;
   3'b010 : ALUout = {~(A^B),~(A&B)};
   3'b011 : ALUout = (A||B)? 8'b00001111:8'b00000000;
   3'b100 : ALUout = (((A[0]+A[1]+A[2]+A[3]==1'b1))&&((B[0]+B[1]+B[2]+B[3]==2'b10)))? 8'b11110000:8'b00000000;
   3'b101 : ALUout = {A,B};
  default : ALUout = 8'b00000000;
  endcase
 end
endmodule

//adder4bit
module adder4bit (A, B, Cin, S, Cout);
 input [8:0] A;
 input [9:0] B;
 input Cin;
 output Cout;
 output [9:0] S;
 wire C1, C2, C3, C4;
 
 FA Bit0 (A[0], B[0], Cin, S[0], C1);
 FA Bit1 (A[1], B[1], C1, S[1], C2);
 FA Bit2 (A[2], B[2], C2, S[2], C3);
 FA Bit3 (A[3], B[3], C3, S[3], Cout);
endmodule
 
//adder4bit
module FA(a, b, Cin, S, Cout);
 input a, b, Cin;
 output S, Cout;
 assign S = Cin^b^a;
 assign Cout = (b&a)|(Cin&b)|(Cin&a);
endmodule






//hex decoder
module hex6(HEX0, SW);
 input [9:0] SW;
 output [9:0] HEX0;
 hex u0(
 .c0(SW[0]),
 .c1(SW[1]),
 .c2(SW[2]),
 .c3(SW[3]),
 .led0(HEX0[0]),
 .led1(HEX0[1]),
 .led2(HEX0[2]),
 .led3(HEX0[3]),
 .led4(HEX0[4]),
 .led5(HEX0[5]),
 .led6(HEX0[6])
 );
endmodule
//hexdecoder
module seg7(input c0, c1, c2, c3, output led0, led1, led2, led3, led4, led5, led6);
 assign led0 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (c3 & ~c2 & c1 & c0) | (c3 & c2 & ~c1 & c0);
 assign led1 = (~c3 & c2 & ~c1 & c0) | (~c3 & c2 & c1 & ~c0) | (c3 & ~c2 & c1 & c0) | (c3 & c2 & ~c1 & ~c0) | (c3 & c2 & c1 & ~c0) | (c3 & c2 & c1 & c0);
 assign led2 = (~c3 & ~c2 & c1 & ~c0) | (c3 & c2 & ~c1 & ~c0) | (c3 & c2 & c1 & ~c0) | (c3 & c2 & c1 & c0);
 assign led3 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (~c3 & c2 & c1 & c0) | (c3 & ~c2 & ~c1 & c0) | (c3 & ~c2 & c1 & ~c0) | (c3 & c2 & c1 & c0);
 assign led4 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & ~c2 & c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (~c3 & c2 & ~c1 & c0) | (~c3 & c2 & c1 & c0) | (c3 & ~c2 & ~c1 & c0);
 assign led5 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & ~c2 & c1 & ~c0) | (~c3 & ~c2 & c1 & c0) | (~c3 & c2 & c1 & c0) | (c3 & c2 & ~c1 & c0);
 assign led6 = (~c3 & ~c2 & ~c1 & ~c0) | (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & c1 & c0) | (c3 & c2 & ~c1 & ~c0);
endmodule
