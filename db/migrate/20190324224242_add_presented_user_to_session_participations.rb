class AddPresentedUserToSessionParticipations < ActiveRecord::Migration[5.2]
  def up 
    execute "ALTER TABLE session_participations ADD COLUMN presented_user_id INTEGER NULL REFERENCES users (id);"
  end

  def down 
    execute "ALTER TABLE session_participations DROP COLUMN IF EXISTS presented_user_id;"
  end

  #def change
  #  add_reference :session_participations, :presented_user, class_name: 'User', foreign_key: true, optional: true
  #end
end
