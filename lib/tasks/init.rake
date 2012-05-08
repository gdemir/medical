#!/usr/bin/ruby
# encoding: utf-8
# --------------------------------------------------------------------
# Veritabanın Tabloların Güncellenmesi Ve Sistemin Kurulumu İçin Betik
# --------------------------------------------------------------------

require 'yaml'

# Görev kök dizini
TASKS_DIR = 'lib/tasks'
# Uygulama dizini
APP      = "app/views"
# Migrate
MIGRATE  = "db/migrate"
# Generate
GENERATE = "rails generate"       # rails generate
MODEL    = "#{GENERATE} model"    # rails generate model
RESOURCE = "#{GENERATE} resource" # rails generate resource
SCAFFOLD = "#{GENERATE} scaffold" # rails generate scaffold

# Tablolarımızın bulunduğu dosya
Config = YAML.load_file(File.join(TASKS_DIR, '_config.yml'))

# --------------------------------------------------------------------
# Görevler
# --------------------------------------------------------------------

task :init => %w(init:db init:dir init:table)
task :info => %w(info:dir info:table)

# Example using:
#  rake init
#  rake init:db
#  rake init:dir
#  rake init:table

#  rake table:update

#  rake info
#  rake info:dir
#  rake info:table

namespace :init do
   # Veritabanını sil ve oluştur
   task :db do
      puts "db siliniyor..."
      system "rake db:drop"

      puts "db oluşturuluyor..."
      system "rake db:create"
   end

   # Ana dizinleri oluştur
   task :dir do
      puts "dizinler oluşturuluyor..."
      Config["dirs"].each do |dir|
         full_path_dir = File.join(APP, dir)
         FileUtils.mkdir full_path_dir unless File::exists? full_path_dir
      end
   end

   # Tabloları oluştur
   task :table => %w(table:create table:migrate)
end

namespace :table do
   # Tablo tohumlarını sil ve tekrardan oluştur
   task :create do
      puts "tablo çerezleri siliniyor..."
      FileUtils.rm_rf MIGRATE

      puts "tablolar oluşturuluyor..."
      Config["tables"].each do |table, fields|
         args = table
         fields.each { |field, type| args += " #{field}:#{type}" }
         system "#{MODEL} #{args}"
      end
   end

   # Tablo tohumlarını etkinleştir
   task :migrate do
      puts "tablolar etkinleşiyor..."
      system "rake db:migrate"
   end

   # Migrate'ten tablo güncelle
   task :update => %w(init:db migrate)
end

namespace :info do
   # Dizinler hakkında
   task :dir do
      puts "Dizinler"
      Config["dirs"].each { |dir| puts "- #{dir}" }
   end

   # Tablolar Hakkında
   task :table do
      puts "Tablolar"
      Config["tables"].each do |table, fields|
         puts "  # #{table}"
         fields.each { |field, type| puts "    - #{field} : #{type}" }
      end
   end
end
