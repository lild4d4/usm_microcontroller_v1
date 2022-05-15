// memory-mapped I/O addresses
#define GPIO_SWs    0x00000004
#define GPIO_LEDs   0x00000008

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

int main ( void )
{
  int switches_value;

  while (1) { 
    switches_value = READ_GPIO(GPIO_SWs);   // read value on switches
    WRITE_GPIO(GPIO_LEDs, switches_value);  // display switch value on LEDs
  }

  return(0);
}

