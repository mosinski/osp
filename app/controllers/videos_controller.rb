class VideosController < ApplicationController
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # POST /videos
  # POST /videos.json
  def create
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    		file = params[:videof]
		if News.find_all_by_id(params[:przydzial]).count != 0
		@news = News.find(params[:przydzial])
		@albums = Album.find_all_by_nr_newsa(@news.id)
		else
		@albums = Album.find_all_by_nr_newsa(params[:przydzial])
		end
		if file != nil && file.original_filename.end_with?('.webm','.WEBM')
		@filmy = Video.find_all_by_nazwa(file.original_filename).count
		if (@filmy == 0)
		  file.original_filename = file.original_filename.gsub(/\s+/, "")
    		  ftp = Net::FTP.new('s3.masternet.pl')
        	  ftp.passive = true
    		  ftp.login(user = ENV['video_login'], passwd = ENV['video_haslo'])
    		  ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    		  ftp.quit()
    		  @video = Video.new
		  @video.nazwa = file.original_filename
        	  @video.opis = params[:opis]
		  @video.przydzial = params[:przydzial]
		  if @albums.count == 0
		    @album = Album.new
		    @album.tytul = @news.tytul
	            @album.nr_newsa = @news.id
		    @album.save
		  end

    		  respond_to do |format|
      			if @video.save
        			format.html { redirect_to @news, notice: 'Gratulacje! Dodano film do aktualno&#347;ci' }
        			format.json { render json: @video, status: :created, location: @video }
     			else
        			format.html { redirect_to @news, notice: 'Uwaga! Niepowodznie dodania filmu' }
        			format.json { render json: @video.errors, status: :unprocessable_entity }
      			end
    		  end
	       else
		  redirect_to @news, :notice => 'Uwaga! Film o takiej nazwie ju&#380; jest w bazie!'
	       end
	       else
		  redirect_to @news, :notice => 'Uwaga! Nie wybrano filmu z komputera lub rozszerzenie jest nieprawid&#322owe!'
	       end
	else
  	redirect_to websites_path, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
end
