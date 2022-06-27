class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table(:users) do |t|
      t.string(:email, null: false, default: '')
      t.string(:password_digest)
      t.string(:first_name)
      t.string(:last_name)
      t.text(:photo_url)
      t.datetime(:birth)
      t.string(:phone)
      t.integer(:gender)
      t.string(:activation_digest)
      t.boolean(:is_activated, default: false)
      t.datetime(:activated_at)
      t.boolean(:is_partner, default: false)
      t.string(:remember_digest)
      t.boolean(:is_block, default: false)

      t.timestamps
    end
  end
end
