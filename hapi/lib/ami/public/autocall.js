$(function() {
  $(".col-lg-3").draggable();
  $('input[type="radio"]').click(function() {
    if ($(this).attr("value") == "auto") {
      $("#progres").hide();
      $("#auto").show();
    }
    if ($(this).attr("value") == "progres") {
      $("#auto").hide();
      $("#progres").show();
    }
  });
  $("#debug").resizable();
});
//var socket = new WebSocket("ws://localhost:8000");

var host = window.location;
var wsHost = (window.location.href).split("/")[2]
var socket = new ReconnectingWebSocket('ws://'+wsHost, null, {
  debug: true,
  reconnectInterval: 3000,
  maxReconnectAttempts: 10,
  automaticOpen: true
});

socket.onopen = function() {
  $('#connect h4').hide();
  $('#connect').append($('<h4>').text("Соединение установлено."));
};

function login() {
  const user = {
    sip: $('#sip').val(),
    loginName: $('#login').val()
  };
  const jsn = {
    action: `join`,
    user: user,
  };
  socket.send(JSON.stringify(jsn));
  // $('#connect h4').hide();
  // $('#connect').append($('<h4>').text("Соединение установлено."));
}


function callto() {
  var phone = $('#phone').val();
  if (phone && phone.length > 11) {
    const jsn = {
      action: `call`,
      source: {
        clID: $('#clID').val(),
        phone: phone,
      },
      exten: $('#exten').val(),
    };
    socket.send(JSON.stringify(jsn));
  }
}
socket.onclose = function(event) {
  if (event.wasClean) {
    $('#connect').append($('<li>').text('Соединение закрыто чисто'));
  } else {
    $('#connect').append($('<li>').text('Обрыв соединения')); // например, "убит" процесс сервера
  }
  $('#connect').append($('<li>').text('Код: ' + event.code + ' причина: ' + event.reason));
};

socket.onmessage = function(event) {
  var currentTime = new Date();
  var hours = currentTime.getHours();
  var minutes = currentTime.getMinutes();
  if (minutes < 10) {
    minutes = "0" + minutes;
  }
  console.log(event.data);
  $('#console').append(event.data);
  $('#console').append("=========" + hours + ":" + minutes + "=========\n");
};

socket.onerror = function(error) {
  $('#console').append(error.message);
  $('#console').append("=========" + hours + ":" + minutes + "=========\n");
};

function startAuto() {
  console.log($('input[type="radio"]').attr("value"));
  if ($('input[type="radio"]').attr("value") == "auto") {
    const jsn = {
      action: 'progress',
      url: $("#url").val(),
      ffID: $("#base").val(),
      exten: $("#exten").val(),
      factor: $("#factor").val()
    };
    socket.send(JSON.stringify(jsn));
  }
}

function stopAuto() {
  const jsn = {
    action: `progress-stop`,
  };
  socket.send(JSON.stringify(jsn));
}
