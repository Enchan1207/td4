`timescale 1us/1ns
`include "alu.v"

module alu_test ();
    localparam bitWidth = 4;
    
    reg [bitWidth-1:0] A = 0;
    reg [bitWidth-1:0] B = 0;
    wire [bitWidth-1:0] Y;
    wire C;
    
    ALU #(.bitWidth(bitWidth)) alu (.A(A), .B(B), .Y(Y), .C(C));

    initial begin
        $dumpfile("alu_test.vcd");
        $dumpvars(0, alu_test);

        // キャリーのない加算
        A <= 4'h5;
        B <= 4'h3;
        #1;

        if(Y != 8) begin
            $fatal(1, "Invalid answer");
        end
        
        // キャリーのある加算
        A <= 4'hF;
        B <= 4'h3;
        #1;

        if(Y != 2 || C != 1) begin
            $fatal(1, "Invalid answer");
        end

        $finish();
    end
    
endmodule
