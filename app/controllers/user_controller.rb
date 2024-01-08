class UserController < ApplicationController

  def login
    render 'login'
  end

  def signup
    @user = User.new
    render 'signup'
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]

    @user = User.new(name: name, email: email, password: password)

    if @user.save
      redirect_to login_path, notice: "User was successfully registered"
    else
      flash.now[:alert] = @user.errors.full_messages
      render 'signup'
    end
  end

  def profile
    render 'profile'
  end

  def update
    @user = User.find_by(email: params[:email])
    @user.name = params[:name]
    @user.password = params[:password]

    if @user.save
      redirect_to :profile, notice: "User updated successfully"
    else
      render 'profile'
    end
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user != nil && BCrypt::Password.new(@user.password_digest) == params[:password]
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = ["Invalid email or password"]
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  def password_reset_new
    render 'password_mailer/new'
  end

  def password_reset_create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password"
  end

  def password_reset_edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    render "password_mailer/edit"
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, notice: "Your token has expired, Please try again"
  end

  def password_reset_update
    @user = User.find_signed(params[:token], purpose: "password_reset")

    if @user.update(password: params[:password])
      redirect_to login_path, notice: "Your password has been changed"
    else
      redirect_to root_path
    end
  end


end
