`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2022 01:04:30 PM
// Design Name: 
// Module Name: cpu_com_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_com_controller(
    input logic clk,reset,rx,
    input logic [31:0] pc,
    output logic tx,cpu_reset,cpu_run,
    output logic [31:0] uart_data
    );
    
    localparam IDLE = 0;
    localparam WAIT_CMD = 1;
    localparam RESET_CPU = 2;
    localparam SEND_PC = 3;
    localparam RUN_CPU = 4;
    
    logic [2:0] state, next_state;
    
    always_ff@(posedge clk) begin
        if(reset) state <= IDLE;
        else state <= next_state;
    end
    
    logic cmd_redy;
    logic cpu_redy;
    logic send_pc;
    logic div_clk;
    
    clock_divider #(163) div(clk,reset, div_clk);
    
    word_32_bit_uart_rx uart_rx(div_clk,reset,rx,uart_data,cmd_redy);
    word_32bit_uart_tx uart_send_redy(div_clk,reset,cpu_redy,32'd3,tx); //juntar ambos send en uno solo con un multiplexor dentro
    word_32bit_uart_tx uart_tx(div_clk,reset,send_pc,pc,tx);
    
    always_comb begin
        next_state = state;
        cpu_redy = 0;
        cpu_reset = 0;
        cpu_run = 0;
        send_pc = 0;
        case(state)
            IDLE: begin
                if(cmd_redy & uart_data == 1) begin
                    next_state = RESET_CPU; 
                end
            end
            WAIT_CMD: begin
                cpu_redy = 1;
                if(cmd_redy & uart_data == 2) begin
                    next_state = SEND_PC;
                end
            end
            RESET_CPU: begin
                cpu_reset = 1;
                next_state = WAIT_CMD;
            end
            SEND_PC: begin
                send_pc = 1;
                if(cmd_redy) begin
                    next_state = RUN_CPU;
                end
            end
            RUN_CPU: begin
                cpu_run = 1;
                next_state = WAIT_CMD;
            end
        endcase
    end
    
endmodule