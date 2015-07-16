<- $ document .ready

init-webGL = (canvas) ->
  try
    gl = canvas.get-context \webgl
  catch
  gl
canvas = document.getElementById \canvas
gl = init-webGL canvas
console.log gl
if !gl => return
gl.clear-color 0,0,0,1

/*
gl.enable gl.DEPTH_TEST
gl.depth-func gl.LEQUAL
gl.clear gl.COLOR_BUFFER_BIT .|. gl.DEPTH_BUFFER_BIT
gl.viewport 0, 0, canvas.width, canvas.height
*/

buf = gl.create-buffer!
gl.bind-buffer gl.ARRAY_BUFFER, buf
vertices = [-0.5 -0.5 0.5 -0.5 0 0.5]
gl.buffer-data gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW
vs = "attribute vec2 blahpos; void main() { gl_Position = vec4(blahpos, 0, 1); } "
fs = "void main() { gl_FragColor = vec4(0,1,0,1); }"

create-shader = (type, code) ->
  shader = gl.create-shader type
  gl.shader-source shader, code
  gl.compile-shader shader
  shader

create-program = (vs, fs) ->
  program = gl.create-program!
  vs = create-shader gl.VERTEX_SHADER, vs
  fs = create-shader gl.FRAGMENT_SHADER, fs
  gl.attach-shader program, vs
  gl.attach-shader program, fs
  gl.link-program program
  program

program = create-program vs, fs
gl.use-program program
pos = gl.get-attrib-location program, \blahpos
gl.enable-vertex-attrib-array pos
gl.vertex-attrib-pointer pos, 2 gl.FLOAT, false, 0, 0
gl.draw-arrays gl.TRIANGLES, 0, 3
vertices = [-0.5 0.5 0.5 0.5 0 -0.5]
#gl.buffer-data gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW
gl.draw-arrays gl.TRIANGLES, 0, 3
