# syntax=docker/dockerfile:1
# Stable R stack with pandoc/tinytex/rmarkdown/tidyverse preinstalled
FROM --platform=linux/amd64 rocker/r-ver:4.4.1

# avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# (light) system deps for a few R packages; keep image small
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev libssl-dev libcurl4-openssl-dev \
 && rm -rf /var/lib/apt/lists/*

# Pre-install all R packages used by the report.
# (Many are already in verse; reinstalling is idempotent and ensures completeness.)
RUN R -q -e "install.packages(c( \
  'here','dplyr','tidyr','purrr','ggplot2','PerformanceAnalytics','slider', \
  'readr','xts','scales','knitr','rmarkdown' \
), repos='https://cran.rstudio.com')"

# Project will be mounted at /work when running the container
WORKDIR /work
ENV OUTDIR=/work/report

# Render script lives inside the image; it expects R_Project.Rmd under /work
COPY 01_render_report.R /usr/local/bin/01_render_report.R

# Default behavior: render the report
ENTRYPOINT ["Rscript", "/usr/local/bin/01_render_report.R"]