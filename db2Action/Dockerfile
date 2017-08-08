FROM csantanapr/nodejs6action:whisk-build-5338

RUN apt-get update \
    && apt-get install -y python make g++ \
    && npm install ibm_db@2.1.0 \
    && npm cache clean \
    && apt-get purge -y --auto-remove python make g++ \
    && rm -rf /var/lib/apt/lists/*



