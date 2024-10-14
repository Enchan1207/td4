module DataSelector #(
    parameter bitWidth = 4
) (
    input [bitWidth-1:0] A,
    input [bitWidth-1:0] B,
    input [bitWidth-1:0] C,
    input [bitWidth-1:0] D,
    input [1:0] OE,
    output [bitWidth-1:0] Y
);

    function [bitWidth-1:0] sel;
        input [bitWidth-1:0] A, B, C, D;
        input [1:0] n;
        case (n)
            2'd0: sel = A;
            2'd1: sel = B;
            2'd2: sel = C;
            2'd3: sel = D;
        endcase
    endfunction

    assign Y = sel(A, B, C, D, OE);

endmodule
