$root_dir = File.dirname(__FILE__)
$included_paths = {}

def parse_sass_file(path)
  File.readlines(path).each do |line|
    unless line =~ /require '.*?'/
      puts line
      next
    end

    file = /require '(.*?)'/.match(line)[1] + ".rb"
      
    unless $included_paths[file]
      $included_paths[file] = true
      STDERR.puts file

      if line =~ /sass/
        parse_sass_file(File.join($root_dir, file))
        next
      end

      puts line
    end
  end
end

parse_sass_file('./sass.rb')
