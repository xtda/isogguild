import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["name"];

  submit() {
    if (this.nameTarget.value.length !== 0) {
      window.Turbolinks.visit(`/apply?name=${this.nameTarget.value}`);
    }
  }
}
