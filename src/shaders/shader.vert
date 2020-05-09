#version 450
#extension GL_KHR_vulkan_glsl: enable

layout(location = 0) in vec3 inPos;

layout(location = 0) out vec3 outColor;

layout (set = 0, binding = 0) uniform UniformBufferObject{
	mat4 projection;
	mat4 view;
	mat4 model;
};

void main()
{
    gl_Position = projection * view * model * vec4(inPos, 1.0);
	gl_PointSize = 1;
	
	int id = gl_VertexIndex % 3;
	if(id == 0) {
		outColor = vec3(1.f,0.f,0.f);
	} else if (id == 1) {
		outColor = vec3(0.f,1.f,0.f);
	} else {
		outColor = vec3(0.f,0.f,1.f);
	}
}
