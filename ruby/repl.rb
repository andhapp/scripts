repl = -> prompt { print prompt; puts(" => %s" % eval(gets.chomp!)) }
loop { repl[">> "] }
