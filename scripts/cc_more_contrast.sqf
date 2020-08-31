//--- Color correction More Contrast
// more contrast and saturation
ten_hndl = ppEffectCreate ["colorCorrections", 1501];
ten_hndl ppEffectEnable true;
ten_hndl ppEffectAdjust [
    1,
    1.05,
    0,
    [0,0.61,0.57,-0.08],
    [1,1,1,1.71],
    [-0.05,-0.05,1.14,0],
    [0,0,1,1,0,0,0]

];

ten_hndl ppEffectCommit 25;
//ppEffectDestroy ten_hndl;