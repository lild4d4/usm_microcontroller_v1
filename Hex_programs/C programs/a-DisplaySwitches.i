# 0 "DisplaySwitches.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "DisplaySwitches.c"







int main ( void )
{
  int En_Value=0xFFFF, switches_value;

  while (1) {
    switches_value = (*(volatile unsigned *)0x00000004);
    switches_value = switches_value >> 16;
    { (*(volatile unsigned *)0x00000008) = (switches_value); };
  }

  return(0);
}
