# encoding: utf-8
class Admin::DrugUsesController < ApplicationController

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
    if drug_use = DrugUse.find_by_consult_id_and_drug_id(params[:consult_id], params[:drug_id])
      flash[:error] = "İstek Listesinde Bu İlaç Var"
    else
      # depo sayısını azalt
      drug_storage = DrugStorage.find_by_drug_id(params[:drug_id])
      if drug_storage.sequence > 0
        drug_storage.sequence = drug_storage.sequence - 1
        drug_storage.save

        today = Date.today
        drug_use = DrugUse.new({
          :consult_id => params[:consult_id],
          :drug_id => params[:drug_id],
          :sequence => 1,
          :start_time => today,
          :end_time => today.next_day,
        })
        drug_use.save

        flash[:success] = "İlaç isteğinde bulunuldu"
      else
        flash[:error] = "Depoda bu ilaçtan kalmamış"
      end
    end
    redirect_to "/admin/consults/#{params[:consult_id]}"
  end

  def update
    drug_use = DrugUse.find(params[:id])
    if params[:end_time].to_date > drug_use.drug.expiry_date
      flash[:error] = "İlacın son kullanma tarihinden sonra kullanılamaz"
    else
      if params[:end_time] < params[:start_time]
        flash[:error] = "İlaç bitirme tarihi başlama tarihinden önce olamaz"
      elsif params[:sequence].to_i < 1
        flash[:error] = "İlaç sayısı 1'den olamaz"
      else
        # depo sayısını azalt
        drug_storage = DrugStorage.find_by_drug_id(drug_use[:drug_id])
        if drug_storage[:sequence] + drug_use[:sequence] >= params[:sequence].to_i
          drug_storage.sequence = drug_storage.sequence + drug_use[:sequence] - params[:sequence].to_i
          drug_storage.save

          drug_use[:sequence] = params[:sequence].to_i
          drug_use[:content] = params[:content]
          drug_use[:start_time] = params[:start_time]
          drug_use[:end_time] = params[:end_time]

          if drug_use.save
            flash[:success] = "İlaç Kullanımı Güncellenmiştir."
          else
            flash[:error] = "İlaç Kullanımı Güncellenemedi."
          end
        else
          flash[:error] = "Depoda bu ilaçtan yeteri kadar yok ya da kalmamış"
        end
      end
    end
    redirect_to "/admin/consults/#{drug_use[:consult_id]}"
  end

  def destroy
    drug_use = DrugUse.find(params[:drug_use_id])
    drug_use_consult_id = drug_use[:consult_id]

    # depo sayısını arttır
    drug_storage = DrugStorage.find_by_drug_id(drug_use[:drug_id])
    drug_storage.sequence = drug_storage.sequence + drug_use[:sequence]
    drug_storage.save

    # istek silinirse faturadan da sil
    Invoice.delete_all(
      :consult_id => drug_use[:consult_id],
      :product_id => drug_use[:drug_id],
      :product_type => 1,
    )

    if drug_use.delete
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to "/admin/consults/#{drug_use_consult_id}"
  end
end
