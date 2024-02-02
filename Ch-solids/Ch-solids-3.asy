if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="Ch-solids-3";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import three;
settings.render=8;
settings.prc=false;
size(10cm);

//currentprojection=perspective((45,45,30));
currentprojection = orthographic((3,6,1));

material sphereCcolor = material(diffusepen=black, ambientpen=gray(0.1), specularpen=white);
material cylcolor = material(diffusepen=white, ambientpen=white);

real cylRadius = 0.1;
real sphereRadius = 0.25;

void drawRod(triple a, triple b) {
surface rod = extrude(scale(cylRadius)*unitcircle, axis=length(b-a)*Z);
triple orthovector = cross(Z, b-a);
if (length(orthovector) > .01) {
real angle = aCos(dot(Z, b-a) / length(b-a));
rod = rotate(angle, orthovector) * rod;
}
draw(shift(a)*rod, surfacepen=cylcolor);
}

void drawCarbon(triple center) {
draw(shift(center)*scale3(sphereRadius)*unitsphere, surfacepen=sphereCcolor);
}

triple Aa = (0,0,0);
triple Ab = 4X;
triple Ac = 4Y;
triple Ad = 4X+4Y;
triple Ae = 2X+2Y;
triple Ba = 1X+1Y+1Z;
triple Bb = 3X+3Y+1Z;
triple Ca = 2X+2Z;
triple Cb = 2Y+2Z;
triple Cc = 4X+2Y+2Z;
triple Cd = 2X+4Y+2Z;
triple Da = 3X+1Y+3Z;
triple Db = 1X+3Y+3Z;
triple Ea = 4Z;
triple Eb = 4X+4Z;
triple Ec = 4Y+4Z;
triple Ed = 4X+4Y+4Z;
triple Ee = 2X+2Y+4Z;

drawRod(Ba,Aa);
drawRod(Ba,Ae);
drawRod(Bb,Ae);
drawRod(Bb,Ad);
drawRod(Ba,Ca);
drawRod(Ba,Cb);
drawRod(Bb,Cc);
drawRod(Bb,Cd);
drawRod(Da,Ca);
drawRod(Da,Cc);
drawRod(Db,Cb);
drawRod(Db,Cd);
drawRod(Da,Eb);
drawRod(Da,Ee);
drawRod(Db,Ee);
drawRod(Db,Ec);

drawCarbon(Aa);
drawCarbon(Ab);
drawCarbon(Ac);
drawCarbon(Ad);
drawCarbon(Ae);
drawCarbon(Ba);
drawCarbon(Bb);
drawCarbon(Ca);
drawCarbon(Cb);
drawCarbon(Cc);
drawCarbon(Cd);
drawCarbon(Da);
drawCarbon(Db);
drawCarbon(Ea);
drawCarbon(Eb);
drawCarbon(Ec);
drawCarbon(Ed);
drawCarbon(Ee);

// Frame
material framecolor = material(diffusepen=white, ambientpen=yellow);
void drawFrame(triple a, triple b) {
surface rod = extrude(scale(.5*cylRadius)*unitcircle, axis=length(b-a)*Z);
triple orthovector = cross(Z, b-a);
if (length(orthovector) > .01) {
real angle = aCos(dot(Z, b-a) / length(b-a));
rod = rotate(angle, orthovector) * rod;
}
draw(shift(a)*rod, surfacepen=framecolor);
draw(shift(b)*scale3(cylRadius)*unitsphere, surfacepen=framecolor);
}
drawFrame((0,0,0),4X);
drawFrame((0,0,0),4Y);
drawFrame((0,0,0),4Z);
drawFrame(4X,4X+4Y);
drawFrame(4X,4X+4Z);
drawFrame(4Y,4Y+4X);
drawFrame(4Y,4Y+4Z);
drawFrame(4Z,4X+4Z);
drawFrame(4Z,4Y+4Z);
drawFrame(4X+4Y+4Z,4Y+4Z);
drawFrame(4X+4Z,4X+4Y+4Z);
drawFrame(4X+4Y,4X+4Y+4Z);
%%%TAG:CHEM201
