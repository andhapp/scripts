#!/usr/bin/env ruby

require 'diff/lcs'
require 'diff/lcs/string'

class CustomDiff #:nodoc:
  attr_accessor :output

  def initialize(output)
    @output = output
  end

    # This will be called with both lines are the same
  def match(event)
    @output << %Q|<pre class="match">#{event.old_element}</pre>\n|
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @output << %Q|<pre class="only_a"> - #{event.old_element}</pre>\n|
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @output << %Q|<pre class="only_b"> + #{event.new_element}</pre>\n|
  end
end

if ARGV.size != 2
  puts "usage: #{File.basename($0)} old new > output.html"
  exit 255
end

cd = CustomDiff.new($stdout)

preprocess = lambda { |line| line.chomp }

a = IO.readlines(ARGV[0]).map(&preprocess)
b = IO.readlines(ARGV[1]).map(&preprocess)

$stdout.write <<-START
<html>
  <head>
    <title>diff #{ARGV[0]} #{ARGV[1]}</title>
    <style>
  body { 
    margin: 0; 
    font: 12px Verdana;
  }
  .diff {
    border: 1px solid black;
    margin: 1em 2em;
  }
  pre {
    padding-left: 1em;
    margin: 0;
    font-family: Lucida, Courier, monospaced;
		white-space: pre;
  }
  
  .match { }
  .only_a {
    background-color: #fdd;
  }
  .only_b {
    background-color: #ddf;
    border-left: 3px solid blue
  }
  h1 { margin-left: 2em; }
    </style>
  </head>
  <body>
    <h1>diff&nbsp;
        <span class="only_a">#{ARGV[0]}</span>&nbsp;
        <span class="only_b">#{ARGV[1]}</span>
    </h1>
    <div class="diff">
START

Diff::LCS.traverse_sequences(a, b, cd)

$stdout.write <<-END
    </div>
  </body>
</html>
END
