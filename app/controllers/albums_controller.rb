class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    if News.find_all_by_id(@album.nr_newsa).count != 0
    @news = News.find(@album.nr_newsa)
    end
    @zdjecia = Image.find_all_by_przydzial(@album.nr_newsa.to_s).sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(28).order("created_at DESC").find_all_by_przydzial(@album.nr_newsa.to_s)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @album }
    end
  end

  def create
    @album_last = Album.last
    @album = Album.new(params[:album])
    if @album_last != nil
    @album.nr_newsa = (10000+@album_last.id)
    else
    @album.nr_newsa = 10000
    end

    respond_to do |format|
      if @album.save
        format.html { redirect_to "/galeria", notice: 'Dodano nowy Album.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @album = Album.find(params[:id])
       @album.destroy

       respond_to do |format|
         format.html { redirect_to "/galeria" }
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
    @zdjecia_page = Image.page(params[:page]).per_page(12).order("created_at DESC")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end
end
