# TODO think about a better way
db_name = Rails.application.class.parent_name.underscore

database = options[:database].delete('jdbc')
database = 'postgres' if database == 'postgresql'
database = 'sqlite'   if database == 'sqlite3'

prefix   = ''
postfix  = ''
prefix   = 'db/' if database == 'sqlite'
postfix  = '.db' if database == 'sqlite'

remove_file 'config/database.yml'
create_file 'config/database.yml' do
<<-YAML
defaults: &defaults
  adapter: #{database}

development:
  database: #{prefix}#{db_name}_development#{postfix}
  <<: *defaults

  # Add more repositories
  # repositories:
  #   repo1:
  #     adapter:  postgres
  #     database: sample_development
  #     username: the_user
  #     password: secrets
  #     host:     localhost
  #   repo2:
  #     ...

test:
  database: #{prefix}#{db_name}_test#{postfix}
  <<: *defaults
production:
  database: #{prefix}#{db_name}_production#{postfix}
  <<: *defaults
YAML
end
