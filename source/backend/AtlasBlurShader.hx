package backend;

import flixel.system.FlxAssets.FlxShader;

class AtlasBlurShader extends FlxShader {
    @:glFragmentSource('
        #pragma header
        uniform float strength;
        
        void main() {
            vec2 uv = openfl_TextureCoordv;
            vec4 color = texture2D(bitmap, uv);
            
            // Простое размытие
            color += texture2D(bitmap, uv + vec2(strength * 0.01, 0));
            color += texture2D(bitmap, uv - vec2(strength * 0.01, 0));
            
            gl_FragColor = color / 3.0;
        }
    ')
    
    public function new(strength:Float = 1.0) {
        super();
        this.strength.value = [strength];
    }
}
