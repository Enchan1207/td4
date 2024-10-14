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

    function [bitWidth-1:0] select_data;
        input [1:0] n;
        case (n)
            2'd0: select_data = A;
            2'd1: select_data = B;
            2'd2: select_data = C;
            2'd3: select_data = D;
        endcase
    endfunction

    assign Y = select_data(OE);
    
endmodule