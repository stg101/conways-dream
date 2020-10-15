require 'colorize'

@width = 3 # future constants to generate @world
@height = 3
@world = [[0,1,0],[1,0,1],[1,1,0]]
states = {
    alive: "● ".colorize(:light_red),
    death: "○ ".colorize(:light_yellow),
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

    alive_neighbours
end

@world.each.with_index do |row, row_index|
    row.each.with_index do |cell_value, column_index|
        cell_state = cell_value == 1 ? :alive : :death
        print evaluate_cell([row_index, column_index])
        print states[cell_state]
    end
    print "\n"
end