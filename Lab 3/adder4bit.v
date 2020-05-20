module adder4bit (SW, LEDR);
	input [8:0] SW;
	output [9:0] LEDR;
	wire C1, C2, C3;

	FA Bit0 (SW[0], SW[4], SW[8], LEDR[0], C1);
	FA Bit1 (SW[1], SW[5], C1, LEDR[1], C2);
	FA Bit2 (SW[2], SW[6], C2, LEDR[2], C3);
	FA Bit3 (SW[3], SW[7], C3, LEDR[3], LEDR[9]);
endmodule

module FA(a, b, Cin, S, Cout);
	input a, b, Cin;
	output S, Cout;
	assign S = Cin^b^a;
	assign Cout = (b&a)|(Cin&b)|(Cin&a);
endmodule
