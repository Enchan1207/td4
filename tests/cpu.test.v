`timescale 1us/1ns
`include "cpu.v"
`include "progmem.v"

module cpu_test ();
    reg CLK = 0;
    reg CLR = 1;

    wire [3:0] address;
    wire [7:0] data;
    
    TD4 cpu (.CLK(CLK), .CLR(CLR), .A(address), .D(data));

    ProgramMemory progmem(.A(address), .D(data));

    initial begin
        $dumpfile("cpu_test.vcd");
        $dumpvars(0, cpu_test);

        #1;

        $finish();
    end

    always #0.5 CLK <= ~CLK;

endmodule
