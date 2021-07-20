library(tidyverse)
library(blastula)

# 전자우편 인증키 ----------
create_smtp_creds_key(
    id = 'rconf',
    # user = 'victor@r2bit.com', 
    user = 'victor@aispiration.com', 
    provider = 'gmail',
    overwrite = TRUE,
    use_ssl = TRUE
)

# 후원 대상자 ----------

## 1차 대상 테스트 -----
recipient <- "경기도"
blastula::render_email("korea_r_conference.Rmd")

## 전체 후원 대상 테스트 -----

# usethis::edit_r_environ()

recipient_tbl <- googlesheets4::read_sheet(Sys.getenv("Sponsor_Google_Sheet"))

recipient_tbl

## 전체 후원 대상 목록 -----

preview_email_list <- list()

for(i in 1:nrow(recipient_tbl)) {
    recipient <- recipient_tbl %>% 
        select(Contact) %>% 
        slice(i) %>% 
        pull
    cat(i, ":", recipient, "\n")
    preview_email_list[[i]] <-  blastula::render_email("korea_r_conference.Rmd")
}

preview_email_list[[2]]
