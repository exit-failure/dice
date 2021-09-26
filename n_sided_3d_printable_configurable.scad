mode = "binary";

sides = 10;
thickness = 7;
facet_angle = 30;
vertical_size=20; // dice may be smaller if facet_angle is too steep
sign_scale_factor = .8;
number_vertical_adjust = 0;
number_offset = 0;



bianry_font = "Arial Black:style=Bold";


rot_angle = 360 / (sides / 2);
angle_offset = (rot_angle/2) * ((sides/2)%2);
rot = 20;
sign_offset = thickness;
 
module number (num) {

    number = num+number_offset;
    text_num = number == 6 ? str(number, ".") : (number == 9 ? str(number, ".") : str(number));

    translate([sign_offset, 0,number_vertical_adjust]) 
        rotate([90,0,90]) 
            scale([sign_scale_factor, sign_scale_factor, 1]) 
                linear_extrude(1.5, center=true) 
                    text(text_num, halign="center", valign="center");
}

module binary(num) {

    if(num == 0) {
        translate([sign_offset, 0,number_vertical_adjust]) 
            rotate([90,0,90]) 
                scale([sign_scale_factor, sign_scale_factor, 1]) 
                    linear_extrude(1.5, center=true) 
                        text("–", font=bianry_font, halign="center", valign="center");
    }
    if(num == 1) {
        translate([sign_offset, 0,number_vertical_adjust]) 
            rotate([90,0,90]) 
                scale([sign_scale_factor, sign_scale_factor, 1]) 
                    linear_extrude(1.5, center=true) 
                        text("+", font=bianry_font, halign="center", valign="center");
    }
}

if(mode == "roman") {
    difference() {
        cube([300,300,vertical_size], center=true);
        for(i=[0:(sides/2)-1]){

            angle_1 = i*rot_angle;
            angle_2 = angle_offset + i * rot_angle;
 
            rotate([facet_angle,facet_angle,angle_1]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
                    
            rotate([-facet_angle,-facet_angle, angle_2]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
            
            if(i % 2 == 0) {
                rotate([180,facet_angle,angle_1]) number(i);
                rotate([0,-facet_angle,angle_2]) number(sides/2+i);
            }
            else {
                rotate([180,facet_angle,angle_1]) number(sides/2+i);
                rotate([0,-facet_angle,angle_2]) number(i);
            }
        }
    }
}
if(mode == "binary"){
    difference() {
        cube([300,300,vertical_size], center=true);
        for(i=[0:(sides/2)-1]){

            angle_1 = i*rot_angle;
            angle_2 = angle_offset + i * rot_angle;

            rotate([facet_angle,facet_angle,angle_1]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
                    
            rotate([-facet_angle,-facet_angle, angle_2]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
            
            if(i % 2 == 0) {
                rotate([180,facet_angle,angle_1]) binary(1);
                rotate([0,-facet_angle,angle_2]) binary(0);
            }
            else {
                rotate([180,facet_angle,angle_1]) binary(0);
                rotate([0,-facet_angle,angle_2]) binary(1);
            }
        }
    }
}

if(mode == "roman"){
    //TODO
    difference() {
        cube([300,300,vertical_size], center=true);
        for(i=[0:(sides/2)-1]){

            angle_1 = i*rot_angle;
            angle_2 = angle_offset + i * rot_angle;

            rotate([facet_angle,facet_angle,angle_1]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
                    
            rotate([-facet_angle,-facet_angle, angle_2]) 
                translate([150+thickness,0,0]) 
                    cube([300,300,300], center=true);
            
            if(i % 2 == 0) {
                rotate([180,facet_angle,angle_1]) binary(1);
                rotate([0,-facet_angle,angle_2]) binary(0);
            }
            else {
                rotate([180,facet_angle,angle_1]) binary(0);
                rotate([0,-facet_angle,angle_2]) binary(1);
            }
        }
    }
}