`timescale 1us/1ns
`include "program_counter.v"

module program_counter_test ();
    localparam bitWidth = 4;
    
    reg CLK = 0;

    reg CLR = 1;
    reg CS = 1;
    
    reg [bitWidth-1:0] D = 0;
    wire [bitWidth-1:0] Q;
    
    ProgramCounter #(.N(bitWidth)) progcnt (.CLK(CLK), .CLR(CLR), .CS(CS), .D(D), .Q(Q));

    initial begin
        $dumpfile("program_counter_test.vcd");
        $dumpvars(0, program_counter_test);

        // CSがアサートされていなければカウントアップする
        CS <= 1;
        #10;
        if(Q != 10) begin
            $fatal(1, "Invalid count value");
        end

        // CSをアサートしてクロックを入れると値を取り込む
        CS <= 0;
        D <= 4'h4;
        #1;
        if(Q != 4) begin
            $fatal(1, "Invalid data input");
        end

        // 再びCSをネゲートしてカウントアップ
        CS <= 1;
        #10;
        if(Q != 14) begin
            $fatal(1, "Invalid count value");
        end

        $finish();
    end

    always #0.5 CLK <= ~CLK;

endmodule
