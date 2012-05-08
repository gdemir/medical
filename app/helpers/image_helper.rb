# encoding: utf-8
module ImageHelper
  class Image
    @base_dir = 'uploads'
    @dir      = Rails.root.join('public', @base_dir) # <ana_dizin>
    @types    = %w(jpe?g png gif)
    @size     = 0.5 * 1024 * 1024                    # 0.5 Mb

    # sesli hatalı çıkış için   : [false, "bla bla"]
    # sesli başarılı çıkış için : [true,  "bla bla"]
    # sessiz hatalı çıkış için  : nil
    def self.upload directory, savename, uploaded, overwrite = false

      # yüklenen dosya yok ise sessiz çık
      return nil unless File.exist? uploaded.path

      # <ana_dizin> yoksa oluşturalım
      unless File.exist? @dir
        FileUtils.mkdir_p @dir, :mode => 0755
        FileUtils.chmod_R 0755, @dir
      end

      # hedef dizin
      destination = @dir.join directory

      # hedef dizin yoksa oluşturalım
      unless File.exist? destination
        FileUtils.mkdir_p destination, :mode => 0755
        FileUtils.chmod_R 0755, destination
      end

      # dosya tipini belirleyelim
      if @types.select { |type| uploaded.content_type =~ /#{type}/ }.none?
        return [false, "Resim #{@types} formatında olmalıdır"]
      else
        savename += '.' + File.basename(uploaded.content_type)
      end

      # resmin tam yolu
      image = destination.join savename

      if uploaded.size > @size;                  return [false, "Resim çok büyük"]
      elsif File.exist?(image) && !(overwrite);  return [false, "Resim zaten var"]
      elsif !FileUtils.mv(uploaded.path, image); return [false, "Dosya yükleme hatası"]
      else
        FileUtils.chmod 0644, image
        return [true, "/#{@base_dir}/#{directory}/#{savename}"] # resim yükleme başarısı
      end

      return nil
    end

    # resim var ise sil çık
    def self.delete savename
      base_savename = savename.split('.')[0]   # resmin dosya tipinden ayrılmış hali

      # aynı isimdeki tüm dosya tipilerini sil
      unless (files = Dir.glob(File.join('public', base_savename + '.*'))).none? # resim var ise sil
        files.each { |file| FileUtils.rm_f(file) }
      end
    end
  end
end
