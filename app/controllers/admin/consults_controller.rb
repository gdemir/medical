# encoding: utf-8
class Admin::ConsultsController < ApplicationController

  include ApplicationHelper
  include PdfHelper
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
    redirect_to "/admin/consults"
  end

  def payment
    consult = Consult.find(params[:id])
    flash[:error] = ""

    consult.drug_requests.each do |drug_request|
      unless invoice = Invoice.find_by_consult_id_and_product_id_and_product_type(drug_request[:consult_id],
                                                                                  drug_request[:drug_id],
                                                                                  true)
        flash[:error] += "İlaç isteklerinde eklenmemiş ürün var, faturaya ekleyiniz ya da siliniz\n"
        break
      end
    end

    consult.trial_requests.each do |trial_request|
      unless invoice = Invoice.find_by_consult_id_and_product_id_and_product_type(trial_request[:consult_id],
                                                                                  trial_request[:trial_type_id],
                                                                                  false)
        flash[:error] += "Test tipi isteklerinde eklenmemiş ürün var, faturaya ekleyiniz ya da siliniz"
        break
      end
    end

    if flash[:error] == ""
      consult[:payment] = !consult[:payment]
      consult[:reply_admin_id] = session[:admin][:id]
      if consult.save
        flash[:success] = "Ödeme Tetiklendi."
      else
        flash[:error] = "Ödeme Tetiklenemedi."
      end
    end
    redirect_to "/admin/consults/#{consult[:id]}"
  end

  def state
    consult = Consult.find(params[:id])
    consult[:state] = !consult[:state]
    consult[:reply_admin_id] = session[:admin][:id]
    if consult.save
      flash[:success] = "Başvuru Tetiklendi."
    else
      flash[:error] = "Başvuru Tetiklenemedi."
    end
    redirect_to "/admin/consults/#{consult[:id]}"
  end

  def invoicepdf
    consult = Consult.find(params[:id])
    if consult.payment
      consult_info = [
        ["Tarih:",  Time.now.to_s,             "File No:",  consult.patient.file_no],
        ["Hasta:",  consult.patient.full_name, "Cinsiyet:", consult.patient.gender ? "E" : "K"],
        ["Doktor:", consult.doctor.full_name,  "Yaş:",      consult.patient.age],
      ]

      products = [["Ürün", "Adet", "Fiyat", "Toplam"],]
      consult.all_product.each do |invoice|
        product = invoice[:product_type] ? Drug.find(invoice[:product_id]) : TrialType.find(invoice[:product_id])
        products << [product[:name], invoice[:sequence], invoice[:price], invoice[:sequence] * invoice[:price]]
      end
      product_sums = [["Toplam", consult.total_price],]

      pdf = patient_invoice consult_info, products, product_sums
      send_data(pdf.render(), :filename => "#{consult[:id]}-invoice.pdf")
    else
      flash[:error] = "Bu Başvurunun Henüz Ödemesi Yapılmamış"
      redirect_to "/admin/consults/#{consult[:id]}"
    end
  end

  def trialtypepdf
    consult = Consult.find(params[:id])
    consult_info = [
      ["Tarih:",  Time.now.to_s,             "File No:",  consult.patient.file_no],
      ["Hasta:",  consult.patient.full_name, "Cinsiyet:", consult.patient.gender ? "E" : "K"],
      ["Doktor:", consult.doctor.full_name,  "Yaş:",      consult.patient.age],
    ]

    trial_request = TrialRequest.find_by_consult_id_and_trial_type_id(params[:id], params[:trial_type_id])
    trial_results = TrialResult.find_all_by_trial_request_id(trial_request[:id])

    trial_type = TrialType.find(params[:trial_type_id]).name
    trials = [["Test Adı", "Sonuç", "Normal", "Units"],]
    trial_results.each do |trial_result|
      trials << [ trial_result.trial.name,
                  trial_result[:result],
                  "#{trial_result[:min_range]}-#{trial_result[:max_range]}",
                  trial_result.trial.units,
                ]
    end

    pdf = patient_trial_type consult_info, trial_type, trials
    send_data(pdf.render(), :filename => "#{consult[:id]}-trialtype-#{params[:trial_type_id]}.pdf")
  end

  def drugspdf
    consult = Consult.find(params[:id])
    consult_info = [
      ["Tarih:",  Time.now.to_s,             "File No:",  consult.patient.file_no],
      ["Hasta:",  consult.patient.full_name, "Cinsiyet:", consult.patient.gender ? "E" : "K"],
      ["Doktor:", consult.doctor.full_name,  "Yaş:",      consult.patient.age],
    ]
    drug_uses = DrugUse.find_all_by_consult_id(params[:id])

    drugs = [["İlaç Adı", "S.K.T", "Başlama Tarihi", "Bitirme Tarihi", "İçerik"],]
    drug_uses.each do |drug_use|
      drugs << [ drug_use.drug.name,
                  drug_use.drug.expiry_date,
                  drug_use[:start_time],
                  drug_use[:end_time],
                  drug_use[:content],
                ]
    end

    pdf = patient_drug_use consult_info, drugs
    send_data(pdf.render(), :filename => "#{consult[:id]}-drugs.pdf")
  end

  def destroy
    if Consult.delete(params[:consult_id])
      flash[:success] = "Kayıt Silindi"
    else
      flash[:error] = "Kayıt Silinemedi"
    end
    redirect_to '/admin/consults/all'
  end
end
