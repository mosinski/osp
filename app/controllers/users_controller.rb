class UsersController < ApplicationController

  def index
    if current_user
      if (current_user.username == 'Administrator'&&current_user.id==1)
        @users = User.all
        @statystyki = Statistic.find_by_rok(Time.now.year)

        respond_to do |format|
          format.html
          format.json { render json: @users }
        end
      else
        redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
      end
    else
      redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def new
   if current_user
    redirect_to root_url, :notice => 'Informacja! Wyloguj si&#281; aby dokona&#263; rejestracji'
   else
    redirect_to root_url, :notice => 'Informacja! Rejestracja zosta&#322;a wy&#322;&#261;czona'
   end
   #@user = User.new
   #@statystyki = Statistic.find_by_rok(Time.now.year)

    #respond_to do |format|
      #format.html # new.html.erb
      #format.json { render json: @user }
    #end
  end

  def edit
    if current_user
      @user = User.find(params[:id])
      if (current_user.username == 'Administrator'&&current_user.id==1)
        @statystyki = Statistic.find_by_rok(Time.now.year)
      else
        redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
      end
    else
      redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def create
    redirect_to root_url, :notice => 'Informacja! Rejestracja zosta&#322;a wy&#322;&#261;czona'
    #@user = User.new(params[:user])

    #respond_to do |format|
      #if @user.save
        #format.html { redirect_to( root_url, :notice => 'Informacja! Konto zarejestrowane!') }
        #format.xml { render :xml => @user, :status => :created, :location => @user }
      #else
        #format.html { render :action => "new" }
        #format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      #end
    #end
  end

  def update
   if current_user
     @user = User.find(params[:id])
     if (current_user.username == 'Administrator'&&current_user.id==1)

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

  def destroy
    if current_user
      @user = User.find(params[:id])
      if (current_user.username == 'Administrator'&&current_user.id==1)
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
      format.html
      format.json { render json: @users }
    end
  end

 def galeria
    @albums = Album.page(params[:page]).per_page(7).order("created_at DESC")
    @zdjecia = Image.all.sort_by(&:created_at).reverse
    @zdjecia_page = Image.page(params[:page]).per_page(9).order("created_at DESC")
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

 def about
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

 def czlonkowie
    @member = Member.new
    @members = Member.all
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

 def wynajem_sali
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
