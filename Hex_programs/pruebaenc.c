// DisplayInverse.c
// Description: display the inverted value of the switches on the LEDs

// memory-mapped I/O addresses
#define GPIO_SWs    0xd0000004
#define GPIO_LEDs   0xd0000008

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int switches_value;

  while (1) { 
    switches_value = READ_GPIO(GPIO_SWs);
    WRITE_GPIO(GPIO_LEDs, switches_value);
  }

  return(0);
}
