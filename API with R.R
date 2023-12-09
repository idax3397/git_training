#install.packages("httr2")
library(httr2)

# GET dry run examples ------------------------------------------------------------
local_url <- example_url()
local_url
req <- request(local_url)
req %>% 
  req_dry_run() 

# GET with parameter and header -------------------------------------------------------
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("fib") %>%
  req_url_query(n = 7) %>%
  req_headers(authorization = "DM_DV_123#!")
req %>% req_dry_run() 
resp <- req %>% 
  req_perform()
resp %>%
  resp_body_string()
# GET with parameters and header API key -----------------------------------------
req <- request("https://planets-by-api-ninjas.p.rapidapi.com") %>%
  req_url_path("v1/planets") %>%
  req_url_query(name = "Venus") %>%
  req_headers('X-RapidAPI-Key' = 'b1974985e6msh21f518f4fea290bp189d01jsnbcf11a089d57',
              'X-RapidAPI-Host' = 'planets-by-api-ninjas.p.rapidapi.com') 
resp <- req %>% 
  req_perform() 
resp %>%
  resp_body_json()

# GET with string response --------------------------------------------
# String
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("response") %>%
  req_url_query(format = "json") %>%
  req_headers(authorization = "DM_DV_123#!")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_json()


# POST dry run example ------------------------------------------------------------
# Body as an R list
req_body <- list(x = c(1, 2, 3), y = c("a", "b", "c"))
req_body
# Body transformed to JSON in the request
request(example_url()) %>%
  req_body_json(req_body) %>% 
  req_dry_run()

# POST with data ----------------------------------------------------------
# Simulate data
n <- 100
x1 <- rnorm(n = n)
x2 <- rnorm(n = n)
y <- 2*x1 + 3*x2 + rnorm(n = n)
df <- round(data.frame(y = y, x1 = x1, x2 = x2))
# Construct a request including the data
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("lm") %>%
  req_body_json(as.list(df)) %>%
  req_headers(authorization = "DM_DV_123#!")
# Send the request to the API
resp <- req %>% 
  req_perform()
# View the result
resp %>%
  resp_body_json()

# POST with rapid API -----------------------------------------------------
req <- request("https://google-translate1.p.rapidapi.com/language/translate/v2") %>% 
  req_headers('X-RapidAPI-Key' = "56ed76992emshbc75de74d961699p18c1fajsn65d35123364e",
              'X-RapidAPI-Host' = 'google-translate1.p.rapidapi.com' ) %>%
  req_body_form(q = "Hello, world!",
                target = "da")

resp <- req %>% 
  req_perform()
result <- resp %>%
  resp_body_json()

result$data$translations

# Post with rapid API using detect

req <- request("https://google-translate1.p.rapidapi.com/language/translate/v2/detect") %>% 
  req_headers('X-RapidAPI-Key' = "56ed76992emshbc75de74d961699p18c1fajsn65d35123364e",
              'X-RapidAPI-Host' = 'google-translate1.p.rapidapi.com' ) %>%
  req_body_form(q = "Guten heute!",
                target = "da")

resp <- req %>% 
  req_perform()
result <- resp %>%
  resp_body_json()

result$data$detections




