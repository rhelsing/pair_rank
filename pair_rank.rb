options = ["torrus", "nyx", "othello", "miasma", "prysm", "vantage", "eden", "scion", "praxis", "saturn", "citrus", "vixis", "victra", "convox", "neptune", "arc", "vue", "exo", "zevo", "modo", "elle", "volo", "cirrus", "kiara", "nova", "ohm", "vox", "yuro", "sirocco", "kerala", "atlantis", "solace", "onyx"].shuffle

#use logic, record answers and a > b, b > c, then a > c, transitive property

options_hash = Hash.new(0)

pairs = options.combination(2).to_a.shuffle
auto_lose = []

pairs.each do |pair|
  answer = nil

  i = 1
  pair.each do |x|
    if auto_lose.include?(x)
      answer = 2 if i == 1
      answer = 1 if i == 2
    end
    i += 1
  end

  #choose one, increment hash
  puts "Which would you choose?" if answer == nil
  i = 1
  pair.each do |x|
    puts "#{i}. #{x}" if answer == nil
    i += 1
  end
  while answer == nil
    answer = gets
    answer = answer.chomp
    if answer == "show" && options_hash.values.count > 2
      options_hash = options_hash.sort_by {|k,v| v}.reverse
      options_hash.each do |o|
        puts o.inspect
      end
    end

    answer = nil if "#{answer}" != "1" && "#{answer}" != "2"
    puts "Try again.." if "#{answer}" != "1" && "#{answer}" != "2"
  end
  #interpret answer
  case "#{answer}"
  when "1"
    options_hash["#{pair[0]}"]+=0.1
    options_hash["#{pair[1]}"]-=0.1 if options_hash["#{pair[1]}"] != 0
    auto_lose << pair[1]
    auto_lose.uniq!
  when "2"
    options_hash["#{pair[1]}"]+=0.1
    options_hash["#{pair[0]}"]-=0.1 if options_hash["#{pair[1]}"] != 0
    auto_lose << pair[0]
    auto_lose.uniq!
  end

end

options_hash = options_hash.sort_by {|k,v| v}.reverse
options_hash.each do |o|
  puts o.inspect
end
