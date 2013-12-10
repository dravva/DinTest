<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<HomePage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Resources" %><%
    HomePage.Heroes heroes = Model.Container.Heroes;
    HomePage.Products products = Model.Container.Products;
    HomePage.Success success = Model.Container.Success;
    HomePage.About about = Model.Container.About;
    HomePage.Hero hero = null;
    HomePage.Product product = null;
%>
<div id="contentHeroWrapper" class="contentHeroWrapper">
    <% if (heroes.Item.Count > 0)
       {
           hero = heroes.Item[0];
           string heroImage = string.Format("/dev/content/images/dev-center/{0}", hero.Image);
        %>
    <input id="contentHeroID" type="hidden" value="0" />
    <div id="contentHeroInner" class="contentHeroInner">
	    <div id="heroImageWrapper" style="position:absolute;width:980px;height:280px;overflow:hidden">
	         <img src="<%: heroImage %>" height="280" width="980" />
	     </div>
    <% if (hero.Type == "0")
       { %>
        <div class="contentHeroMainPanel">
            <div class="contentHeroMainPanelTop">
                <div id="contentHeroHeader" class="largest"><%= hero.Header %></div>
                <div id="contentHeroSubtext" class="normal"><%= hero.Subtext %></div>
            </div>
            <%
                string linkText = hero.Link != null && hero.Link.Text != null ? hero.Link.Text : string.Empty;
                string linkHref = hero.Link != null && hero.Link.Href != null ? Helpers.ParseLocation(hero.Link.Href, Model.LocaleID) : string.Empty;
                string linkTarget = hero.Link != null ? hero.Link.Target : "_self";
                string linkVisibility = linkText == string.Empty || linkHref == string.Empty ? "hidden" : "visible";
            %>
            <div id="contentHeroLinkWrapper" class="contentHeroMainPanelBottom" style="visibility:<%: linkVisibility %>">
                <a id="contentHeroLink" href="<%: linkHref %>" target="<%: linkTarget %>"><div 
                    id="contentHeroLinkText" class="centerAlign"><%= linkText %></div>
                </a>
            </div>
        </div>
        <div class="contentHeroActionPanel">
            <div id="contentHeroActionPanelBackground" class="contentHeroActionPanelBackground opacity95"></div>
            <div  id="contentHeroContent" class="contentHeroActionPanelContent">
                <%= hero.Content.Value %>
            </div>
        </div>
    <%
       }
       else
       { %>
            <%= hero.Content.Value %>
    <%           
       }%>
    </div>
    <div id="contentHeroToolbar" class="contentHeroToolbar">
        <% for (int i = 0; i < heroes.Item.Count; i++)
            {
                string linkSelected = (i == 0) ? " linkSelected" : string.Empty; %>
            <span id="heroLink<%: i %>" class="heroLink<%: linkSelected %>" onclick="ChangeHero(<%: i %>)"></span>
        <%
            } 
        } %>
        <span>&#160;<!-- ie7 --></span>
    </div>
</div>
<div class="contentResourcePanel">
    <div class="contentLeftContent">
        <h1 class="contentSectionHeader"><%= Strings.Developer_Resources %></h1>
        <% for (int i = 0; i < products.Item.Count; i++)
           {
               product = products.Item[i];
               string productLogo = string.Format("/dev/content/images/logos/{0}", product.Image);
               string linkHref = product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty;
               string linkTarget = product.Target != null ? product.Target : "_self";               
           %>
        <div class="contentTile">
            <% if (linkHref != string.Empty)
                { %>
            <div class="contentTileBanner" onclick="GetProductLink(<%: i %>)">
                <div class="contentTileLogo">
                    <a href="<%: linkHref %>" target="<%: linkTarget %>"><img 
                        alt="<%: product.Header %>" src="<%: productLogo %>" height="48" width="48" /></a>
                </div>
                <div class="contentTileHeaderWrap">
                    <h2 class="contentTileHeader">
                        <a href="<%: linkHref %>" target="<%: linkTarget %>"><%= product.Header %></a>
                    </h2>
                    <div class="contentTileSubtext"><%= product.Subtext %></div>
                </div>
            </div>
            <%
                }
                else
                { %>
            <div class="contentTileBanner">
                <div class="contentTileLogo">
                    <img style="cursor:default" alt="<%: product.Header %>" src="<%: productLogo %>" height="48" width="48" />
                </div>
                <div class="contentTileHeaderWrap">
                    <h2 class="contentTileHeader">
                        <a style="cursor:default" id="<%: product.Header %>"><%= product.Header %></a>
                    </h2>
                    <div class="contentTileSubtext"><%= product.Subtext %></div>
                </div>
            </div>
            <%
                }%>
            <div class="contentTileContent">
                <div class="contentTileContentVerbiage">
                    <%= product.Content.Value %>
                </div>                
                <div class="contentTileContentLinksWrapper">
                    <div class="contentTileContentLinks">
                    <% if (product.Links != null)
                    {
                        List<HomePage.Link> links = product.Links;
                        for (int j = 0; j < links.Count; j++)
                        { %> <a 
                        <%  if (links[j].Target != null)
                            { %>
                        target="<%: links[j].Target %>"          
                        <%
                            } %>
                        href="<%: Helpers.ParseLocation(links[j].Href, Model.LocaleID) %>"><%= links[j].Text %></a><br />
                    <%
                        }
                    } %>
                    </div>
                </div>
            </div>
        </div>
        <%
            } %>
    </div>
    <div id="contentRightContent" class="contentRightContent">
        <h1 id="feedSectionHeader" class="contentSectionHeader"><%= Strings.Blogs %></h1>
        <div id="blogFeed">&#160;</div>
        <div class="successStoryTile">
                <h2 class="contentTileHeader"><%= Strings.Success_Stories %></h2>
                <%= success.Content.Value %>
            <div class="contentTileLinkWrapper">
                <a class="contentTileLink" 
                    <% if (success.Link.Target != null)
                    { %>
                    target="<%: success.Link.Target %>" <%
                    } %>                        
                    href="<%: Helpers.ParseLocation(success.Link.Href, Model.LocaleID) %>">
                    <div class="contentTileLinkText">
                        <span><%= Strings.More %>&#160;&gt;</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="successStoryTile">
                <h2 class="contentTileHeader">About Bing</h2>
                <%= about.Content.Value %>
            <div class="contentTileLinkWrapper">
                <a class="contentTileLink" 
                    <% if (success.Link.Target != null)
                    { %>
                    target="<%: about.Link.Target %>" <%
                    } %>                        
                    href="<%: Helpers.ParseLocation(about.Link.Href, Model.LocaleID) %>">
                    <div class="contentTileLinkText">
                        <span><%= Strings.More %>&#160;&gt;</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var heroArray = []; 
    var productArray = [];
    <%  for (int i = 0; i < heroes.Item.Count; i++)
    {
        hero = heroes.Item[i];
        %>
    heroArray[<%: i %>] = {
        type: '<%: hero.Type != null ? hero.Type : "0" %>',
        image: '<%: hero.Image != null ? string.Format("/dev/content/images/dev-center/{0}", hero.Image) : string.Empty %>',
        header: '<%: hero.Header != null ? hero.Header : string.Empty %>',
        subtext: '<%: hero.Subtext != null ? hero.Subtext : string.Empty %>',
        linkHref: '<%: hero.Link != null && hero.Link.Href != null ? Helpers.ParseLocation(hero.Link.Href, Model.LocaleID) : string.Empty %>',
        linkTarget: '<%: hero.Link != null && hero.Link.Target != null ? hero.Link.Target : "_self" %>',
        linkText: '<%: hero.Link != null && hero.Link.Text != null ? hero.Link.Text : string.Empty %>',
        content: '<%= hero.Content.Value != null ? hero.Content.Value.Replace("'", "&rsquo;") : string.Empty %>'
    }; <%
    }    
    for (int i = 0; i < products.Item.Count; i++)
    {
        product = products.Item[i];
        %>
    productArray[<%: i %>] = {
        linkHref: '<%: product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty %>',
        linkTarget: '<%: product.Target != null ? product.Target : "_self" %>'
    }; <%
    } %>
</script>
<script type="text/javascript">
    var appVirtualPath = "<%= Helpers.ParseLocation(string.Empty, Model.LocaleID) %>";
</script>
<script type="text/javascript" src="/dev/content/scripts/dev-center.js"></script>
<div style="display:none"><% 
/*
 * The file-sizes for the rotating hero graphics on the homepage are somewhat large and this size was causing rendering issues
 * when transitioning from one image to the next when subsequent images are not yet cached on local machines.  For this reason, 
 * we pre-load the subsequent hero images in order to initiate the download process before the images are actually needed. 
 * Rather than pre-load via a Javascript Image object, we pre-load using a series of <img /> tags residing in a hidden div near
 * the bottom of the webpage. These images will not be visible until called-upon to be rendered in the hero-graphic area. Using
 * actual <img /> tags have the added benefit of allowing a ctrl/F5 refresh if any of them are corrupted during/after downloaded.
 */
for (int i = 1; i < heroes.Item.Count; i++)
{
    if (!String.IsNullOrEmpty(heroes.Item[i].Image))
    {
        string imgSrc = string.Format("/dev/content/images/dev-center/{0}", heroes.Item[i].Image);
%><img src="<%: imgSrc %>" height="1" width="1"/><% 
    }
}
%></div>
