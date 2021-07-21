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

## 전체 후원 대상 -----

# usethis::edit_r_environ()

recipient_tbl <- googlesheets4::read_sheet(Sys.getenv("Sponsor_Google_Sheet"))

recipient_tbl

# 전체 후원 대상 전자우편 생성 -----

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

# 전체 메일 발송 -----

preview_email_list[[1]] %>%
    smtp_send(
        to = "kwangchun.lee.7@gmail.com",
        from = "victor@aispiration.com",
        subject = "한국 R 컨퍼런스 후원 테스트",
        credentials = creds_key("rconf")
        # credentials = blastula::creds(
        #     user = "victor@aispiration.com",
        #     provider = "gmail")
    )

# 메일 HTML --> Image -----


webshot2::webshot(url = preview_email_list[[1]], file = "data/test.html")

preview_email_list[[1]]$html_str %>% writeLines("data/test.html")

webshot2::webshot("data/test.html", file = "fig/test.png")

## 1. HTML 추출    
# mail_html <- map(preview_email_list, "html_str")

# recipient_tbl$후원사명


preview_email_list %>% 
    write_rds("data/preview_email_list.rds")
