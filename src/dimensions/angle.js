// keyboard dimensions, should match redox.scad
const redox_thumb_width = 50;
const redox_thumb_height = 61;
const redox_thumb_contact_point = 102;
const redox_total_width = 176;

// we're trying to find an angle at which the thumb plate touches
// the main body at exactly the measured contact point
const target_width = redox_total_width - redox_thumb_contact_point;

const target_precision = 5;
const rotation_direction = -1;

// lots of potential solutions to
//  50 * cos(x) + 61 * sin(x) = 74
const found_angles = [];
do {
  const last_angle = peek(found_angles) || 0;
  const next_angle = find_next_angle(last_angle + rotation_direction);
  found_angles.push(next_angle);
} while (Math.abs(peek(found_angles)) < 90);

console.log(`Potential angles with width ${target_width}:`);
found_angles.forEach((x) => console.log(` ${x}`));

// retrieve the last item in an array without modifying it
function peek(arr) {
  return arr[arr.length - 1];
}

// rounds a value to the specified number of decimal places
function round(number, decimalPlaces) {
  return Number(
    Math.round(number + "e" + decimalPlaces) + "e-" + decimalPlaces
  );
}

// iteratively finds the next angle after the specified start point
// which satisfies the width condition
function find_next_angle(start_angle) {
  console.info(`Searching from ${start_angle}`);
  let last_angle = start_angle;

  for (let i = 0; i < target_precision; i++) {
    const step = rotation_direction / Math.pow(10, i);
    let next_angle = last_angle;
    let last_width;
    let next_width;

    while (true) {
      next_angle = round(next_angle + step, i);
      next_width =
        redox_thumb_width * Math.cos(next_angle) -
        redox_thumb_height * Math.sin(next_angle);

      if (next_width > target_width) {
        console.debug(
          ` Step ${step}` +
            `\r\n  Last angle ${last_angle}` +
            `\r\n  Last width ${last_width}` +
            `\r\n  Next angle ${next_angle}` +
            `\r\n  Next width ${next_width}`
        );
        break;
      }

      last_angle = next_angle;
      last_width = next_width;
    }
  }

  console.info(`Found ${last_angle}`);
  return last_angle;
}
