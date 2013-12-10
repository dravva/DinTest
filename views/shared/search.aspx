<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Microsoft.Bing.DevCenter.Models.SearchPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Resources" %>
<div class="Clear"></div>
<noscript>
    <h2>Javascript is disabled.</h2>
    <p>The page you are trying to view requires Javascript to be enabled in your browser. 
        Please enable Javascript and refresh the page.</p>    
</noscript>

<script id="DebugTmpl" type="text/x-jquery-tmpl">
    <div id="DebugModeHeader">
        DEBUG MODE ACTIVE
    </div>

    {{if build_version}}
    <div id="DebugBuildVersion">
        <strong>Build Version</strong>
        <div id="DebugBuildVersionContent" class="contents">
            ${build_version}
        </div>
    </div>
    {{/if}}

    {{if resolved_locale}}
    <div id="DebugLocale">
        <strong>Resolved Locale</strong>
        <div id="DebugLocaleContent" class="contents">
            ${resolved_locale}
        </div>
    </div>
    {{/if}}

    <div id="DebugQuery">
        <strong>Query</strong>
        <div id="DebugQueryContent" class="contents">
            {{html query}}
        </div>
    </div>

    {{if refinements}}
    <div id="DebugRefinements">
        <strong>Refinements</strong>
        <div id="DebugRefinementsContent" class="contents">
            <table border="1">
                <tr><th width="100">Id</th><th>Name</th><th>Type</th><th width="100">Matches</th><th>Weight</th></tr>
                {{each refinements}}
                <tr><td>${id}</td><td>${name}&nbsp;&nbsp;&nbsp;</td><td>${type}&nbsp;&nbsp;&nbsp;</td><td>${matches}</td><td>${weight}</td></tr>
                {{/each}}
            </table>
        </div>
    </div>
    {{/if}}
</script>

<script id="AuthorTmpl" type="text/x-jquery-tmpl">
    {{if metadata['author']}}
    <span class="ResultAuthor inlineRtl">
        <br />
        by ${metadata['author']}
    </span>
    {{/if}}
</script>

<script id="PublisherTmpl" type="text/x-jquery-tmpl">
    {{if metadata['publisher']}}
    <span class="ResultAuthor inlineRtl">
        {{if metadata['publisher_url']}}
            <br />
            by <a href="${metadata['publisher_url']}">${metadata['publisher']}</a>
            {{if metadata['affiliation']}}
                (${metadata['affiliation']})
            {{/if}}
        {{else}}
            by ${metadata['publisher']}
        {{/if}}
    </span>
    {{/if}}
</script>

<script id="ForumsResultsMetadataItemTmpl" type="text/x-jquery-tmpl">
    {{if metadata['post_count'] && metadata['post_count'] >= 0}}
    <tr>
        <td class="ResultStatusIconCell">
            <div class="${getForumsStatusStyle(metadata)}"></div>
        </td>
        <td class="ResultStatusText">
            ${getForumsStatus(metadata)}
        </td>
    </tr>
    {{/if}}
</script>

<script id="GalleriesResultsMetadataItemTmpl" type="text/x-jquery-tmpl">
    <tr>
        <td>
            {{if metadata['ratings_count'] > 0}}
            <div style="font-size: .9em; white-space: nowrap;">
                {{tmpl({metadata: metadata}) '#RatingStarsTmpl'}}
                (${metadata['ratings_count']})
            </div>
            {{/if}}
            <div>${metadata['published_date_display']}</div>
            {{if metadata['downloads_count'] > 0}}
            <div>${metadata['downloads_count_display']} Downloads</div>
            {{/if}}
        </td>
    </tr>
</script>

<script id="RatingStarsTmpl" type="text/x-jquery-tmpl">
    <span class="RatingStarContainer" title="${metadata['rating_display']} star rating">
        {{each(i) [1, 2, 3, 4, 5]}}
        <div class="${getStarStyle(i, metadata['rating'])}">&nbsp;</div>
        {{/each}}
    </span>
</script>

<script id="LibraryRatingResultsMetadataItemTmpl" type="text/x-jquery-tmpl">
    {{if metadata['code_language']}}
    <tr>
        <td class="ResultStatusIconCell">
            <div class="ResultStatusIcon ResultStatusIconLibrary" />
        </td><td class="ResultStatusText">
             Includes Example Code
         </td>
    </tr>
    {{/if}}
    {{if metadata['rating'] > 0}} 
    <tr id="LibraryRatingsRow">
        <td colspan="2">Rating <span 
            class="LibraryRatingStars inlineRtl">
                {{tmpl({metadata: metadata}) '#RatingStarsTmpl'}}
            </span>
        </td>
    </tr>
    {{/if}}
</script>

<script id="ConnectResultsMetadataItemTmpl" type="text/x-jquery-tmpl">
    <tr>
        <td class="ResultStatusIconCell"><div class="${getConnectStatusStyle(metadata)}" /></td>
        <td class="ResultStatusText">${getConnectStatusText(metadata)}</td>
    </tr>
</script>

<script id="CodePlexResultsMetadataItemTmpl" type="text/x-jquery-tmpl">
    <tr>
        <td>
            <a href="${metadata['project_url']}">${metadata['release_name']}</a>
        </td>
    </tr>
    <tr>
        <td>
            <span class="inlineRtl">${metadata['release_date_display']}</span>
        </td>
    </tr>
    {{if metadata['rating'] > 0}} 
    <tr>
        <td>
            <span class="RatingStarContainer inlineRtl">
                {{tmpl({metadata: metadata}) '#RatingStarsTmpl'}}
                &nbsp; ${getCodePlexRatingsReviewsCountDisplay(metadata)}
            </span>
        </td>
    </tr>
    {{/if}}
</script>

<script id="HorizontalMetadataTmpl" type="text/x-jquery-tmpl">
    <div class="ResultMetaData">
        {{each data}}
        <div class="ResultMetaDataItem">
            <span class="ResultMetaDataName inlineRtl">${title.toUpperCase()}</span>
            <span class="ResultMetaDataValue">{{html value}}</span>
        </div>
        {{/each}}
		<div class="Clear"></div>
    </div>
</script>

<script id="ResultsTmpl" type="text/x-jquery-tmpl">
    {{each(index, value) items}}
    <div class="SearchResult">
        <div class="ResultItemRight" style="display:none">
            {{if matching_refinements.source[0]}}
            <div class="ResultItemSourceRefinement">
                <div class="inlineRtl">
                    {{if !Page.sourceRefinementSelected}}
                    <a class="resultMetadataHeader" href="javascript:void(0);" data-id="${matching_refinements.source[0].id}" data-url="${matching_refinements.source[0].url}">${matching_refinements.source[0].name}</a>
                    {{else}}
                    ${matching_refinements.source[0].name}
                    {{/if}}
                </div>
            </div>
            <table border="0" cellpadding="0" cellspacing="0" class="StatusInfo" width="100%">
                {{if matching_refinements.source[0].id === 117}}
                    {{tmpl({metadata: metadata}) '#LibraryRatingResultsMetadataItemTmpl'}} 
                {{/if}}
                {{if matching_refinements.source[0].id === 456}}
                    {{tmpl({metadata: metadata}) '#CodePlexResultsMetadataItemTmpl'}} 
                {{/if}}
                {{if matching_refinements.source[0].id === 449}}
                    {{tmpl({metadata: metadata}) '#ConnectResultsMetadataItemTmpl'}} 
                {{/if}}
                {{if matching_refinements.source[0].id === 200 || matching_refinements.source[0].id === 201}}
                    {{tmpl({metadata: metadata}) '#GalleriesResultsMetadataItemTmpl'}} 
                {{/if}}
                {{if matching_refinements.source[0].id === 112}}
                    {{tmpl({metadata: metadata}) '#ForumsResultsMetadataItemTmpl'}} 
                {{/if}}
                {{if (matching_refinements.source[0].id === 300 || matching_refinements.source[0].id === 117) && metadata['thumbnail_url'] }}
                    <tr><td align="center"><img src="${metadata['thumbnail_url']}" /></td></tr>
                {{/if}}
            </table>
            {{/if}}
        </div>
        <div class="ResultItemThumbnail">
            {{if metadata['thumbnail_url'] && matching_refinements.source[0] && matching_refinements.source[0].id != 300 && matching_refinements.source[0].id != 117}}
            <img src="${metadata['thumbnail_url']}" />
            {{/if}}
        </div>
        <div class="result">
            <a class="resultTitleLink"
               data-refinementId="${value.matching_refinements.source[0] ? value.matching_refinements.source[0].id : 0}" 
               data-index="${index}" href="${url}">{{html title}}&#x200E;</a>&nbsp;
            {{tmpl(this) '#AuthorTmpl'}}
            {{tmpl(this) '#PublisherTmpl'}}
            <div class="ResultDescription">{{html description}}</div>
            <div class="ResultUrl">{{html display_url}}</div>
            {{if matching_refinements.source[0]}}
            {{tmpl({data: getMetadataForRefinement(matching_refinements.source[0].id, this.metadata)}) '#HorizontalMetadataTmpl'}}
            {{/if}}
        </div>
    </div>
    <div class="ResultSeperator">
    </div>
    {{/each}}
</script>

<script id="ResultsDetailsTmpl" type="text/x-jquery-tmpl">
    <div class="ResultsNavPanel">
        <div id="ResultsMessageDiv">
            <span class="ResultsMessage">{{html message}}</span> 
            <span class="Elapsed" style="display:none"> <a 
                class="RssLink" href="#" onclick="return false;"
                title="Results in RSS" class="Left"><div class="rssfeed"></div></a></span>        
        </div>
    </div>
</script>

<script id="ResultsSpellCorrectionNotification" type="text/x-jquery-tmpl">    
</script>

<script id="PagerTmpl" type="text/x-jquery-tmpl">
    {{if previous}}
    <div><a href="javascript:void(0);" id="PreviousPageLink" data-id="${previous.text}" data-url="${previous.url}"> <span>&lt;&lt;</span></a></div>
    {{/if}}
    {{each numbered}}
        <div>
      {{if url}}<a href="javascript:void(0);" data-id="${text}" data-url="${url}">{{/if}}
      ${text}
      {{if url}}</a>{{/if}}
      </div>
    {{/each}}
    {{if next}}
    <a href="javascript:void(0);" id="NextPageLink" data-id="${next.text}" data-url="${next.url}"> <span>&gt;&gt;</span></a>
    {{/if}}
</script>

<script id="CurrentRefinementsTmpl" type="text/x-jquery-tmpl">   
    <li>
        <span class="inlineRtl">
            <div class="removeAll RefinementLink">
                <a id="removeAllRefinements" href="javascript:void(0);">Remove All</a>
            </div>
        </span>
    </li>
</script>

<script id="RefinementsTmpl" type="text/x-jquery-tmpl">
    {{each items}}
    <li data-id="${id}">
        <div class="RefinementCheckbox">
        <input type="checkbox" class="RefinementCheckBox" name="chkbox" id="${id}" data-id="${id}" data-url="${url}"/>
        </div>
        <label class="RefinementLabel" for="${id}" title="${name}">${name}</label>
        <div class="Clear"></div>
    </li>
    {{/each}}
</script>

<script id="RatingTmpl" type="text/x-jquery-tmpl">
    {{each items}}
        <li>
            <div class="RefinementLink">
                <span class="inlineRtl">
                    <a class="RefinementLinkAnchor" data-id="${id}">${name}</a>
                </span>
            </div>
        </li>
    {{/each}}
</script>

<script type="text/javascript">
    
    var searchResources = {
        forumStatsAnsweredLabel: 'Answered Question',
        forumStatsUnansweredLabel: 'Unanswered Question',
        forumStatsDiscussionsLabel: 'General Discussion',
        resultsMessage: 'Results {0} of about {1} for: <span id="SearchResultsQueryString"><b><%: Model.SearchQuery %></b></span>',
        resultsMessageShort: 'Results {0} of about {1} for: <span id="SearchResultsQueryString"><b><%: Model.SearchQuery %></b></span>',
        threadStatRepliesLabel:'REPLIES',
        connectCreatedHeading: 'CREATED',
        connectValidationsLabel: 'VALIDATIONS',
        connectWorkaroundsLabel: 'WORKAROUNDS', 
        connectCommentsLabel: 'COMMENTS', 
        codeplexPageViewsLabel: 'PAGE VIEWS', 
        codeplexDownloadsCountLabel: 'DOWNLOADS', 
        codeplexContributorsLabel: 'CONTRIBUTORS',
        codeplexLicenseLabel: 'LICENSE', 
        codeplexNumberOfRatingsSingular: '1 rating',
        codeplexNumberOfRatingsPlural: '{0} ratings',
        codeplexNumberOfReviewsSingular: '1 review', 
        codeplexNumberOfReviewsPlural: '{0} reviews',
        galleriesTagsLabel: 'Tags',
        videoDurationLabel: 'Length',
        videoViewCountLabel: 'Views'
    };
    
    var Page = {
        sourceRefinementSelected: false,
        isSearch: true,
        autoCompleteCode: 0,
        omnitureEnabled: true,
        maxNumOfItemsPerPage: 20,
        maxTotalResults: 1000,
        hasInstantAnswer: false,
        errorUrl: '/dev/search/<%= Model.LocaleId %>/error?query=<%= Model.EncodedQuery %>',
        baseApiUrl: '<%= Model.FormattedSearchApiUrl %>'
    };

    $(function () {
        var results = <%= Model.JsonOutput %>;
        if (results.data) {
            window.initialSourceRefinements = results.data.refinements.source;
            dataReady(results, true);
        }
    });
</script>
<div id="DebugOutput" style="display:none"></div>
<div id="Search">
    <table id="SearchTable" cellpadding="0" cellspacing="0">
        <tr>
            <td class="content" id="ContentTableCell" style="width: 100%; vertical-align: top">
                <div id="resultSearchBox" style="clear:both;float:none;margin:18px 0 18px 0">
                    <form action="search" method="get">
                        <input id="resultSearchBoxText" name="query" type="text" maxlength="100" autocomplete="off" 
                            value="<%: Model.SearchQuery %>" />
                        <input name="Refinement" type="hidden" value="<%: Constants.SearchApiRefinementId %>" />
                        <input id="resultSearchBoxButton" title="<%: Strings.Search_Dev_Center_with_Bing %>" type="submit" value="" />
                    </form>
                </div>
                <div class="SearchInfo"></div>
                <div id="SearchResultsDisplay"></div>
                <div class="SearchInfo"></div>
                <div class="PagingDiv"></div>
                <div id="NoResultsContainer" class="NoResultsContainer" style="display: none;">
                    <div class="HelpPanel">
                        <div class="NoResultsMessage">
                            <div class="headerText">
                                <span class="inlineRtl">No Results Found For:</span> <strong><%= Model.SearchQuery %></strong>
                            </div>
                            <br />Can’t find it? Here are some options:
                            <ul>
                                <li>Change your query to use different or fewer keywords.</li>
                                <li>Check your spelling.  Tip: autocomplete on the search box can help you spell difficult terms.</li>
                                <li id="RefinementsNoResultsItem" style="display:none"></li>
                                <li>Try asking a question in <a href="http://www.bing.com/blogs/site_blogs/f/default.aspx" title="Bing Forums">Bing Forums</a>.</li>
                            </ul>
                        </div>
                    </div>
                    <div class="Clear">
                    </div>
                </div> <%                                                            
                if (Model.ShowHelpContainer)
                { 
                %>
                <div class="SearchHelpContainer">
                    <p><strong>Search Tips</strong></p>
                    <table id="SearchHelpTable">
                        <tbody>
                            <tr>
                                <th>Operation</th>
                                <th>Syntax</th>
                                <th>Examples</th>
                            </tr>
                            <tr>
                                <td>All Terms</td>
                                <td><span>term1 <b>AND</b> term2<br />
                                    term1 <b>&amp;</b> term2<br />
                                    term1 term2</span></td>
                                <td>Console <b>AND</b> WriteLine<br />
                                    Console <b>&amp;</b> WriteLine<br />
                                    Console WriteLine</td>
                            </tr>
                            <tr>
                                <td>Any Terms</td>
                                <td><span>term1 <b>OR</b> term2<br />
                                    term1 <b>|</b> term2</span></td>
                                <td>Word <b>OR</b> Excel<br />
                                    Word <b>|</b> Excel</td>
                            </tr>
                            <tr>
                                <td>Exclude</td>
                                <td><span>term1 <b>-</b>term2</span></td>
                                <td>FindWindow <b>-</b>CE</td>
                            </tr>
                            <tr>
                                <td>Group</td>
                                <td><span><b>(</b>term1 term2<b>)</b>‎</span></td>
                                <td>FindWindow <b>AND (</b>CE <b>OR</b> MFC<b>)</b>‎</td>
                            </tr>
                            <tr>
                                <td>Exact Phrase</td>
                                <td><span><b>"</b>phrase<b>"</b></span></td>
                                <td><b>"</b>Provider Toolkit<b>"</b></td>
                            </tr>
                            <tr>
                                <td>Preference</td>
                                <td><span><b>prefer:</b>[op]‎term2</span></td>
                                <td>FindWindow <b>prefer:</b>MFC</td>
                            </tr>
                        </tbody>
                    </table>
                </div> <% 
                }                                                
                %>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript" src="http://i2.services.social.microsoft.com/search/Widgets/SearchBox.jss?boxid=resultSearchBoxText&btnid=resultSearchBoxButton&loc=<%: Model.LocaleId %>&resref=<%: Constants.SearchApiRefinementId %>&watermark=Dev+Center&searchLocation=/dev/<%: Model.LocaleId %>/search"></script>
<script type="text/javascript" src="http://i1.social.s-msft.com/Search/scripts/jquery_tmpl.min.js"></script>
<script type="text/javascript" src="http://i1.social.s-msft.com/Search/scripts/logic.js"></script>
<div class="Clear"></div>

