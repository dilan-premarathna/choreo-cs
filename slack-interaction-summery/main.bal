import ballerina/http;
import ballerina/lang.'int as langint;
import ballerina/lang.'map as maps;
import ballerina/log;
import ballerina/regex;
import ballerina/time;
import ballerinax/googleapis.sheets;
import ballerinax/slack.'listener as slack;

configurable string slackToken = ?;
configurable string slackBotToken = ?;

slack:ListenerConfiguration configuration = {
    port: 8090,
    verificationToken: slackToken
};

listener slack:Listener slackListener = new (configuration);

configurable string CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;

service /slack on slackListener {
    remote function onMessage(slack:MessageEvent event) returns error? {
        log:printInfo("Event received from Slack Channel");
        sheets:Client sheetsEndpoint = check new ({oauthClientConfig: {
                clientId: CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
                clientSecret: CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
                refreshToken: REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
                refreshUrl: TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222
            }});

        // Get the timestamp from slack event
        int slackMsgTimestamp = check langint:fromString(event.event?.ts.toString().substring(0, 10));

        // Convert the slack timestamp to IST
        time:Utc msgTimeStampIST = time:utcAddSeconds([slackMsgTimestamp], 19800);
        string msgDate = time:utcToString(msgTimeStampIST).substring(0, 10);
        string msgTime = time:utcToString(msgTimeStampIST).substring(11, 19);

        // Check if the slack message added was for the general channel 
        if (event.event?.channel.toString() == "C01TCFVPGGP") {
            if (!maps:hasKey(event.event, "parent_user_id")) {
                // Get the email from the user id
                http:Client httpEndpoint = check new ("https://slack.com/api/users.info?user=");
                json getEmailResponse = check httpEndpoint->get(event.event?.user.toString(), headers = {"Authorization": 
                    slackBotToken}, targetType = json);

                // Get the slack message link from the timestamp
                string permLinkQueryParam = "channel=" + event.event?.channel.toString() + "&message_ts=" + event.event?.
                ts.toString();
                http:Client httpEndpointLink = check new ("https://slack.com/api/chat.getPermalink?");
                json getLinkResponse = check httpEndpointLink->get(permLinkQueryParam, headers = {"Authorization": 
                    slackBotToken}, targetType = json);
                json email = check getEmailResponse.user.profile.email;
                json slackLink = check getLinkResponse.permalink;

                // Add the slack message to a new row in spreadsheet
                string[] spreadSheetRowData = [];
                string spreadSheetId = "16M0oNpMZSRG9yhJrfHPbha7m5-BMVdSuFhf5Yn9SvrA";
                string sheetName = "data";
                string suffix = regex:split(email.toString(), "@")[1];
                if (suffix == "wso2.com") {
                    spreadSheetRowData = [msgDate, msgTime, event.event?.text.toString(), email.toString(), "Internal User", "tbd", "tbd", "tbd", "tbd", 
                    slackLink.toString()];
                    log:printInfo("internal user");
                } else {
                    spreadSheetRowData = [msgDate, msgTime, event.event?.text.toString(), email.toString(), "tbd", "tbd", "tbd", "tbd", "tbd", 
                    slackLink.toString()];
                }
                check sheetsEndpoint->appendRowToSheet(spreadSheetId, sheetName, spreadSheetRowData, 
                valueInputOption = "USER_ENTERED");
                log:printInfo("Successfully appended to spreadsheet");
            }
        } else {
            log:printInfo("Channel is not General");
        }
    }
}
