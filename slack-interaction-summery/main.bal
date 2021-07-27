import ballerina/http;
import ballerina/lang.'int as langint;
import ballerina/lang.'map as maps;
import ballerina/log;
import ballerina/regex;
import ballerina/time;
import ballerinax/googleapis.sheets;
import ballerinax/slack.'listener as slack;

const string EMPTY_STRING = "";

# Description
#
# + date - Slack message received date    
# + time - Slack message received time    
# + message - Slack message    
# + userEmail - Slack user Email    
# + userState - User state "Internal User" or "External User"  
# + messageLink - Link to the slack message
public type SlackAttribute record {
    string date = EMPTY_STRING;
    string time = EMPTY_STRING;
    string message = EMPTY_STRING;
    string userEmail = EMPTY_STRING;
    string userState = EMPTY_STRING;
    string messageLink = EMPTY_STRING;
};

# Description
#
# + user - Slack user details  
public type UserDetail record {
    SlackUser user;
};

# Description
#
# + profile - Slack user profile details
public type SlackUser record {
    SlackUserProfile profile;
};

# Description
#
# + email - Slack User email  
public type SlackUserProfile record {
    string email;
};

# Description
#
# + permalink - Slack Chat URL  
public type SlackChatURL record {
    string permalink;
};

configurable string slackToken = ?;
configurable string slackBotToken = ?;
configurable string CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;
configurable string REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222 = ?;

string channelId = "C01TCFVPGGP";
string sheetName = "data";
string spreadSheetId = "16M0oNpMZSRG9yhJrfHPbha7m5-BMVdSuFhf5Yn9SvrA";

slack:ListenerConfiguration configuration = {
    port: 8090,
    verificationToken: slackToken
};

listener slack:Listener slackListener = new (configuration);

sheets:Client sheetsEndpoint = check new ({
    oauthClientConfig: {
        clientId: CLIENT_ID_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
        clientSecret: CLIENT_SECRET_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
        refreshToken: REFRESH_TOKEN_16E5D1DF_CF26_11EB_8DA9_1E403C197222,
        refreshUrl: TOKEN_ENDPOINT_16E5D1DF_CF26_11EB_8DA9_1E403C197222
    }
});

service /slack on slackListener {
    remote function onMessage(slack:MessageEvent event) returns error? {
        log:printInfo("Event received from Slack Channel");

        // Get the timestamp from slack event
        int slackMsgTimestamp = check langint:fromString(event.event?.ts.toString().substring(0, 10));

        // Convert the slack timestamp to IST
        time:Utc msgTimeStampIST = time:utcAddSeconds([slackMsgTimestamp], 19800);
        SlackAttribute slackMessage = {
            date :time:utcToString(msgTimeStampIST).substring(0, 10),
            time :time:utcToString(msgTimeStampIST).substring(11, 19)
        };
    
        string slackEventChannel = event.event?.channel.toString();
        // Check if the slack message added was for the general channel 
        if (slackEventChannel == channelId) {
            // Check if it is new message or a thread reply
            if (!maps:hasKey(event.event, "parent_user_id")) {
                _ = check getSlackUserEmail(event.event?.user.toString(), slackMessage);
                slackMessage.message = event.event?.text.toString();
                _ = check getSlackPermLink(event.event?.ts, slackMessage);
                string suffix = regex:split(slackMessage.userEmail, "@")[1];
                if (suffix == "wso2.com") {
                    slackMessage.userState = "Internal User";
                    log:printInfo("internal user");
                } else {
                    slackMessage.userState = "tbd";
                }
                check addSlackMessageToSpreadSheet(slackMessage);
                log:printInfo("Successfully appended to spreadsheet");
            }
        } else {
            log:printInfo("Channel is not General");
        }
    }
}

// Get the email from the user id
function getSlackUserEmail(string userId, SlackAttribute slackMessage) returns error? {
    http:Client httpEndpoint = check new ("https://slack.com/api/users.info?user=");
    UserDetail response = check httpEndpoint->get(userId, headers = {"Authorization": slackBotToken}, targetType =
         UserDetail);
    slackMessage.userEmail = response.user.profile.email;
}

// Get the slack message link from the timestamp
function getSlackPermLink(string? timeStamp, SlackAttribute slackMessage) returns error? {
    if (timeStamp is string) {
        string permLinkQueryParam = "channel=" + channelId + "&message_ts=" + timeStamp;
        http:Client httpEndpointLink = check new ("https://slack.com/api/chat.getPermalink?");
        SlackChatURL response = check httpEndpointLink->get(permLinkQueryParam, headers = 
            {"Authorization": slackBotToken}, targetType = SlackChatURL);
        slackMessage.messageLink = response.permalink;
    }
}

// Add slack message to a new row in spreadsheet
function addSlackMessageToSpreadSheet(SlackAttribute slackMessage) returns error? {
    string[] spreadSheetRowData = [slackMessage.date, slackMessage.time, slackMessage.message, slackMessage.userEmail, 
        slackMessage.userState, "tbd", "tbd", "tbd", "tbd", slackMessage.messageLink];
    check sheetsEndpoint->appendRowToSheet(spreadSheetId, sheetName, spreadSheetRowData, 
        valueInputOption = "USER_ENTERED");
}
