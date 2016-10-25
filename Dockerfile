FROM ruby:2.3.1
MAINTAINER Brickgao <brickgao@gmail.com>

RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /app 
WORKDIR /app

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

RUN touch .In_Container

RUN rake db:migrate RAILS_ENV=development

RUN rails runner script/create_default_admin.rb

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]