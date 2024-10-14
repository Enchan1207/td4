`include "register.v"

module ProgramCounter #(
    parameter bitWidth = 4
) (
    input CLK,
    input CLR,
    input CS,
    input [bitWidth-1:0] D,
    output [bitWidth-1:0] Q
);

    wire [bitWidth-1:0] internalData = CS == 0 ? D[bitWidth-1:0] : Q[bitWidth-1:0] + 1;

    Register #(.bitWidth(bitWidth)) register (.CLK(CLK), .CLR(CLR), .CS(1'b0), .D(internalData), .Q(Q));
    
endmodule
