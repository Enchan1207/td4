module Counter (
    input CLK,
    input CLR,
    output [3:0]Q
);

reg [3:0] count = 0;

assign Q = count;

always @(posedge CLK) begin
    count <= CLR ? count + 1 : 0;
end
    
endmodule
