FROM ruby:2.4.1

ARG version=6.3.5

# Install OS deps
RUN apt-get update \
	&& apt-get install -y qt5-qmake g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# Install Ruby deps
RUN gem update --system \
	&& gem install bundler -v 2.0

# Change to a base directory
WORKDIR /usr/src/

# Download tagged release of source code
RUN wget https://github.com/YaleSTC/reservations/archive/v${version}.tar.gz \
	&& tar xzvf v${version}.tar.gz \
	&& rm v${version}.tar.gz

# Rename directory to not contain the version
RUN mv reservations-${version} reservations

# Change into untarred source
WORKDIR reservations

# Use production settings
RUN cp config/database.yml.example.production config/database.yml
RUN cp config/secrets.yml.example config/secrets.yml

# Facilitate disk-based logging
RUN mkdir log

# Install app deps
RUN bundle install

# Specify production env
ENV RAILS_ENV=production

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
