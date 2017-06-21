FROM csantanapr/nodejs6action:whisk-build-4911

RUN apt-get update \
    && apt-get install -y python make g++ \
    && npm install ibm_db@2.0.0 \
    && rm node_modules/ibm_db/installer/linuxx64_odbc_cli.tar.gz \
    && npm cache clean \
    && apt-get purge -y --auto-remove python make g++ \
    && rm -rf /var/lib/apt/lists/*



