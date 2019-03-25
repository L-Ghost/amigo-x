class SessionsController < ApplicationController
  
  REQUIRED_USERS = 3

  def index
    @group = Group.find(params[:group_id])
  end

  def show
    @group = Group.find(params[:group_id])
    @session = Session.find(params[:id])
    @presented_user = SessionParticipation.where(session: @session, user: current_user).first.presented_user
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

  def make_raffle
    @session = Session.find(params[:id])
    ids = []
    raffle = Hash.new
    # gets participants ids
    @session.users.each do |user|
      ids << user.id
    end

    # shuffle ids to decide which participant presents which other
    shuffled_ids_keys = ids.shuffle
    shuffled_ids_values = shuffled_ids_keys.dup
    shuffled_ids_values.insert(0, shuffled_ids_values.pop)

    # assigns participant to participant who should be presented
    0.upto(shuffled_ids_keys.size-1) do |k|
      user = User.find(shuffled_ids_keys[k])
      presented_user = User.find(shuffled_ids_values[k])
      sp = SessionParticipation.where(session: @session, user: user).first
      sp.presented_user = presented_user
      sp.save
    end
    
    flash[:message] = 'Sorteio realizado. Compre um belo presente para quem você tirou. =)'
    redirect_to group_session_path(@session.group, @session)
  end
end