require 'sinatra'
enable :sessions

get '/' do
  session[:secret_num] = rand 1..100
  session[:guess_history] = []
  erb :home
end

post '/' do
  @guess = params[:guess].to_i
  session[:guess_history] << @guess
  guess_count = 0
  @guess_count = guess_count
  until guess_count == 7
    break if @guess == session[:secret_num]

    if @guess < (session[:secret_num] - 11)
      puts 'your guess is close but low'
      'Your guess is close but low'
    elsif @guess <= (session[:secret_num] - 10)
      puts ' your guess is to low'
      'Your guess is to low'
    elsif @guess >= (session[:secret_num] + 10)
      puts 'your guess is close but to high'
      'Your guess is close but to high'
    elsif @guess > (session[:secret_num] + 11)
      puts 'your guess is way to high'
      'Your guess is way to high'
    end
    guess_count += 1
  end
  erb :answer if guess_count > 7

  erb :answer if @guess == session[:secret_num]
  erb :home
end
