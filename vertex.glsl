uniform mat4 modelview;
uniform mat4 projection;
attribute vec4 position;
attribute vec3 normal;
varying vec3 fragNormal;

void main() {
  fragNormal = (modelview * vec4(normal, 0.0)).xyz;  // Transform the normal's orientation into eye space
  gl_Position = projection * modelview * position;
}
