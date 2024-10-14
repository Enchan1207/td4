module ProgramMemory (
    input [3:0] A,
    output [7:0] D
);

    function [7:0] memory;
        input [3:0] n;
        case (n)
            4'h0: memory = 8'b00000000;
            4'h1: memory = 8'b00000000;
            4'h2: memory = 8'b00000000;
            4'h3: memory = 8'b00000000;
            4'h4: memory = 8'b00000000;
            4'h5: memory = 8'b00000000;
            4'h6: memory = 8'b00000000;
            4'h7: memory = 8'b00000000;
            4'h8: memory = 8'b00000000;
            4'h9: memory = 8'b00000000;
            4'ha: memory = 8'b00000000;
            4'hb: memory = 8'b00000000;
            4'hc: memory = 8'b00000000;
            4'hd: memory = 8'b00000000;
            4'he: memory = 8'b00000000;
            4'hf: memory = 8'b00000000;
        endcase
    endfunction

    assign D = memory(A);
    
endmodule
