class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
   if current_user
       if (current_user.username == 'Administrator')
    @users = User.all
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
@user = User.new
    @zdjecia_stopka = Image.last(3)
   @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @statystyki = Statistic.find_by_rok(Time.now.year)
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # POST /users
  # POST /users.json
def create
  @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to( root_url, :notice => 'Informacja! Konto zarejestrowane!') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
end

  # PUT /users/1
  # PUT /users/1.json
  def update
   if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  if current_user
    @user = User.find(params[:id])
       if (current_user.username == 'Administrator')||(current_user.username == @user.username)
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

 def start
    @news = News.last(6).sort_by(&:created_at).reverse
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)
    if @statystyki == nil
	@statystyki = Statistic.new
	@statystyki.rok = Time.now.year
	@statystyki.pozary = 0
	@statystyki.zagrozenia = 0
	@statystyki.falarmy = 0
	@statystyki.save
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

 def galeria
    @albums = Album.all.reverse
    @zdjecia = Image.all.sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(9).order("created_at DESC")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

 def galeria1
    @zdjecia = Image.all.sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(9).order("created_at DESC")
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

 def about
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

 def czlonkowie
    @member = Member.new
    @members = Member.all
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

end
