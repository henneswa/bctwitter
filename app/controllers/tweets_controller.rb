class TweetsController < ApplicationController
	before_action :authenticate_user!
	
	def new 
		@tweet = Tweet.new
		#the Tweet with uppercase refers to the model 
		@tweets = current_user.tweets 
	end

	def create

		@tweet = Tweet.new(tweet_params)
		#@tweet=Tweet.create(tweet_params)
		@tweet.user=current_user 
		@tweets = current_user.tweets 

		if @tweet.save
			flash.now[:success]= "Tweet Created"
			redirect_to new_tweet_path
		else 
			flash.now[:danger]= "No luck"
			render 'new'
		end 	
	end

	def index 
		@tweets = Tweet.all.reject{ |tweet| tweet.user == current_user }
		@relationship= Relationship.new 
	end 	

	private 

	def tweet_params
		params.require(:tweet).permit(:content)
	end	

end
