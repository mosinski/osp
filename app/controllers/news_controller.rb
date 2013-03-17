class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    @news = News.page(params[:page]).per_page(5).order("created_at DESC")
    @zdjecia_stopka = Image.last(3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])
    @zdjecia = Image.find_all_by_przydzial(params[:id])
    @zdjecia_stopka = Image.last(3)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
   if current_user
       if (current_user.username == 'Administrator')
    @news = News.new
    @zdjecia_stopka = Image.last(3)

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
       if (current_user.username == 'Administrator')
    @news = News.find(params[:id])
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
       if (current_user.username == 'Administrator')
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
       if (current_user.username == 'Administrator')
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
       if (current_user.username == 'Administrator')
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
end
