FROM debian:buster

COPY tool/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["php-fpm7.3", "-F"]

