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

# 전자우편 발송 날짜 -------
date_time <- add_readable_time()

# 한국 R 컨퍼런스 로고 ----

img_string <- add_image(file = "fig/koRea_logo.png")

# 전자우편 본문 -----------

email <-
    compose_email(
        body = md(glue::glue(
            " 안녕하세요. 
            
한국 R 컨퍼런스는 기존 통계학 관련 학계, 산업계, 정부 뿐 아니라 데이터 과학계까지 망라해 데이터를 통해 문제를 해결하고 가치를 창출하고자 하는 모든 분이 모여 경험과 지식을 공유하고 네트워킹을 할 수 있는 자리로 기획된 데이터 과학 R 컨퍼런스입니다. 데이터 활용의 폭과 깊이를 더한 금번 컨퍼런스에서 데이터를 통해 새로운 세상을 열어가고 함께 하실 수 있는 많은 분을 만나는 소중한 시간이 되도록 준비되었습니다.
            
코로나19라는 특수한 상황에서도 저명한 데이터 과학자인 Julia Silge 박사님을 키노트 연사로 모셨고, 국내 R을 소개하고 보급하는데 20년 이상 기여해주신 유충현님을 모셔 충실한 컨퍼런스로 준비했으며 R을 학계와 현업에 오랜동안 활용하여 가치를 창출하신 발표자분들로 R 컨퍼런스를 준비했습니다.

한국 R 컨퍼런스는 롯데월드타워에서 실시간 발표자분들을 모시고 온라인 라이브로 2021년 11월 19일 개최됩니다.

Seoul R Meetup 운영경험을 살려 온라인에서도 오프라인에서의 생생함을 전달하고, 참가자와 후원사간에도 데이터를 통한 가치창출을 위해 노력하고 있습니다. 

발표자, 참가자, 후원사와 함께 한국 R 컨퍼런스를 성공적으로 만들고자 합니다.

- 한국 R 컨퍼런스 2021 웹페이지: <https://use-r.kr>
- 후원(Sponsor) 안내: <https://tidyverse-korea.github.io/sponsor/>
- 후원계좌: 하나은행 403-910048-29504, 알(R) 사용자회

관련하여 문의사항이 계신 경우, 해당 메일로 회신주시거나 R 사용자회(admin@r2bit.com) 메일 부탁드립니다.

후원사 참여제안에 대한 긍정적인 검토와 후원사의 적극적인 참여를 부탁드립니다.

감사합니다.

{img_string}
")),
        footer = md(glue::glue("Email sent on {date_time}."))
    )

# 미리보기 ----------------
email

# 발송 ----------------
email %>%
    smtp_send(
        to = "kwangchun.lee.7@gmail.com",
        from = "victor@aispiration.com",
        subject = "한국 R 컨퍼런스 후원 테스트",
        credentials = creds_key("rconf")
        # credentials = blastula::creds(
        #     user = "victor@aispiration.com",
        #     provider = "gmail")
    )


