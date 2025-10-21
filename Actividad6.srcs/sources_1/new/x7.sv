`timescale 1ns / 1ps

module x7(
    input logic clk, reset, start,
    input logic [7:0] x, y,           
    input logic [7:0] gcd_result,    
    output logic [3:0] an,
    output logic [6:0] sseg
);
    localparam N = 18;
    
    logic [N-1:0] q_reg, q_next;
    logic [3:0] hex_in;
    logic [3:0] hex3, hex2, hex1, hex0;
    logic  display_mode;
    logic start_edge;  

    edge_detect_mealy detector (.clk(clk),   .reset(reset),.level(start), .tick(start_edge)  );

    always_ff @(posedge clk, posedge reset)
        if (reset)
            display_mode <= 1'b0; 
        else if (start_edge)
            display_mode <= 1'b1;  

    always_ff @(posedge clk, posedge reset)
        if (reset)
            q_reg <= 0;
        else 
            q_reg <= q_next;
    
    assign q_next = q_reg + 1;
    
    always_comb begin
        if (display_mode) begin  
            hex1 = gcd_result[7:4];
            hex0 = gcd_result[3:0];
            hex3 = 4'b0000; 
            hex2 = 4'b0000; 
        end else begin  
            hex1 = x[7:4];     
            hex0 = x[3:0];     
            hex3 = y[7:4];     
            hex2 = y[3:0];     
        end
    end
    
    
    always_comb
        case (q_reg[N-1:N-2])
            2'b00:
                begin
                    an = 4'b1110;
                    hex_in = hex0;
                end
            2'b01:
                begin
                    an = 4'b1101;
                    hex_in = hex1;
                end
            2'b10:
                begin
                    an = 4'b1011;
                    hex_in = hex2;
                end
            default:
                begin
                    an = 4'b0111;
                    hex_in = hex3;
                end
        endcase
    
    always_comb begin
        case(hex_in)
            4'h0: sseg[6:0] = 7'b1000000;  
            4'h1: sseg[6:0] = 7'b1111001;  
            4'h2: sseg[6:0] = 7'b0100100;  
            4'h3: sseg[6:0] = 7'b0110000;  
            4'h4: sseg[6:0] = 7'b0011001;  
            4'h5: sseg[6:0] = 7'b0010010;  
            4'h6: sseg[6:0] = 7'b0000010;  
            4'h7: sseg[6:0] = 7'b1111000;  
            4'h8: sseg[6:0] = 7'b0000000;  
            4'h9: sseg[6:0] = 7'b0010000;  
            4'ha: sseg[6:0] = 7'b0001000;  
            4'hb: sseg[6:0] = 7'b0000011;  
            4'hc: sseg[6:0] = 7'b1000110;  
            4'hd: sseg[6:0] = 7'b0100001;  
            4'he: sseg[6:0] = 7'b0000110;  
            default: sseg[6:0] = 7'b0001110; 
        endcase
    end
endmodule