`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 14.03.2022 18:47:57
// Design Name: 
// Module Name: IO_driver
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


module in_driver(
    input logic [15:0] IO_port,
    input logic [31:0] adress,
    output logic [31:0] bus_out
    );
    
    always_comb begin
        case(adress)
            32'd4: begin
                bus_out = {16'd0,IO_port};
            end
            default bus_out = 32'hz;
        endcase
    end
    
endmodule
