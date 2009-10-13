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
VOICE = VOICES["Vicki"]

def say(message)
  `say -v #{VOICE} #{message}`
end

def show_dialog(message, buttons = [])
  appscript = "tell app \"Finder\" to display dialog \"#{message}\" with title \"Pomodoro ticker\""
  if buttons.any?
    appscript += " buttons {#{buttons.map{|button| "\"#{button}\""}.join(",")}}"
  end
  system("osascript -e '#{appscript}' &> /dev/null")
end

def message_box(message)
  show_dialog(message,["OK"])
end

def confirm_dialog(message)
  show_dialog(message)
end

def display_message(message)
  puts message
  say(message)
  message_box(message)
end

puts "Staring up pomodoro timer...."
loop {
  puts restart_message
  say(restart_message)
  sleep(TIME_INTERVAL_SECONDS)
  display_message(break_message)
  sleep(BREAK_INTERVAL_SECONDS)
  display_message(break_is_over_message)
  break unless confirm_dialog("Continue working ????")
}