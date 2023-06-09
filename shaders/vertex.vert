#version 460

layout(location = 0) in vec3 vPos;
layout(location = 1) in vec2 vUV;
layout(location = 2) in vec3 vNorm;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 uvCoord;
layout(location = 2) out vec3 fragNormal;

layout(set = 0, binding = 0) uniform CameraBuffer{
	mat4 viewproj;
} Camera;

struct GPUObjectData {
	mat4 transform;
	vec4 colour;
};

layout(std140,set = 2, binding = 0) readonly buffer ObjectBuffer{
	GPUObjectData data[];
} ObjectData;

vec2 positions[3] = vec2[](
	vec2(0,-0.3),
	vec2(0.25,0.34),
	vec2(-0.4,0.2)
);
/*
vec3 cols[24] = vec3[]( //jesus christ
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0),
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0),
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0),
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0),
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0),
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0),
	vec3(1.0, 1.0, 1.0)
);
*/
void main() {
	//gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
	GPUObjectData objectdata = ObjectData.data[gl_BaseInstance];
	gl_Position = Camera.viewproj * (objectdata.transform*vec4(vPos,1.0));


	//gl_Position = Camera.viewproj * (vec4(vPos,1.0));

	fragColor = objectdata.colour.xyz; //vec3(1.0,1.0,1.0);//cols[gl_VertexIndex];
	fragNormal = vNorm;
	uvCoord = vUV;
}