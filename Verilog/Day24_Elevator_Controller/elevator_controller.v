`timescale 1ns/1ps

module elevator_controller(

    input clk,
    input reset,

    input [1:0] request_floor,

    output reg [1:0] current_floor,

    output reg moving_up,
    output reg moving_down,
    output reg door_open

);

//========================================
// State Encoding
//========================================

parameter IDLE       = 3'd0;
parameter MOVE_UP    = 3'd1;
parameter MOVE_DOWN  = 3'd2;
parameter DOOR_OPEN  = 3'd3;
parameter DOOR_CLOSE = 3'd4;

//========================================
// Registers
//========================================

reg [2:0] current_state;
reg [2:0] next_state;

reg [2:0] timer;

// Door Timing

parameter DOOR_TIME = 3;
 //========================================
// State Register + Timer
//========================================

always @(posedge clk)
begin

    if(reset)
    begin
        current_state  <= IDLE;
        current_floor  <= 2'd0;
        timer          <= 3'd0;
    end

    else
    begin

        current_state <= next_state;

        case(current_state)

            MOVE_UP:
            begin
                if(current_floor < request_floor)
                    current_floor <= current_floor + 1;
            end

            MOVE_DOWN:
            begin
                if(current_floor > request_floor)
                    current_floor <= current_floor - 1;
            end

            DOOR_OPEN:
            begin
                if(timer < DOOR_TIME)
                    timer <= timer + 1;
                else
                    timer <= 0;
            end

            default:
            begin
                timer <= 0;
            end

        endcase

    end

end
 //========================================
// Next State Logic
//========================================

always @(*)
begin

    next_state = current_state;

    case(current_state)

        //--------------------------------
        // IDLE
        //--------------------------------
        IDLE:
        begin
            if(request_floor > current_floor)
                next_state = MOVE_UP;

            else if(request_floor < current_floor)
                next_state = MOVE_DOWN;

            else
                next_state = DOOR_OPEN;
        end

        //--------------------------------
        // MOVE UP
        //--------------------------------
        MOVE_UP:
        begin
            if(current_floor == request_floor)
                next_state = DOOR_OPEN;
            else
                next_state = MOVE_UP;
        end

        //--------------------------------
        // MOVE DOWN
        //--------------------------------
        MOVE_DOWN:
        begin
            if(current_floor == request_floor)
                next_state = DOOR_OPEN;
            else
                next_state = MOVE_DOWN;
        end

        //--------------------------------
        // DOOR OPEN
        //--------------------------------
        DOOR_OPEN:
        begin
            if(timer == DOOR_TIME)
                next_state = DOOR_CLOSE;
            else
                next_state = DOOR_OPEN;
        end

        //--------------------------------
        // DOOR CLOSE
        //--------------------------------
        DOOR_CLOSE:
        begin
            next_state = IDLE;
        end

        //--------------------------------
        default:
        begin
            next_state = IDLE;
        end

    endcase
    
end


//========================================
// Output Logic (Moore FSM)
//========================================

always @(*)
begin

    // Default Outputs
    moving_up   = 1'b0;
    moving_down = 1'b0;
    door_open   = 1'b0;

    case(current_state)

        //--------------------------------
        // IDLE
        //--------------------------------
        IDLE:
        begin
            moving_up   = 1'b0;
            moving_down = 1'b0;
            door_open   = 1'b0;
        end

        //--------------------------------
        // MOVE UP
        //--------------------------------
        MOVE_UP:
        begin
            moving_up   = 1'b1;
            moving_down = 1'b0;
            door_open   = 1'b0;
        end

        //--------------------------------
        // MOVE DOWN
        //--------------------------------
        MOVE_DOWN:
        begin
            moving_up   = 1'b0;
            moving_down = 1'b1;
            door_open   = 1'b0;
        end

        //--------------------------------
        // DOOR OPEN
        //--------------------------------
        DOOR_OPEN:
        begin
            moving_up   = 1'b0;
            moving_down = 1'b0;
            door_open   = 1'b1;
        end

        //--------------------------------
        // DOOR CLOSE
        //--------------------------------
        DOOR_CLOSE:
        begin
            moving_up   = 1'b0;
            moving_down = 1'b0;
            door_open   = 1'b0;
        end

        //--------------------------------
        default
        //--------------------------------
        begin
            moving_up   = 1'b0;
            moving_down = 1'b0;
            door_open   = 1'b0;
        end

    endcase

end

endmodule