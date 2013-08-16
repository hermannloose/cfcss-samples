#!/usr/bin/env ruby

require 'optparse'

categories = {
  :branches => %w{call ret jmp je jne jz jnz}
}

options = {
  :instructions => []
}

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: parse-dump [options] file"

  opts.on("--instructions call,ret,xor,...", Array,
      "Instruction mnemonics to return addresses for") do |list|

    options[:instructions] = list
  end

  opts.on("--category CATEGORY", [:all, :branches],
      "Select instruction category to return addresses for (all, branches)") do |category|

    options[:category] = category
  end
end

opt_parser.parse!(ARGV)

disassembled = `objdump -d #{ARGV[0]}`
if $?.exited? && $?.exitstatus == 0
  disassembled.lines do |line|
    /^\s*([0-9a-f]+):\t(?:[0-9a-f]{2} )+[ ]*\t(\w+)/.match(line) do |matched|
      if options[:category] === :all
        puts matched[1]
        next
      end

      if instructions = categories[options[:category]]
        if instructions.include? matched[2]
          puts matched[1]
          next
        end
      end

      if options[:instructions].include? matched[2]
        puts matched[1]
        next
      end
    end
  end
end
