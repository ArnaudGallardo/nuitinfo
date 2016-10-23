FROM ubuntu:xenial

EXPOSE 8080

# Create folder
RUN mkdir /var/www

# Install NodeJS
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y curl wget
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential

# Install Git
RUN apt-get install git -y

# Install Python 2.7
RUN apt-get install python2.7 -y
ENV PYTHON python2.7

# Install make
RUN apt-get install build-essential -y

# Install gcc
RUN apt-get install gcc -y

# Clone repo
RUN cd /var/www && git clone https://github.com/asso-labeli/nuitinfo.git
RUN cd /var/www/nuitinfo/ && npm i
RUN cd /var/www/nuitinfo/app && npm i

# Set ENV
ENV MONGO_HOST vps322703.ovh.net
ENV MONGO_PORT 27017
ENV MONGO_DB nuitinfo
ENV MAIL_SERVICE custom
ENV MAIL_ADDRESS email@default.com
ENV MAIL_PASSWORD password
ENV API_URL http://localhost:8080
ENV WEBSERVER_URL http://localhost:8080/web
ENV JWT_SECRET bJC2rlw0IW7XcsV5pWrFvcAK86y9JMD4L8JLB75BBmFJ00heK6yXtXMPDglcrZhl
ENV BCRYPT_SALT_ROUNDS 10

CMD cd /var/www/nuitinfo && git pull && npm i && cd /var/www/nuitinfo/server/config/ && mv local.env.default.js local.env.default.js && cd /var/www/nuitinfo/app && npm i && npm run build && cd /var/www/nuitinfo && npm run start