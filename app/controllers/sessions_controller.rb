class SessionsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
  end

  def show
    @group = Group.find(params[:group_id])
    @session = Session.find(params[:id])
    @presented_user = SessionParticipation.where(user: current_user).first.presented_user
  end
end