`timescale 1ns / 1ps

module tb_control;

    logic clk, reset, start;
    logic [7:0] xin, yin;
    logic [7:0] gcd;

    control uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .xin(xin),
        .yin(yin),
        .gcd(gcd)
    );

   
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        xin = 0;
        yin = 0;
        #20;

        reset = 0;
        #20;

        xin = 8'h4;
        yin = 8'hFF;
        start = 1;
        #10;
        start = 0;

        repeat(400) @(posedge clk);

      

        reset = 1; #20; reset = 0; #20;
        xin = 8'hAA;
        yin = 8'hA;
        start = 1;
        #10;
        start = 0;
        repeat(400) @(posedge clk);
      

        reset = 1; #20; reset = 0; #20;
        xin = 8'hF;
        yin = 8'h3;
        start = 1;
        #10;
        start = 0;
        repeat(400) @(posedge clk);
     
    end
endmodule
