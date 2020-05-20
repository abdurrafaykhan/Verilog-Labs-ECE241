`timescale 1ns/1ns

module lab5part2(input CLOCK_50, [2:0]SW, output [6:0]HEX0);
    wire W1; 
    wire [25:0] W2; 
    wire [3:0] Qout;
    EnableSignal ES1(.S(SW[1:0]), .Clk(CLOCK_50), .Clear_b(SW[2]), .Q(W2)); 
    assign W1 = (W2 == 0)?1:0;
    Counter C1(.Enable(W1), .Clk(CLOCK_50), .Clear_b(SW[2]) , .Q(Qout)); 
    HEX H0(.B(Qout), .S(HEX0));  
endmodule // HexCounter

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

module EnableSignal(input Clear_b, Clk,  [1:0]S, output reg [25:0]Q); 
    always @(posedge Clk) 
    begin
        if(Clear_b == 1'b0)
            Q <= 26'b0000000000000000000000000;  
        else if(Q == 0)
            if(S == 2'b01)
                Q <= 26'b00101111101011110000011111; 
            else if(S == 2'b10)
                Q <= 26'b01011111010111100000111111;
            else if(S == 2'b11)
                Q <= 26'b10111110101111000001111111;
            else
                Q <= 26'b0000000000000000000000000; 
        else
            Q <= Q - 1;  
    end
endmodule // EnableSignal

module Counter(input Enable, Clk, Clear_b, output reg [3:0]Q); 
    always @(posedge Clk) 
    begin
        if(Clear_b == 1'b0)
            Q <= 4'b0000;
        else if(Q == 4'b1111)
            Q <= 4'b0000; 
        else if(Enable == 1'b1) 
            Q <= Q + 1;      
    end
endmodule // Counter