class NewsController < ApplicationController
  def index
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find(:all, :conditions => ['rodzaj != ? ', "OTWP"])
    @aktualnosci_atom =  News.all
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
      format.atom
      format.xml  { render :xml => @news }
    end
  end

  def show
    @news = News.find(params[:id])
    @album = Album.find_by_nr_newsa(@news.id)
    @zdjecia = Image.find_all_by_przydzial(params[:id]).last(4)
    @filmiki = Video.find_all_by_przydzial(params[:id]).last(4)
    @calosc = (@zdjecia+@filmiki).last(4)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def new
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @news = News.new
       @statystyki = Statistic.find_by_rok(Time.now.year)

       respond_to do |format|
         format.html
         format.json { render json: @news }
       end
     else
       redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
     end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  def edit
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @news = News.find(params[:id])
       @statystyki = Statistic.find_by_rok(Time.now.year)
     else
       redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
     end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  def create
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @news = News.new(params[:news])

       respond_to do |format|
         if @news.save
           format.html { redirect_to @news, notice: 'Gratulacje! Dodano now&#261; aktualno&#347;&#263;!' }
           format.json { render json: @news, status: :created, location: @news }
         else
           format.html { render action: "new" }
           format.json { render json: @news.errors, status: :unprocessable_entity }
         end
       end
     else
       redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
     end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  def update
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
        @news = News.find(params[:id])

        respond_to do |format|
          if @news.update_attributes(params[:news])
            format.html { redirect_to @news, notice: 'Gratulacje! Poprawiono aktualno&#347;&#263;!' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @news.errors, status: :unprocessable_entity }
          end
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
          @news = News.find(params[:id])
          @news.destroy

          respond_to do |format|
            format.html { redirect_to news_index_url }
            format.json { head :no_content }
          end
       else
         redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
       end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  def group
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.uniq.pluck(:rodzaj).reverse
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def imprezy
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Imprezy")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def interwencje
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Interwencje")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def szkolenia
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Szkolenia")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def inne
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Inne")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def otwp
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("OTWP")
    @statystyki = Statistic.find_by_rok(Time.now.year)
    @pliki = Plik.all

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end
end
