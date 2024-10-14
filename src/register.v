module Register #(
    parameter N=4
) (
    input CLK,
    input CLR,
    input CS,
    input [N-1:0] D,
    output [N-1:0] Q
);

reg [N-1:0] memory = 0;

assign Q = memory;

always @(posedge CLK) begin
    if (CLR == 0) begin
        memory <= 0;
    end else if (CS == 0) begin
        memory <= D;
    end
end
    
endmodule
