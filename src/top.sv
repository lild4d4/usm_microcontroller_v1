`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2022 18:21:46
// Design Name: 
// Module Name: top
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


module top(
    input logic clk, reset,run_cpu,
    input logic rx,
    input logic [7:0] IO_port,
    output logic tx,
    //output logic [6:0] segments,
    //output logic [7:0] anodos,
    output logic [7:0] Leds,
    output logic rx_debug,tx_debug,PB_pressed_pulse,PB_pressed_pulse2,PB_pressed_pulse3,
    output logic [2:0] state
    );
    
    assign rx_debug = rx;
    assign tx_debug = tx;
    
    logic word_end;
    logic cpu_run;
    
    logic io_control;
    logic [31:0] mem_data;
    logic [31:0] switches_data;
    
    logic [31:0] instr,data_in,PC,data_out1,write_direction,extend_data;
    logic [1:0] MemWrite;
    logic [2:0] SizeLoad;
    
    logic div_clk,div_clk1;

    //Clocks
    clock_divider #(163) div(clk,~reset, div_clk);
	clock_divider #(49999) div1(clk, ~reset, div_clk1);
    
    logic cpu_reset;
    
    //comunication controller
    cpu_com_controller com_contr(clk,~reset,rx,PC,tx,cpu_reset,cpu_run,instr,PB_pressed_pulse,PB_pressed_pulse2,PB_pressed_pulse3,state);
    
    //CPU
    cpu_usm_v1 cpu(cpu_run,~reset,instr,data_in,PC,data_out1,write_direction,extend_data,MemWrite,SizeLoad);
    
    //Memorycpu_run
    dmem memoria(cpu_run,MemWrite,SizeLoad,write_direction,data_out1,mem_data);
    
    //switches dir = 4
    IO_driver switchesio(IO_port,write_direction,io_control,switches_data);
    mux2 #(32) iomux(mem_data,switches_data,io_control,data_in);
    
    //LEDs dir = 8
    out_driver leds(clk,~reset,data_out1,write_direction,Leds);
    
endmodule
