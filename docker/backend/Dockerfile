ARG PHP_FPM_VERSION=8.1

FROM php:${PHP_FPM_VERSION}-fpm

RUN apt-get update \
    && apt-get install -y git \
    && apt-get install -y \
		libfreetype6-dev \
		libxpm-dev \
		libpng-dev \
		libicu-dev \
		libxml2-dev \
		libxslt-dev \
		libzip-dev \
		libgmp-dev \
		libcurl4-openssl-dev \
		libwebp-dev \
		libonig-dev \
		libldap2-dev \
		sqlite3 \
		libsqlite3-dev \
		libjpeg-dev \
        gzip \
        zip \
        unzip \
        vim \
        nano \
        default-mysql-client \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install bcmath \
			mbstring \
			intl \
			pdo_mysql \
			soap \
			sockets \
			xsl \
			pdo \
            mysqli \
            gettext \
            gd \
	&& docker-php-ext-install -j$(nproc) zip

RUN apt-get install wget
ENV INSTALL_DIR /var/www/html
ENV COMPOSER_HOME /var/www/.composer/

# Install jpeg gd library

WORKDIR /
RUN wget http://www.ijg.org/files/jpegsrc.v9e.tar.gz
RUN tar xvfz jpegsrc.v9e.tar.gz
WORKDIR /jpeg-9e
RUN ./configure
RUN make && make install
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg=/usr/local/lib
RUN docker-php-ext-install gd

#WORKDIR $INSTALL_DIR

# install composer
RUN set -x \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.7

######### copy auth.json file
COPY ./auth.json $COMPOSER_HOME

###### Create user
ARG APP_ID=1000
RUN addgroup --gid "$APP_ID" app \
 && adduser --ingroup app --uid "$APP_ID" --shell /bin/bash --system app
RUN chown -R app:app /var/www


########### Copy magento integration file
COPY ./install-config-mysql.php /
RUN chmod +x /install-config-mysql.php

# copy entry point
COPY ./docker-entry.sh /
RUN chmod +x /docker-entry.sh

# executing entry point
ENTRYPOINT ["bash", "/docker-entry.sh"]
WORKDIR $INSTALL_DIR
EXPOSE 9000