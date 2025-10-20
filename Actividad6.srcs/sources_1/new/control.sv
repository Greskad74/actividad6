`timescale 1ns / 1ps

module control(
    input  logic clk, reset, start,
    input  logic [7:0] xin, yin,
    output logic [7:0] gcd
);
    logic [7:0] xreg, yreg;

    typedef enum logic [2:0] {q0, q1, q2, q3, q4, q5, q6} state_type;
    /// q0 start, q1 input, q2 test1, q3 test2, q4 y = y -x, q5 x = x - y, q6 done
    state_type now, next;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            now <= q0;
        else
            now <= next;
    end

    always_comb begin
        next = now;
        case (now)
            q0: if (start) next = q1;
            q1: if (1) next = q2;
            q2: if (xreg == yreg) next = q6;
                else if (xreg < yreg) next = q4;
                else next = q5;
            q4: if (1) next = q2;
            q5: if (1) next = q2;
            q6: next = q6; 
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            xreg <= 0;
            yreg <= 0;
            gcd  <= 0;
        end else begin
            case (now)
                q1: begin
                    xreg <= xin;
                    yreg <= yin;
                end
                q4: yreg <= yreg - xreg;
                q5: xreg <= xreg - yreg;
                q6: gcd  <= xreg;
            endcase
        end
    end
endmodule
