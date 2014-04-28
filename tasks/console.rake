desc "Open an irb session preloaded with this library"
task :console do
  sh "pry --gem"
end