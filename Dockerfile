FROM ruby:2.7.1
EXPOSE 8080
ENV TZ America/Toronto
COPY . /app
WORKDIR /app
RUN make
CMD bin/server
