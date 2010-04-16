/*probe description*/
syscall:::entry
{
   /* action statements */
   @[execname] = count(); 
}