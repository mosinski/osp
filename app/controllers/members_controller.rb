class MembersController < ApplicationController

  def create
   if current_user
       if (current_user.username == 'Administrator'&&current_user.id==1)||(current_user.username == 'strazak'&&current_user.id==2)
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to "/czlonkowie", notice: 'Gratulacje! Dodano nowego Cz&#322onka OSP.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
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
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to "/czlonkowie", notice: 'Informacja! Usuni&#281to Cz&#322onka OSP.' }
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
