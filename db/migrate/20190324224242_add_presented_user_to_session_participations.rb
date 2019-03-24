class AddPresentedUserToSessionParticipations < ActiveRecord::Migration[5.2]
  def change
    add_reference :session_participations, :presented_user, class_name: 'User', foreign_key: true, optional: true
  end
end
