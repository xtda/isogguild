import { Controller } from "stimulus";

let recruitingArray = {};

function fadeTarget() {
  const toggleClass = this.id.split("-")[0];
  const toggleSpec = this.id.split("-")[1];
  const toggleCheckBox = document.getElementById(
    `${toggleClass}-${toggleSpec}-priority`
  );
  if (this.style.opacity === "1" || !this.style.opacity) {
    this.style.opacity = 0.5;
    recruitingArray[toggleClass][toggleSpec] = "no";
    toggleCheckBox.checked = false;
    toggleCheckBox.disabled = true;
  } else if (this.style.opacity === "0.5") {
    this.style.opacity = 1;
    toggleCheckBox.disabled = false;
    recruitingArray[toggleClass][toggleSpec] = "low";
  }
}

function togglehighPriority() {
  const toggleClass = this.id.split("-")[0];
  const toggleSpec = this.id.split("-")[1];
  const toggleCheckBox = document.getElementById(
    `${toggleClass}-${toggleSpec}-priority`
  );
  if (toggleCheckBox.checked) {
    recruitingArray[toggleClass][toggleSpec] = "high";
  } else {
    recruitingArray[toggleClass][toggleSpec] = "low";
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
    this.specPriority = document.getElementsByClassName("spec_icon_priority");
    this.csrfToken = document.head.querySelector(
      'meta[name="csrf-token"'
    ).content;
    recruitingArray = document.getElementById("recruiting_json").value;
    recruitingArray = JSON.parse(recruitingArray);
    Array.from(this.specClass).forEach(element => {
      element.addEventListener("click", fadeTarget);
    });
    Array.from(this.specPriority).forEach(element => {
      element.addEventListener("change", togglehighPriority);
    });
  }
  submit() {
    submitUpdate(this.csrfToken);
  }
}
