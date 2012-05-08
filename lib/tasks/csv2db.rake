#!/usr/bin/ruby
# encoding: utf-8
# ---------------------------------------------------------------
# Csv Kayıt Verilerini Veritabanın İlgili Tablosuna Aktaran Betik
# ---------------------------------------------------------------

require 'csv'

# Görev kök dizini
TASKS_DIR = 'lib/tasks'
# CONSOLE de çalışacak geçici dosyanın tam yolu
TEMP_FILE = File.join(TASKS_DIR, 'temp')
# Csvlerin bulunduğu dizinin tam yolu
CSV_DIR   = File.join(TASKS_DIR, 'csv')
# Rails konsol
CONSOLE   = 'rails console'

task :push do
  Dir[File.join(CSV_DIR, '*')].each do |file|
    @records = []
    file = File.basename file
    if file =~ /.csv/
      if file =~ /_/
        tablename = file.split(".")[0].split("_")
        table = tablename[0].capitalize + tablename[1].capitalize
      else
        table = file.split(".")[0].capitalize
      end
      begin
        rows = CSV.open(File.join(CSV_DIR, file), "r")
      rescue Exception => e
        puts "CSV dosya okuma veya yazmada hata: #{e}"
      end

      # Csv dosyasının sütun başlıklarını al
      fields = rows.shift
      # Csv dosyasının içindeki tüm satırları @records listesine doldur
      this_like = Hash[*fields.map { |field| [field, nil] }.flatten]
      rows.each do |row|
        record = this_like.clone
        fields.each { |field| record[field] = row.shift }
        @records << record
      end

      # CONSOLE uygun çalışacak kayıtları TEMP_FILE içine yaz
      fp = File.new(TEMP_FILE, "w")
      @records.each do |record|
        fp.write("new_record = #{table}.new\n")
        record.each { |field, value| fp.write("new_record.#{field} = '#{value}'\n") }
        fp.write("new_record.save\n")
      end
      fp.close

      puts "#{table} tablosuna bilgiler yükleniyor..."

      # TEMP_FILE içindeki kayıtları CONSOLE yolla
      system "cat #{TEMP_FILE} | #{CONSOLE}"
      # Geçici dosyayı sil
      FileUtils.rm_rf TEMP_FILE
    end
  end
end
