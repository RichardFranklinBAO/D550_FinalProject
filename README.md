# Cross-Sectional Momentum on S&P 500

This repository contains a fully reproducible pipeline (via **Docker**) for a **12–1 cross-sectional momentum** study on S&P 500 stocks (Kaggle “S&P 500 stock data”).

- Report source: `R_Project.Rmd`
- Prebuilt Docker image on DockerHub: **https://hub.docker.com/r/richardfbao/d550-final-report**

---

## Repository Layout

```text
.
├── code/
│   └── 01_render_report.R        # renders R_Project.Rmd; honors OUTDIR env var
├── data/
│   ├── raw/
│   │   └── all_stocks_5yr.csv
│   └── clean/
│       └── monthly_returns.csv
├── Dockerfile
├── Makefile
├── R_Project.Rmd
├── renv/                         # project library (renv)
└── .gitignore                    # includes /report to avoid committing artifacts
```


## Quick Start (Recommended)

Generate the HTML report into a local report/ folder using the Makefile:

`make docker-report`

After it finishes, open:

`report/R_Project.html`

This target pulls (or uses) the image richardfbao/d550-final-report:latest, mounts your project and an output folder, runs the render, and leaves the compiled HTML in report/.

⸻

## How to Build the Docker Image

You can skip this step and use the prebuilt image from DockerHub.
If you want to build locally:

`docker build -t richardfbao/d550-final-report:latest .`

Optionally push to DockerHub (maintainers):

`docker login`
`docker push richardfbao/d550-final-report:latest`


⸻

## How to Create the Report with Docker

A) Using the Makefile (cross-platform)

`make docker-report`

B) Raw docker run command (Mac/Linux)

`mkdir -p report`
`
docker run --rm \
  -v "$PWD":/work \
  -v "$PWD/report":/out \
  -w /work \
  -e OUTDIR=/out \
  richardfbao/d550-final-report:latest
`

Windows (Git Bash) path note

On Git Bash you often need an extra leading / for mounts, e.g.:

`mkdir -p report`
`docker run --rm \
  -v "//c/Users/<YOU>/path/to/project":/work \
  -v "//c/Users/<YOU>/path/to/project/report":/out \
  -w /work \
  -e OUTDIR=/out \
  richardfbao/d550-final-report:latest`

After the container exits, the report is available at report/R_Project.html.

⸻

Local (non-Docker) Build

If you prefer running locally (R 4.4+, renv activated):

# from an R session in the project root
source("code/01_render_report.R")   # or: rmarkdown::render("R_Project.Rmd")


⸻

Methods (What the report does)
	1.	Read raw daily OHLCV data and aggregate to monthly log returns.
	2.	Construct 12–1 momentum (t−12 to t−2, skipping t−1).
	3.	Form deciles; compute long–short (Q10–Q1) returns.
	4.	Report annualized return/vol/Sharpe; plot cumulative gross vs. net returns.

⸻

Reproducibility Notes
	•	Dependencies are managed with renv inside the container; the image installs needed system/R packages.
	•	Build artifacts are ignored by Git via .gitignore (contains /report).

⸻

Make Targets

make docker-pull     # pull image from DockerHub
make docker-build    # build image locally
make docker-report   # run containerized render -> report/R_Project.html
make clean           # remove local report/ artifacts


⸻

Contact

Maintainer: richardfbao
DockerHub image: richardfbao/d550-final-report:latest
