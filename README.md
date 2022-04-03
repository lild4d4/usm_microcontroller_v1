# usm_microcontroller_v1
 
This is a soft-microcontroller with the RISCV [cpu_usm_v1](https://github.com/lild4d4/cpu_usm_v1) on it, this version has only 16 I/O ports, 8 Inputs and 8 Outputs in the directions 0x4 and 0x8 respectively.

To debug use the [Serial Debuger](https://github.com/jcontrerasf/serial_debbuger) made by [Julio Contreras](https://github.com/jcontrerasf)

## Directory Structure

    ├── Diagrams                       #Microcontroller diagrams and conections
    ├── Hex_programs                   #Program´s dir
    │   └── General_Diagram           
    └── src                            #src root dir
        ├── IO_drivers                 #Input and Ouput controller
        ├── Memory                     #main memory
        ├── cpu_usm_v1                 #RISCV-cpu
        ├── dbg                        #debug controller
        ├── nexys4ddr_constraints      
        └── top.sv                     #microcontroller top module

![soft_microcontroller_diagram](https://user-images.githubusercontent.com/64666124/161451944-779f86ed-0c1e-43e7-aa9b-19af7270d080.png)
