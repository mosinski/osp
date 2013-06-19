class PliksController < ApplicationController
require 'net/ftp'
  # GET /pliks
  # GET /pliks.json
  def index
 if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @pliks = Plik.all
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pliks }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # POST /pliks
  # POST /pliks.json
  def create
 if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    file = params[:file]
    if file != nil
    ftp = Net::FTP.new('s3.masternet.pl')
    ftp.passive = true
    ftp.login(user = ENV['pliki_login'], passwd = ENV['pliki_haslo'])
    ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    ftp.quit()
    @plik = Plik.new
    @plik.nazwa = file.original_filename
    @plik.opis = params[:opis]

    respond_to do |format|
      if @plik.save
        format.html { redirect_to "/otwp", notice: 'Gratulacje! Plik zosta&#322; dodany.' }
        format.json { render json: @plik, status: :created, location: @plik }
      else
        format.html { redirect_to "/otwp", notice: 'Uwaga! Niepowodznie dodania pliku.' }
        format.json { render json: @plik.errors, status: :unprocessable_entity }
      end
    end
    		else
		  redirect_to "/otwp", :notice => 'Uwaga! Nie wybrano pliku z komputera!'
		end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def destroy
 if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @plik = Plik.find(params[:id])
    @plik.destroy

    respond_to do |format|
      format.html { redirect_to pliks_url }
      format.json { head :no_content }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end
end
