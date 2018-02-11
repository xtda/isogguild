/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "babel-polyfill";
import Rails from "rails-ujs";

import Turbolinks from "turbolinks";

import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

import "bulma/bulma.sass";
import "./application.css";

import "./background.png";
import "./headerlogo.png";

import "../admin/admin";

const application = Application.start();
const context = require.context("../controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

Rails.start();
Turbolinks.start();

document.addEventListener("turbolinks:load", () => {
  const $navbarBurgers = Array.prototype.slice.call(
    document.querySelectorAll(".navbar-burger"),
    0
  );
  if ($navbarBurgers.length > 0) {
    $navbarBurgers.forEach($el => {
      $el.addEventListener("click", () => {
        const { target } = $el.dataset;
        const $target = document.getElementById(target);
        $el.classList.toggle("is-active");
        $target.classList.toggle("is-active");
      });
    });
  }
});
