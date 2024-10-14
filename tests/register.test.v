`timescale 1us/1ns
`include "register.v"

module register_test ();
    localparam bitWidth = 4;
    
    reg CLK = 0;

    reg CLR = 1;
    reg CS = 1;
    
    reg [bitWidth-1:0] D = 0;
    wire [bitWidth-1:0] Q;
    
    Register #(.bitWidth(bitWidth)) register (.CLK(CLK), .CLR(CLR), .CS(CS), .D(D), .Q(Q));

    initial begin
        $dumpfile("register_test.vcd");
        $dumpvars(0, register_test);

        // レジスタをクリア
        CLR <= 0;
        #1;
        CLR <= 1;

        // CSが立っていなければ値を取り込まない
        D <= 4'hF;
        #1;
        if(Q != 0) begin
            $fatal(1, "Load value when CS is negated");
        end

        // CSをアサートしてクロックを入れると値を取り込む
        CS <= 0;
        #1;
        if(Q != D) begin
            $fatal(1, "Value not changed when CS is asserted");
        end
        CS <= 1;
        #1;

        // CLRをアサートしてクロックを入れると値を初期化する
        CLR <= 0;
        #1;
        if (Q != 0) begin
            $fatal(1, "Value not cleared when CLR is asserted");
        end
        CLR <= 0;
        #1;

        $finish();
    end

    always #0.5 CLK <= ~CLK;
    
endmodule
