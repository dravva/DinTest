<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<SuccessStoriesPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %><%
    List<SuccessStoriesPage.Product> products = Model.Container.Products;
    SuccessStoriesPage.Product product = null;
%>
<div class="contentTopPanel">
    <% if (products.Count > 0)
        {
            product = products[0];
            string imageUrl = string.Format("/dev/content/images/resources/{0}", product.Image);
            string linkHref = product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty;
            string linkTarget = product.Target != null ? product.Target : "_self"; 
            %>
    <h1 class="contentSectionHeader">See what others have done</h1>
    <div class="contentHeroPanelWrapper">
        <div class="contentHeroPanel">
            <%
            if (linkHref.Length > 0)
            { %>
            <a href="<%: linkHref %>" target="<%: linkTarget %>"><img 
                alt="<%: product.Header %>" src="<%: imageUrl %>" height="280" width="484" /></a>
            <%
            }
            else
            { %>
            <img alt="<%: product.Header %>" src="<%: imageUrl %>" height="280" width="484" />
            <%
            } %>
        </div>
    </div>
    <div class="contentTile">
        <div class="contentTileCanvas">            
            <div class="contentTileBanner">
                <h2 class="contentTileHeader">
            <%
            if (linkHref.Length > 0)
            { %>
                    <a href="<%: linkHref %>" target="<%: linkTarget %>"><%= product.Header %></a>
            <%
            }
            else
            { %>
                    <%= product.Header %>
            <%
            } %>
                </h2>
            </div>
            <div class="contentTileContent">
                <div class="contentTileContentVerbiage">
                    <%= product.Content.Value %>
                </div>
            </div>
        </div>
    </div>
    <%
        } %>
</div>
<div class="contentBottomPanel">
    <% if (products.Count > 1)
        { %>
    <div class="subSectionHeader">More stories</div>
        <% for (int i = 1; i < products.Count; i++)
            {
                product = products[i];
                string imageUrl = string.Format("/dev/content/images/resources/{0}", product.Image);
                string linkHref = product.Href != null ? Helpers.ParseLocation(product.Href, Model.LocaleID) : string.Empty;
                string linkTarget = product.Target != null ? product.Target : "_self"; 
                %>
    <div class="contentTile">
        <div class="contentTileLogo">
            <%
            if (linkHref.Length > 0)
            { %>
            <a href="<%: linkHref %>" target="<%: linkTarget %>"><img 
                alt="<%: product.Header %>" src="<%: imageUrl %>" height="60" width="60" /></a>
            <%
            }
            else
            { %>
            <img alt="<%: product.Header %>" src="<%: imageUrl %>" height="60" width="60" />
            <%
            } %>
        </div>
        <div class="contentTileCanvas">
            <div class="contentTileBanner">
                <h2 class="contentTileHeader">
            <%
            if (linkHref.Length > 0)
            { %>
                    <a href="<%: linkHref %>" target="<%: linkTarget %>"><%= product.Header %></a>
            <%
            }
            else
            { %>
                    <%= product.Header %>
            <%
            } %>
                </h2>
            </div>
            <div class="contentTileContent">
                <div class="contentTileContentVerbiage">
                    <%= product.Content.Value %>
                </div>
            </div>
        </div>
    </div>
        <%
            } %>
    <%
        } %>
</div>



