package data;

typedef Stage = {
    var BF_POS:Array<Int>;
    var GF_POS:Array<Int>;
    var DAD_POS:Array<Int>;

    var CAM_POS_BF:Array<Int>;
    var CAM_POS_GF:Array<Int>;
    var CAM_POS_DAD:Array<Int>;

    var BG:Array<StageBGImg>;

    var FG:Array<StageBGImg>;

    var CamZoom:Float;
}

typedef StageBGImg = {
    var img:String;
    var pos:Array<Int>;
    var scale:Array<Int>;
    var scrol:Array<Int>;
    var flipX:Bool;
    var flipY:Bool;
}