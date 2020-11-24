// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap";

require("trix");
require("@rails/actiontext");

require("chartkick");
require("chart.js");

require("jquery");
require("jquery-ui-dist/jquery-ui");

import "../trix-editor-overrides";

import videojs from "video.js";
import "video.js/dist/video-js.css";

$(document).on("turbolinks:load", function () {
  $(".lesson-sortable").sortable({
    cursor: "grabbing",
    cursorAt: { left: 10 },
    placeholder: "ui-state-highlight",
    update: function (e, ui) {
      let item = ui.item;
      let item_data = item.data();
      let params = { _method: "put" };
      params[item_data.modelName] = { row_order_position: item.index() };
      $.ajax({
        type: "POST",
        url: item_data.updateUrl,
        dataType: "json",
        data: params,
      });
    },
    stop: function (e, ui) {
      console.log("stop called when finishing sort of cards");
    },
  });

  let videoPlayer = videojs(document.getElementById("my-video"), {
    controls: true,
    playbackRates: [0.5, 1, 1.5],
    autoplay: false,
    fluid: true,
    preload: false,
    autoplay: false,
    liveui: true,
    responsive: true,
    loop: false,
  });
  videoPlayer.addClass("video-js");
  videoPlayer.addClass("vjs-big-play-centered");
});
