syscall::open*:entry
{
   @[copyinstr(arg0)] = count();
}

/* To run this do: sudo dtrace -s <filename>*/