# --- base image: latest known Eskapade environment
FROM kave/root:6.14.06

# --- me
MAINTAINER Max Baak <baak.max@kpmg.nl>

# --- switch to root user
USER root

# --- link sh to bash
SHELL ["/bin/bash", "-c"]

# --- useful Ubuntu packages, e.g. pdflatex. 
RUN apt-get update && apt-get install -y --no-install-recommends less vim aspell dvipng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# --- trigger automatic installation of required Spark dependencies. Requires Spark setup.
ENV PATH=/usr/local/spark/bin:$PATH
RUN echo "print('Hello world!')" > /tmp/test.py \
    && /usr/local/spark/bin/spark-submit --packages org.diana-hep:histogrammar-sparksql_2.11:1.0.4 /tmp/test.py \
    && rm /tmp/test.py

# --- append sourcing of ROOT env to bashrc
COPY bashrc_appendum /tmp/
RUN cat /tmp/bashrc_appendum >> "${HOME}"/.bashrc && rm /tmp/bashrc_appendum

# --- switch to jovyan user
USER $NB_UID

# --- install Eskapade and other useful python packages
ENV ROOT_ENV_SCRIPT "/opt/root/bin/thisroot.sh"
RUN source "${ROOT_ENV_SCRIPT}" \
    && pip install Eskapade-Core==0.9.0 \
    && pip install Eskapade==0.9.0 \
    && pip install -e git+https://github.com/KaveIO/Eskapade-ROOT.git@v0.9.0#egg=eskapade-root \
    && pip install Eskapade-Spark==0.9.0 \
    && pip install sphinx_rtd_theme==0.4.1 \
    && pip install pymongo==3.4.0 \
    && pip install jaydebeapi==1.1.1 \
    && pip install django==2.0.5 \
    && pip install findspark==1.3.0 \
    && pip install dash==0.28.7 \
    && pip install dash-core-components==0.38.0 \
    && pip install dash-html-components==0.13.2 \
    && pip install dash-renderer==0.14.3 \
    && pip install dash-table==3.1.5

# --- Note on Eskapade-ROOT: pip does not pick up custom cxx installation from pypi repo, 
#     but does so from git when installing in editable mode. Strange but true.
#     See: https://stackoverflow.com/questions/19569557/pip-not-picking-up-a-custom-install-cmdclass

