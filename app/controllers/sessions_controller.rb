class SessionsController < ApplicationController
  
  REQUIRED_USERS = 3

  def index
    @group = Group.find(params[:group_id])
  end

  def show
    @group = Group.find(params[:group_id])
    @session = Session.find(params[:id])
    @presented_user = SessionParticipation.where(user: current_user).first.presented_user
  end

  def new
    @group = Group.find(params[:group_id])
    @session = Session.new
  end

  def create
    # creates session
    @session = Session.new(params.require(:session).permit(:name))
    @group = Group.find(params[:group_id])
    @session.group = @group    

    # check if group has minimum required users
    if @group.users.count < SessionsController::REQUIRED_USERS
      @session.errors.add(:group, message: 'É necessário haver no mínimo três pessoas participando de um grupo para criar uma Sessão')
    end
    
    if @session.errors.any?
      render :new
    else
      if @session.save
        # adds participants to session
        @group.users.each do |user|
          SessionParticipation.create(session: @session, user: user)
        end
        redirect_to group_sessions_path(@group)
      else
        render :new
      end
    end
  end
end