# syntax=docker/dockerfile:1
# Stable R stack with pandoc/tinytex/rmarkdown/tidyverse preinstalled
FROM --platform=linux/amd64 rocker/r-ver:4.4.1

# avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# 系统依赖：pandoc + 编译依赖（解决你日志里报的 libx11-dev）
RUN apt-get update && apt-get install -y --no-install-recommends \
    pandoc libx11-dev libicu-dev libcurl4-openssl-dev libssl-dev libxml2-dev \
 && rm -rf /var/lib/apt/lists/*

# 可选：预装常用 R 包，减少运行时安装
RUN R -q -e "install.packages(c('rmarkdown','knitr','here','dplyr','tidyr','purrr','ggplot2','PerformanceAnalytics','readr','xts','zoo','slider'))"


# Project will be mounted at /work when running the container
WORKDIR /work
ENV OUTDIR=/work/report

# Render script lives inside the image; it expects R_Project.Rmd under /work
COPY code/01_render_report.R /usr/local/bin/01_render_report.R

# Default behavior: render the report
ENTRYPOINT ["Rscript", "/usr/local/bin/01_render_report.R"]

