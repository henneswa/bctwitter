class Tweet < ActiveRecord::Base
	include Twitter::Extractor 

	belongs_to :user 
	validates :content, length: { maximum: 140 }

	def extract_hash_tags
		extract_hashtags(self.content)
	end 

	validate :hashtags_created

	def hashtags_created
		begin	
			transactions do 
				@hashtags= self.extract_hash_tags
				puts "************************************"
				puts "************************************"
				@hashtags.each do |the_hashtag|
					if Hashtag.where(tag: the_hashtag).any?
					#do nothing 
					else
						if Hashtag.create!(tag: the_hashtag)
						#do nothing 
						else 
							self.errors.add(:tweet, "The Hashtag is Invalid")
						end
					end 
				end 
			end 
		rescue
			self.errors.add(:tweet, "The Hashtag(s) are invalid")
		end
	end 
end
