FROM ruby:2.7.1
COPY . /app
WORKDIR /app
RUN make
CMD bin/server
