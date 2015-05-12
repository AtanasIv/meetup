class RelatesController < ApplicationController

	 def create
  
     @meeting = Meeting.find(params[:relate][:followed_id])
   current_user.follow!(@meeting)
    redirect_to allMeetings_path

   

  end

  def destroy
    @meeting = Relate.find(params[:id]).followed
    current_user.unfollow!(@meeting)
   
   redirect_to allMeetings_path
  end
end
