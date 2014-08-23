#
# Cookbook Name:: wp-cli
# Library:: helpers
#

module WpCli
  module Helpers
    def args_to_s(args = {})
      args_str = ''
      args.each { |k,v|
        next if v.nil?
        key = "--#{k.to_s.shellescape}" if [String,Symbol].include? k.class
        arg = v.to_s.shellescape unless v === ''
        equal = '=' if key && arg
        args_str +=" #{key}#{equal}#{arg}"
      }
      args_str
    end
  end
end
