`timescale 1us/1ns
`include "counter.v"

module CounterTest ();
    reg CLK = 0;
    reg CLR = 1;
    wire [3:0] Q;
    
    Counter counter(.CLK(CLK), .CLR(CLR), .Q(Q));

    initial begin
        $dumpfile("counter_test.vcd");
        $dumpvars(0, CounterTest);

        CLR <= 0;
        #1;
        
        $display("Time: %0t, CLR: %b, Q: %X", $time, CLR, Q);

        CLR <= 1;
        #10;
        $display("Time: %0t, CLR: %b, Q: %X", $time, CLR, Q);

        #10;
        $display("Time: %0t, CLR: %b, Q: %X", $time, CLR, Q);

        CLR <= 0;
        #1;
        $display("Time: %0t, CLR: %b, Q: %X", $time, CLR, Q);

        CLR <= 1;
        #10;
        $display("Time: %0t, CLR: %b, Q: %X", $time, CLR, Q);

        CLR <= 0;
        #1;
        if (Q != 0) begin
            $fatal(1);
        end

        $finish();
    end

    always #0.5 CLK <= ~CLK;
    
endmodule
