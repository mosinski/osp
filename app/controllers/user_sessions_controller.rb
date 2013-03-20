class UserSessionsController < ApplicationController
 
# GET /user_sessions/new
# GET /user_sessions/new.xml
def new
  if current_user
	redirect_to users_path, :notice => 'Informacja! Jeste&#347; ju&#380; zalogowany!'
  else
        @zdjecia_stopka = Image.last(3)
    	@statistic = Statistic.find_by_rok(Time.now.year)
	@user_session = UserSession.new
 
	respond_to do |format|
		format.html # new.html.erb
		format.xml { render :xml => @user_session }
	end
  end
end
 
# POST /user_sessions
# POST /user_sessions.xml
def create
  @user_session = UserSession.new(params[:user_session])
 
	respond_to do |format|
	 if @user_session.save
	   format.html { redirect_to(root_url, :notice => "Informacja! U&#380;ytkownik zalogowany") }
	   format.xml { render :xml => @user_session, :status => :created, :location => @user_session }
	 else
	   format.html { render :action => "new", :notice => "Uwaga! U&#380;ytkownik nie zalogowany" }
	   format.xml { render :xml => @user_session.errors, :status => :unprocessable_entity, :location => @user_session }
	 end
	end
end
 
# DELETE /user_sessions/1
# DELETE /user_sessions/1.xml
def destroy
@user_session = UserSession.find
@user_session.destroy
reset_session
 
	respond_to do |format|
	   format.html { redirect_to(root_url, :notice => 'Informacja! U&#380;ytkownik wylogowany') }
	   format.xml { head :ok }
	end
end
end
