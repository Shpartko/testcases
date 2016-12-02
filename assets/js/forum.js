function set_focus(id) {
    var obj = document.getElementById(id);
    if (!obj) return;
    obj.focus();
}

function set_value(id, new_value) {
    var obj = document.getElementById(id);
    if (!obj) return;
    obj.value = new_value;
}

function get_value(id, new_value) {
    var obj = document.getElementById(id);
    if (!obj) return;
    return obj.value;
}



$(document).ready(function () {

    $("form#new_topic").submit(function (e) {
        e.preventDefault();
        $.post("/addTopic", $('form#new_topic').serialize(), function (data) {
            if (data.id > 0) {
                window.location.href = "/topic-" + data.id;
            } else {
                alert('Err: ' + data.message);
            }
        });
    });


    $("form#new_post").submit(function (e) {
        e.preventDefault();
        $.post("/addPost", $('form#new_post').serialize(), function (data) {
            if (data.id > 0) {
                window.location.reload();
            } else {
                alert('Err: ' + data.message);
            }
        });

    });
});