$(function() {
    'use strict';

    $("#sendProduction").on("click", function() {
        var contentOrders = document.querySelectorAll(".num_order");
        var numOrders     = [];

        for(var i = 0; i < contentOrders.length; i++) {
            var numOrder = contentOrders[i].textContent;
            if(numOrders[numOrders.length - 1] !== numOrder)
                numOrders.push(numOrder);
        }

        $.ajax({
            type: "POST",
            url: "sendproduction",
            data: 'orders='+numOrders,
            success: function(result) {
                console.log(result);
            },
            error: function(error) {
                console.log(error);
            }
        });
    });
});