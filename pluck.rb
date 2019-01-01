require 'optparse'

options = Struct.new(:in_filename, :out_filename, :map_filename).new

OptionParser.new do |opts|
  opts.banner = "Usage: pluck -i SAVFILENAME -o DSTFILENAME -m MAPFILENAME"

  opts.on("-i NAME", "--input-file=NAME", ".SAV file to pluck block from") do |v|
    options.in_filename = v
  end

  opts.on("-o NAME", "--output-file=NAME", "file name to put plucked block to") do |v|
    options.out_filename = v
  end

  opts.on("-m NAME", "--map-file=NAME", ".MAP file name") do |v|
    options.map_filename = v
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

sav = File.binread(options.in_filename)
bottom_addr = sav[040, 2].unpack('v')[0]
top_addr    = sav[050, 2].unpack('v')[0]
size = File.binwrite(options.out_filename, sav[bottom_addr..(top_addr+1)])
puts "Plucked block size #{size} bytes."

str = ''
symbols_line = false
File.read(options.map_filename).each_line do |line|
  symbols_line = false if /Transfer address/ === line
  str << line if symbols_line
  symbols_line = true if /ABS\./ === line
end

symbols = str.scan(/[\w\.]{1,6}\t\d{6}/)

macro_map_file_name = "#{options.in_filename[/.+(?=.sav)/i]}.MM"

File.open(macro_map_file_name, 'w') do |f|
  f.puts('; vim: set fileformat=dos filetype=asmpdp11 tabstop=8 expandtab shiftwidth=4 autoindent :')
  f.puts('        .RADIX 8')
  symbols.each do |pair|
    symbol, address = pair.split("\t")
    f.puts "#{symbol} =: #{address}"
  end
end

puts File.read(macro_map_file_name)

