<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<SupportPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %><%
                                                             
    List<SupportPage.Product> products = Model.Container.Products;
    
%>
<div class="contentResourcePanel">
    <div class="contentLeftContent">
        <h1 class="contentSectionHeader">Ask or answer a question in the forums</h1>
        <% for (int i = 0; i < products.Count; i++)
           {
               SupportPage.Product product = products[i];
               string productLogo = string.Format("/dev/content/images/logos/{0}", product.Image);
               string linkHref = product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty;
               string linkTarget = product.Target != null ? product.Target : "_self";               
           %>
        <div class="contentTile">
            <div class="contentTileContent">
                <div class="contentTileLogo"><a title="<%: product.Header %>"
                        href="<%: Helpers.ParseLocation(product.Href, Model.LocaleID) %>"
                        target="<%: product.Target %>"><img 
                        alt="<%: product.Header %>" height="32" width="32" src="<%: productLogo %>" /></a>
                </div>
                <div class="contentTileCanvas">
                    <h2 class="contentTileHeader"><a title="<%: product.Header %>" 
                        href="<%: Helpers.ParseLocation(product.Href, Model.LocaleID) %>"
                        target="<%: product.Target %>"><%= product.Header %></a></h2>
                <%
                    if (product.Content != null)
                    { %>
                    <div class="contentTileContentVerbiage">
                        <%= product.Content.Value %>
                    </div> 
                <%
                    }
                    if (product.Links != null)
                    {
                       List<SupportPage.Link> links = product.Links;
                       %>
                    <div class="contentTileContentLinks">
                    <%
                       for (int j = 0; j < links.Count; j++)
                       { %>
                        <div><a title="<%: links[j].Text %>"
                        <%  if (links[j].Target != null)
                            { %>
                            target="<%: links[j].Target %>"          
                        <%
                            } %>
                            href="<%: Helpers.ParseLocation(links[j].Href, Model.LocaleID) %>"><%= links[j].Text %></a></div>
                    <%
                       } %>
                    </div> 
                <%
                   } %>
               </div>
            </div>
        </div>
        <%
            } %>
    </div>
    <div id="contentRightContent" class="contentRightContent">
        
        <h1 id="feedSectionHeader" class="contentSectionHeader" style="display:none">Team Blogs</h1>

        <h2 id="feedSectionHeader_00" class="contentTileHeader" style="display:none">Bing Dev Center</h2>
        <div id="blogFeed_00" class="contentFeedItem">&#160;</div>

        <h2 id="feedSectionHeader_01" class="contentTileHeader" style="display:none">Bing Maps</h2>
        <div id="blogFeed_01" class="contentFeedItem">&#160;</div>

        <h2 id="feedSectionHeader_02" class="contentTileHeader" style="display:none">Bing Translator </h2>
        <div id="blogFeed_02" class="contentFeedItem">&#160;</div>

        <h2 id="feedSectionHeader_03" class="contentTileHeader" style="display:none">Bing Blogs</h2>
        <div id="blogFeed_03" class="contentFeedItem">&#160;</div>

    </div>
</div>
<script type="text/javascript">
    var appVirtualPath = "<%= Helpers.ParseLocation(string.Empty, Model.LocaleID) %>";
</script>
<script type="text/javascript" src="/dev/content/scripts/support.js"></script>
