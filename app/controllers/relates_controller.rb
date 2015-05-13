class RelatesController < ApplicationController

	def create
@meeting = Meeting.find(params[:relate][:followed_id])
current_user.follows!(@meeting)
redirect_to allMeetings_path
	end
	def destroy
@meeting = Relate.find(params[:id]).followed
current_user.unfollows!(@meeting)
redirect_to allMeetings_path
	end
end
