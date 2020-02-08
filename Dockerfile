FROM ruby:2.4.1

ARG version=6.3.5

RUN apt-get update \
	&& apt-get install -y qt5-qmake g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

RUN wget https://github.com/YaleSTC/reservations/archive/v${version}.tar.gz \
	&& tar xzvf v${version}.tar.gz \
	&& rm v${version}.tar.gz

WORKDIR reservations-${version}

# Use production database settings
RUN cp config/database.yml.example.production config/database.yml

RUN gem update --system \
	&& gem install bundler -v 2.0

RUN bundle install

ENV RAILS_ENV=production

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
