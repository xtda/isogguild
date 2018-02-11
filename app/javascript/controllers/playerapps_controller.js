import { Controller } from "stimulus";

function updateRealmList(data, realmSelect) {
  const option = document.createElement("option");
  option.text = data.name;
  option.value = data.slug;
  realmSelect.add(option);
}

function updateClassList(classSelect) {
  const classList = [
    {
      text: "Druid",
      value: "Druid"
    },
    {
      text: "Hunter",
      value: "Hunter"
    },
    {
      text: "Mage",
      value: "Mage"
    },
    {
      text: "Paladin",
      value: "Paladin"
    },
    {
      text: "Priest",
      value: "Priest"
    },
    {
      text: "Rogue",
      value: "Rogue"
    },
    {
      text: "Shaman",
      value: "Shaman"
    },
    {
      text: "Warlock",
      value: "Warlock"
    },
    {
      text: "Warrior",
      value: "Warrior"
    },
    {
      text: "Death Knight",
      value: "DeathKnight"
    },
    {
      text: "Monk",
      value: "Monk"
    },
    {
      text: "Demon Hunter",
      value: "DemonHunter"
    }
  ];
  classList.forEach(option =>
    classSelect.add(new Option(option.text, option.value, option.selected))
  );
}

function updateSpecList(playerClass, specList) {
  const classSpecs = {
    Druid: [
      {
        text: "Balance"
      },
      {
        text: "Feral"
      },
      {
        text: "Guardian"
      },
      {
        text: "Restoration"
      }
    ],
    Hunter: [
      {
        text: "Beast Mastery"
      },
      {
        text: "Marksmanship"
      },
      {
        text: "Survival"
      }
    ],
    Mage: [
      {
        text: "Arcane"
      },
      {
        text: "Fire"
      },
      {
        text: "Frost"
      }
    ],
    Paladin: [
      {
        text: "Holy"
      },
      {
        text: "Protection"
      },
      {
        text: "Retribution"
      }
    ],
    Priest: [
      {
        text: "Discipline"
      },
      {
        text: "Holy"
      },
      {
        text: "Shadow"
      }
    ],
    Rogue: [
      {
        text: "Assassination"
      },
      {
        text: "Outlaw"
      },
      {
        text: "Sublety"
      }
    ],
    Shaman: [
      {
        text: "Elemental"
      },
      {
        text: "Enhancement"
      },
      {
        text: "Restoration"
      }
    ],
    Warlock: [
      {
        text: "Afflication"
      },
      {
        text: "Demonology"
      },
      {
        text: "Destruction"
      }
    ],
    Warrior: [
      {
        text: "Arms"
      },
      {
        text: "Fury"
      },
      {
        text: "Protection"
      }
    ],
    DeathKnight: [
      {
        text: "Blood"
      },
      {
        text: "Frost"
      },
      {
        text: "Unholy"
      }
    ],
    DemonHunter: [
      {
        text: "Havoc"
      },
      {
        text: "Vengeance"
      }
    ]
  };
  let setSpec = [];
  switch (playerClass) {
    case "Druid":
      setSpec = classSpecs.Druid;
      break;
    case "Hunter":
      setSpec = classSpecs.Hunter;
      break;
    case "Mage":
      setSpec = classSpecs.Mage;
      break;
    case "Paladin":
      setSpec = classSpecs.Paladin;
      break;
    case "Priest":
      setSpec = classSpecs.Priest;
      break;
    case "Rogue":
      setSpec = classSpecs.Rogue;
      break;
    case "Shaman":
      setSpec = classSpecs.Shaman;
      break;
    case "Warlock":
      setSpec = classSpecs.Warlock;
      break;
    case "Warrior":
      setSpec = classSpecs.Warrior;
      break;
    case "DeathKnight":
      setSpec = classSpecs.DeathKnight;
      break;
    case "Monk":
      setSpec = classSpecs.Monk;
      break;
    case "DemonHunter":
      setSpec = classSpecs.DemonHunter;
      break;
    default:
      break;
  }
  setSpec.forEach(option =>
    specList.add(new Option(option.text, option.value, option.selected))
  );
}

function getWoWProgLink(realm) {
  const val = realm.replace(/[']|[ ]/g, "-");
  return val;
}

function getLinks(playerName, playerRealm) {
  let playerlinks = "";
  const realmSelect = document.getElementById("player_realm");
  const realm = realmSelect.selectedOptions[0].innerText;
  const wowProgLink = `https://www.wowprogress.com/character/us/${getWoWProgLink(
    realm
  )}/${playerName}`;
  const raiderIoLink = `https://raider.io/characters/us/${playerRealm}/${playerName}`;
  const wowArmoryLink = `https://worldofwarcraft.com/en-us/character/${playerRealm}/${playerName}`;
  const warcraftLogsLink = `https://www.warcraftlogs.com/character/us/${playerRealm}/${playerName}`;
  playerlinks += `${wowProgLink.toLowerCase()} / ${raiderIoLink} / ${warcraftLogsLink} / ${wowArmoryLink}`;
  return playerlinks;
}

function submitApplicationHandler(appForm, event) {
  event.preventDefault();
  const playerapp = [];
  const defaultanswers = [];
  let result = {};
  let playerappanswers = {};
  let grecaptcharesponse = "";

  let i = 0;
  const appFormData = new FormData(appForm);
  /* eslint-disable */
  for (const entry of appFormData.entries()) {
    switch (entry[0]) {
      case "utf8":
        break;
      case "g-recaptcha-response":
        grecaptcharesponse = entry[1];
        break;
      case "authenticity_token":
        break;
      case "player_name":
      case "player_realm":
      case "player_bnettag":
      case "player_class":
      case "player_spec":
        playerappanswers = entry[1];
        defaultanswers.push(playerappanswers);
        break;
      case "player_links":
        break;
      default:
        i++;
        playerappanswers = {
          name: entry[0],
          question: entry[0],
          answer: entry[1],
          position: i
        };
        playerapp.push(playerappanswers);
        break;
    }

    /* eslint-enable */

    result = {
      "g-recaptcha-response": grecaptcharesponse,
      playerapp: {
        player_name: defaultanswers[0],
        player_realm: defaultanswers[1],
        player_bnettag: defaultanswers[2],
        player_class: defaultanswers[3],
        player_spec: defaultanswers[4],
        player_links: getLinks(defaultanswers[0], defaultanswers[1]),
        playerappanswers_attributes: playerapp
      }
    };
  }
  result = JSON.stringify(result);

  fetch("/apply", {
    headers: { "Content-Type": "application/json" },
    method: "post",
    body: result
  })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        window.Turbolinks.visit("/applied");
      }
    });
}

export default class extends Controller {
  static get targets() {
    return ["playerclass", "output"];
  }
  constructor() {
    super();
    this.realmApi = "/v1/wow/realms";
    this.realmSelect = document.getElementById("player_realm");
    this.classSelectOptions = document.getElementById("player_class").options;
    this.classSelect = document.getElementById("player_class");
    this.specSelect = document.getElementById("player_spec");
    this.appForm = document.getElementById("application_form");
    this.gooeyDiv = document.getElementById("gooey-bg-display");
  }
  initialize() {
    this.realmSelect.length = 0;

    fetch(this.realmApi)
      .then(response => response.json())
      .then(responseJson => {
        responseJson.forEach(data => {
          updateRealmList(data, this.realmSelect);
        });
        this.realmSelect.value = "frostmourne";
      });
    updateClassList(this.classSelectOptions);
    updateSpecList(this.classSelect.value, this.specSelect);
  }
  updatespecs() {
    this.specSelect.length = 0;
    updateSpecList(this.classSelect.value, this.specSelect);
  }
  submit(event) {
    submitApplicationHandler(this.appForm, event);
  }
}
