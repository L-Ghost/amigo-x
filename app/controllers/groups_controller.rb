class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
  end

  def my_groups
    @groups = Group.where(user: current_user)
  end
end