class PliksController < ApplicationController
require 'net/ftp'
  # GET /pliks
  # GET /pliks.json
  def index
    @pliks = Plik.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pliks }
    end
  end

  # GET /pliks/1
  # GET /pliks/1.json
  def show
    @plik = Plik.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plik }
    end
  end

  # GET /pliks/new
  # GET /pliks/new.json
  def new
    @plik = Plik.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plik }
    end
  end

  # GET /pliks/1/edit
  def edit
    @plik = Plik.find(params[:id])
  end

  # POST /pliks
  # POST /pliks.json
  def create
    file = params[:file]
    ftp = Net::FTP.new('s3.masternet.pl')
    ftp.passive = true
    ftp.login(user = "kostek-pliki", passwd = "Startr3k")
    ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    ftp.quit()
    @plik = Plik.new
    @plik.nazwa = file.original_filename
    @plik.opis = params[:opis]

    respond_to do |format|
      if @plik.save
        format.html { redirect_to "/otwp", notice: 'Plik zostal dodany.' }
        format.json { render json: @plik, status: :created, location: @plik }
      else
        format.html { render action: "new" }
        format.json { render json: @plik.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pliks/1
  # PUT /pliks/1.json
  def update
    @plik = Plik.find(params[:id])

    respond_to do |format|
      if @plik.update_attributes(params[:plik])
        format.html { redirect_to @plik, notice: 'Plik was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plik.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pliks/1
  # DELETE /pliks/1.json
  def destroy
    @plik = Plik.find(params[:id])
    @plik.destroy

    respond_to do |format|
      format.html { redirect_to pliks_url }
      format.json { head :no_content }
    end
  end
end
