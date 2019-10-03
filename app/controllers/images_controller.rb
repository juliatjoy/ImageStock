class ImagesController < ApplicationController
  def create
    if params && params[:data] && params[:data][:image_url].present?
      parsed_file  = URI.parse(params[:data][:image_url])
      parsed_file.host.present? ? upload_external_image(params[:data][:image_url]) : upload_local_image(params[:data][:image_url])
    else
      @message = 'image_url id required'
      @status = 422
    end
    render json: {
      data: {
        message: @message,
        status: @status,
        id: @image&.id
      }
    }
  end

  def upload_external_image(url)
    filename = File.basename(URI.parse(params[:data][:image_url]).path)
    binding.pry
    uploaded_image = URI.open(params[:data][:image_url])
    upload_image(uploaded_image, filename)
  end

  def upload_local_image(url)
    filename = url.split('/').last
    uploaded_image = File.open("#{Rails.public_path}#{url}")
    upload_image(uploaded_image, filename)
  rescue Errno::ENOENT
    @message = 'File not found'
    @status = 404
  end

  def upload_image(uploaded_image, filename)
    @image = Image.new
    @image.file.attach(io: uploaded_image, 
                       filename: filename, 
                       content_type: "image/#{filename.split('.').last}")
    if @image.file.attached?
      @image.save
      @message = 'Image saved successfully'
      @status = 201
    else
      @message = 'Error occured while saving'
      @status = 422
    end
  end
end
