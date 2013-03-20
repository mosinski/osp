class StatisticsController < ApplicationController
  # GET /statistics
  # GET /statistics.json
  def index
    @statistics = Statistic.all
    @zdjecia_stopka = Image.last(3)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statistics }
    end
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
    @statistic = Statistic.find(params[:id])
    @zdjecia_stopka = Image.last(3)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statistic }
    end
  end

  # GET /statistics/new
  # GET /statistics/new.json
  def new
    @statistic = Statistic.new
    @zdjecia_stopka = Image.last(3)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statistic }
    end
  end

  # GET /statistics/1/edit
  def edit
    @statistic = Statistic.find(params[:id])
    @zdjecia_stopka = Image.last(3)
  end

  # POST /statistics
  # POST /statistics.json
  def create
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
  end

  # PUT /statistics/1
  # PUT /statistics/1.json
  def update
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
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic = Statistic.find(params[:id])
    @statistic.destroy

    respond_to do |format|
      format.html { redirect_to statistics_url }
      format.json { head :no_content }
    end
  end

  def pozar_plus
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
  end
  
  def pozar_minus
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
  end

  def zagrozenia_plus
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
  end

  def zagrozenia_minus
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
  end

  def alarmy_plus
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
  end

  def alarmy_minus
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
  end
end
