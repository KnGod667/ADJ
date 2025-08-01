shader_type spatial;
render_mode world_vertex_coords;
group_uniforms noise;
//instance uniform vec2 noise_offset=vec2(0);
uniform vec2 global_noise_offset = vec2(0);
uniform int _Seed=0;
uniform float _Scale=1.0;
uniform float _GradientRotation=0.0;
uniform float _Lacunarity=1.0;
uniform float _InitialAmplitude=1.0;
uniform vec2 _AngularVariance;
uniform float _NoiseRotation = 0.0;
uniform int _Octaves = 4;
uniform float _AmplitudeDecay=0.5;
uniform float _FrequencyVarianceLowerBound = 0.0;
uniform float _FrequencyVarianceUpperBound = 1.0;
group_uniforms;
group_uniforms terrain;
uniform float _TerrainHeight = 1.0;
uniform vec2 _Offset;
uniform float _SlopeDamping= 1.0;
uniform vec2 _SlopeRange = vec2(1.0,1.0);
uniform vec4 _LowSlopeColor :source_color = vec4(0.2,0.8,0.2,1.0);
uniform vec4 _HighSlopeColor :source_color = vec4(0.2,0.2,0.2,1.0);
group_uniforms;
group_uniforms light;
uniform bool enable_raymarched_shadows = false;
uniform float specular_power = 32;
uniform int shadow_precision = 12;
uniform float shadow_step = 0.1;
uniform float shadow_penumbra = 0.1;
group_uniforms;
varying vec3 surface_normal;
varying vec3 frag_pos;

float pseudo(vec2 v) {
	vec3 p3  = fract(vec3(v.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
	//v = fract(v/128.)*128. + vec2(-64.340622, -72.465622);
	//return fract(dot(v.xyx * v.xyy, vec3(20.390625, 60.703125, 2.4281209)));
}

float HashPosition(vec2 pos) {
	return pseudo(pos * vec2(float(_Seed), float(_Seed + 4)));
}

vec2 RandVector(float seed) {
	float theta = float(seed * 360.0 * 2.0 - 360.0);
	theta += _GradientRotation;
	theta = theta * PI / 180.0;
	return normalize(vec2(cos(theta), sin(theta)));
}

vec2 quinticInterpolation(vec2 t) {
	return t * t * t * (t * (t * vec2(6) - vec2(15)) + vec2(10));
}

vec2 quinticDerivative(vec2 t) {
	return vec2(30) * t * t * (t * (t - vec2(2)) + vec2(1));
}
// it's perlin noise that returns the noise in the x component and the derivatives in the yz components as explained in my perlin noise video
vec3 perlin_noise2D(vec2 pos) {
	vec2 latticeMin = floor(pos);
	vec2 latticeMax = ceil(pos);
	vec2 remainder = fract(pos);
	// Lattice Corners
	vec2 c00 = latticeMin;
	vec2 c10 = vec2(latticeMax.x, latticeMin.y);
	vec2 c01 = vec2(latticeMin.x, latticeMax.y);
	vec2 c11 = latticeMax;
	// Gradient Vectors assigned to each corner
	vec2 g00 = RandVector(HashPosition(c00));
	vec2 g10 = RandVector(HashPosition(c10));
	vec2 g01 = RandVector(HashPosition(c01));
	vec2 g11 = RandVector(HashPosition(c11));
	// Directions to position from lattice corners
	vec2 p0 = remainder;
	vec2 p1 = p0 - vec2(1.0);
	vec2 p00 = p0;
	vec2 p10 = vec2(p1.x, p0.y);
	vec2 p01 = vec2(p0.x, p1.y);
	vec2 p11 = p1;

	vec2 u = quinticInterpolation(remainder);
	vec2 du = quinticDerivative(remainder);

	float a = dot(g00, p00);
	float b = dot(g10, p10);
	float c = dot(g01, p01);
	float d = dot(g11, p11);

	// Expanded interpolation freaks of nature from https://iquilezles.org/articles/gradientnoise/
	float noise = a + u.x * (b - a) + u.y * (c - a) + u.x * u.y * (a - b - c + d);

	vec2 gradient = g00 + u.x * (g10 - g00) + u.y * (g01 - g00) + u.x * u.y * (g00 - g10 - g01 + g11) + du * (u.yx * (a - b - c + d) + vec2(b, c) - a);
	return vec3(noise, gradient);
}

// The fractional brownian motion that sums many noise values as explained in the video accompanying this project
vec3 fbm(vec2 pos, int lod) {
	float lacunarity = _Lacunarity;
	float amplitude = _InitialAmplitude;
		// height sum
	float height = 0.0;
	// derivative sum
	vec2 grad = vec2(0.0);
		// accumulated rotations
	mat2 m = mat2(vec2(1.0, 0.0), vec2(0.0, 1.0));
// generate random angle variance if applicable
	float angle_variance = mix(_AngularVariance.x, _AngularVariance.y, HashPosition(vec2(float(_Seed), 827.0)));
	float theta = (_NoiseRotation + angle_variance) * PI / 180.0;
	// rotation matrix
	mat2 m2 = mat2(vec2(cos(theta), -sin(theta)),
			  	   vec2(sin(theta),  cos(theta)));

	mat2 m2i = inverse(m2);
	for(int i = 0; i < clamp(_Octaves-lod,1,_Octaves); ++i) {
		vec3 n = perlin_noise2D(pos);

		// add height scaled by current amplitude
		height += amplitude * n.x;

		// add gradient scaled by amplitude and transformed by accumulated rotations
		grad += amplitude * m * n.yz;

		// apply amplitude decay to reduce impact of next noise layer
		amplitude *= _AmplitudeDecay;

		// generate random angle variance if applicable
		angle_variance = mix(_AngularVariance.x, _AngularVariance.y, HashPosition(vec2(float(i * 419), float(_Seed))));
		theta = (_NoiseRotation + angle_variance) * PI / 180.0;
		// reconstruct rotation matrix, kind of a performance stink since this is technically expensive and doesn't need to be done if no random angle variance but whatever it's 2025
		m2 = mat2(vec2(cos(theta), -sin(theta)),
			  	  vec2(sin(theta),  cos(theta)));

		m2i = inverse(m2);
		// generate frequency variance if applicable
		float freq_variance = mix(_FrequencyVarianceLowerBound, _FrequencyVarianceUpperBound, HashPosition(vec2(float(i * 422), float(_Seed))));
		// apply frequency adjustment to sample position for next noise layer
		pos = (lacunarity + freq_variance) * m2 * pos;
		m = (lacunarity + freq_variance) * m2i * m;
	}

	return vec3(height, grad);
}
//TODO this needs work. Extremely slow, i should think of another approach. I should probably check shadow mapping shadow mapping
float getShadow(vec3 position, vec3 lightDir){
	float shadow = 1.0;
	float s = shadow_step/_Scale;
	for(int i = 0; i < shadow_precision; ++i){
		vec3 lightRay = lightDir*(float(i)*s);
		vec3 pos = position+lightRay;
		float h = fbm(pos.xz/_Scale,_Octaves/2+1).x*_TerrainHeight + _TerrainHeight - _Offset.y;
		//float h = fbm(pos.xz,1).x;
		shadow = min(shadow,pos.y-h);
	}
	shadow = smoothstep(-shadow_penumbra,shadow_penumbra,shadow);
	return shadow;
}
void vertex() {

	vec2 noise_pos=(VERTEX.xz+global_noise_offset)/_Scale;
	//idk how i should handle the lod exactly, the point in which the detail starts dropping
	//seems about right but it feels like after the first drop it should drop faster
	vec3 n = fbm(noise_pos,int(distance(CAMERA_POSITION_WORLD,NODE_POSITION_WORLD)/50.0));
	VERTEX.y += _TerrainHeight * n.x + _TerrainHeight - _Offset.y;
	surface_normal = normalize(vec3(-n.y, 1, -n.z) * vec3(_SlopeDamping, 1, _SlopeDamping));
	NORMAL = normalize(vec3(-n.y, 1, -n.z));
	frag_pos = VERTEX;
}

void fragment() {
	vec3 slope_normal = normalize(NORMAL * vec3(_SlopeDamping, 1, _SlopeDamping));
	float blend_factor = smoothstep(_SlopeRange.x, _SlopeRange.y, 1.0 - slope_normal.y);
	
	vec4 albedo = mix(_LowSlopeColor, _HighSlopeColor, vec4(blend_factor));

	ALBEDO = albedo.xyz;
}

void light() {
	//TODO fix this
	float ndotl = clamp(dot(LIGHT, NORMAL), 0, 1);
	vec3 direct_light = ndotl *LIGHT_COLOR*ATTENUATION/PI;
	vec3 reflectDir = reflect(LIGHT, NORMAL);
	float spec = pow(max(dot(VIEW, -reflectDir), 0.0), specular_power);
	float shadow =  1.0;
	if(enable_raymarched_shadows){
		shadow = getShadow(frag_pos,LIGHT);
	}
	DIFFUSE_LIGHT += direct_light*shadow;
	SPECULAR_LIGHT = vec3(spec)*shadow;

	//float shadow = getShadow(frag_pos,(vec4(LIGHT,1.0)*VIEW_MATRIX).xyz);
	//DIFFUSE_LIGHT = clamp(dot(LIGHT, NORMAL), 0, 1)*LIGHT_COLOR*ATTENUATION/PI*shadow;
	//DIFFUSE_LIGHT = vec3(shadow);
}