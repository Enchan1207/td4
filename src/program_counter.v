`include "register.v"

module ProgramCounter #(
    parameter N = 4
) (
    input CLK,
    input CLR,
    input CS,
    input [N-1:0] D,
    output [N-1:0] Q
);

    wire [N-1:0] internalData = CS == 0 ? D[N-1:0] : Q[N-1:0] + 1;

    Register #(.N(N)) register (.CLK(CLK), .CLR(CLR), .CS(1'b0), .D(internalData), .Q(Q));
    
endmodule
