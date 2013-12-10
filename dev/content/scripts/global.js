
OpenExternalWindow = function (href, target) {

    if (target == "w_BingDevCenter") {
        window.w_BDC = window.w_BDC ? window.w_BDC : window["w_BingDevCenter"];
        if (window.w_BDC && !window.w_BDC.closed) {
            window.w_BDC.location = href;
        } else {
            window.w_BDC = window.open(href, target);
        }
    }
    else {
        window.open(href, target);
    }
}

GetProductLink = function (id) {
    if (productArray && productArray[id]) {
        var href = productArray[id].linkHref;
        var target = productArray[id].linkTarget;
        if (href && href.length) OpenExternalWindow(href, target);
    }
}



