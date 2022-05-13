`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2022 20:51:37
// Design Name: 
// Module Name: out_driver
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


module out_driver(
    input logic clk,reset,
    input logic [31:0] bus_in,
    input logic [31:0] adress,
    output logic [15:0] IO_port
    );
    
    logic [15:0] IO_port_prev;
    
    always_ff@(posedge clk) begin
        if(reset) IO_port = 0;
        else IO_port = IO_port_prev;
    end
    
    always_comb begin
        IO_port_prev = IO_port;
        case(adress)
            32'd8: IO_port_prev = bus_in[15:0];
        endcase
    end
    
endmodule
