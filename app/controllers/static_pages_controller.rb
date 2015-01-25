class StaticPagesController < ApplicationController
	def index 
		if user_signed_in?
				if current_user.profile 
					#do something
					redirect_to tweets_path
				else 
					flash[:sucess]= "Create a profile below" #this is built to survive the redirect
					redirect_to new_profile_path
			end 
		else 
			#do something else (but just want to go to normal page so we don't need to put anything in here)
		end 
	end 	
end
