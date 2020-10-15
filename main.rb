require 'colorize'

@width = 30 # future constants to generate @world
@height = 30
@world = Array.new(@width) { Array.new(@height) {rand(2)} }
@next_world = Marshal.load(Marshal.dump(@world)) # Lazy copy

@states = {
    alive: "● ".colorize(:light_red),
    death: "○ ".colorize(:light_red),
}

def evaluate_cell(pos = [0, 0])
    relative_neighbours = [
        [-1, 0],
        [-1, 1],
        [0, 1],
        [1, 1],
        [1, 0],
        [1, -1],
        [0, -1],
        [-1, -1]
    ]

    alive_neighbours = 0

    relative_neighbours.each do |relative_pos|
        absolute_pos = []
        absolute_pos[0] = pos[0] + relative_pos[0]
        next if absolute_pos[0] < 0 || absolute_pos[0] > @width - 1
        absolute_pos[1] = pos[1] + relative_pos[1]
        next if absolute_pos[1] < 0 || absolute_pos[0] > @height - 1

        alive_neighbours += 1 if @world[absolute_pos[0]][absolute_pos[1]] == 1
    end

    # Conway's rules
    case alive_neighbours
    when 0..1
        0
    when 2
        @world[pos[0]][pos[1]]
    when 3
        1
    else
        0
    end
end

def draw_world
    print "\e[2J\e[f" # clear console
    @world = Marshal.load(Marshal.dump(@next_world))

    @world.each.with_index do |row, row_index|
        row.each.with_index do |cell_value, column_index|
            cell_state = cell_value == 1 ? :alive : :death
            print @states[cell_state]
            @next_world[row_index][column_index] = evaluate_cell([row_index, column_index])
            
        end
        print "\n"
    end
    print "\n"

    sleep(0.1)
end

while true do
    draw_world
end