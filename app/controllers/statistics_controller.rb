class StatisticsController < ApplicationController
  # GET /statistics
  # GET /statistics.json
  def index
    @statistics = Statistic.all
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statistics }
    end
  end

  # GET /statistics/new
  # GET /statistics/new.json
  def new
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)
    @statistic = Statistic.new
    @zdjecia_stopka = Image.last(3)
    @statystyki = Statistic.find_by_rok(Time.now.year)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statistic }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # GET /statistics/1/edit
  def edit
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find(params[:id])
    @zdjecia_stopka = Image.last(3)
  end

  # POST /statistics
  # POST /statistics.json
  def create
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)
    @statistic = Statistic.new(params[:statistic])

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to @statistic, notice: 'Statistic was successfully created.' }
        format.json { render json: @statistic, status: :created, location: @statistic }
      else
        format.html { render action: "new" }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # PUT /statistics/1
  # PUT /statistics/1.json
  def update
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      if @statistic.update_attributes(params[:statistic])
        format.html { redirect_to @statistic, notice: 'Statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)
    @statistic = Statistic.find(params[:id])
    @statistic.destroy

    respond_to do |format|
      format.html { redirect_to statistics_url }
      format.json { head :no_content }
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def pozar_plus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.pozary += 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zwi&#281;kszono liczb&#281; po&#380;ar&#243;w' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end
  
  def pozar_minus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.pozary -= 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zmniejszono liczb&#281; po&#380;ar&#243;w' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def zagrozenia_plus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.zagrozenia += 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zwi&#281;kszono liczb&#281; zagro&#380;e&#324;' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def zagrozenia_minus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.zagrozenia -= 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zmniejszono liczb&#281; zagro&#380;e&#324;' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def alarmy_plus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.falarmy += 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zwi&#281;kszono liczb&#281; fa&#322;szywych alarm&#243;w' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def alarmy_minus
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @statistic = Statistic.find_by_rok(Time.now.year)
    @statistic.falarmy -= 1
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to root_url, notice: 'Gratulacje! Zmniejszono liczb&#281; fa&#322;szywych alarm&#243;w' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, notice: 'Uwaga! Niepowodzenie' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end
end
