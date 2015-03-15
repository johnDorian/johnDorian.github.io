knitPosts <- function(input, base.url = "/") {
  files <- list.files("_Rmd", pattern = ".rmd|.Rmd")
  require(knitr)
  opts_knit$set(base.url = base.url)
  
  library(stringr)
  for(file in files){
    infile = paste0("_Rmd/",file)
    outfile = paste0("_posts/",str_replace(file, ".Rmd|.rmd", ".md"))
    fig.path <- paste0("figures/", sub(".Rmd$", "", basename(file)), "/")
    opts_chunk$set(fig.path = fig.path)
    opts_chunk$set(fig.cap = "center")
    render_jekyll()
    knit(infile,output = outfile)
  }
}