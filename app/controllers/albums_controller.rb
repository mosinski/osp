class AlbumsController < ApplicationController

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])
    @news = News.find(@album.nr_newsa)
    @zdjecia = Image.find_all_by_przydzial(@album.nr_newsa.to_s).sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(9).order("created_at DESC").find_all_by_przydzial(@album.nr_newsa.to_s)
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def galeria_wszystkie
    @albums = Album.all.reverse
    @zdjecia = Image.all.sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(9).order("created_at DESC")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

end
