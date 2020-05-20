//Hex INVERTER

module inverter6(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    inverter u0(
        .pin1(SW[0]),
        .pin3(SW[1]),
        .pin5(SW[2]),
        .pin9(SW[3]),
        .pin11(SW[4]),
        .pin13(SW[5]),
        .pin2(LEDR[0]),
        .pin4(LEDR[1]),
        .pin6(LEDR[2]),
        .pin8(LEDR[3]),
        .pin10(LEDR[4]),
        .pin12(LEDR[5])
	);
endmodule



module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule

