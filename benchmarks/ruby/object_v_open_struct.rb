require "ostruct"
require 'benchmark/ips'

Benchmark.ips do |r|
  r.report("Struct.new ") do
    Struct.new(:name)
  end

  r.report("Object.new ") do
    Object.new
  end

  r.report("OpenStruct.new ") do
    OpenStruct.new(id: 10)
  end
end

__END__

# Ruby 2.0.0-p0

Calculating -------------------------------------
         Struct.new       7341 i/100ms
         Object.new      57600 i/100ms
     OpenStruct.new       5462 i/100ms
-------------------------------------------------
         Struct.new     90353.5 (±10.0%) i/s -     447801 in   5.017170s
         Object.new   2335283.3 (±3.2%) i/s -   11692800 in   5.012149s
     OpenStruct.new     65014.7 (±4.9%) i/s -     327720 in   5.053209s
