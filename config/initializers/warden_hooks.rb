Warden::Manager.after_set_user do |user,auth,opts|
  if user.instance_of?(User)
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
  end
end

Warden::Manager.before_logout do |user, auth, opts|
  if user.instance_of?(User)
    scope = opts[:scope]
    auth.cookies.signed["#{scope}.id"] = nil
  end
end
