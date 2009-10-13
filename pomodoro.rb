#!/usr/bin/env ruby
TIME_INTERVAL_MINUTES = 0.1
TIME_INTERVAL_SECONDS = TIME_INTERVAL_MINUTES * 60
BREAK_INTERVAL_MINUTES = 0.05
BREAK_INTERVAL_SECONDS = BREAK_INTERVAL_MINUTES * 60

break_message = "#{TIME_INTERVAL_MINUTES} Minutes are over! Make a #{BREAK_INTERVAL_MINUTES} minute break!"
restart_message = "Keep working for #{TIME_INTERVAL_MINUTES} minutes!"
break_is_over_message = "Break is over!"

VOICES = {
 "Victoria"   =>"Victoria",
 "Agnes"      =>"Agnes",
 "Junior"     =>"Junior",
 "Zarvox"     =>"Zarvox",
 "Ralph"      =>"Ralph",
 "Princess"   =>"Princess",
 "Good News"  =>"Good News",
 "Boing"      =>"Boing",
 "Vicki"      =>"Vicki",
 "Trinoids"   =>"Trinoids",
 "Hysterical" =>"Hysterical",
 "Fred"       =>"Fred",
 "Bad News"   =>"Bad News",
 "Bells"      =>"Bells",
 "Whisper"    =>"Whisper",
 "Kathy"      =>"Kathy",
 "Pipe Organ" =>"Pipe Organ",
 "Albert"     =>"Albert",
 "Cellos"     =>"Cellos",
 "Bahh"       =>"Bahh",
 "Bruce"      =>"Bruce",
 "Bubbles"    =>"Bubbles",
 "Deranged"   =>"Deranged"
}
voice = VOICES["Vicki"]
break_command = "say -v #{voice} #{break_message}"
restart_command = "say -v #{voice} #{restart_message}"
break_is_over_command = "say -v #{voice} #{break_is_over_message}"

def continue?(question)
  print question
  response = gets
  return case response.chomp.downcase
    when "n"
      false
    when "y"
      true
    else
      continue?(question) 
  end
end

def message_box(message)
  appscript = <<-HEREDOC
  tell app "Finder" to display dialog "#{message}" with title "Pomodoro ticker"  buttons {"OK"}
  HEREDOC

  system("osascript -e '#{appscript}' &> /dev/null")
end

def confirm_dialog(message)
  appscript = <<-HEREDOC
  tell app "Finder" to display dialog "#{message}" with title "Pomodoro ticker"
  HEREDOC
  system("osascript -e '#{appscript}' &> /dev/null")  
end

puts "Staring up pomodoro timer...."
loop {
  puts restart_message
  `#{restart_command}`
  sleep(TIME_INTERVAL_SECONDS)
  puts break_message
  `#{break_command}`
  message_box(break_message)
  sleep(BREAK_INTERVAL_SECONDS)
  puts break_is_over_message
  `#{break_is_over_command}`
  message_box(break_is_over_message)
  break unless confirm_dialog("Continue working ????")
}