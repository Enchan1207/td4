module Register #(
    parameter bitWidth=4
) (
    input CLK,
    input CLR,
    input CS,
    input [bitWidth-1:0] D,
    output [bitWidth-1:0] Q
);

reg [bitWidth-1:0] memory = 0;

assign Q = memory;
    
endmodule
