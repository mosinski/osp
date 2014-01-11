class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find(:all, :conditions => ['rodzaj != ? ', "OTWP"])
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @aktualnosci_atom =  News.all
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
      format.atom     # index.atom.builder
      format.xml  { render :xml => @news }  
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.find(params[:id])
    @album = Album.find_by_nr_newsa(@news.id)
    @zdjecia = Image.find_all_by_przydzial(params[:id]).last(4)
    @filmiki = Video.find_all_by_przydzial(params[:id]).last(4)
    @calosc = (@zdjecia+@filmiki).last(4)
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @news = News.new
       @news_kalendarz = News.all
       @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
       @zdjecia_stopka = Image.last(3)
       @statystyki = Statistic.find_by_rok(Time.now.year)

       respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @news }
       end
     else
       redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
     end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # GET /news/1/edit
  def edit
   if current_user
     if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
       @news_kalendarz = News.all
       @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
       @news = News.find(params[:id])
       @zdjecia_stopka = Image.last(3)
       @statystyki = Statistic.find_by_rok(Time.now.year)
     else
       redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
     end
   else
     redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
   end
  end

  # POST /news
  # POST /news.json
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

  # PUT /news/1
  # PUT /news/1.json
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

  # DELETE /news/1
  # DELETE /news/1.json
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
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.uniq.pluck(:rodzaj).reverse
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @news }
    end
  end

  def imprezy
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Imprezy")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def interwencje
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Interwencje")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def szkolenia
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Szkolenia")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def inne
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("Inne")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def otwp
    @news_kalendarz = News.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @news = News.paginate(:page => params[:page], :per_page => 6, :order => 'created_at DESC').search(params[:search], params[:page]).find_all_by_rodzaj("OTWP")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)
    @pliki = Plik.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end
end
