# encoding: utf-8
class Admin::DrugStoragesController < ApplicationController

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
  end

  def update
    drug_storage = DrugStorage.find(params[:id])

    if params[:sequence].to_i < 0
      flash[:error] = "İlaç depo sayısı 0dan küçük olamaz"
    else
      drug_storage[:sequence] = params[:sequence]
      if drug_storage.save
        flash[:success] = "İlaç Deposu Güncellenmiştir."
      else
        flash[:error] = "İlaç Deposu Güncellenemedi."
      end
    end
    redirect_to "/admin/drug_storages/#{drug_storage[:id]}"
  end
end
