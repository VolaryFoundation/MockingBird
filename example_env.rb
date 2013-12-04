if ENV['RACK_ENV'] == 'test'
  ENV['DATABASE_URL'] = 'postgres://dev@localhost:5432/grn_test'
else
  ENV['DATABASE_URL'] = 'postgres://dev@localhost:5432/grn_development'
end