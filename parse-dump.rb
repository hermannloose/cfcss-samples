#!/usr/bin/env ruby

branch_instructions = %w{call ret jmp je jne jz jnz}

if ARGV.length >= 2
  disassembled = `objdump -d #{ARGV[0]}`
  if $?.exited? && $?.exitstatus == 0
    disassembled.lines do |line|
      /^\s*([0-9a-f]+):\t(?:[0-9a-f]{2} )+[ ]*\t(\w+)/.match(line) do |matched|
        case ARGV[1]
        when "branches"
          if branch_instructions.include?(matched[2])
            puts matched[1]
          end
        else
          puts matched[1]
        end
      end
    end
  end
end
