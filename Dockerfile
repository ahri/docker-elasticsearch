FROM ahri/java:0.0.2

ENV ELASTICSEARCH_VERSION 2.0.0

RUN su -s /bin/sh -c "cd /tmp && wget -O - http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz | tar xz" daemon && \
        mv /tmp/elasticsearch-$ELASTICSEARCH_VERSION /elasticsearch && \
        cd /elasticsearch && \
        mkdir plugins config/scripts data logs && \
	chown daemon:daemon plugins config/scripts && \
        chown nobody:nobody logs data

VOLUME ["/elasticsearch/data"]

EXPOSE 9200
EXPOSE 9300

USER nobody
ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
CMD ["--network.host", "0.0.0.0"]
