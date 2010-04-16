/* The format of the probe is- provider:module:function:name */
syscall::open*:entry
{
   printf("%s %s", execname, copyinstr(arg0));
}