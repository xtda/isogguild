import { Controller } from "stimulus";

let recruitingArray = {};

function fadeTarget() {
  const toggleClass = this.id.split("-")[0];
  const toggleSpec = this.id.split("-")[1];
  if (this.style.opacity === "1" || !this.style.opacity) {
    this.style.opacity = 0.2;
    recruitingArray[toggleClass][toggleSpec] = false;
  } else if (this.style.opacity === "0.2") {
    this.style.opacity = 1;
    recruitingArray[toggleClass][toggleSpec] = true;
  }
}

function submitUpdate(csrfToken) {
  const settings = recruitingArray;
  const settingsOut = {
    settings
  };
  fetch("/admin/recruitment", {
    headers: {
      "X-Requested-With": "XMLHttpRequest",
      Accept: "application/json",
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken
    },
    method: "post",
    body: JSON.stringify(settingsOut),
    credentials: "same-origin"
  })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        window.Turbolinks.visit("/admin/recruitment");
      }
    });
}

export default class extends Controller {
  initialize() {
    this.specClass = document.getElementsByClassName("spec_icon");
    this.csrfToken = document.head.querySelector(
      'meta[name="csrf-token"'
    ).content;
    recruitingArray = document.getElementById("recruiting_json").value;
    recruitingArray = JSON.parse(recruitingArray);
    Array.from(this.specClass).forEach(element => {
      element.addEventListener("click", fadeTarget);
    });
  }
  submit() {
    submitUpdate(this.csrfToken);
  }
}
