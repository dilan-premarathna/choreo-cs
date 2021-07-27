import ballerina/http;
import ballerina/log;
import ballerina/regex;
import ballerina/time;
import ballerinax/googleapis.gmail;
import ballerinax/googleapis.sheets;

configurable string CLIENT_ID_FEC133F8_DB1F_11EB_969D_6EF1A3EB314C = ?;
configurable string CLIENT_SECRET_FEC133F8_DB1F_11EB_969D_6EF1A3EB314C = ?;
configurable string TOKEN_ENDPOINT_FEC133F8_DB1F_11EB_969D_6EF1A3EB314C = ?;
configurable string REFRESH_TOKEN_FEC133F8_DB1F_11EB_969D_6EF1A3EB314C = ?;

configurable string CLIENT_ID_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98 = ?;
configurable string CLIENT_SECRET_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98 = ?;
configurable string TOKEN_ENDPOINT_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98 = ?;
configurable string REFRESH_TOKEN_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98 = ?;

configurable string CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;

public function main() returns error? {

    sheets:Client sheetsEndpoint = check new ({oauthClientConfig: {
            clientId: CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
            clientSecret: CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
            refreshToken: REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
            refreshUrl: TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222
        }});

    gmail:Client gmailEndpoint = new ({oauthClientConfig: {
            clientId: CLIENT_ID_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98,
            clientSecret: CLIENT_SECRET_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98,
            refreshToken: REFRESH_TOKEN_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98,
            refreshUrl: TOKEN_ENDPOINT_5B1A8A80_DB30_11EB_8A11_2E7A45D2DD98
        }});

    string emailBodyTemplate = string `<html><body><div id=":1sa" class="Am Al editable LW-avf tS-tW" hidefocus="true" aria-label="Message Body" g_editable="true" role="textbox" aria-multiline="true" contenteditable="true" tabindex="1" style="direction: ltr; min-height: 662px;" spellcheck="false"><span id="gmail-docs-internal-guid-0b378384-7fff-b16f-a925-be87c66044b9"><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Hi userName,</span></p><br><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">You are assigned as an '</span><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Incident Handling Rotation member</span><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">' for the next week.&nbsp;</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Start Date - ${
    startDate}&nbsp;</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">End Date - ${
    endDate} (inclusive).</span></p><br><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Please contact your lead if you have any concerns.</span></p><br><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Guideline for the Incident Handling Rotation members:</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Primary task of the people in this rotation is to work on resolving the incidents.</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. After every incident, this team should prepare an RCA report [1].</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. In case you are unavailable during the incident handling rotation period, you need to find a replacement for the unavailable duration.</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. You will receive mobile calls during the rotation in following cases. Therefore please make sure to update your contact information in the incident rotation spreadsheet [2].</span></p><ul style="margin-top: 0px; margin-bottom: 0px; padding-inline-start: 48px;"><li dir="ltr" style="list-style-type: disc; font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre; margin-left: 36pt;"><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;" role="presentation"><span style="font-size: 10pt; background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">PagerDuty alerts (mobile call) for the availability tests that are configured in site24x7&nbsp;</span></p></li><li dir="ltr" style="list-style-type: disc; font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: transparent; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre; margin-left: 36pt;"><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;" role="presentation"><span style="font-size: 10pt; background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">You will be reached via mobile if the dev team, the operation team or the support team need assistance for an incident.</span></p></li></ul><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">      5. Please attend the PagerDuty alerts and if you require assistance please reach out to the CS team, SRE team or the Dev team.</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">      6. You will be added to the '</span><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-weight: 700; font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">Choreo On Call Team'</span><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;"> chat. Alerts will be forwarded to this chat room and please make sure to contribute to these discussions.</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">      7. If there are any queries in the slack channel [3] that are not answered by the choreo product team, the CS team will forward these queries to you. Please make sure to attend them or forward them to the corresponding m</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">embers.</span></p><br><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">This is an automated reminder and there is no need to reply :)</span></p><br><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] https://docs.google.com/spreadsheets/d/1-S1pG75Z7awN_mpq9lv5_d2_C4vtKgi3oGeKkDJcNWo/edit?usp=sharing</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[2] https://docs.google.com/spreadsheets/d/1oFw5rW44ZqtHWKD2cheoIi2NT-0WV9vlQte5TXpO6lI/edit?usp=sharing</span></p><p dir="ltr" style="line-height: 1.38; margin-top: 0pt; margin-bottom: 0pt;"><span style="font-size: 10pt; font-family: &quot;Roboto Mono&quot;, monospace; color: rgb(0, 0, 0); background-color: rgb(255, 255, 254); font-variant-numeric: normal; font-variant-east-asian: normal; vertical-align: baseline; white-space: pre-wrap;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3] https://join.slack.com/t/wso2-choreo/shared_invite/zt-qm86tg1f-R2kXf~26GB6X6Ux0GcuYbQ</span></p></span><br class="gmail-Apple-interchange-newline"><div><br></div>-- <br><div dir="ltr" class="gmail_signature" data-smartmail="gmail_signature"><div dir="ltr"><div><font face="arial, sans-serif">Shanaka Dilan Premarathna</font></div><div><font face="arial, sans-serif">Senior Software Engineer</font></div><div><font face="arial, sans-serif">WSO2 Inc.: <a href="http://wso2.com" target="_blank">http://wso2.com</a></font></div><div><font face="arial, sans-serif">&nbsp;</font></div><div><font face="arial, sans-serif">Email: <a href="mailto:shanakap@wso2.com" target="_blank">shanakap@wso2.com</a></font></div><div><font face="arial, sans-serif">Mobile: +94 71 9596784</font></div></div></div></div></body></html>`;

    int count = 0;
    string sheetName = "Rotation";
    string sheetId = "1oFw5rW44ZqtHWKD2cheoIi2NT-0WV9vlQte5TXpO6lI";
    string message = "Rotation team for the next week are consist of ";

    time:Utc startTimestamp = time:utcAddSeconds(time:utcNow(), 259200);
    string startDate = time:utcToString(startTimestamp).substring(0, 10);

    time:Utc endTimeStamp = time:utcAddSeconds(time:utcNow(), 864000);
    string endDate = time:utcToString(endTimeStamp).substring(0, 10);

    sheets:Column getColumnResponse = check sheetsEndpoint->getColumn(sheetId, sheetName, "A");

    foreach var item in getColumnResponse.values {
        count += 1;

        if (item == startDate) {
            log:printInfo(startDate + " time match " + count.toString());

            sheets:Row getRowResponse = check sheetsEndpoint->getRow(sheetId, sheetName, count);
            json[] arr = getRowResponse.values;
            json[] emailList = [];
            int[] email_position = [1, 3, 5, 7, 9, 11, 13, 15];

            foreach var id in email_position {
                if (arr[id] != "") {
                    emailList.push(arr[id]);
                }
            }

            foreach var email in emailList {
                message = message.concat(email.toJsonString(), " ,");
                string userName = regex:split(email.toString(), "@")[0];
                string emailBody = regex:replaceAll(emailBodyTemplate, "userName", userName);

                gmail:Message sendMessageResponse = check gmailEndpoint->sendMessage({
                    recipient: email.toString(),
                    subject: "[Reminder]  Your Choreo Incident Handling Rotation starts on next Monday ",
                    messageBody: emailBody,
                    contentType: "text/html"
                }, userId = "me");
                log:printInfo(sendMessageResponse.toString());
            }
            http:Client httpEndpoint = check new (
            "https://chat.googleapis.com/v1/spaces/AAAAs_lXKjM/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=qfD-8LQ6DSuJlOn4hsicsV9zAKgQjIFTY4BMyg6RI4g%3D");
            http:Response postResponse = check httpEndpoint->post("", {"text": message});
        } 
    }

}
