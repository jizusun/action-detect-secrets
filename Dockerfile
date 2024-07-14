FROM python:3.11.4-alpine

ENV REVIEWDOG_VERSION=v0.20.1


# RUN apk add --no-cache gcc musl-dev \
#     && pip install --no-cache-dir -r /code/requirements.txt \
#     && apk del .build-deps


RUN apk --no-cache add git gcc musl-dev \
    && which gcc 
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION} \
    && pip install detect-secrets[word_list] 

COPY baseline2rdf.py /usr/local/bin/baseline2rdf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
