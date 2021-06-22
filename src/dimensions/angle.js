// keyboard dimensions, should match redox.scad
const redox_thumb_width = 50;
const redox_thumb_height = 61;
const redox_thumb_contact_point = 102;
const redox_total_width = 176;

// we're trying to find an angle at which the thumb plate touches
// the main body at exactly the measured contact point
const target_width = redox_total_width - redox_thumb_contact_point;

const target_precision = 5;
const rotation_direction = 1;

// multiple potential solutions to
//  50 * cos(x) + 61 * sin(x) = 74
const found_angles = [];
while (true) {
  const last_angle = peek(found_angles) || -rotation_direction;
  const next_angle = find_next_angle(last_angle + rotation_direction);
  if (next_angle.has_solution && Math.abs(next_angle.angle) < Math.abs(360)) {
    found_angles.push(next_angle.angle);
  } else {
    break;
  }
}

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

// converts an angle in degrees to radians
function to_radians(degrees) {
  return (degrees * Math.PI) / 180;
}

// measures the overall width of the thumb cluster
// at the specified angle
function calculate_width(angle) {
  const true_angle = to_radians(angle);
  return (
    redox_thumb_width * Math.cos(true_angle) +
    redox_thumb_height * Math.sin(true_angle)
  );
}

// iteratively finds the next angle after the specified start point
// which satisfies the width condition
function find_next_angle(start_angle) {
  const start_width = calculate_width(start_angle);
  const search_direction = start_width > target_width ? -1 : 1;
  console.info(`Searching from ${start_angle} with width ${start_width}`);

  let last_angle = start_angle;
  let last_width = start_width;

  for (let i = 0; i < target_precision; i++) {
    const step = rotation_direction / Math.pow(10, i);
    let next_angle = last_angle;
    let next_width;

    while (next_angle < start_angle + 360) {
      next_angle = round(next_angle + step, i);
      next_width = calculate_width(next_angle);

      if (next_width * search_direction > target_width * search_direction) {
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

  if (start_width * search_direction < target_width * search_direction) {
    console.info(`Found ${last_angle} with width ${last_width}`);
    return { has_solution: true, angle: last_angle };
  }

  console.info(`No solution for start_angle ${start_angle}`);
  return { has_solution: false, angle: null };
}
