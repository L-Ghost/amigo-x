class SessionsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
  end

  def show
    @group = Group.find(params[:group_id])
    @session = Session.find(params[:id])
  end
end