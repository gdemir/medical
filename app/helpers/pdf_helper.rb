# encoding: utf-8
module PdfHelper
  def patient_invoice consult_info, products, product_sums
    pdf = Prawn::Document.new(:page_size => 'A5', :layout => 'portrait') do

      font "#{Prawn::BASEDIR}/data/fonts/comicsans.ttf", :size => 4

      move_up(30)
      text "Medical Manager", :size => 12, :align => :center

      move_down(10)
      table consult_info,
        :position => 60,
        :column_widths => { 0 => 24, 1 => 150, 2 => 24, 3 => 100 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0, :padding => 1 }

      table products,
        :position => :center,
        :column_widths => { 0 => 124, 1 => 50, 2 => 25, 3 => 25 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0.1, :padding => 1 }

      table product_sums,
        :position => :center,
        :column_widths => { 0 => 199, 1 => 25 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0.1, :padding => 1 }

      move_down(5)
      text "http://medical.a.ondokuz.biz", :size => 5, :align => :center
      text "copyright © #{Time.now.strftime("%Y")} Medical Manager", :size => 5.5, :align => :center
    end
  pdf
  end

  def patient_trial_type consult_info, trial_type, trials
    pdf = Prawn::Document.new(:page_size => 'A5', :layout => 'portrait') do

      font "#{Prawn::BASEDIR}/data/fonts/comicsans.ttf", :size => 4

      move_up(30)
      text "Medical Manager", :size => 12, :align => :center

      move_down(10)
      table consult_info,
        :position => 60,
        :column_widths => { 0 => 24, 1 => 150, 2 => 24, 3 => 100 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0, :padding => 1 }

      text trial_type, :size => 7, :align => :center
      move_down(5)

      table trials,
        :position => :center,
        :column_widths => { 0 => 94, 1 => 40, 2 => 50, 3 => 40 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0.1, :padding => 1 }

      move_down(5)
      text "http://medical.a.ondokuz.biz", :size => 5, :align => :center
      text "copyright © #{Time.now.strftime("%Y")} Medical Manager", :size => 5.5, :align => :center
    end
  pdf
  end
  def patient_drug_use consult_info, drugs
    pdf = Prawn::Document.new(:page_size => 'A5', :layout => 'portrait') do

      font "#{Prawn::BASEDIR}/data/fonts/comicsans.ttf", :size => 4

      move_up(30)
      text "Medical Manager", :size => 12, :align => :center

      move_down(10)
      table consult_info,
        :position => 60,
        :column_widths => { 0 => 24, 1 => 150, 2 => 24, 3 => 100 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0, :padding => 1 }

      table drugs,
        :position => :center,
        :column_widths => { 0 => 50, 1 => 36, 2 => 36, 3 => 36, 4 => 66 },
        :cell_style => { :size => 5, :text_color => "000000", :height => 13, :border_width => 0.1, :padding => 1 }

      move_down(5)
      text "http://medical.a.ondokuz.biz", :size => 5, :align => :center
      text "copyright © #{Time.now.strftime("%Y")} Medical Manager", :size => 5.5, :align => :center
    end
  pdf
  end
end
