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
    input logic [15:0] Switches,
    output logic tx,
    output logic [15:0] Leds,
    output logic rx_debug,tx_debug,PB_pressed_pulse,PB_pressed_pulse2,PB_pressed_pulse3,
    output logic [2:0] state
    );
    
    //Clocks
    logic div_clk;
    //logic div_clk1;
    
    clock_divider #(163) div(clk,~reset, div_clk);          //UART Clock, set 163 for 9600 bauds or set 13 for 115200 bauds
	//clock_divider #(49999) div1(clk, ~reset, div_clk1);   //7 segments display clock (only used for debug)
    
    //UART/Debug signals
    assign rx_debug = rx;
    assign tx_debug = tx;
    logic word_end;
    logic cpu_run;
    
    //CPU signals
    logic [31:0] instr,PC,data_out1,write_direction,data_in;
    logic [1:0] MemWrite;
    logic [2:0] SizeLoad;
    logic cpu_reset;
    
    //UART comunication controller and debugger
    cpu_com_controller com_contr(clk,~reset,rx,PC,tx,cpu_reset,cpu_run,instr,PB_pressed_pulse,PB_pressed_pulse2,PB_pressed_pulse3,state);
    
    //CPU
    cpu_usm_v1 cpu(cpu_run,~reset,instr,data_in,PC,data_out1,write_direction,MemWrite,SizeLoad);
    
    //Memorycpu_run
    dmem memoria(cpu_run,MemWrite,SizeLoad,write_direction,data_out1,data_in);
    
    //switches dir = 4 <- this is just for test, should be at the end of the memory
    in_driver switchesio(Switches,write_direction,data_in);
    
    //LEDs dir = 8 <- this is just for test, should be at the end of the memory
    out_driver leds(clk,~reset,data_out1,write_direction,Leds);
    
endmodule
