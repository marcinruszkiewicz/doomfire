require 'doomfire'

desc 'some long running task'
task :long do
  fire = Doomfire::Spinner.new
  fire.run

  5.times do
    sleep 1
  end

  fire.stop
end
