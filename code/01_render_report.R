# --- make renv robust in container ---
if (file.exists("renv.lock")) {
  if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
  renv::restore(prompt = FALSE)
}
# -------------------------------------

# 下面保持你的原有渲染逻辑
rmarkdown::render("R_Project.Rmd", output_file = file.path(Sys.getenv("OUTDIR", "."), "R_Project.html"))

# code/01_render_report.R
here::i_am("code/01_render_report.R")

out <- Sys.getenv("OUTDIR", unset = "report")
dir.create(out, recursive = TRUE, showWarnings = FALSE)

rmarkdown::render(
  here::here("R_Project.Rmd"),
  output_file = file.path(out, "R_Project.html")
)