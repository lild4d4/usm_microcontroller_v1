// 4bitAdd.c
// Description: Add 4 least significant bits of switches to 4 most significant bits of
//              switches and display result on LEDs.

// memory-mapped I/O addresses
#define GPIO_SWs    0x00000004
#define GPIO_LEDs   0x00000008

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  unsigned int switches_value, num1, num2, result;

  while (1) { 

    switches_value = READ_GPIO(GPIO_SWs);   // read value on switches

    num1 = (switches_value & 0xF000) >> 12; // num1 = 4 msbs
    num2 = (switches_value & 0x000F);       // num2 = 4 lsbs
	
    result = num1 + num2;                   // result = num1 + num2

    WRITE_GPIO(GPIO_LEDs, result);          // display sum of num1 and num2 on LEDs
  }

  return(0);
}
