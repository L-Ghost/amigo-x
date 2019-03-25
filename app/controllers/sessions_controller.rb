class SessionsController < ApplicationController
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
    @group = Group.find(params[:group_id])
    @session = Session.new(params.require(:session).permit(:name))
    @session.group = @group
    if @session.save
      redirect_to group_sessions_path(@group)
    else
      render :new
    end
  end
end