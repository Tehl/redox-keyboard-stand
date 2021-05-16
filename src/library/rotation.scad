// ref: http://forum.openscad.org/Wanted-rotate-function-on-vectors-td11218.html

function identity(d)        = d == 0 ? 1 : [for(y=[1:d]) [for(x=[1:d]) x == y ? 1 : 0] ];
function length(v)          = let(x=v[0], y=v[1], z=v[2]) sqrt(x*x + y*y + z*z);
function unit_vector(v)     = let(x=v[0], y=v[1], z=v[2]) [x/length(v), y/length(v), z/length(v)];
function skew_symmetric(v)  = let(x=v[0], y=v[1], z=v[2]) [[0, -z, y], [z, 0, -x], [-y, x, 0]];
function tensor_product1(u) = let(x=u[0], y=u[1], z=u[2]) [[x*x, x*y, x*z], [x*y, y*y, y*z], [x*z, y*z, z*z]];
function rotate(a, v)
 = is_list(a)
	? let(rx=a[0], ry=a[1], rz=a[2])
		  [[1, 0, 0],              [0, cos(rx), -sin(rx)], [0, sin(rx), cos(rx)]]
		* [[cos(ry), 0, sin(ry)],  [0, 1, 0],              [-sin(ry), 0, cos(ry)]]
		* [[cos(rz), -sin(rz), 0], [sin(rz), cos(rz), 0],  [0, 0, 1]]
	: let(uv=unit_vector(v))
	  cos(a)*identity(3) + sin(a)*skew_symmetric(uv) + (1 - cos(a))*tensor_product1(uv);