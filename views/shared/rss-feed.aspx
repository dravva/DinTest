<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<RssBlogPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Models" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Resources" %><div class="contentTile"><% 
RssBlogPage.Entries blogEntries = Model.Container.Entries;
const string template = @"<span class=""month"">{0}</span>&#160;{1}.{2}";
int maxDescriptionChars = (Model.ViewType == 0) ? 130 : 260;
bool feedHasItems = (blogEntries.Item != null && blogEntries.Item.Count > 0);
if (feedHasItems)
{
    if (Model.ViewType == 0)
    { %>
    <h2 class="contentTileHeader"><%= Helpers.FormatDateString(blogEntries.Item[0].PubDate, template) %></h2>
    <div class="contentTileSubtext"><a 
        target="w_BingDevCenter"
        href="<%: blogEntries.Item[0].Link.Href %>"><%: blogEntries.Item[0].Title %></a>
    </div>
    <div class="contentTileContent"><%= 
        Helpers.GetSubstring(blogEntries.Item[0].Description, maxDescriptionChars, true, true) %>... <span 
        style="white-space: nowrap"><a target="w_BingDevCenter" href="<%: blogEntries.Item[0].Link.Href %>"><%: Strings.Read_more %></a></span>
    </div>
    <div id="blogContentLinks">
        <ul> <% 
        int maxEntries = blogEntries.Item.Count > 4 ? 4 : blogEntries.Item.Count;
        for (int i = 1; i < maxEntries; i++)
        { %>
            <li>
                <span class="date"><%= Helpers.FormatDateString(blogEntries.Item[i].PubDate, template) %></span>
                <span class="link"><a target="w_BingDevCenter"
                    href="<%: blogEntries.Item[i].Link.Href %>"><%= Helpers.ParsePhrase(blogEntries.Item[i].Title, 14, 84, true) %></a></span></li>
        <%
        } %>
        </ul>
        <div class="clear"></div>
    </div>
    <%
    } 
    else if (Model.ViewType == 1)
    { %>
    <div class="blogContentLinks">
        <ul>
        <%
            int maxEntries = blogEntries.Item.Count > 3 ? 3 : blogEntries.Item.Count;
            for (int i = 0; i < maxEntries; i++)
            { %>
            <li>
                <span class="date"><%= Helpers.FormatDateString(blogEntries.Item[i].PubDate, template) %></span>
                <span class="link"><a target="w_BingDevCenter"
                    href="<%: blogEntries.Item[i].Link.Href %>"><%= Helpers.ParsePhrase(blogEntries.Item[i].Title, 14, 84, true) %></a></span></li>
        <%
            } %>
        </ul>
        <div class="clear"></div>
    </div> <%
    }
} %></div>
<!-- <%= System.DateTime.Now.ToString() %> -->