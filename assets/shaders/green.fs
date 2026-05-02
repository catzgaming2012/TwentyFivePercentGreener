extern float green_mix;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
    vec4 tex = Texel(texture, texture_coords);

    // Normally for grayscale, but I want biblically accurate G R E E N
    float luma = dot(tex.rgb, vec3(0.299, 0.587, 0.114));

    // Blend between the original color and the G R E E N
    tex.rgb = mix(tex.rgb, vec3(0, luma, 0), green_mix);

    return tex*color;
}

#ifdef VERTEX
vec4 position(mat4 t, vec4 v)
{
    return t * v;
}
#endif