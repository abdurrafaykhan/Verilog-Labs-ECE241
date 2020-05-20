`timescale 1ns/1ns

module lab5part1(input [1:0]SW, [0:0]KEY, output [6:0]HEX0, [6:0]HEX1); 
    wire [7:0]Tin; wire [7:0]Qout; 
    assign Tin[0] = SW[1]; 
    TFF U0(.T(Tin[0]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[0])); 
    assign Tin[1] = Qout[0] & Tin[0]; 
    TFF U1(.T(Tin[1]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[1]));  
    assign Tin[2] = Qout[1] & Tin[1]; 
    TFF U2(.T(Tin[2]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[2])); 
    assign Tin[3] = Qout[2] & Tin[2]; 
    TFF U3(.T(Tin[3]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[3])); 
    assign Tin[4] = Qout[3] & Tin[3]; 
    TFF U4(.T(Tin[4]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[4]));  
    assign Tin[5] = Qout[4] & Tin[4]; 
    TFF U5(.T(Tin[5]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[5])); 
    assign Tin[6] = Qout[5] & Tin[5];  
    TFF U6(.T(Tin[6]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[6]));  
    assign Tin[7] = Qout[6] & Tin[6]; 
    TFF U7(.T(Tin[7]), .Clock(KEY[0]), .Clear_b(SW[0]), .Q(Qout[7])); 
    HEX H0(.B(Qout[3:0]), .S(HEX0));
    HEX H1(.B(Qout[7:4]), .S(HEX1));
endmodule // TFlipFlop

module HEX(input [3:0]B, output [6:0]S);
    wire [6:0]W; wire [3:0]D;
    assign D = B;
    assign W[0] = !((!D[0]|D[1]|D[2]|D[3]) & (D[0]|D[1]|!D[2]|D[3]) & (!D[0]|!D[1]|D[2]|!D[3]) & (!D[0]|D[1]|!D[2]|!D[3]));
    assign W[1] = !((!D[0]|D[1]|!D[2]|D[3]) & (D[0]|!D[1]|!D[2]|D[3]) & (!D[0]|!D[1]|D[2]|!D[3]) & (D[0]|D[1]|!D[2]|!D[3]) & (D[0]|!D[1]|!D[2]|!D[3]) & (!D[0]|!D[1]|!D[2]|!D[3]));
    assign W[2] = !((D[0]|!D[1]|D[2]|D[3]) & (D[0]|D[1]|!D[2]|!D[3]) & (D[0]|!D[1]|!D[2]|!D[3]) & (!D[0]|!D[1]|!D[2]|!D[3]));
    assign W[3] = !((!D[0]|D[1]|D[2]|D[3]) & (D[0]|D[1]|!D[2]|D[3]) & (!D[0]|!D[1]|!D[2]|D[3]) & (D[0]|!D[1]|D[2]|!D[3]) & (!D[0]|!D[1]|!D[2]|!D[3]));
    assign W[4] = !((!D[0]|D[1]|D[2]|D[3]) & (!D[0]|!D[1]|D[2]|D[3]) & (D[0]|D[1]|!D[2]|D[3]) & (!D[0]|D[1]|!D[2]|D[3]) & (!D[0]|!D[1]|!D[2]|D[3]) & (!D[0]|D[1]|D[2]|!D[3]));
    assign W[5] = !((!D[0]|D[1]|D[2]|D[3]) & (D[0]|!D[1]|D[2]|D[3]) & (!D[0]|!D[1]|D[2]|D[3]) & (!D[0]|!D[1]|!D[2]|D[3])&(!D[0]|D[1]|!D[2]|!D[3]));
    assign W[6] = !((D[0]|D[1]|D[2]|D[3]) & (!D[0]|D[1]|D[2]|D[3]) & (!D[0]|!D[1]|!D[2]|D[3]) & (D[0]|D[1]|!D[2]|!D[3]));
    assign S = W;
endmodule // hexDecoder

module TFF(input T, Clock, Clear_b, output reg Q);
    always @(posedge Clock or negedge Clear_b)
    begin
        if(Clear_b == 1'b0)
            Q <= 1'b0; 
        else if(T == 1'b1)
            Q <= ~Q;     
    end
endmodule // TFF
