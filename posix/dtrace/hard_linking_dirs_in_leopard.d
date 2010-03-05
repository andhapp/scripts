syscall:::entry
/pid == $target/
{}

/*Should be run like this - sudo dtrace -s hard_linking_dirs_in_leopard.d -c "ln Dir1 Dir2" */