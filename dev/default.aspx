<%@ Page Language="C#" %>
<%@ Import Namespace="Microsoft.Bing.DevCenter" %><%
    string path = String.Format(@"/{0}/{1}/{2}", Constants.DefaultAreaId, Constants.DefaultLocaleId, Constants.DefaultAssetId);
    HttpContext.Current.Response.Redirect(path);
%>

