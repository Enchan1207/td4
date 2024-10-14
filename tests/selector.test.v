`timescale 1us/1ns
`include "selector.v"

module selector_test ();
    localparam bitWidth = 4;

    reg [bitWidth-1:0] A = 4'h3;
    reg [bitWidth-1:0] B = 4'h5;
    reg [bitWidth-1:0] C = 4'h7;
    reg [bitWidth-1:0] D = 4'h9;
    reg [1:0] OE = 0;
    wire [bitWidth-1:0] Y;

    DataSelector #(.N(bitWidth)) selector (.A(A), .B(B), .C(C), .D(D), .OE(OE), .Y(Y));

    initial begin
        $dumpfile("selector_test.vcd");
        $dumpvars(0, selector_test);

        OE <= 2'd0;
        #1;
        if(Y != A) begin
            $fatal(1, "invalid output");
        end

        OE <= 2'd1;
        #1;
        if(Y != B) begin
            $fatal(1, "invalid output");
        end

        OE <= 2'd2;
        #1;
        if(Y != C) begin
            $fatal(1, "invalid output");
        end

        OE <= 2'd3;
        #1;
        if(Y != D) begin
            $fatal(1, "invalid output");
        end
        
        $finish();
    end

endmodule
