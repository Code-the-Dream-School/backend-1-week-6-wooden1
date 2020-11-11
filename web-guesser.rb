require 'sinatra'
enable :sessions

get '/' do
  erb :home
end

def random_secret_num
  session[:secret_num] = rand 1..100
  session[:guess_history] = []
  guess_count = 0
  @secret_num = session[:secret_num]
  @guess_history = session[:guess_history]
  @guess = params[:guess].to_i
  puts @secret_num

  while guess_count <= 7
    break if @guess == @secret_num

    if @guess < (@secret_num - 11)
      'Your guess is close but low'
    elsif @guess <= (@secret_num - 10)
      'Your guess is to low'
    elsif @guess >= (@secret_num + 10)
      'Your guess is close but to high'
    elsif @guess > (@secret_num + 11)
      'Your guess is way to high'
    end
    guess_count += 1
  end
  @guess_history << @guess

  if @guess == @secret_num
    puts "Winning number is: #{@guess}"
    "Winning number is: #{@guess}"
  elsif guess_count == 7
    puts "You lose! Secret Number: #{@secret_num} Guess History: #{
           @guess_history
         }"
    'You lost!'
  end
end
post '/' do
  random_secret_num
  erb :home
end
