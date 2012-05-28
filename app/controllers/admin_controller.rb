# encoding: utf-8
require 'prawn' # http://cracklabs.com/prawnto # pdf

class AdminController < ApplicationController

  include ApplicationHelper
  include ImageHelper
  before_filter :require_admin, :except => [:login, :sign_in, :logout]

  def login
    redirect_to '/admin' if session[:admin]
  end

  def sign_in
    if session[:admin] = Admin.find_by_first_name_and_password(params[:first_name], params[:password])
      session[:superadmin] = true if session[:admin][:status] == 1
      flash[:success] = "Yönetici paneline hoşgeldiniz"
      redirect_to '/admin/index'
    else
      if params[:first_name] or params[:password]
        flash[:error] = "Oops! İsminiz veya şifreniz hatalı, belkide bunlardan sadece biri hatalıdır?"
      end
      redirect_to '/admin/login'
    end
  end

  def logout
    reset_session
    session[:admin] = nil
    redirect_to '/admin/login'
  end

  def approval
    if session[:admin][:password] == params[:password]
      render params[:path]
    end
  end

  def profile_update
    image = params[:image]
    admin = Admin.update(session[:admin][:id], {
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :password => params[:password],
    })

    if admin.save
      if image and response = Image.upload('admins', admin[:id].to_s, image, true)
        if response[0]
          admin[:image_url] = response[1]
          admin.save
        else
          flash[:error] = response[1]
        end
      end
      session[:admin] = admin
      flash[:success] = "Bilgileriniz Güncellenmiştir."
    else
      flash[:error] = "Bilgileriniz Güncellenemedi."
    end
    redirect_to '/admin/profile'
  end
end

