#version 150

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;

void main() {
	gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

	vertexColor = Color;
	
	// hide background scoreboard
	if(gl_Position.y > -0.5 && gl_Position.y < 0.85 && gl_Position.x > 0.0 && gl_Position.x <= 1.0 && Position.z == 0.0) {
		vertexColor.a = 0.0;
	}
}