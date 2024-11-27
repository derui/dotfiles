import * as k from "karabiner_ts";

/** Hide the application by name */
function toHideApp(name: string) {
  return k.to$(
    `osascript -e 'tell application "System Events" to set visible of process "${name}" to false'`,
  );
}

/** not apple keyboard */
const ifNotSelfMadeKeyboard = k.ifDevice([
  { product_id: 1, vendor_id: 22854 }, // Claw44
]).unless();

k.writeToProfile("Default profile", [
  k.rule("Quit application by holding command-q").manipulators([
    k.map({
      key_code: "q",
      modifiers: { mandatory: ["command"], optional: ["caps_lock"] },
    })
      .toIfHeldDown({
        key_code: "q",
        modifiers: ["left_command"],
        repeat: false,
      }),
  ]),

  k.rule("Tap CMD to toggle Kana/Eisuu", ifNotSelfMadeKeyboard).manipulators([
    k.withMapper(
      {
        "left_command": "japanese_eisuu",
        "right_command": "japanese_kana",
      } as const,
    )((cmd, lang) =>
      k.map({ key_code: cmd, modifiers: { optional: ["any"] } })
        .to({ key_code: cmd, lazy: true })
        .toIfAlone({ key_code: lang })
        .description(`Tap ${cmd} alone to switch to ${lang}`)
        .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 })
    ),
  ]),

  k.rule(
   "Define sturdy layout"
  ).manipulators([
    k.withMapper(
      {
        "a": "s",
        "s": "t",
        "d": "r",
        "f": "d",
        "g": "y",
        "h": ".",
        "j": "n",
        "k": "a",
        "l": "e",
        ";": "i",
        "z": "z",
        "x": "k",
        "c": "q",
        "v": "g",
        "b": "w",
        "n": "b",
        "m": "h",
        ",": "'",
        ".": ";",
        "/": ",",
        "q": "v",
        "w": "m",
        "e": "l",
        "r": "c",
        "t": "p",
        "y": "x",
        "u": "f",
        "i": "o",
        "o": "u",
        "p": "j",
        "'": "/",
      } as const,
    )((from, to) =>
      k.map({ key_code: from, modifiers: { optional: ["any"] } })
        .to({ key_code: to, modifires: { optional: ["any"] }})
        .description(`Tap ${from} to ${to}`)
    )
  ]),

]);
