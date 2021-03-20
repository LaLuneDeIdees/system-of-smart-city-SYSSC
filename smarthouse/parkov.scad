
module block(){
difference(){
translate([-2.5,-16,0.5-0.25])cube([5,32,5]);
translate([-2,-17,0.5-0.25])cube([4,34,4.5]);
    translate([0,0,0]){
    translate([0,-1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    translate([0,1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    }
    translate([0,-10.5,0]){
    translate([0,-1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    translate([0,1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    }
    translate([0,10.5,0]){
    translate([0,-1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    translate([0,1.35,2.25])rotate([0,90,0])cylinder(6,0.85,0.85,center=true, $fn=100);
    }
    translate([0])cylinder(10,0.3,0.3,$fn=100);
    translate([0,10.5,0])cylinder(10,0.3,0.3,$fn=100);
    translate([0,-10.5,0])cylinder(10,0.3,0.3,$fn=100);
}
}
h=5;
a =[
for(t=[90:3:270])
    [cos(-t)*h+t*3.14/180*h-3.14/2*h,sin(-t)*h]
];
a1 = [
for(t=[270:-3:90])
    [cos(-t)*h+t*3.14/180*h-3.14/2*h,sin(-t)*h-0.1]
];
b = [[4*h,1*h],[4*h,-2*h],[0,-2*h]];
c = concat(a,b);
c1=concat([[0,-1]],a,[[4*h,1*h]],[[4*h,1*h-0.1]],a1,[[0,-1-0.1]]);
module stenka(){
translate([0,10,0])linear_extrude(0.5,true,$fn=100)
polygon(c);
}
module pl(){
rotate([90,0,0]){
    union(){
    difference(){
        stenka();
        translate([24,7.5,0])cylinder(2,7,7,true,$fn=200);
        translate([2,1.5,0])scale([0.8,0.8,1]){
            difference(){
        stenka();
        translate([25,7.5,0])cylinder(2,7/0.8,7/0.8,true,$fn=200);
    }
        }
    }
    difference(){
    translate([3,17,0])cylinder(0.5,16,16,$fn=200);
     translate([1.5,18.5,0])cylinder(0.5,16,16,$fn=200);
     translate([-10,0,-1])cube([10,10,2]);
     translate([10,15,-1])cube([10,20,2]);
    }
}
}
}

rotate([-90,0,0])pl();
translate([50,0,0])block();
translate([40,0,0])rotate([0,90,0])block();
translate([-50,0,0])cube([45,32,0.5],true);

block();
cube([45,32,0.5],true);
translate([2.5,-15.5,0.25])pl();
translate([2.5,16,0.25])pl();
translate([2.5,-5.5,0.25])pl();
translate([2.5,6,0.25])pl();
translate([2.5,16,5.4])rotate([90,0,0])translate([0,5,0])linear_extrude(32)polygon(c1);
mirror([1,0,0]){
translate([2.5,-15.5,0.25])pl();
translate([2.5,16,0.25])pl();
translate([2.5,-5.5,0.25])pl();
translate([2.5,6,0.25])pl();
translate([2.5,16,5.4])rotate([90,0,0])translate([0,5,0])linear_extrude(32)polygon(c1);
}