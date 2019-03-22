class GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params.require(:group).permit(:name))
    @group.user = current_user
    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def my_groups
    @groups = Group.where(user: current_user)
  end
end