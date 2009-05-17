Factory.define :user do |f|
  f.first_name 'John'
  f.last_name  'Doe'
  f.email 'john.doe@example.com'
  f.password 'abcd'
  f.password_confirmation 'abcd'
end

Factory.define :admin, :parent => :user do |f|
  f.role "admin"
end
