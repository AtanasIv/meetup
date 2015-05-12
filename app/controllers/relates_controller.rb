class RelatesController < ApplicationController

	 def create
  
     @meeting = Meeting.find(params[:relate][:followed_id])
   current_user.follow!(@meeting)
    redirect_to @meeting

   

  end

  def destroy
    @meeting = Relate.find(params[:id]).followed
    current_user.unfollow!(@meeting)
     respond_to do |format|
      format.html { redirect_to @meeting }
      format.js
    end
  end
end
