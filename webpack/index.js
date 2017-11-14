function main({lines=[], pad=30}) {
  const leftPad = require("left-pad")
  return { padded: lines.map(l => leftPad(l, pad, ".")) }
}
global.main = main;
