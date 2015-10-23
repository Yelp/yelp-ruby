desc "Open a pry session preloaded with this library"
task :console do
  sh "pry --gem"
end
