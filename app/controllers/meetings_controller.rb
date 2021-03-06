class MeetingsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :createMeeting, :following]
  before_action :correct_user,   only: :destroy



    
      def index
     @user = User.all
      @meetings = @user.find(params[:user_id])
  
  

    end

  def show
      
        @meetings = Meeting.find(params[:id])
        if  @meetings.destroy
             flash[:success] = "Meeting deleted"
        end
     
   redirect_to  current_user

    @users = current_user.following.paginate(page: params[:page])
end
  

def new 
  @meetings = Meeting.new
end

  def create
    
   @meetings = current_user.meetings.build(meeting_params)
   if @meetings.save
     flash[:success] = "Meeting created!"
     redirect_to @current_user


    else
 
   render 'index'
    end
  end 
 

def thePicture
  @picture = Meeting.find(params[:picture])
  @thePicture = @picture.resize('big.jpg', 'small.jpg', 300, 300)
end


 def createMeeting 
@user = User.find(session[:user_id])
  @meetingss = @user.meetings

end






def allMeetings
 @meetings = Meeting.all

end


def otherUserMeeting

@meetings = Meeting.all
end


  def destroy
    @meetings.destroy
    flash[:success] = "Meeting deleted"
   redirect_to  'static_pages#home'
  end


 def following
    @title = "Following"

    @meeting = Meeting.find(params[:id])
 
    @users = @meeting.user_followers.paginate(page: params[:page])
    render 'show_follow'
  end



  

  private

    def meeting_params
      params.require(:meeting).permit(:content, :place, :thedate, :picture, :user_id)
    end

 def correct_user
      @meetings = current_user.meetings.find_by(id: params[:id])
  
    end

end