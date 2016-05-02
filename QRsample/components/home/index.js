'use strict';

app.home = kendo.observable({
    onShow: function () {
        alert(8);

    },
    afterShow: function () { },
    scan: function () {
 var option = {
            x: 120,
            y: 250,
            width: 600,
            height: 600
        };

        WVQRScan.setQrReader(function (r) {
            alert(r);

        }, function (e) {
            alert(e);
        }, option);
        
    }
});

