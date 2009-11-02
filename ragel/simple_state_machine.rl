%%{
	machine hello;
	expr = 'h';
	main := expr* @ { puts "hello world !" };
	write data;
	
}%%

def run_machine(data)
	data = data.unpack("c*") if data.is_a?(String)
	puts "Running the state machine with input #{data}..."

	%% write init;
	%% write exec;	

	puts "Finished. The state of the machine is: #{cs}"
	puts "p: #{p} pe: #{pe}"
end