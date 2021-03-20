module house(){
difference(){
    union(){
        difference(){
            cube([25,50,50]);
            translate([0.5,0.5,0.5])cube([25,49,16]);
            translate([0.5,0.5,0.5+16+0.5])cube([25,49,16]);
            translate([0.5,-1,0.5+16+0.5+16+0.5])cube([25,49+1.5,16]);
            translate([-1,40,0.5])cube([30,15,16]);
            translate([-1,40,0.5+16+0.5])cube([30,15,16]);
            translate([-1,40,0.5+16+0.5+16-2])cube([30,15,20]);
            
            translate([(25-12)/2,-1,5])cube([12,3,6]);
            translate([(25-12)/2,-1,5+16+0.5])cube([12,3,6]);
            
            translate([-1,40,16+16+1.5])rotate([20,0,0])cube([27,10,20]);
            translate([-1,0,16+16+1.5])scale([1,-1,1])rotate([20,0,0])cube([27,10,20]);
            translate([3,7.5,49])cube([19,24,3]);
        }
        
        translate([0,40,16*2+0.5*2])rotate([-20,0,0])cube([25,12,0.5]);
        difference(){
            translate([0,40-0.5,0.1])cube([25,0.5,17+16+0.5-0.2]);
                
            translate([(25-7)/2,40-1,0.5])cube([7,2,12]);
            translate([(25-7)/2,40-1,0.5+16+0.5])cube([7,2,12]);
        }
        translate([0,50-0.5,0.1])cube([0.5,0.5,29+0.2]);
        translate([25-0.5,50-0.5,0.1])cube([0.5,0.5,29+0.2]);
        translate([0,50-0.5,29-0.5+0.2+0.1])cube([25,0.5,0.5]);
        translate([0,50-0.5,20-0.5+0.2+0.1+1])cube([25,0.5,0.5]);
        translate([0,50-0.5,17])cube([25,0.5,0.5]);
        
        translate([0,50-0.5-10,20-0.5+0.2+0.1+1])cube([0.5,10,0.5]);
        translate([0,50-0.5-10,17])cube([0.5,10,0.5]);
        
        translate([25-0.5,50-0.5-10,20-0.5+0.2+0.1+1])cube([0.5,10,0.5]);
        translate([25-0.5,50-0.5-10,17])cube([0.5,10,0.5]);
        
        for(i = [1:9]){
            translate([25/10*i,50-0.5,16+1-0.1])cube([0.5,0.5,4+0.1]);
        }
        for(i = [1:4]){
            translate([0,40+10/5*i,16+1-0.1])cube([0.5,0.5,4+0.1]);
            translate([25-0.5,40+10/5*i,16+1-0.1])cube([0.5,0.5,4+0.1]);
        }
        
        translate([(25-12)/2-0.5,-0.5,5-0.5])difference(){
            cube([12+1,0.5,6+1]);
            translate([0.5,-1,0.5])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5+0.5+(13-1.5)/2,-1,0.5])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5,-1,0.5+0.5+(7-1.5)/2])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5+0.5+(13-1.5)/2,-1,0.5+0.5+(7-1.5)/2])cube([(13-1.5)/2,3,(7-1.5)/2]);
        }
        translate([(25-12)/2-0.5,-0.5,5-0.5+0.5+16])difference(){
            cube([12+1,0.5,6+1]);
            translate([0.5,-1,0.5])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5+0.5+(13-1.5)/2,-1,0.5])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5,-1,0.5+0.5+(7-1.5)/2])cube([(13-1.5)/2,3,(7-1.5)/2]);
            translate([0.5+0.5+(13-1.5)/2,-1,0.5+0.5+(7-1.5)/2])cube([(13-1.5)/2,3,(7-1.5)/2]);
        }
        
        translate([0,40-0.5,16+16+1.5])rotate([20,0,0])cube([25,0.5,16.8]);
        translate([0,0+0.5,16+16+1.5])scale([1,-1,1])rotate([20,0,0])cube([25,0.5,16.8]);
        
        intersection(){
            union(){
            translate([0,40,16+16+1.5])rotate([20,0,0])cube([25,0.5,16.8]);
        translate([0,0,16+16+1.5])scale([1,-1,1])rotate([20,0,0])cube([25,0.5,16.8]);
            }
            translate([25/2,-1,16*2+1.5+16/2])rotate([-90,0,0])cylinder(d1=11,d2=11,h=55, $fn=100);
        }
    }
    translate([25/2,-1,16*2+1.5+16/2])rotate([-90,0,0])cylinder(d1=10,d2=10,h=55, $fn=500);
}

        translate([0+25/2,40,16+16+1.5])rotate([20,0,0])translate([0,0+0.5/2,16/2+0.2])rotate([0,90,0])cube([1,0.5,10.8],true);
        translate([0+25/2,0,16+16+1.5])scale([1,-1,1])rotate([20,0,0])translate([0,0+0.5/2,16/2+0.2])rotate([0,90,0])cube([1,0.5,10.8],true);
translate([2.5,7,50])union(){
difference(){
    cube([20,25,8.122992406]);
    rotate([18,0,0])cube([20,30,8.122992406]);
    translate([0.5,0,0])cube([19,24.5,10]);
    translate([1.5,24,1.5])cube([17,3,5]);
    }
rotate([18,0,0])translate([-1,0,0])cube([22,26.286555606+1,0.5]);
}
}
*projection()rotate([0,0,0])house();
projection(true)translate([0,0,-15 * 37.796327212])rotate([0,-90,0])scale([1 + 1/5, 1 + 1/5, 1])scale(37.796327212)house();
house();
module m(){
scale([1 + 1/5, 1 + 1/5, 1])scale(37.796327212)house();
}
projection(true)
translate([0,0,120])rotate([0,90,0])m();
!projection(true){
    translate([-1500,0,-1])rotate([-90,0,0])m();
    translate([-3000,0,0])rotate([-90,0,0])m();
    translate([-4500,0,-1])m();
    translate([-6000,0,-1])m();
    translate([-7500,0,-33 * 38])m();
    translate([-9000,0,-49.5 * 38])m();
    translate([-10500,0,-2180])rotate([66.41,0,0])m();
    translate([-12000,0,-2180])rotate([66.41,0,0])m();
    translate([-13500,0,-1750])rotate([-15.15,0,0])m();
    translate([-15000,0,-2167])rotate([66.41,0,0])m();
    translate([-16500,0,-1735])rotate([16.87,0,0])m();
    translate([0,-3000,1])rotate([0,90,0])m();
    translate([0,-10000,1])rotate([0,90,0])m();
    translate([-18000,0,1807])rotate([-90,0,0])m();
    *translate([-19500,0,2255])rotate([-90,0,0])m();
    translate([-21000,0,2255])rotate([-90,0,0])m();
    translate([-22500,0,1444])rotate([-90,0,0])m();
    translate([0,-7000,120])rotate([0,90,0])m();
}
!translate([0,0,-2180])rotate([66.41,0,0])m();