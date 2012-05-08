# encoding: utf-8
class Admin::AdminsController < ApplicationController

  include ApplicationHelper
  include ImageHelper
  before_filter :require_admin

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    image = params[:image]
    admin = Admin.new({
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :password => params[:password],
      :status => params[:status],
    })

    flash[:success] = "Admin eklendi" if admin.save

    if image and response = Image.upload('admins', admin[:id].to_s, image, false) # üzerine yazma olmasın
      if response[0] # bu yanıt iyi mi kötü mü
        admin[:image_url] = response[1]
        admin.save
      else
        flash[:error] = response[1]
      end
    end

    redirect_to "/admin/admins/#{admin.id}"
  end

  def update
    image = params[:image]

    admin = Admin.update(params[:id], {
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :password => params[:password],
      :status => params[:status],
    })

    if admin.save
      flash[:success] = "Admin Güncellenmiştir"
    else
      flash[:error] = "Admin Güncellenemedi"
    end

    if image and response = Image.upload('admins', admin[:id].to_s, image, true)
      if response[0] # bu yanıt iyi mi kötü mü
        admin[:image_url] = response[1]
        admin.save
      else
        flash[:error] = response[1]
      end
    end

    redirect_to "/admin/admins/#{admin.id}"
  end

  def destroy
    admin = Admin.find(params[:admin_id])
    Image.delete(admin[:image_url])
    if admin.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end

    redirect_to '/admin/admins'
  end
end
