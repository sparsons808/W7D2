class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :ensure_logged_in, only: [:index, :show]
  before_action :ensure_logged_out, only: [:new, :create]
 # GET /users or /users.json
  def index
    @users = User.all

    render :index
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])

    render :show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    render :edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    
      if @user.save
        login(@user)
        redirect_to user_url(@user)
      else
        flash.now[:errors] = @user.errors.full_messages

        render :new
      end
    
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email)
    end
end
