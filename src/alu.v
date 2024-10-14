module ALU #(parameter bitWidth = 4) (
    input [bitWidth-1:0] A,
    input [bitWidth-1:0] B,
    output [bitWidth-1:0] Y,
    output C
);

    wire [bitWidth:0] answer;

    // この1ステートメントにどれくらいのロジックが詰まっていると思う?
    assign answer = A + B;
    assign Y = answer[bitWidth-1:0];
    assign C = answer[bitWidth];
    
endmodule