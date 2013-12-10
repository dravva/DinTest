
var GlobalFadeOut_Immediate = 0;
var HeroFadeIn_Milliseconds = 1000;
var HeroInterval_Milliseconds = 9000;

var heroArray = [];

heroArray[0] = {
    image: '/dev/content/images/maps-preview-app/heroes/DE_NW_Monchengladbach_Countryside.jpg',
    linkHref: 'bingmaps3d://?cp=51.189345~6.446282&lvl=17&3DCamera=-30~0.1~323.91&cpalt=111&sty=a&trfc=0',
    linkText: 'Mönchengladbach, Germany',
    linkTitle: 'Tap or click to explore Mönchengladbach in 3D'
};

heroArray[1] = {
    image: '/dev/content/images/maps-preview-app/heroes/DE_ST_Halle_MoritzburgCastle.jpg',
    linkHref: 'bingmaps3d://?cp=51.482968~11.973062&lvl=15&3DCamera=-35.1~0~374.81&cpalt=154&sty=a&trfc=0',
    linkText: 'Halle, Germany',
    linkTitle: 'Tap or click to explore Halle in 3D'
};

heroArray[2] = {
    image: '/dev/content/images/maps-preview-app/heroes/ES_A_Alicante---Castle1.jpg',
    linkHref: 'bingmaps3d://?cp=38.350052~-0.47934&lvl=15&3DCamera=-50.3~172.2~1013.15&cpalt=128&sty=a&trfc=0',
    linkText: 'Alicante, Spain',
    linkTitle: 'Tap or click to explore Alicante in 3D'
};

heroArray[3] = {
    image: '/dev/content/images/maps-preview-app/heroes/ES_SE_Seville_PlazaDeEspana.jpg',
    linkHref: 'bingmaps3d://?cp=37.37715~-5.986067&lvl=15&3DCamera=-35.8~6.5~596.98&cpalt=58&sty=a&trfc=0',
    linkText: 'Seville, Spain',
    linkTitle: 'Tap or click to explore Seville in 3D'
};

heroArray[4] = {
    image: '/dev/content/images/maps-preview-app/heroes/ES_V_Valencia_CityOfArtsAndSciences.jpg',
    linkHref: 'bingmaps3d://?cp=39.456143~-0.353967&lvl=14&3DCamera=-29.5~54.7~734.36&cpalt=53&sty=a&trfc=0',
    linkText: 'Valencia, Spain',
    linkTitle: 'Tap or click to explore Valencia in 3D'
};

heroArray[5] = {
    image: '/dev/content/images/maps-preview-app/heroes/FR_13_AixenProvence_GrandTheater.jpg',
    linkHref: 'bingmaps3d://?cp=43.525935~5.43957&lvl=16&3DCamera=-30~240~487.31&cpalt=251&sty=a&trfc=0',
    linkText: 'Aix-en-Provence, France',
    linkTitle: 'Tap or click to explore Aix-en-Provence in 3D'
};

ChangeHero = function(id) {

    HeroFadeOut(GlobalFadeOut_Immediate);

    var iHeroId = (id != null) ? id : Number($("#contentHeroID").val()) + 1;
    if (iHeroId >= heroArray.length) iHeroId = 0;

    var hero = heroArray[iHeroId];
    var heroInnerHtml =
        '<div id="heroImageWrapper" style="display:none"><img src="' + hero.image + '" height="306" width="980" /></div>' +
        '<a id="contentHeroLink" title="' + hero.linkTitle + '" ' +
        'href="' + hero.linkHref + '"><span class="contentHeroText">' + hero.linkText + '</span></a>';

    $("#contentHeroID").val(iHeroId);
    $("#contentHeroInner").html(heroInnerHtml);

    // change selected toolbar item
    $(".heroLink.linkSelected").removeClass("linkSelected");
    $(".heroLink").each(function(index) {
        if (iHeroId == index) $(this).addClass("linkSelected");
    });

    HeroFadeIn(HeroFadeIn_Milliseconds);
};

HeroSetInterval = function() {
    window.heroInterval = window.setInterval(function() { ChangeHero() }, HeroInterval_Milliseconds);
};

HeroClearInterval = function() {
    window.clearInterval(window.heroInterval);
};

HeroStopRotation = function() {
    $("#contentHeroInner").unbind("mouseleave");
    $("#contentHeroInner").unbind("mouseenter");
    HeroClearInterval();
};

HeroFadeOut = function(ms) {
    $("#contentHeroActionPanelBackground").css("visibility", "hidden");
    $("#contentHeroWrapper").css("visibility", "hidden");
    $("#contentHeroWrapper").fadeOut(ms);
    $("#contentHeroActionPanelBackground").fadeOut(ms);
};

HeroFadeIn = function(ms) {
    var heroImageFadeInDelay_Milliseconds = 1500;
    $("#contentHeroWrapper").fadeIn(ms);
    $("#contentHeroActionPanelBackground").fadeIn(ms);
    $("#contentHeroWrapper").css("visibility", "visible");
    $("#contentHeroActionPanelBackground").css("visibility", "visible");
    $("#heroImageWrapper").fadeIn(ms + heroImageFadeInDelay_Milliseconds);
};

HeroImagePreload = function() {
    var preloadInnerHtml = "";
    for (var iHeroId = 0; iHeroId < heroArray.length; iHeroId++) {
        preloadInnerHtml += '<img src="/dev/content/images/maps-preview-app/thumbnails/' +
            heroArray[iHeroId].image + '" height="1" width="1" />';
    }
    $("#contentHeroImagePreload").html(preloadInnerHtml);
};

ResetBannerImage = function () {
    var logoWrapperInnerHtml = '<a href="/"><div class="headerLogoImage">' +
    '<img src="/dev/content/images/chrome/bing_65x25.jpg" alt="Bing" /><span>Bing</span></div></a>';
    $("div.headerLogoWrapper").html(logoWrapperInnerHtml);
};

$(function () {

    ResetBannerImage();
    HeroFadeOut(GlobalFadeOut_Immediate);
    HeroFadeIn(HeroFadeIn_Milliseconds);
    HeroSetInterval();
    HeroImagePreload();

	// add hero event handlers        
	$("#contentHeroInner").mouseenter(HeroClearInterval);
	$("#contentHeroInner").mouseleave(HeroSetInterval);
	$("#contentHeroToolbar").click(HeroStopRotation);

});
