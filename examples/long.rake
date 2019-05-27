require 'doomfire'

desc 'some long running task'
task :long do
  fire = Doomfire::Terminal.new
  fire.run

  elapsed = 0
  5.times do
    elapsed += 1
    sleep 1
  end

  fire.stop
  puts "The long running task ran #{elapsed} loops."
end
