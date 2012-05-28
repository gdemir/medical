# encoding: utf-8
class Admin::BloodGroupsController < ApplicationController

  include ApplicationHelper
  before_filter :require_superadmin

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    blood_group = BloodGroup.new({
      :name => params[:name],
    })
    blood_group.save
    flash[:success] = "Kan Grup eklendi"
    redirect_to "/admin/blood_groups/#{blood_group[:id]}"
  end

  def update
    blood_group = BloodGroup.update(params[:id], {
      :name => params[:name],
    })

    if blood_group.save
      flash[:success] = "Kan Grup Güncellenmiştir."
    else
      flash[:error] = "Kan Grup Güncellenemedi."
    end
    redirect_to "/admin/blood_groups/#{blood_group[:id]}"
  end

  def destroy
    if BloodGroup.delete(params[:blood_group_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/blood_groups'
  end
end
