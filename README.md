# Cross-Sectional Momentum on S&P 500

This repo contains all code, data, and a Dockerized environment to reproduce a 12–1 cross-sectional momentum analysis on S&P 500 stocks.
You do not need local R—only Docker.

Docker Hub: richardfbao/d550-final-report:latest
Prebuilt Docker image on DockerHub: **https://hub.docker.com/r/richardfbao/d550-final-report**


## Repository Layout

```text
.
├─ data/
│  ├─ raw/all_stocks_5yr.csv
│  └─ clean/monthly_returns.csv
├─ R_Project.Rmd
├─ Dockerfile
├─ Makefile
└─ report/                  # created at runtime; contains R_Project.html
```


## One-command build of the report (Rubric-ready)

From the repo root, with Docker Desktop running:

`make docker-report`

Output: report/R_Project.html

This target runs docker run and bind-mounts the local report/ directory into the container, so the compiled report is written back to your machine—exactly what the rubric requires for the Makefile + report generation points.


## (Optional) Build the image locally

This satisfies the rubric “docker build README” item.
You can skip this step and use the prebuilt image from DockerHub.
If you want to build locally:

`make docker-build`
# equivalent:
# docker build --platform=linux/amd64 -t richardfbao/d550-final-report:latest .


⸻

## Makefile targets

* `make docker-build` -> Builds richardfbao/d550-final-report:latest locally (uses --platform=linux/amd64 for Apple Silicon compatibility).
* `make report` -> Generates ./report/R_Project.html (alias of docker-report).
* `make clean` -> Removes the local report/ directory.
* `make help` -> Prints target help.

Notes
	* Apple Silicon (M-series): already handled by --platform=linux/amd64 in the build recipe.
	* Windows (Git Bash): if a bind-mount path error occurs, change -v "$(PWD)" to -v "/$(PWD)" in the Makefile (some Git Bash setups need the leading slash).

## Why R is not required locally
The Docker image includes all system deps and R packages (rmarkdown, here, tidyverse, PerformanceAnalytics, xts, zoo, etc.). The container renders R_Project.Rmd and writes the HTML to your mounted report/ directory.

## TA quick check
```
# fresh clone
git clone https://github.com/RichardFranklinBAO/D550_FinalProject.git
cd D550_FinalProject

# render via Docker
make report

# verify artifact exists
test -f report/R_Project.html && echo "✅ report OK" || echo "❌ report missing"
```
## License
For course use and demonstration only.

ardfbao/d550-final-report:latest
