#!/bin/bash
function ccurl() {
    curl --location --cookie cookie.txt --cookie-jar cookie.txt "${@}" --silent
}   
# Create the token
token=$(ccurl --location --request POST 'https://time-aze-flextime-rem-prod.paychex.com/odata/Token(1)/Employee.CreateToken' \
--header 'Accept: application/json' \
--header 'Accept-Language: en-US,en;q=0.9' \
--header 'Connection: keep-alive' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36' \
--data-raw '{"PNGSSOGUID":"004UWBZQL7Z1QTXW19NP","StratusCAID":"004UWBZQKWUW29C24PTV"}' | jq -r '.value')

echo "Token: ${token}"
ccurl --location --request POST 'https://time-aze-flextime-rem-prod.paychex.com/odata/Punch(1)/Employee.AddPunch' \
--header 'Accept: application/json' \
--header 'Accept-Language: en-US,en;q=0.9' \
--header 'Connection: keep-alive' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'PunchSource: 1' \
--header "Token: ${token}" \
--header 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36' \
--data-raw '{"TransactionType":3,"EmployeeNote":"","LaborLevelDetailID":1,"JobCostingDetailID":-1,"LaborDistributionDetailID":8,"IsMobileDevice":false,"LocationCoordinates":"0,0,0","PunchPromptAnswers":null}'