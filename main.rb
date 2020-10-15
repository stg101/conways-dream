require 'colorize'

world = [[0,1,0],[1,0,1],[1,1,0]]
states = {
    alive: "● ".colorize(:light_red),
    death: "○ ".colorize(:light_yellow),
}


world.each do |row|
    row.each do |cell_value|
        cell_state = cell_value == 1 ? :alive : :death
        print states[cell_state]
    end
    print "\n"
end