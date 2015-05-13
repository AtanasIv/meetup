class UsersController < ApplicationController
     before_action :logged_in_user, only: [:index, :edit, :destroy, :update, :following, :followers]
     before_action :correct_user,   only: [:edit, :update, :destroy  ]
def home
 
end

  def new
    @user = User.new
  end

 def index
    @users = User.paginate(page: params[:page])

  end

def show

  @user = User.find(params[:id])
  @users = User.all
  @meetings = @user.meetings.paginate(page: params[:page])


end


  def edit
    @user = User.find(params[:id])
end

def create 
  @user = User.new(user_params)
  if @user.save
    log_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
  else
 render 'new'
  end
end


  def destroy
 @user = User.find params[:id]
   @user.destroy
   

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end

def update
@user = User.find(params[:id])
if @user.update_attributes(user_params)
  flash[:success] = "Updated successfully"
  redirect_to @user
else 
  render 'edit'
end
end



def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

 def createMeeting
     @user = User.find(params[:id])
  end



   def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end



private 

def user_params
 params.require(:user).permit(:name, :email, :password, :password_confirmation, :created_at)
  end

  

 def correct_user
      @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    end





  end
