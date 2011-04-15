ruby << EOF
  path = VIM.evaluate %{expand("<sfile>")}
  dir  = File.dirname(path)
  $LOAD_PATH << File.expand_path("../lib", dir)
  require 'reruby/method_extractor'
EOF

function! ExtractMethod(method_name) range
ruby << EOF
  method_extractor = Reruby::MethodExtractor.new(VIM::Buffer.current)
  line_range  = VIM.evaluate("a:firstline")..VIM.evaluate("a:lastline")
  method_name = VIM.evaluate("a:method_name")
  method_extractor.extract_method(line_range, method_name)
EOF
endfunction

command! -range -nargs=1 ExtractMethod :<line1>,<line2>call ExtractMethod(<f-args>)
