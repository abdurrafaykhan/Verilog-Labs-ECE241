//Quad 2-input OR
module or4(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    or4 u0(
        .pin1(SW[0]),
        .pin2(SW[1]),
        .pin4(SW[2]),
        .pin5(SW[3]),
        .pin9(SW[4]),
        .pin10(SW[3]),
        .pin12(SW[4]),
        .pin13(SW[4]),
        .pin3(LEDR[0]),
        .pin6(LEDR[1]),
        .pin8(LEDR[2]),
        .pin11(LEDR[3])
	);
endmodule



module v7432 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule
