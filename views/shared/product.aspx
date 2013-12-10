<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ProductPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %><%
    ProductPage.Product product = Model.Container.Product;
    List<ProductPage.Section> sections = product.Sections;
    List<ProductPage.Detail> details = null;
    List<ProductPage.Link> links = null;
    string productImage = string.Format("/dev/content/images/resources/{0}", product.Image);
%>
<div class="contentTopPanel">
    <h1 class="contentSectionHeader"><%= product.Title %></h1>
    <div class="contentHeroPanelWrapper">
        <div class="contentHeroPanel">
            <div id="productImageWrapper" style="position:absolute;width:480px;height:280px;overflow:hidden">
                <img src="<%: productImage %>" height="280" width="480" />
            </div><%
    if (!String.IsNullOrEmpty(product.HeroText))
    { %>
            <div class="contentHeroPanelText" style="position:absolute">
                <div><%= product.HeroText %></div>
            </div>
<%
    } %>
        </div>
    </div>
    <div class="contentTile">
        <div class="contentTileCanvas">
<%
if (sections.Count > 0)
{ %>
            <h2 class="contentTileHeader"><%= product.Sections[0].Header %></h2>
    <%
    details = product.Sections[0].Details;
    for (int i = 0; i < details.Count; i++)
    { %>
            <div class="contentTileSubsection">
                <h3 class="contentTileSubHeader"><%= details[i].Header %></h3>
        <% 
        if (details[i].Content != null)
        {
            %>
                <div class="contentTileContentVerbiage">
                    <%= details[i].Content.Value %>
                </div>
        <% 
        } 
        if (details[i].Links != null)
        {
            links = details[i].Links;
            %>
                <div class="contentTileContentLinks">
                    <ul>
            <% 
            for (int k = 0; k < links.Count; k++)
            { %>
                        <li><a 
                <%
                if (links[k].Target != null)
                { %>
                            target="<%: links[k].Target %>"          
                <% 
                } %>
                            href="<%: Helpers.ParseLocation(links[k].Href, Model.LocaleID) %>"><%= Helpers.ParsePhrase(links[k].Text, 12, 72, true) %></a></li>
            <%
            } %>
                    </ul>
                </div>
        <% 
        } %>
            </div>
    <% 
    } %>
<% 
} %>
        </div>
    </div>
    <div style="height:1px;width:1px;clear:both;oveflow:hidden"></div>
</div>
<div class="contentBottomPanel">
<%
for (int i = 1; i < sections.Count; i++)
{ %>
    <div class="contentTile">
        <div class="contentTileCanvas">
            <h2 class="contentTileHeader"><%= product.Sections[i].Header %></h2>
    <%
    details = product.Sections[i].Details;
    for (int j = 0; j < details.Count; j++)
    { %>
            <div class="contentTileSubsection">
                <h3 class="contentTileSubHeader"><%= details[j].Header %></h3>
        <% 
        if (details[j].Content != null)
        {
            %>
                <div class="contentTileContentVerbiage"><%= details[j].Content.Value %></div>
        <% 
        }
        if (details[j].Links != null)
        {
            links = details[j].Links;
            %>
                <div class="contentTileContentLinks">
                    <ul>
            <% 
            for (int k = 0; k < links.Count; k++)
            { %>
                        <li><a 
                <%
                if (links[k].Target != null)
                { %>
                            target="<%: links[k].Target %>"          
                <% 
                } %>
                            title="<%: links[k].Text %>"
                            href="<%: Helpers.ParseLocation(links[k].Href, Model.LocaleID) %>"><%= Helpers.ParsePhrase(links[k].Text, 12, 54, true) %></a></li>
            <%
            } %>
                    </ul>
                </div>
        <% 
        } %>
            </div>
    <% 
    } %>
        </div>
    </div>
<% 
} %>
    <div style="height:1px;width:1px;clear:both;overflow:hidden"></div>
</div>

