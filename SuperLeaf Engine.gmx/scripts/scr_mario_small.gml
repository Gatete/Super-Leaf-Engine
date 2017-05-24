///scr_mario_small();

/*
**  Usage:
**      scr_mario_small();
**
**  Purpose:
**      Handles the animation of Mario when he does not have a powerup.
*/

//Handle shooting animation.
firing = 0;

//If Mario is not holding anything.
if (!holding) {

    //If Mario is not sliding down a slope.
    if (sliding == false) {
    
        //If Mario is kicking something.
        if (kicking == false) {

            //If Mario is not moving.
            if (state == 0) {
            
                //Do not animate.
                image_speed = 0;
                image_index = 0;
                
                //Set the idle sprite.
                sprite_index = spr_mario_small_walk
            }
            
            //If Mario is moving.
            else if (state == 1) {
                    
                //If Mario's vertical speed is lower than -0.1 and Mario is facing right.
                if (hspeed < -0.1) 
                && (xscale == 1)
                && (sliding == false)
                && (swimming == false) 
                && (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0)) {
                
                    //Do not animate
                    image_speed = 0;
                    image_index = 0;
                
                    //Set the turning sprite.
                    sprite_index = spr_mario_small_skid;
                }
                
                //If Mario's vertical speed is greater than 0.1 and Mario is facing left.
                else if (hspeed > 0.1) 
                && (xscale == -1)
                && (sliding == false)
                && (swimming == false)
                && (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0)) {
                
                    //Do not animate
                    image_speed = 0;
                    image_index = 0;
                                
                    //Set the turning sprite.
                    sprite_index = spr_mario_small_skid;
                }
            
                else { //Otherwise, execute this.
                
                    //If Mario is running.
                    if (run) {
            
                        //Set the walking sprite.
                        sprite_index = spr_mario_small_run;
                    }
                    else { //Otherwise, If Mario is not running.
            
                        //Set the running sprite.
                        sprite_index = spr_mario_small_walk;
                    }
                    
                    //Set the animation speed.
                    if (!place_meeting(x,y+1,obj_slippery))
                        image_speed = 0.065+abs(hspeed)/7.5;
                    else
                        image_speed = 0.130+abs(hspeed)/7.5;
                }
            }
            
            //If Mario is doing his trademark pose.
            else if (state == 2) {
            
                //If Mario is not swimming.
                if (!swimming) {
                
                    //If Mario is running.
                    if (run) {
                    
                        //Do not animate.
                        image_speed = 0;
                        image_index = 0;
                        
                        //Set the jumping sprite.
                        sprite_index = spr_mario_small_runjump;                        
                    }
                    else {
                    
                        //Do not animate.
                        image_speed = 0;
                        image_index = 0;
                        
                        //Set the jumping sprite.
                        sprite_index = spr_mario_small_jump;                         
                    }
                }
                else {
                
                    //Animate
                    image_speed = 0.15;
                
                    //If Mario is swimming.
                    if (vspeed > 0) {
                    
                        //Set the swimming pose.
                        sprite_index = spr_mario_small_swim;
                    }
                    else { //Otherwise, if it's diving.
                    
                        //Set the diving pose.
                        sprite_index = spr_mario_small_swim2;
                    }
                }
            }
            
            else if (state == 3) {
                
                //If Mario is not moving.
                if (speed == 0) {
                
                    //Do not animate
                    image_speed = 0;
                    image_index = 0;
                    
                    //Reset temporary variable
                    noise = 0;
                }
                
                //If Mario is moving.
                else if (speed != 0) {
                
                    //Animate
                    image_speed = 0.15;
                    
                    //Increment noise and play a sound when noise hits 7.
                    if (!place_meeting(x,y,obj_climb_net)) {
                    
                        if (vspeed < 0) {
                    
                            noise++;
                            if (noise >= 8) {
                            
                                //Reset noise.
                                noise = 0;
                                
                                //Play 'Climb' sound
                                audio_play_sound(snd_climb,0,0);                
                            }
                        }
                        else {
                        
                            //Reset noise.
                            noise = 0;
                        }
                    }
                }
                
                //Set the climbing pose.
                sprite_index = spr_mario_small_climb;
            }
        }
        else { //Otherwise if it's kicking something.
        
            //Do not animate.
            image_speed = 0;
            image_index = 0;
            
            //Set the kicking pose.
            sprite_index = spr_mario_small_kick;
        }
    }
    else { //Otherwise, if Mario is sliding down a slope.
    
        //Do not animate.
        image_speed = 0;
        image_index = 0;
        
        //Set the kicking pose.
        sprite_index = spr_mario_small_slide;    
    }
}

//Otherwise, if Mario is holding something.
else if (holding) {

    //If Mario is not moving.
    if (state == 0) {
    
        //Do not animate.
        image_speed = 0;
        image_index = 0;
    }
    
    //If Mario is moving.
    else if (state == 1) {
    
        //Set the animation speed.
        if (!place_meeting(x,y+1,obj_slippery))
            image_speed = 0.065+abs(hspeed)/7.5;
        else
            image_speed = 0.130+abs(hspeed)/7.5;
    }
    
    //If Mario is doing his trademark pose.
    else if (state == 2) {
    
        //Do not animate.
        image_speed = 0;
        image_index = 1;        
    }
    
    //Set the holding pose.
    if (!turning)
        sprite_index = spr_mario_small_hold;
    else
        sprite_index = spr_mario_small_warp;
}

//Set the mask
mask_index = spr_mask;

//Play a skid sound when Mario is turning directions.
if (sprite_index == spr_mario_small_skid) {

    if (!skidnow) {
    
        //Prevent sound clipping
        skidnow = true;
    
        //Loop 'skid' sound.
        audio_play_sound(snd_skid,0,1);
    }
}
else {

    //Restart sound.
    skidnow = false;
    
    //Stop 'skid' sound.
    audio_stop_sound(snd_skid);
}
