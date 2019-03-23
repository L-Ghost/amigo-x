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
      GroupParticipation.create(group: @group, user: current_user)
      redirect_to @group
    else
      render :new
    end
  end
  
  def my_groups
  end

  def my_created_groups
    @groups = Group.where(user: current_user)
  end

  def add_participant
    @group = Group.find(params[:id])
  end

  def confirm_participant
    @group = Group.find(params[:id])
    @user = User.where(email: params[:email]).first
    if @user
      GroupParticipation.create(group: @group, user: @user)
      flash[:message] = "Usuário #{@user.name} (#{@user.email}) foi adicionado ao grupo #{@group.name}"
    else
      flash[:message] = 'Não foi encontrado um usuário com este email. Verifique o endereço informado.'
    end
    redirect_to add_participant_group_path(@group)
  end
end