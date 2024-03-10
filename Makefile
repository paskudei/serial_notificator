preinstall_app:
	bundle install \
	&& yarn install \
	&& bundle exec rails db:create \
	&& bundle exec rails db:migrate
