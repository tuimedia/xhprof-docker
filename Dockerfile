FROM php:5-apache

RUN pecl install xhprof-beta && docker-php-ext-enable xhprof
RUN apt-get update && \
    apt-get install -y graphviz && \
    rm -r /var/lib/apt/lists/*

# Because https://github.com/phacility/xhprof/pull/66
WORKDIR /root/xhprof
RUN curl https://pecl.php.net/get/xhprof-0.9.4.tgz | tar xz

# Serve the UI from the DocumentRoot
WORKDIR /root/xhprof/xhprof-0.9.4
RUN mv ./xhprof_html/* /var/www/html/ && \
    mv ./xhprof_lib/ /var/www/ && \
    rm -rf /root/xhprof && \
    chown -R www-data:www-data /var/www/html/

COPY ./custom.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html
