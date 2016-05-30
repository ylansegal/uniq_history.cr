require "./uniq_history"

puts UniqHistory::Filter.new(ARGF).de_duplicate
