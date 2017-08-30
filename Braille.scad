//Braille Tile
cells = [[-1.25,2.5,0.5],[-1.25,0,0.5],[-1.25,-2.5,0.5],
    [1.25,2.5,0.5],[1.25,0,0.5],[1.25,-2.5,0.5]];
// A-J
a = [1,0,0,0,0,0];
b = [1,1,0,0,0,0];
c = [1,0,0,1,0,0];
d = [1,0,0,1,1,0];
e = [1,0,0,0,1,0];
f = [1,1,0,1,0,0];
g = [1,1,0,1,1,0];
h = [1,1,0,0,1,0];
i = [0,1,0,1,0,0];
j = [0,1,0,1,1,0];
// K - T
k = [1,0,1,0,0,0];
l = [1,1,1,0,0,0];
m = [1,0,1,1,0,0];
n = [1,0,1,1,1,0];
o = [1,0,1,0,1,0];
p = [1,1,1,1,0,0];
q = [1,1,1,1,1,0];
r = [1,1,1,0,1,0];
s = [0,1,1,1,0,0];
t = [0,1,1,1,1,0];
// U - ?
u = [1,0,1,0,0,1];
v = [1,1,1,0,0,1];
w = [0,1,0,1,1,1];
x = [1,0,1,1,0,1];
y = [1,0,1,1,1,1];
z = [1,0,1,0,1,1];
shift = [0,0,0,0,0,1];
prime = [0,0,1,0,0,0];
num = [0,0,1,1,1,1];
dash = [0,1,0,0,1,0];
space = [0,0,0,0,0,0];

tray(0,[shift,t,i,m,space,shift,h,e,i,l,e,r,s,space]);
tray(1,[t,h,i,s,space,i,s,space,a,space,t,e,s,t]);
slate(2,13);
slate(3,13);



//Dot Module
module dot(){
    union(){
        translate([0,0,-0.25])
        cylinder($fn=12,0.25,0.3,0.6);
        translate([0,0,0])
        cylinder($fn=12,0.25,0.6,0.3);
    }
}

//Cell Module
module cell(dots){
    for (i = [0:len(dots)-1]){
        if (dots[i]) translate (cells[i]) dot();
    }
}

//Tile Modules
module tile(dots,holes){
    if (holes){
        difference(){
            cube([6,10,1], center=true);
            cell(dots);
        }
    } else {
        union(){   
            cube([6,10,1], center=true);
            cell(dots);
        }
    }
}

//Tray Module
module tray(row,line){
    for (i = [0:len(line)-1]){
        translate([tileCol(i),tileRow(row),0.5])
        union(){
            tile(line[i]);
        }
    }    
}

module slate(row,col){
    for (i = [0:col]){
        translate([tileCol(i),tileRow(row),0.5])
        tile([1,1,1,1,1,1],1);
    }
}

function tileCol(y) = y*6-39;
function tileRow(x) = 20-x*10;