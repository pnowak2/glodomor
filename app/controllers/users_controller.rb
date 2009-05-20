class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]
  before_filter :require_user_admin, :only => [:index]
  before_filter :validate_user, :only => [:edit, :update, :destroy]
  
  def validate_user
    user_id = params[:id]
    if(user_id.to_i != current_user.id && !current_user.is_admin?)
      flash[:notice] = "You can't modify not Your profile"
      redirect_to root_path
    end
  end
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].reject{|k,v| k == 'role'})
    if User.count == 0
      @user.role = User.ROLES[:admin]
    end
    
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default user_path(@user)
    else
      render :action => :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def my_profile
    @user = current_user
    render :action => :show
  end
 
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user].reject{|k,v| k == 'role' unless current_user.is_admin? })
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
end
