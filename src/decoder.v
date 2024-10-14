module Decoder (
    input [3:0] A,
    input C,
    output [1:0] OE,
    output [3:0] CS
);

assign OE[1] = A[1];
assign OE[0] = A[0] | A[3];

assign CS[0] = A[2] | A[3];
assign CS[1] = ~A[2] | A[3];
assign CS[2] = A[2] | ~A[3];
assign CS[3] = ~A[2] | ~A[3] | (~A[0] & C);
    
endmodule