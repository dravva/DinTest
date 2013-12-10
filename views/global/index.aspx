<%@ Page Language="C#" MasterPageFile="~/views/global/site.master" Inherits="System.Web.Mvc.ViewPage<Microsoft.Bing.DevCenter.Models.GenericPage>" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter.Resources" %>

<asp:Content id="indexTitle" ContentPlaceHolderID="PageTitle" runat="server"><%= Model.Title %></asp:Content>

<asp:Content id="indexHeaderTags" ContentPlaceHolderID="PageHeaderTags" runat="server"><link rel="canonical" href="<%: Helpers.GetLocalizedAbsolutePath(Model.LocaleID, Model.AssetID) %>" />
<% if(!String.IsNullOrEmpty(Model.StyleSheet)) 
    { 
       %><link type="text/css" rel="Stylesheet" href="<%: Model.StyleSheet %>" />
<% 
    } 
    if(!String.IsNullOrEmpty(Model.MetaDescription)) 
    { 
        %><meta name="description" content="<%: Model.MetaDescription %>" /><% 
    } %></asp:Content>

<asp:Content id="indexBreadcrumbNavigation" ContentPlaceHolderID="PageBreadcrumbNavigation" runat="server">
<% if (!String.IsNullOrEmpty(Model.NavigationTitle))
    { %>
<div class="breadcrumbNavigation"><a title="<%: Strings.Home %>" 
    href="dev-center"><%= Strings.Bing_Dev_Center %></a><span 
    class="breadcrumbDivider">&gt;</span><%= Model.NavigationTitle %></div>
<%        
    } %>
</asp:Content>

<asp:Content id="indexContent" ContentPlaceHolderID="PageContent" runat="server">
<% if (Model.Content != null)
    { %>
    <% Html.RenderPartial(Model.Path, Model.Content, this.ViewData); %>
<%        
    } %>
</asp:Content>

<asp:Content id="indexScripts" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript" src="http://i2.msdn.microsoft.com/Areas/Sto/Content/Scripts/modernizr2.js"></script>
    <script type="text/javascript" src="http://i2.msdn.microsoft.com/Areas/Epx/Themes/Base/Content/SearchBox.js"></script>
    <script type="text/javascript" src="http://i2.services.social.microsoft.com/search/Widgets/SearchBox.jss?boxid=headerSearchBoxText&btnid=headerSearchBoxButton&loc=<%: Model.LocaleID %>&resref=<%: Constants.SearchApiRefinementId %>&watermark=Dev+Center&searchLocation=/dev/<%: Model.LocaleID %>/search"></script>
</asp:Content>
