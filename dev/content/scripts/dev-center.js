
var GlobalFadeOut_Immediate = 0;
var HeroFadeIn_Milliseconds = 1000;
var HeroInterval_Milliseconds = 9000;
var RightPanelFadeIn_Milliseconds = 2000;
var EmptyRssFeed_Html = "<div></div>";

GetHeroLink = function (id) {
	if (heroArray[id]) {
		var href = heroArray[id].linkHref;
		var target = heroArray[id].linkTarget;
		if (href && href.length) OpenExternalWindow(href, target);
	}
}

ChangeHero = function (id) {

    HeroFadeOut(GlobalFadeOut_Immediate);

	var iHeroID = (id != null) ? id : Number($("#contentHeroID").val()) + 1;
	if (iHeroID >= heroArray.length) iHeroID = 0;

	var hero = heroArray[iHeroID];
	var linkWrapperDisplay = (hero.linkHref.length == 0 || hero.linkText.length == 0) ? "hidden" : "visible";
	var heroInnerHtml = heroArray[iHeroID].content;
    
	if (heroArray[iHeroID].type == "0") {
	    heroInnerHtml =
        '<div class="contentHeroMainPanel"><div class="contentHeroMainPanelTop">' +
        '<div class="largest" id="contentHeroHeader">' + heroArray[iHeroID].header + '</div>' +
        '<div class="normal" id="contentHeroSubtext">' + heroArray[iHeroID].subtext + '</div></div>' +
        '<div class="contentHeroMainPanelBottom" id="contentHeroLinkWrapper" style="visibility:' + linkWrapperDisplay + '"><a ' +
        'id="contentHeroLink" href="' + heroArray[iHeroID].linkHref + '" target="' + heroArray[iHeroID].linkTarget +
        '"><div class="centerAlign" id="contentHeroLinkText">' + heroArray[iHeroID].linkText +
        '</div></a></div></div><div class="contentHeroActionPanel"><div class="contentHeroActionPanelBackground opacity95" id="contentHeroActionPanelBackground" ' +
        'style="display:block;visibility:hidden"></div><div class="contentHeroActionPanelContent" id="contentHeroContent">' + heroArray[iHeroID].content + '</div></div>';
	}

    // prepend the absolutely positioned hero image
	heroInnerHtml =
	    '<div id="heroImageWrapper" style="position:absolute;width:980px;height:280px;overflow:hidden;display:none"><img src="' +
	    heroArray[iHeroID].image + '" height="280" width="980" /></div>' + heroInnerHtml;

	$("#contentHeroID").val(iHeroID);
	$("#contentHeroInner").html(heroInnerHtml);
	$(".heroLink.linkSelected").removeClass("linkSelected");
	$("#heroLink" + iHeroID).addClass("linkSelected");

	HeroFadeIn(HeroFadeIn_Milliseconds);
}

HeroSetInterval = function () {
    window.heroInterval = window.setInterval(function () { ChangeHero() }, HeroInterval_Milliseconds);
}

HeroClearInterval = function () {
    window.clearInterval(window.heroInterval);
}

HeroStopRotation = function () {
    $("#contentHeroInner").unbind("mouseleave");
    $("#contentHeroInner").unbind("mouseenter");
	HeroClearInterval();
}

HeroFadeOut = function (ms) {
    $("#contentHeroActionPanelBackground").css("visibility", "hidden");
    $("#contentHeroWrapper").css("visibility", "hidden");
    $("#contentHeroWrapper").fadeOut(ms);
    $("#contentHeroActionPanelBackground").fadeOut(ms);
}

HeroFadeIn = function (ms) {
    var heroImageFadeInDelay_Milliseconds = 1500;
    $("#contentHeroWrapper").fadeIn(ms);
    $("#contentHeroActionPanelBackground").fadeIn(ms);
    $("#contentHeroWrapper").css("visibility", "visible");
    $("#contentHeroActionPanelBackground").css("visibility", "visible");
    $("#heroImageWrapper").fadeIn(ms + heroImageFadeInDelay_Milliseconds);
}

$(function () {

    HeroFadeOut(GlobalFadeOut_Immediate);
    HeroFadeIn(HeroFadeIn_Milliseconds);

    // load blog content
    $("#contentRightContent").fadeOut(GlobalFadeOut_Immediate);
    var loadFeedUrl = (appVirtualPath ? appVirtualPath : "") + "rss-feed?type=dev-center-feed";
    $("#blogFeed").load(loadFeedUrl, function (response, status, xhr) {
        var emptyFeed = (response == EmptyRssFeed_Html);
        if (status == "error" || emptyFeed) {
		    var msg = '<h1 class="contentSectionHeader">&#160;</h1>';
		    $("#feedSectionHeader").html(msg);
		    $("#blogFeed").html("");
		}
        $("#contentRightContent").fadeIn(RightPanelFadeIn_Milliseconds);
		$("#contentRightContent").css("display", "block");
	});

	// begin hero rotator
	HeroSetInterval();

	// add hero event handlers        
	$("#contentHeroInner").mouseenter(HeroClearInterval);
	$("#contentHeroInner").mouseleave(HeroSetInterval);
	$("#contentHeroInner").click(HeroStopRotation);
	$("#contentHeroToolbar").click(HeroStopRotation);
});
