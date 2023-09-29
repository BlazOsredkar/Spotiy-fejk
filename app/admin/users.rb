ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :full_name, :is_artist, :is_admin
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :full_name, :uid, :provider, :avatar_url, :reset_password_token, :reset_password_sent_at, :remember_created_at, :is_artist, :is_admin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  

  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :uid
    column :provider
    column :avatar_url
    column :is_artist
    column :is_admin
    actions
  end

  #create things for edit
  form do |f|
    f.inputs do
      f.input :email
      f.input :full_name
      f.input :is_artist
      f.input :is_admin
    end
    f.actions
  end

  #if creating do local user creation
  controller do
    def create
      @user = User.new(permitted_params[:user])
      @user.password = Devise.friendly_token[0, 20]
      @user.save!
      redirect_to admin_users_path
    end
  end

end
