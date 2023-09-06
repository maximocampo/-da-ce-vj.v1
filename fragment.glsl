#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec3 fragNormal;

void main() {
  vec3 normalDirection = normalize(fragNormal);
  vec3 lightDirection = normalize(vec3(0.5, 0.5, 1.0));
  float dotProduct = dot(normalDirection, lightDirection);
  float brightness = max(dotProduct, 0.0);
  
  // Subsurface Scattering
  vec3 backColor = vec3(0.2, 0.5, 0.2);
  vec3 frontColor = vec3(0.0, 1.0, 0.0);
  float scatter = brightness;  // A simple factor; you can make this more complex
  vec3 scatterColor = mix(backColor, frontColor, scatter);
  
  // Specular Lighting
  vec4 specular = vec4(1.0, 1.0, 1.0, 1.0) * pow(max(dot(lightDirection, normalDirection), 0.0), 3.0);
  
  // Translucency
  float alpha = 0.8;  // Could be dependent on various factors
  
  gl_FragColor = vec4(scatterColor, alpha) + specular;
}
