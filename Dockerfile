FROM frolvlad/alpine-glibc

ENV CONDA_DIR="/opt/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

# Install conda
RUN CONDA_VERSION="4.0.5" && \
    CONDA_MD5_CHECKSUM="42dac45eee5e58f05f37399adda45e85" && \
    \
    apk add --no-cache --virtual=.build-dependencies bash && \
    \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda2-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "$CONDA_MD5_CHECKSUM  miniconda.sh" | md5sum -c && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    rm miniconda.sh && \
    \
    conda update --all --yes && \
    conda clean --all --yes && \
    \
    apk del --purge .build-dependencies

RUN echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh