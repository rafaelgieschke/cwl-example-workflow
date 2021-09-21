FROM perl:5.34-slim-buster

COPY mapseq2biom.pl /tools/mapseq2biom.pl

RUN chmod -R a+rwx /tools
ENV PATH="/tools:${PATH}"

##############################################################
# Dockerfile Version:   19.03.1
# Software:             mapseq2biom.pl
# Software Version:     1.0.0
# Description:          Convert mapseq to OTU tsv format for krona
##############################################################


CMD ["mapseq2biom.pl"]