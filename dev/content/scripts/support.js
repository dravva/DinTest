
var GlobalFadeOut_Immediate = 0;
var FeedPanelFadeIn_Milliseconds = 500;
var RightPanelFadeIn_Milliseconds = 2000;
var EmptyRssFeed_Html = "<div></div>";

$(function () {

    // load blog content
    $("#blogFeed_02").fadeOut(GlobalFadeOut_Immediate);
    $("#blogFeed_01").fadeOut(GlobalFadeOut_Immediate);
    $("#blogFeed_00").fadeOut(GlobalFadeOut_Immediate);
    $("#contentRightContent").fadeOut(GlobalFadeOut_Immediate);

    var blogSectionSuccess = false;

    var loadFeedUrl_00 = (appVirtualPath ? appVirtualPath : "") + "rss-feed?type=support-feed-00";
    $("#blogFeed_00").load(loadFeedUrl_00, function (response, status, xhr) {
        var emptyFeed = (response == EmptyRssFeed_Html);
        if (status == "error" || emptyFeed) {
            $("#blogFeed_00").text("");
            $("#feedSectionHeader_00").text("");
        } else {
            $("#blogFeed_00").fadeIn(FeedPanelFadeIn_Milliseconds);
            blogSectionSuccess = true;
        }
    });

    var loadFeedUrl_01 = (appVirtualPath ? appVirtualPath : "") + "rss-feed?type=support-feed-01";
    $("#blogFeed_01").load(loadFeedUrl_01, function (response, status, xhr) {
        var emptyFeed = (response == EmptyRssFeed_Html);
        if (status == "error" || emptyFeed) {
            $("#blogFeed_01").text("");
            $("#feedSectionHeader_01").text("");
        } else {
            $("#blogFeed_01").fadeIn(FeedPanelFadeIn_Milliseconds);
            blogSectionSuccess = true;
        }
    });

    var loadFeedUrl_02 = (appVirtualPath ? appVirtualPath : "") + "rss-feed?type=support-feed-02";
    $("#blogFeed_02").load(loadFeedUrl_02, function (response, status, xhr) {
        var emptyFeed = (response == EmptyRssFeed_Html);
        if (status == "error" || emptyFeed) {
            $("#blogFeed_02").text("");
            $("#feedSectionHeader_02").text("");
        } else {
            $("#blogFeed_02").fadeIn(FeedPanelFadeIn_Milliseconds);
            blogSectionSuccess = true;
        }
    });

    var loadFeedUrl_03 = (appVirtualPath ? appVirtualPath : "") + "rss-feed?type=support-feed-03";
    $("#blogFeed_03").load(loadFeedUrl_03, function (response, status, xhr) {
        var emptyFeed = (response == EmptyRssFeed_Html);
        if (status == "error" || emptyFeed) {
            $("#blogFeed_03").text("");
            $("#feedSectionHeader_03").text("");
            if (blogSectionSuccess == false) {
                $("#feedSectionHeader").text("");
            }
        } else {
            $("#blogFeed_03").fadeIn(FeedPanelFadeIn_Milliseconds);
        }
        
        // after last feed loaded fade in right-panel
        $("#contentRightContent").fadeIn(RightPanelFadeIn_Milliseconds);
        
        // show right-panel and it's headers and sub headers
        $("#feedSectionHeader").css("display", "block");
        $("#feedSectionHeader_00").css("display", "block");
        $("#feedSectionHeader_01").css("display", "block");
        $("#feedSectionHeader_02").css("display", "block");
        $("#feedSectionHeader_03").css("display", "block");
        $("#contentRightContent").css("display", "block");
    });
});
