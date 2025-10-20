module contador(
    input  logic clk, 
    input  logic reset,
    output logic [7:0] count_out
);

    always_ff @(posedge clk or posedge reset) 
        if (reset)
            count_out <= 0;
        else 
            count_out <= count_out + 1;

endmodule