<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<DownloadsPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Resources" %><%
    DownloadsPage.Products products = Model.Container.Products;
    DownloadsPage.RelatedProducts relatedProducts = Model.Container.RelatedProducts;
    DownloadsPage.Product product = null;
%>
<div class="contentTopPanel">
    <h1 class="contentSectionHeader"><%= Strings.Developer_Downloads %></h1>
    <% for (int i = 0; i < products.Item.Count; i++)
        {
            product = products.Item[i];
            string imageUrl = string.Format("/dev/content/images/logos/{0}", product.Image);
            string linkHref = product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty;
            string linkTarget = product.Target != null ? product.Target : "_self";
           %>
    <div class="contentTile" style="background-image:url('<%: imageUrl %>')">
        <div class="contentTileCanvas">            
            <div class="contentTileBanner">
                <h2 class="contentTileHeader"><a 
                    href="<%: Helpers.ParseLocation(product.Href, Model.LocaleID) %>"
                    target="<%: product.Target %>"><%= product.Header %></a></h2>
                <div class="contentTileSubtext" onclick="GetProductLink(<%: i %>)"><%= product.Subtext %></div>
            </div>
            <div class="contentTileContent">
                <div class="contentTileContentVerbiage">
                    <%= product.Content.Value %>
                </div>
            </div>
            <div class="contentTileContentLinks">
            <% if (product.Links != null)
            {
                List<DownloadsPage.Link> links = product.Links;
                for (int j = 0; j < links.Count; j++)
                {
                    if (!String.IsNullOrEmpty(links[j].Descriptor))
                    { %> <div class="contentTileLinkDescriptor"><%= links[j].Descriptor %></div> 
                <% 
                    } %> <div class="contentTileLinkItem"><a title="<%: links[j].Text %>"
                <%  if (links[j].Target != null)
                    { %>
                target="<%: links[j].Target %>"          
                <%
                    } %>
                href="<%: Helpers.ParseLocation(links[j].Href, Model.LocaleID) %>"><%= links[j].Text %></a></div>
            <%
                }
            } %>
            </div>
            <div class="contentTileLogoLink" onclick="GetProductLink(<%: i %>)"></div>
        </div>
    </div>
    <%
        } %>
</div>
<div class="contentBottomPanel">
    <h1 class="contentSectionHeader">Related Downloads</h1>
        <% for (int i = 0; i < relatedProducts.Item.Count; i++)
        { %>
    <div class="contentTile">
        <div class="contentTileCanvas">
            <div class="contentTileBanner">
                <h2 class="contentTileHeader"><%= relatedProducts.Item[i].Header %></h2>
            </div>
            <div class="contentTileContent">
                <div class="contentTileContentVerbiage">
                    <%= relatedProducts.Item[i].Content.Value %>
                </div>
            </div>                
            <div class="contentTileContentLinks">
            <% if (relatedProducts.Item[i].Links != null)
                {
                    List<DownloadsPage.Link> links = relatedProducts.Item[i].Links;
                    for (int j = 0; j < links.Count && j < 1; j++)
                    { %> <div class="contentTileLinkItem"><a 
            <% if (links[j].Target != null)
                { %>
                target="<%: links[j].Target %>"          
            <%
                } %>
                href="<%: Helpers.ParseLocation(links[j].Href, Model.LocaleID) %>"><%= links[j].Text %></a></div>
            <%
                    }
                } %>
            </div>
        </div>
    </div>
    <%
        } %>
</div>
<script type="text/javascript">
    var productArray = [];
<%  for (int i = 0; i < products.Item.Count; i++)
    {
        product = products.Item[i];
        %>
    productArray[<%: i %>] = {
        linkHref: '<%: product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty %>',
        linkTarget: '<%: product.Target != null ? product.Target : "_self" %>'
    }; <%
    } %>
</script>




