`timescale 1ns/1ps

module traffic_light_controller(

    input clk,
    input reset,

    input pedestrian,
    input emergency,

    output reg red,
    output reg yellow,
    output reg green

);

//==============================
// State Encoding
//==============================

parameter RED_STATE    = 3'd0;
parameter GREEN_STATE  = 3'd1;
parameter YELLOW_STATE = 3'd2;
parameter PED_STATE    = 3'd3;
parameter EMG_STATE    = 3'd4;

//==============================
// Timer Values
//==============================

parameter RED_TIME    = 5;
parameter GREEN_TIME  = 5;
parameter YELLOW_TIME = 2;
parameter PED_TIME    = 4;

//==============================
// Registers
//==============================

reg [2:0] current_state;
reg [2:0] next_state;

reg [3:0] timer;

reg pedestrian_request;

//==============================
// Pedestrian Request
//==============================

always @(posedge clk)
begin

    if(reset)
        pedestrian_request <= 1'b0;

    else if(pedestrian)
        pedestrian_request <= 1'b1;

    else if(current_state==PED_STATE && timer==PED_TIME-1)
        pedestrian_request <= 1'b0;

end

//==============================
// State Register
//==============================

always @(posedge clk)
begin

    if(reset)
    begin

        current_state <= RED_STATE;
        timer <= 0;

    end

    else
    begin

        current_state <= next_state;

        if(current_state!=next_state)
            timer <= 0;
        else
            timer <= timer + 1;

    end

end
//==============================
// Next State Logic
//==============================

always @(*)
begin

    next_state = current_state;

    case(current_state)

        //---------------------------------
        // RED
        //---------------------------------
        RED_STATE:
        begin
            if(emergency)
                next_state = EMG_STATE;

            else if(timer >= RED_TIME-1)
                next_state = GREEN_STATE;

            else
                next_state = RED_STATE;
        end

        //---------------------------------
        // GREEN
        //---------------------------------
        GREEN_STATE:
        begin
            if(emergency)
                next_state = EMG_STATE;

            else if(timer >= GREEN_TIME-1)
                next_state = YELLOW_STATE;

            else
                next_state = GREEN_STATE;
        end

        //---------------------------------
        // YELLOW
        //---------------------------------
        YELLOW_STATE:
        begin
            if(emergency)
                next_state = EMG_STATE;

            else if(timer >= YELLOW_TIME-1)
            begin
                if(pedestrian_request)
                    next_state = PED_STATE;
                else
                    next_state = RED_STATE;
            end
            else
                next_state = YELLOW_STATE;
        end

        //---------------------------------
        // PEDESTRIAN
        //---------------------------------
        PED_STATE:
        begin
            if(emergency)
                next_state = EMG_STATE;

            else if(timer >= PED_TIME-1)
                next_state = RED_STATE;

            else
                next_state = PED_STATE;
        end

        //---------------------------------
        // EMERGENCY
        //---------------------------------
        EMG_STATE:
        begin
            if(!emergency)
                next_state = RED_STATE;
            else
                next_state = EMG_STATE;
        end

        //---------------------------------
        default:
            next_state = RED_STATE;

    endcase

end
//==============================
// Output Logic (Moore FSM)
//==============================

always @(*)
begin

    // Default Outputs
    red    = 1'b0;
    yellow = 1'b0;
    green  = 1'b0;

    case(current_state)

        //---------------------------------
        // RED
        //---------------------------------
        RED_STATE:
        begin
            red = 1'b1;
        end

        //---------------------------------
        // GREEN
        //---------------------------------
        GREEN_STATE:
        begin
            green = 1'b1;
        end

        //---------------------------------
        // YELLOW
        //---------------------------------
        YELLOW_STATE:
        begin
            yellow = 1'b1;
        end

        //---------------------------------
        // PEDESTRIAN
        //---------------------------------
        PED_STATE:
        begin
            red = 1'b1;
        end

        //---------------------------------
        // EMERGENCY
        //---------------------------------
        EMG_STATE:
        begin
            red = 1'b1;
        end

        //---------------------------------
        default:
        begin
            red = 1'b1;
        end

    endcase

end

endmodule