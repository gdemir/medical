# encoding: utf-8
class Admin::DrugsController < ApplicationController

  include ApplicationHelper
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
    if params[:expiry_date].to_date < Date.today
      flash[:error] = "İlacın son kullanma tarihi bugünden önce olamaz"
      return redirect_to "/admin/drugs/new"
    else
      drug = Drug.new({
        :name => params[:name],
        :expiry_date => params[:expiry_date],
        :content => params[:content],
        :price => params[:price],
      })
      drug.save
    

      # ilaç için bir depo açalım
      drug_storage = DrugStorage.new({
        :drug_id => drug[:id],
        :sequence => 0,
      })
      drug_storage.save

      flash[:success] = "İlaç eklendi"
    end
    redirect_to "/admin/drugs/#{drug[:id]}"
  end

  def update
    drug = Drug.update(params[:id], {
      :name => params[:name],
      :expiry_date => params[:expiry_date],
      :content => params[:content],
      :price => params[:price],
    })

    if drug.save
      flash[:success] = "İlaç Güncellenmiştir."
    else
      flash[:error] = "İlaç Güncellenemedi."
    end
    redirect_to "/admin/drugs/#{drug[:id]}"
  end

  def destroy
    if Drug.delete(params[:drug_id]) and DrugStorage.delete_all(:drug_id => params[:drug_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/drugs'
  end
end
