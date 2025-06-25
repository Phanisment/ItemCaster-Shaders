#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
	gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
	
	vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
	vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
	texCoord0 = UV0;
	
	// hide scoreboard number
	if (Position.z == 0.0 && gl_Position.x >= 0.98 && gl_Position.y >= -0.2) {
		vertexColor.a = 0.0;
	}
	
	ivec3 iColor = ivec3(Color.xyz * 255 + vec3(0.5));
	if(fract(Position.z) < 0.1) {
		if(iColor==ivec3(0, 0, 0)) {
			gl_Position.y += sin(GameTime * 12000.0 + (gl_Position.x * 6)) / 150.0;
		}
	}
}

// Debugger: vertexColor = vec4(1.0, 1.0, 0.0, 1.0);