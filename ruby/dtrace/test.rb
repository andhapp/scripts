Object.new

__END__

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*:::method-entry { printf("-> %s::%s (%s:%d)\n", copyinstr(arg0), copyinstr(arg1), copyinstr(arg2), arg3); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::cmethod-entry { @[copyinstr(arg2)] = count(); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::cmethod-entry { @[copyinstr(arg0)] = count(); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::cmethod-entry { @[copyinstr(arg1)] = count(); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::method-entry { @[copyinstr(arg0), copyinstr(arg1)] = count(); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::method-entry { @[copyinstr(arg1)] = count(); }'

sudo dtrace -c 'ruby test.rb' -Zn 'ruby*::require-entry { @[copyinstr(arg1), arg3] = count(); }'

sudo dtrace -Zn 'ruby*::method-entry { @[copyinstr(arg0)] = count(); }'
